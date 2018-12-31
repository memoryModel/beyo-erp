/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 学校班级Entity
 * @author Ashon
 * @version 2017-06-01
 */
public class SchoolClass extends DataVo<SchoolClass> {

	private static final long serialVersionUID = 1L;
	private String className;		// 班级名称
	private Long classType;         //班型
	private User headteacher;		// 班主任ID
	private User instructor;		// 指导老师ID
	private User manager;		// 管理老师ID
	private User supervisor;		// 督导老师ID
	private Integer classMaxNum;		// 班级最大人数
	private Integer classMinNum;		// 班级预计招收人数
	private Integer classRealNum;		// 实际招收人数
	private Date planBeginTime;		// 计划开班日期
	private Date realBeginTime;		// 实际开班日期
	private Date planEndTime;		// 计划结业日期
	private Date realEndTime;		// 实际结业日期
	private Integer classTime;		// 课时
	private Integer makeLesson;     // 区别开班/补课
	private BigDecimal prepaidAmount;		// 预付金
	private BigDecimal tuitionAmount;		// 学费
	private BigDecimal miscellaneousAmount;		// 学杂费
	//保证金和保险金已废除，数据库表这两个字段也删除在这里注释是留记录
	/*private BigDecimal depositAmount;		// 保证金
	private BigDecimal insuranceAmount;		// 保险费*/
	private String remark;		// 备注


	private ClassToLesson schoolClassToLesson;
	private cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll;  //学员Entity
	private Integer currentVersion;    //当前版本 分布式锁使用


	//业务字段
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private Integer quitStatusA;	             //退班状态条件01
	private Integer quitStatusB;	             //退班状态条件02

	private Date beginTime;//计划日期业务
	private Date endTime;

	private Integer filter;     //业务字段 用作查询

	@JsonIgnore
	private String lessonNames;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public SchoolClass() {
		super();
	}

	public SchoolClass(Long id){
		super(id);
	}

	@Length(min=1, max=512, message="班级名称长度必须介于 1 和 512 之间")
	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public User getHeadteacher() {
		return headteacher;
	}

	public void setHeadteacher(User headteacher) {
		this.headteacher = headteacher;
	}

	public User getInstructor() {
		return instructor;
	}

	public void setInstructor(User instructor) {
		this.instructor = instructor;
	}

	public User getManager() {
		return manager;
	}

	public void setManager(User manager) {
		this.manager = manager;
	}

	public User getSupervisor() {
		return supervisor;
	}

	public void setSupervisor(User supervisor) {
		this.supervisor = supervisor;
	}

	@NotNull(message="班级最大人数不能为空")
	public Integer getClassMaxNum() {
		return classMaxNum;
	}

	public void setClassMaxNum(Integer classMaxNum) {
		this.classMaxNum = classMaxNum;
	}

	@NotNull(message="班级预计招收人数不能为空")
	public Integer getClassMinNum() {
		return classMinNum;
	}

	public void setClassMinNum(Integer classMinNum) {
		this.classMinNum = classMinNum;
	}

//	@NotNull(message="实际招收人数不能为空")
	public Integer getClassRealNum() {
		return classRealNum;
	}

	public void setClassRealNum(Integer classRealNum) {
		this.classRealNum = classRealNum;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getPlanBeginTime() {
		return planBeginTime;
	}

	public void setPlanBeginTime(Date planBeginTime) {
		this.planBeginTime = planBeginTime;
	}





	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRealBeginTime() {
		return realBeginTime;
	}

	public void setRealBeginTime(Date realBeginTime) {
		this.realBeginTime = realBeginTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPlanEndTime() {
		return planEndTime;
	}

	public void setPlanEndTime(Date planEndTime) {
		this.planEndTime = planEndTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRealEndTime() {
		return realEndTime;
	}

	public void setRealEndTime(Date realEndTime) {
		this.realEndTime = realEndTime;
	}

	public Integer getClassTime() {
		return classTime;
	}

	public void setClassTime(Integer classTime) {
		this.classTime = classTime;
	}

	public BigDecimal getTuitionAmount() {
		return tuitionAmount;
	}

	public void setTuitionAmount(BigDecimal tuitionAmount) {
		this.tuitionAmount = tuitionAmount;
	}

	public BigDecimal getPrepaidAmount() {
		return prepaidAmount;
	}

	public void setPrepaidAmount(BigDecimal prepaidAmount) {
		this.prepaidAmount = prepaidAmount;
	}

	public BigDecimal getMiscellaneousAmount() {
		return miscellaneousAmount;
	}

	public void setMiscellaneousAmount(BigDecimal miscellaneousAmount) {
		this.miscellaneousAmount = miscellaneousAmount;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(Date createTimeStart) {
		this.createTimeStart = createTimeStart;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getErpStudentEnroll() {
		return erpStudentEnroll;
	}

	public void setErpStudentEnroll(cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll) {
		this.erpStudentEnroll = erpStudentEnroll;
	}

	public ClassToLesson getSchoolClassToLesson() {
		return schoolClassToLesson;
	}

	public void setSchoolClassToLesson(ClassToLesson schoolClassToLesson) {
		this.schoolClassToLesson = schoolClassToLesson;
	}

	public Integer getQuitStatusA() {
		return quitStatusA;
	}

	public void setQuitStatusA(Integer quitStatusA) {
		this.quitStatusA = quitStatusA;
	}

	public Integer getQuitStatusB() {
		return quitStatusB;
	}

	public void setQuitStatusB(Integer quitStatusB) {
		this.quitStatusB = quitStatusB;
	}

	public String getLessonNames() {
		return lessonNames;
	}

	public void setLessonNames(String lessonNames) {
		this.lessonNames = lessonNames;
	}

	public Integer getMakeLesson() {
		return makeLesson;
	}

	public void setMakeLesson(Integer makeLesson) {
		this.makeLesson = makeLesson;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getClassType() {
		return classType;
	}

	public void setClassType(Long classType) {
		this.classType = classType;
	}

	public void setFilter(Integer filter) {
		this.filter = filter;
	}

	public Integer getFilter() {
		return filter;
	}

	public void setCurrentVersion(Integer currentVersion) {
		this.currentVersion = currentVersion;
	}

	public Integer getCurrentVersion() {
		return currentVersion;
	}
}