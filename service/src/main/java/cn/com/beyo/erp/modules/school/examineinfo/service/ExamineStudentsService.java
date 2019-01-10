/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.PassStatus;
import cn.com.beyo.erp.modules.school.examineinfo.dao.ExamineStudentsDao;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;
import cn.com.beyo.erp.modules.school.examineinfo.facade.ExamineStudentsFacade;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import com.google.common.base.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 考试学员Service
 * @author beyo.com.cn
 * @version 2017-06-14
 */
@Service
public class ExamineStudentsService extends BeyoService<ExamineStudentsDao, ExamineStudents> implements ExamineStudentsFacade {

	@Autowired
	private ExamineStudentsDao examineStudentsDao;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ExamineStudents get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStudents> findList(ExamineStudents examineStudents) {
		return super.findList(examineStudents);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamineStudents> findPage(Page<ExamineStudents> page, ExamineStudents examineStudents) {
		examineStudents.setPage(page);
		page.setOrderBy("");
		page.setList(examineStudentsDao.findList(examineStudents));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ExamineStudents examineStudents) {
		super.save(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ExamineStudents examineStudents) {
		super.delete(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void deleteReal(ExamineStudents examineStudents) {
		dao.deleteReal(examineStudents);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStudents> examineList(Long id){return  dao.examineList(id);}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStudents> findStudent(ExamineStudents examineStudents){
		return  dao.findStudent(examineStudents);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStudents> selectStudent(ExamineStudents examineStudents) {
		return dao.selectStudent(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateScore(ExamineStudents examineStudents){
		dao.updateScore(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int cleanExamineInfoStudents(ExamineStudents examineStudents){
		return dao.cleanExamineInfoStudents(examineStudents);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineStudents> findExamineInfoStudentByExamineInfo(ExamineStudents examineStudents){
		return dao.findExamineInfoStudentByExamineInfo(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateExamineInfoStudents(ExamineStudents examineStudents) {
		return dao.updateExamineInfoStudents(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateScoreByExamStuden(ExamineStudents examineStudents){
		return dao.updateScoreByExamStuden(examineStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public String studentScoreSave(ExamineInfo examineInfo, String[] studentIdArray, String[] gradeArray){
		try{
			if (null!=studentIdArray && studentIdArray.length>0){

				ExamineStudents student = null;
				for(int i=0;i<studentIdArray.length;i++){

					if(Strings.isNullOrEmpty(studentIdArray[i]) || Strings.isNullOrEmpty(studentIdArray[i].trim()))continue;

					student = new ExamineStudents();
					student.setExamineInfo(examineInfo);
					student.setSchoolClass(examineInfo.getSchoolClass());
					student.setStudent(new Student(Long.parseLong(studentIdArray[i])));
					student.setGrade(Integer.parseInt(gradeArray[i]));

					if (student.getGrade().intValue() >= examineInfo.getPassingGrade().intValue()){
						student.setPassStatus(PassStatus.PASS.getValue());
					}else{
						student.setPassStatus(PassStatus.NOPASS.getValue());
					}

					this.updateScoreByExamStuden(student);

					//examineStudentsService.updateScore(examineStudents);

				}
			}

			return "success";
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			logger.error(e.getMessage());
			return "fail";
		}
	}


	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public Map<String,String> updateScore(ExamineStudents examineStudents, String strVlaue){
		Map<String,String> resultMap = new HashMap<>();
		try{
			String[] str2 = strVlaue.split(",");
			for(int i = 0; i<str2.length;i++){
				examineStudents.setId(Long.valueOf(str2[i]));
				if(Integer.valueOf(str2[i+2])<Integer.valueOf(str2[i+1])){
					examineStudents.setPassStatus(PassStatus.NOPASS.getValue());
				}else{
					examineStudents.setPassStatus(PassStatus.PASS.getValue());
				}
				examineStudents.setGrade(Integer.valueOf(str2[i+2]));

				this.save(examineStudents);
				i = i+2;
			}
			resultMap.put("result","success");
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			logger.error(e.getMessage());
			resultMap.put("result","error");
		}
		return resultMap;
	}
}