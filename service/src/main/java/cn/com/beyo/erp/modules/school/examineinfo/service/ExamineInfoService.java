/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.facade.ClassFacade;
import cn.com.beyo.erp.modules.school.classes.service.ClassService;
import cn.com.beyo.erp.modules.school.examineinfo.dao.ExamineInfoDao;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;
import cn.com.beyo.erp.modules.school.examineinfo.facade.ExamineInfoFacade;
import cn.com.beyo.erp.modules.school.examineinfo.facade.ExamineStudentsFacade;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examineitems.facade.ExamQuestionFacade;
import cn.com.beyo.erp.modules.school.examineitems.service.ExamQuestionService;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.examinestore.facade.ExamineStoreFacade;
import cn.com.beyo.erp.modules.school.examinestore.service.ExamineStoreService;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import com.alibaba.fastjson.JSON;
import com.google.common.base.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 单表生成Service
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@Service
public class ExamineInfoService extends BeyoService<ExamineInfoDao, ExamineInfo> implements ExamineInfoFacade {

	@Autowired
	private ExamineInfoDao examineInfoDao;

	@Autowired
	private ClassService classService;

	@Autowired
	private ExamineStudentsService examineStudentsService;

	@Autowired
	private ExamineStoreService ExamineStoreService;

	@Autowired
	private ExamQuestionService examQuestionService;

