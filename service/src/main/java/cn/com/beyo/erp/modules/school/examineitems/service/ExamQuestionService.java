/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineitems.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examineianswer.service.ExamAnswerService;
import cn.com.beyo.erp.modules.school.examineitems.dao.ExamQuestionDao;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examineitems.facade.ExamQuestionFacade;
import cn.com.beyo.erp.modules.school.examinepaper.entity.ExaminePaper;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import libs.fastjson.com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 考试试题Service
 * @author beyo.com.cn
 * @version 2017-06-15
 */
@Service
public class ExamQuestionService extends BeyoService<ExamQuestionDao, ExamQuestion> implements ExamQuestionFacade {

	@Autowired
	private ExamAnswerService examineAnswerService;
	@Autowired
	private ExamQuestionDao examQuestionDao;
	@Autowired
	private Redis redis;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ExamQuestion get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamQuestion> findList(ExamQuestion examQuestion) {
		return super.findList(examQuestion);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamQuestion> findPage(Page<ExamQuestion> page, ExamQuestion examQuestion) {
		return super.findPage(page, examQuestion);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ExamQuestion examQuestion) {
		super.save(examQuestion);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ExamQuestion examQuestion) {
		super.delete(examQuestion);
	}


	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int deleteQuestionByStore(ExamQuestion examQuestion){
		return examQuestionDao.deleteQuestionByStore(examQuestion);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamQuestion> findQuestionListByStore(ExamQuestion examQuestion){
		String examineStoreStr =
				redis.hget(RedisKey.HASH_EXAMINE_STORE_QUESTION,
						String.valueOf(examQuestion.getExamineStore().getId()));
		if(StringUtils.isNoneBlank(examineStoreStr)){
			ExamineStore examineStore = JSON.parseObject(examineStoreStr,ExamineStore.class);
			return examineStore.getExamQuestionList();
		}

		List<ExamQuestion> questionList = examQuestionDao.findQuestionListByStore(examQuestion);
		return findAnswer(questionList);
	}
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamQuestion> findQuestionListByRandom(ExamQuestion examQuestion){
		List<ExamQuestion> questionList =  examQuestionDao.findQuestionListByRandom(examQuestion);
		return findAnswer(questionList);
	}
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamQuestion> findQuestionListByPaper(ExaminePaper examinePaper){
		List<ExamQuestion> questionList =  examQuestionDao.findQuestionListByPaper(examinePaper);
		return findAnswer(questionList);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamQuestion> findAnswer(List<ExamQuestion> questionList){
		ExamineAnswer examineAnswerQuery = new ExamineAnswer();
		examineAnswerQuery.setStatus(Status.NORMAL.getValue());
		for(ExamQuestion question:questionList){

			examineAnswerQuery.setExamQuestion(question);
			List<ExamineAnswer> answerList = examineAnswerService.findAnswerListByQuestion(examineAnswerQuery);
			if (null==answerList)continue;

			question.setAnswerList(answerList);
		}
		return questionList;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void saveExamQuestion(ExamQuestion examQuestion, String options,
                                 String optionContents, String statusess, String[] strings, String[] strings2){
		this.save(examQuestion);
		for(int i=0;i<strings.length;i++){
			ExamineAnswer examineAnswer = new ExamineAnswer();
			ExamQuestion examQuestion1 = new ExamQuestion();
			examineAnswer.setExamQuestion(examQuestion1);
			examineAnswer.setStatus(Integer.valueOf(strings2[i]));
			examineAnswer.getExamQuestion().setId(examQuestion.getId());
			examineAnswerService.save(examineAnswer);
		}
	}


}