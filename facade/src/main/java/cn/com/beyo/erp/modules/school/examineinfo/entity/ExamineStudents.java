/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.student.entity.Student;

import java.util.Date;

/**
 * 考试学员Entity
 * @author beyo.com.cn
 * @version 2017-06-14
 */
public class ExamineStudents extends DataVo<ExamineStudents> {

	private ExamineInfo examineInfo;		// 考试信息ID
	private Student student;  				//学员id
	private SchoolClass schoolClass; 		//班级ID
	private Integer  grade;  				//得分
	private Integer  makeupStatus; 			//预约状态
	private Integer  passStatus;

	private Date createTimeStart; 			//创建时间-开始时间
	private Date createTimeEnd;   			//创建时间-结束时间
	private ClassLesson classLesson;

	public ExamineStudents() {
		super();
	}

	public ExamineStudents(Long id){
		super(id);
	}

	public ExamineStudents(ExamineInfo examineInfo){
		super();
		this.examineInfo = examineInfo;
	}

	public ExamineStudents(Student erpStudentEnroll){

			super();
			this.student = erpStudentEnroll;
		}

	public ExamineStudents(ExamineInfo examineInfo, Student erpStudentEnroll){
			super();
			this.examineInfo = examineInfo;
			this.student = erpStudentEnroll;
	}

	public ExamineInfo getExamineInfo() {
		return examineInfo;
	}

	public void setExamineInfo(ExamineInfo examineInfo) {
		this.examineInfo = examineInfo;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public Integer getPassStatus() {
		return passStatus;
	}

	public void setPassStatus(Integer passStatus) {
		this.passStatus = passStatus;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Date getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(Date createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public Integer getMakeupStatus() {
		return makeupStatus;
	}

	public void setMakeupStatus(Integer makeupStatus) {
		this.makeupStatus = makeupStatus;
	}

	public ClassLesson getClassLesson() {
		return classLesson;
	}

	public void setClassLesson(ClassLesson classLesson) {
		this.classLesson = classLesson;
	}
}