	@Autowired
	private Redis redis;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ExamineInfo get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineInfo> findList(ExamineInfo schoolExamineInfo) {
		return super.findList(schoolExamineInfo);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamineInfo> findPage(Page<ExamineInfo> page, ExamineInfo schoolExamineInfo) {
		schoolExamineInfo.setPage(page);
		page.setList(examineInfoDao.findList(schoolExamineInfo));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ExamineInfo examineInfo) {
		super.save(examineInfo);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ExamineInfo schoolExamineInfo) {
		super.delete(schoolExamineInfo);
	}



	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateStatus(ExamineInfo examineInfo) {
		dao.updateStatus(examineInfo);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineInfo> findInfoName(){
		return dao.findInfoName(new ExamineInfo());
	};

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineInfo> findExamInfoBySchedule(ExamineInfo examineInfo){
		return dao.findExamInfoBySchedule(examineInfo);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateInfoStatus(ExamineInfo examineInfo){
		return dao.updateInfoStatus(examineInfo);
	}


	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateExamStore(ExamineInfo examineInfo){
		return dao.updateExamStore(examineInfo);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void saveExam(ExamineInfo examineInfo,HttpServletRequest request){
		this.save(examineInfo);
		//scheduleService.stop(examineInfo);
		//未考试-开考时间大于当前时间
		//考试中-结束时间发育当前时间
		if ((examineInfo.getInfoStatus() == InfoStatus.NOTEXAMIN.getValue()
				&& examineInfo.getStartTime().getTime() > System.currentTimeMillis() )
				|| (examineInfo.getInfoStatus() == InfoStatus.EXAMINATION.getValue()
				&& examineInfo.getEndTime().getTime() > System.currentTimeMillis())){
			logger.info(">>>>>> schedule start");
			//scheduleService.start(examineInfo);
		}

		SchoolClass schoolClass1 = classService.get(examineInfo.getSchoolClass().getId());

		String[] studentIdArray = request.getParameterValues("studentId");
		String[] classIdArray = request.getParameterValues("classId");
		if (null!=studentIdArray && studentIdArray.length>0){

			ExamineStudents examineStudentsDelete = null;
			ExamineStudents examineStudentsNew = null;

			//删除旧的
			examineStudentsDelete = new ExamineStudents();
			examineStudentsDelete.setExamineInfo(examineInfo);
			examineStudentsDelete.setStatus(Status.DELETE.getValue());
			examineStudentsService.cleanExamineInfoStudents(examineStudentsDelete);

			//写入新的
			for(int i = 0;i<studentIdArray.length;i++){
				Student student = new Student(Long.parseLong(studentIdArray[i]));
				SchoolClass schoolClass = new SchoolClass(Long.parseLong(classIdArray[i]));

				examineStudentsNew = new ExamineStudents();
				examineStudentsNew.setExamineInfo(examineInfo);
				examineStudentsNew.setStudent(student);
				examineStudentsNew.setSchoolClass(schoolClass);
				examineStudentsNew.setStatus(Status.NORMAL.getValue());

				if (examineInfo.getExamineStatus() == ExamStatus.MAKEUP.getValue()){
					examineStudentsNew.setMakeupStatus(MakeupStatus.ORDER.getValue());

					//把之前未通过的考试状态设置为已预约补考
					ExamineStudents examineStudentsUpdate = new ExamineStudents();
					examineStudentsUpdate.setStudent(student);
					examineStudentsUpdate.setSchoolClass(schoolClass);
					examineStudentsUpdate.setStatus(Status.NORMAL.getValue());
					examineStudentsUpdate.setPassStatus(PassStatus.NOPASS.getValue());
					examineStudentsUpdate.setMakeupStatus(MakeupStatus.ORDER.getValue());
					examineStudentsService.updateExamineInfoStudents(examineStudentsUpdate);


				}else{
					examineStudentsNew.setMakeupStatus(MakeupStatus.NOORDER.getValue());
				}
				examineStudentsService.save(examineStudentsNew);
			}
		}

		String[] actualTitleArray = request.getParameterValues("actualTitle");
		String[] actualPointsArray = request.getParameterValues("actualPoints");

		//实际操作考试
		if (examineInfo.getExamineType() == ExamStoreType.ACTUAL.getValue()
				&& null!=actualTitleArray && actualTitleArray.length>0){

			ExamineStore examineStore = ExamineStoreService.get(examineInfo.getSchoolExamineStore().getId());
			//如果之前也是实际操作考试，那么先清空，否则就是新创建
			if (examineStore.getType() == ExamStoreType.ACTUAL.getValue()){
				ExamQuestion questionDelete = new ExamQuestion();
				questionDelete.setExamineStore(examineStore);
				questionDelete.setStatus(Status.DELETE.getValue());
				examQuestionService.deleteQuestionByStore(questionDelete);
			}else{
				examineStore = null;
			}

			List<ExamQuestion> questionList = new ArrayList<>();
			ExamQuestion question = null;
			for(int i=0;i<actualTitleArray.length;i++){
				if (Strings.isNullOrEmpty(actualTitleArray[i]) || Strings.isNullOrEmpty(actualTitleArray[i].trim()))continue;

				question = new ExamQuestion();
				question.setTitle(actualTitleArray[i]);
				question.setPoint(Integer.parseInt(actualPointsArray[i]));
				question.setType(ExamQuestionType.SINGLE.getValue());
				question.setStatus(Status.NORMAL.getValue());

				questionList.add(question);

			}

			if (questionList.size() > 0){

				if (null==examineStore){
					examineStore = new ExamineStore();
					examineStore.setSubject(schoolClass1.getClassType());
					examineStore.setName(examineInfo.getExamineName());
					examineStore.setType(examineInfo.getExamineType());
					ExamineStoreService.save(examineStore);
				}

				//修改所属题库
				examineInfo.setSchoolExamineStore(examineStore);
				this.updateExamStore(examineInfo);

				for(ExamQuestion examQuestion:questionList){
					examQuestion.setExamineStore(examineStore);

					examQuestionService.save(examQuestion);
				}

				//添加到redis
				examineStore.setExamQuestionList(questionList);
				redis.zadd(RedisKey.SORTEDSET_EXAMINE_STORE,
						(double)examineStore.getCreateTime().getTime(),
						String.valueOf(examineStore.getId()));
				redis.hset(RedisKey.HASH_EXAMINE_STORE_QUESTION,
						String.valueOf(examineStore.getId()),
						JSON.toJSONString(examineStore));

			}
		}
	}

}