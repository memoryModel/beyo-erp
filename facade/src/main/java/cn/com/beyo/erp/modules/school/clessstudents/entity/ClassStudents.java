/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.clessstudents.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.schedule.entity.ClassSchedule;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.transactioncertificate.entity.TransactionCertificate;

import java.util.Date;
import java.util.List;

/**
 * 新增班级中间表Entity
 * @author beyo.com.cn
 * @version 2017-06-27
 */
public class ClassStudents extends DataVo<ClassStudents> {

	private Student student;     //报班学生
	private Employee erpEmployee;     //报班员工
	private SchoolClass schoolClass;     //班级
	private Order order;     //订单
	private Long cause;     //退班原因
	private Date applyTime;    //报名日期
	private Date quitTime;    //退班日期
	private String description;    //退班备注

	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private ClassSchedule classSchedule; //课表
	//业务字段
	private Long currentClassId; //转班前班级Id（转班操作）
	private Long lessonId;
	private Date applyTimeStart;    //报名时间（开始）
	private Date applyTimeEnd;      //报名时间（结束）


	private Integer examStatus;
	private Long countLesson;
	private List<Student> studentList;

	private TransactionCertificate transactionCertificate;//证书记录表

	private Long notSelectClassId; //业务字段
	private Integer filter; //业务字段

	public ClassStudents() {
		super();
	}

	public ClassStudents(Long id){
		super(id);
	}

	public Long getCountLesson() {
		return countLesson;
	}

	public void setCountLesson(Long countLesson) {
		this.countLesson = countLesson;
	}

	public ClassStudents(Integer status){
		super();
		this.status = status;
	}

	public ClassStudents(SchoolClass schoolClass){
		super();
		this.schoolClass = schoolClass;
	}

	public ClassSchedule getClassSchedule() {
		return classSchedule;
	}

	public void setClassSchedule(ClassSchedule classSchedule) {
		this.classSchedule = classSchedule;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public Employee getErpEmployee() {
		return erpEmployee;
	}

	public void setErpEmployee(Employee erpEmployee) {
		this.erpEmployee = erpEmployee;
	}

	public Long getCurrentClassId() {
		return currentClassId;
	}

	public void setCurrentClassId(Long currentClassId) {
		this.currentClassId = currentClassId;
	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getStudent() {
		return student;
	}

	public void setStudent(cn.com.beyo.erp.modules.school.student.entity.Student student) {
		this.student = student;
	}

	public Long getCause() {
		return cause;
	}

	public void setCause(Long cause) {
		this.cause = cause;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Date getQuitTime() {
		return quitTime;
	}

	public void setQuitTime(Date quitTime) {
		this.quitTime = quitTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Long getLessonId() {
		return lessonId;
	}

	public void setLessonId(Long lessonId) {
		this.lessonId = lessonId;
	}

	public TransactionCertificate getTransactionCertificate() {
		return transactionCertificate;
	}

	public void setTransactionCertificate(TransactionCertificate transactionCertificate) {
		this.transactionCertificate = transactionCertificate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getApplyTimeStart() {
		return applyTimeStart;
	}

	public void setApplyTimeStart(Date applyTimeStart) {
		this.applyTimeStart = applyTimeStart;
	}

	public Date getApplyTimeEnd() {
		return applyTimeEnd;
	}

	public void setApplyTimeEnd(Date applyTimeEnd) {
		this.applyTimeEnd = applyTimeEnd;
	}

	public Integer getExamStatus() {
		return examStatus;
	}

	public void setExamStatus(Integer examStatus) {
		this.examStatus = examStatus;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	public void setNotSelectClassId(Long notSelectClassId) {
		this.notSelectClassId = notSelectClassId;
	}

	public Long getNotSelectClassId() {
		return notSelectClassId;
	}

	public void setFilter(Integer filter) {
		this.filter = filter;
	}

	public Integer getFilter() {
		return filter;
	}
}