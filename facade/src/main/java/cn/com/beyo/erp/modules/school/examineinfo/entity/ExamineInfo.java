/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-08
 */
public class ExamineInfo extends DataVo<ExamineInfo> {




	private ExamineStore schoolExamineStore; //题库
	private String examineName;		// 考试名称
	private Integer examineType;		// 考试类型
	private Integer examineLength;		// 考试时长
	private Long examineMethod;		// 考试方式
	private Date startTime;		// 开始时间
	private Date endTime;		// 结束时间
	private Integer examineStatus;		// 补考标记
	private Integer disbursementType;		// 发放类型
	private Integer singleChoiceNum;		// 单选题数目
	private Integer multiChoiceNum;		// 多选题数目
	private Integer singleChoiceGrade;		// 单选题分	数
	private Integer multiChoiceGrade;		// 多选题分数
	private Integer passingGrade;		// 及格分数
	private User teacher;			//监考老师
	private String remark;		// 备注
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束

	private Student erpStudentEnroll; //学员信息id
	private SchoolClass schoolClass; //班级信息ID
	private ClassLesson schoolClassLesson;  //课程
	private ExamineStudents examineStudents; //考试学员
	private Long studentCount; //业务字段：人数
	private Integer infoStatus; //考试状态

	public Date getCreateTimeStart() {return createTimeStart;}

	public void setCreateTimeStart(Date createTimeStart) {this.createTimeStart = createTimeStart;}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public ExamineInfo() {
		super();
	}

	public ExamineInfo(Long id){
		super(id);
	}

	@Length(min=0, max=215, message="考试名称长度必须介于 0 和 215 之间")
	public String getExamineName() {
		return examineName;
	}

	public void setExamineName(String examineName) {
		this.examineName = examineName;
	}

	public Integer getExamineType() {
		return examineType;
	}

	public void setExamineType(Integer examineType) {
		this.examineType = examineType;
	}

	@NotNull(message="考试时长不能为空")
	public Integer getExamineLength() {
		return examineLength;
	}

	public void setExamineLength(Integer examineLength) {
		this.examineLength = examineLength;
	}

	@NotNull(message="考试方式不能为空")
	public Long getExamineMethod() {
		return examineMethod;
	}

	public void setExamineMethod(Long examineMethod) {
		this.examineMethod = examineMethod;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getExamineStatus() {
		return examineStatus;
	}

	public void setExamineStatus(Integer examineStatus) {
		this.examineStatus = examineStatus;
	}

	public Integer getSingleChoiceNum() {
		return singleChoiceNum;
	}

	public void setSingleChoiceNum(Integer singleChoiceNum) {
		this.singleChoiceNum = singleChoiceNum;
	}


	public Integer getMultiChoiceNum() {
		return multiChoiceNum;
	}

	public void setMultiChoiceNum(Integer multiChoiceNum) {
		this.multiChoiceNum = multiChoiceNum;
	}


	public Integer getSingleChoiceGrade() {
		return singleChoiceGrade;
	}

	public void setSingleChoiceGrade(Integer singleChoiceGrade) {
		this.singleChoiceGrade = singleChoiceGrade;
	}


	public Integer getMultiChoiceGrade() {
		return multiChoiceGrade;
	}

	public void setMultiChoiceGrade(Integer multiChoiceGrade) {
		this.multiChoiceGrade = multiChoiceGrade;
	}


	public Integer getPassingGrade() {
		return passingGrade;
	}

	public void setPassingGrade(Integer passingGrade) {
		this.passingGrade = passingGrade;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Student getErpStudentEnroll() {
		return erpStudentEnroll;
	}

	public void setErpStudentEnroll(Student erpStudentEnroll) {
		this.erpStudentEnroll = erpStudentEnroll;
	}

	public ExamineStudents getExamineStudents() {
		return examineStudents;
	}

	public void setExamineStudents(ExamineStudents examineStudents) {
		this.examineStudents = examineStudents;
	}


	public ClassLesson getSchoolClassLesson() {
		return schoolClassLesson;
	}

	public void setSchoolClassLesson(ClassLesson schoolClassLesson) {
		this.schoolClassLesson = schoolClassLesson;
	}

	public ExamineStore getSchoolExamineStore() {
		return schoolExamineStore;
	}

	public void setSchoolExamineStore(ExamineStore schoolExamineStore) {
		this.schoolExamineStore = schoolExamineStore;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public Long getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(Long studentCount) {
		this.studentCount = studentCount;
	}

	public Integer getInfoStatus() {
		return infoStatus;
	}

	public void setInfoStatus(Integer infoStatus) {
		this.infoStatus = infoStatus;
	}

	public Integer getDisbursementType() {
		return disbursementType;
	}

	public void setDisbursementType(Integer disbursementType) {
		this.disbursementType = disbursementType;
	}

	public User getTeacher() {
		return teacher;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}
}