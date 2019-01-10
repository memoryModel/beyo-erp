/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinepaper.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.ClassToLesson;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-08
 */
public class ExaminePaper extends DataVo<ExaminePaper> {

	private ExamineInfo examineInfo; //考试表
	private Student student; //学员ID
	private ExamineStore examineStore;  //考试题库id
	private ExamQuestion examQuestion;  //考题id
	private String remark;		// 备注
	private ExamineAnswer examineAnswer; //答案

	private ClassToLesson classToLesson;  //班级课程中间表
	private ClassStudents classStudents; //班级学员中间表



	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	public ExaminePaper() {
		super();
	}

	public ExaminePaper(Long id){
		super(id);
	}

	public ClassToLesson getClassToLesson() {
		return classToLesson;
	}

	public void setClassToLesson(ClassToLesson classToLesson) {
		this.classToLesson = classToLesson;
	}

	public ClassStudents getClassStudents() {
		return classStudents;
	}


	public ExamineAnswer getExamineAnswer() {
		return examineAnswer;
	}

	public void setExamineAnswer(ExamineAnswer examineAnswer) {
		this.examineAnswer = examineAnswer;
	}

	public void setClassStudents(ClassStudents classStudents) {
		this.classStudents = classStudents;
	}


	public ExamQuestion getExamQuestion() {
		return examQuestion;
	}

	public void setExamQuestion(ExamQuestion examQuestion) {
		this.examQuestion = examQuestion;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Date getCreateTimeStart() {return createTimeStart;}

	public void setCreateTimeStart(Date createTimeStart) {this.createTimeStart = createTimeStart;}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public ExamineInfo getExamineInfo() {
		return examineInfo;
	}

	public void setExamineInfo(ExamineInfo examineInfo) {
		this.examineInfo = examineInfo;
	}

	public ExamineStore getExamineStore() {
		return examineStore;
	}

	public void setExamineStore(ExamineStore examineStore) {
		this.examineStore = examineStore;
	}
}