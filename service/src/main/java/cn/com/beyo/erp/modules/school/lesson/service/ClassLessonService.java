/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.lesson.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.modules.school.lesson.dao.ClassLessonDao;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.lesson.facade.LessonFacade;
import cn.com.beyo.erp.modules.sys.entity.User;
import libs.fastjson.com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 课程管理Service
 * @author Ashon
 * @version 2017-06-01
 */
@Service(value = "classLessonService")
public class ClassLessonService extends BeyoService<ClassLessonDao, ClassLesson> implements LessonFacade{

	@Autowired
	private ClassLessonDao classLessonDao;

	@Autowired
	private Redis redis;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ClassLesson get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public ClassLesson getClassLesson(Long id) {
	    ClassLesson classLesson;
	    String classLessonStr = redis.hget(RedisKey.HASH_CLASS_LESSON,String.valueOf(id));
	    if(StringUtils.isNoneBlank(classLessonStr)){
	        classLesson = JSON.parseObject(classLessonStr,ClassLesson.class);
        }else{
            classLesson = this.get(id);
        }
        return classLesson;
    }

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassLesson> findList(ClassLesson schoolClassLesson) {
		return super.findList(schoolClassLesson);
	}

	/**
	 * 根据Id查询课程
	 */

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ClassLesson findById(ClassLesson schoolClassLesson) {
		return dao.findById(schoolClassLesson);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassLesson> findPage(Page<ClassLesson> page, ClassLesson schoolClassLesson) {
		schoolClassLesson.setPage(page);
		page.setList(classLessonDao.findList(schoolClassLesson));
		//this.setTeacherNames(page.getList());
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ClassLesson schoolClassLesson) {
		super.save(schoolClassLesson);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ClassLesson schoolClassLesson) {
		 super.delete(schoolClassLesson);

	}

	/**
	 * 查询班级列表
	 * @return List<SchoolClassLesson>
	 * @author Ashon
	 * @version 2017-06-08
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassLesson> findLessonList() {
		return dao.findLessonList(new ClassLesson());
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassLesson> findLessonLists() {
		ClassLesson classLesson = new ClassLesson();
		classLesson.setStatus(Status.NORMAL.getValue());
		return dao.findLessonLists(classLesson);
	}


	/**
	 * 查询班级课程列表
	 * @return List<SchoolClassLesson>
	 * @author Ashon
	 * @version 2017-07-29
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassLesson> findClassLessonList(Page<ClassLesson> classLessonPage, ClassLesson classLesson) {
		classLesson.setPage(classLessonPage);
		classLessonPage.setList(dao.findClassLessonList(classLesson));
		//this.setTeacherNames(classLessonPage.getList());

		return classLessonPage;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassLesson> findAllList(ClassLesson classLesson){
		List<ClassLesson> classLessonList = dao.findAllList(classLesson);
		//this.setTeacherNames(classLessonList);
		return classLessonList;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassLesson> selectListAll(ClassLesson classLesson, RpcHttp rpcHttp){

		Page<ClassLesson> page = rpcHttp.getPage();
		//从redis查询课程
		Set<String> set = redis.zrevrange(RedisKey.SORTEDSET_CLASS_LESSON,
				(page.getPageNo()-1)*page.getPageSize(),page.getPageNo()*page.getPageSize()-1);
		if(set == null || set.size() == 0){
			Map<String, Double> map = new HashMap<>();//用于添加sortedset类型
			Map<String,String> hash = new HashMap<>();//用于添加hash类型
			List<ClassLesson> classLessonList = dao.findList(classLesson);
			if(classLessonList != null && classLessonList.size() > 0){
				for(ClassLesson cl:classLessonList){
					map.put(String.valueOf(cl.getId()),(double)cl.getCreateTime().getTime());
					hash.put(String.valueOf(cl.getId()),JSON.toJSONString(cl));
				}
			}
			redis.zadd(RedisKey.SORTEDSET_CLASS_LESSON,map);
			redis.hmset(RedisKey.HASH_CLASS_LESSON,hash);
			return this.findPage(page,classLesson);
		}else{
			List<ClassLesson> classLessonList = new ArrayList<>(set.size());
			String[] idArray = new String[set.size()];
			int i = 0; //此下标为数据添加元素的下标
			for(String idStr:set){
				idArray[i] = idStr;
				i++;
			}
			List<String> classLessonStrList = redis.hmget(RedisKey.HASH_CLASS_LESSON,idArray);
			if(classLessonStrList != null && classLessonStrList.size() > 0){
				for(String classLessonStr:classLessonStrList){
					classLessonList.add(JSON.parseObject(classLessonStr,ClassLesson.class));
				}
				page.setCount(redis.zcard(RedisKey.SORTEDSET_CLASS_LESSON));
				//this.setTeacherNames(classLessonList);
				page.setList(classLessonList);
			}else{//如果查询hash类型失败的话
				//要将sortedset类型进行删除
				redis.zremrangebyrank(RedisKey.SORTEDSET_CLASS_LESSON,0,-1);
				//仍然要从数据库查询
				return this.findPage(page,classLesson);
			}
			return page;
		}
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public Long updateClassLesson(ClassLesson schoolClassLesson){
		this.update(schoolClassLesson);

		return redis.hset(RedisKey.HASH_CLASS_LESSON,
				String.valueOf(schoolClassLesson.getId()),JSON.toJSONString(schoolClassLesson));
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public Long saveClassLesson(ClassLesson schoolClassLesson){
		super.save(schoolClassLesson);

		redis.zadd(RedisKey.SORTEDSET_CLASS_LESSON,
				(double)schoolClassLesson.getCreateTime().getTime(),String.valueOf(schoolClassLesson.getId()));
		return redis.hset(RedisKey.HASH_CLASS_LESSON,
				String.valueOf(schoolClassLesson.getId()),JSON.toJSONString(schoolClassLesson));
	}

    @Override
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public Long deleteClassLesson(ClassLesson schoolClassLesson) {
        super.delete(schoolClassLesson);
        redis.zrem(RedisKey.SORTEDSET_CLASS_LESSON,String.valueOf(schoolClassLesson.getId()));
        return redis.hdel(RedisKey.HASH_CLASS_LESSON,String.valueOf(schoolClassLesson.getId()));
    }


}