/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examineianswer.service.ExamAnswerService;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examineitems.service.ExamQuestionService;
import cn.com.beyo.erp.modules.school.examinestore.dao.ExamineStoreDao;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.examinestore.facade.ExamineStoreFacade;
import cn.com.beyo.erp.thread.school.examinestore.ExamineStoreThread;
import cn.com.beyo.erp.thread.school.examinestore.ExamineStoreThreadPool;
import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.net.URLDecoder;
import java.util.*;

/**
 * 单表生成Service
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@Service
public class ExamineStoreService extends BeyoService<ExamineStoreDao, ExamineStore> implements ExamineStoreFacade {

	@Autowired
	private ExamQuestionService examQuestionService;
	@Autowired
	private ExamAnswerService examineAnswerService;
	@Autowired
	private ExamineStoreDao examineStoreDao;
	@Autowired
	private Redis redis;
	@Autowired
	private ExamineStoreThreadPool examineStoreThreadPool;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ExamineStore get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStore> findList(ExamineStore examineStore) {
		return super.findList(examineStore);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamineStore> findPage(Page<ExamineStore> page, ExamineStore examineStore) {
		examineStore.setPage(page);
		page.setList(examineStoreDao.findList(examineStore));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ExamineStore examineStore) {
		super.save(examineStore);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ExamineStore examineStore) {
		super.delete(examineStore);
	}

	/**
	 * 查询题库列表
	 * 绑定下拉框
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStore> findStoreList(){
		ExamineStore examineStore = new ExamineStore();
		return dao.findStoreList(examineStore);}


	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public String saveExamineStore(ExamineStore examineStore, String examJson){

		try{
			this.save(examineStore);

			String json = URLDecoder.decode(examJson,"UTF-8");
			List<Map<String,Object>> list =  (new ObjectMapper()).readValue(json, new ArrayList<HashMap<String,Object>>().getClass());

			ExamineAnswer answerDelete = new ExamineAnswer();
			answerDelete.setExamStore(examineStore);
			answerDelete.setStatus(Status.DELETE.getValue());
			examineAnswerService.deleteAnswerByQuestion(answerDelete);

			ExamQuestion questionDelete = new ExamQuestion();
			questionDelete.setExamineStore(examineStore);
			questionDelete.setStatus(Status.DELETE.getValue());
			examQuestionService.deleteQuestionByStore(questionDelete);

			List<Map<String,Object>> answerList = null;
			ExamineAnswer answer = null;
			ExamQuestion question = null;

			/**
			 * 用于redis的添加
			 * */
			List<ExamQuestion> questionList = new ArrayList<>(list.size());
			List<ExamineAnswer> examineAnswerList = null;
			/**
			 * */

			for(Map<String,Object> questionMap:list){
				String title = (String)questionMap.get("title");
				String type = (String)questionMap.get("type");
				answerList = (List<Map<String,Object>>)questionMap.get("optionsArray");

				question = new ExamQuestion();
				question.setTitle(title);
				question.setExamineStore(examineStore);
				question.setStatus(Status.NORMAL.getValue());
				question.setType(Integer.parseInt(type));

				examQuestionService.save(question);

				if (null==answerList)continue;

				examineAnswerList = new ArrayList<>(answerList.size());

				for(Map<String,Object> answerMap:answerList){
					String answerOption = (String)answerMap.get("answerOption");
					String optionContent = (String)answerMap.get("optionContent");
					String chckFlag = (String)answerMap.get("chckFlag");

					answer = new ExamineAnswer();

					answer.setExamStore(examineStore);
					answer.setExamQuestion(question);
					answer.setReference(answerOption);
					answer.setTitle(optionContent);
					answer.setSolution(Integer.parseInt(chckFlag));
					answer.setStatus(Status.NORMAL.getValue());

					examineAnswerService.save(answer);
					examineAnswerList.add(answer);
				}
				question.setAnswerList(examineAnswerList);
				questionList.add(question);
			}
			examineStore.setQuestionCount(questionList.size());
			examineStore.setExamQuestionList(questionList);
			redis.zadd(RedisKey.SORTEDSET_EXAMINE_STORE,
					(double)examineStore.getCreateTime().getTime(), JSON.toJSONString(examineStore.getId()));

			redis.hset(RedisKey.HASH_EXAMINE_STORE_QUESTION,
					String.valueOf(examineStore.getId()),
					JSON.toJSONString(examineStore));

			return "success";
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			logger.error(e.getMessage(),e);
			return "fail";
		}
	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamineStore> findPageList(ExamineStore examineStore, RpcHttp rpcHttp) {

		Page<ExamineStore> page = rpcHttp.getPage();


		Object result = redis.getValue(RedisKey.FLAG_EXAMINE_STORE);
		if(result == null || !"2".equals((String)result)){
			this.saveRedis();
			return this.findPage(page,examineStore);
		}

		//从redis查询题库
		Set<String> set = redis.zrevrange(RedisKey.SORTEDSET_EXAMINE_STORE,
				(page.getPageNo()-1)*page.getPageSize(),page.getPageNo()*page.getPageSize()-1);
		if(set == null || set.size() == 0){
			this.saveRedis();
            return this.findPage(page,examineStore);
		}else{
		    List<ExamineStore> examineStoreList = new ArrayList<>(set.size());
            String[] idArray = new String[set.size()];
            int i = 0; //此下标为数据添加元素的下标
            for(String idStr:set){
                idArray[i] = idStr;
                i++;
            }
            List<String> examineStoreStrList = redis.hmget(RedisKey.HASH_EXAMINE_STORE_QUESTION,idArray);
		    if(examineStoreStrList != null && examineStoreStrList.size() > 0){
                for(String examineStoreStr:examineStoreStrList){
                    examineStoreList.add(JSON.parseObject(examineStoreStr,ExamineStore.class));
                }
                page.setCount(redis.zcard(RedisKey.SORTEDSET_EXAMINE_STORE));
                page.setList(examineStoreList);
            }else{
                //如果查询hash类型失败的话
                //要将sortedset类型进行删除
                redis.zremrangebyrank(RedisKey.SORTEDSET_EXAMINE_STORE,0,-1);
                //仍然要从数据库查询
                return this.findPage(page,examineStore);
            }

		}
		return page;
	}

	//将examineStore存入sortedSet类型
	//将examineStore,examineQuestion,examineAnswer存入hash类型
	private void saveRedis(){
		//清除标识位
		redis.del(RedisKey.FLAG_EXAMINE_STORE);

		Map<String, Double> examineStoreMap = new HashMap<>();//用于添加sortedset类型
		Map<String,String> examineStoreHash = new HashMap<>();//用于添加hash类型

		List<ExamineStore> examineStoreQuestionAnswerList = dao.findStoreAllList();
		if(examineStoreQuestionAnswerList != null && examineStoreQuestionAnswerList.size() > 0){
			for(ExamineStore es:examineStoreQuestionAnswerList){
				examineStoreMap.put(String.valueOf(es.getId()),(double)es.getCreateTime().getTime());
				examineStoreHash.put(String.valueOf(es.getId()),JSON.toJSONString(es));
			}
		}

		//此线程用于sortedSet类型的添加
		ExamineStoreThread examineStoreThread = new ExamineStoreThread(redis,
				RedisKey.SORTEDSET_EXAMINE_STORE,
				examineStoreMap,
				"sortedSet");
		//此线程用于hash类型的添加
		ExamineStoreThread examineStoreThread2 = new ExamineStoreThread(redis,
				RedisKey.HASH_EXAMINE_STORE_QUESTION,
				examineStoreHash,
				"hash");
		examineStoreThreadPool.execute(examineStoreThread);
		examineStoreThreadPool.execute(examineStoreThread2);
		examineStoreThreadPool.shutdown();
	}
}