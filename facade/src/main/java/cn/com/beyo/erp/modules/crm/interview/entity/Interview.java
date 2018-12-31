/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.interview.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 面试管理Entity
 * @author beyo.com.cn
 * @version 2017-07-13
 */
public class Interview extends DataVo<Interview> {

	private Employee employee;		// 员工信息
	private Date interviewTime;		// 面试时间
	private Date planInterviewTime;  //计划面试时间
	private String grade;		// 面试等级
	private User interviewers;		// 面试人
	private String remark;		// 备注信息
	private Integer interviewStatus;   //计划状态（待确认、已确认、已放弃）
	private Integer remindStatus;   //提醒状态（已提醒、未提醒）
	private Date appointInterviewTime;   //预约面试时间
	private String abandonCause;    //放弃面试原因

	private CustomerResource customerResource;//来源
	private User user;   //当前操作人
	private User addPlanUser;   //计划添加人

	private Date startTime;    //计划添加开始时间
	private Date endTime;		//计划添加结束时间
	private Date startInterviewTime;    //开始计划面试时间
	private Date endInterviewTime;		//结束计划面试时间
	private Date startAppointInterviewTime;  //开始预约面试时间
	private Date endAppointInterviewTime;  //结束预约面试时间

	private Integer identifying;  //标识

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}



	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	public Interview() {
		super();
	}

	public Interview(Long id){
		super(id);
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInterviewTime() {
		return interviewTime;
	}

	public void setInterviewTime(Date interviewTime) {
		this.interviewTime = interviewTime;
	}
	
	@Length(min=0, max=50, message="面试等级长度必须介于 0 和 50 之间")
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public User getInterviewers() {
		return interviewers;
	}

	public void setInterviewers(User interviewers) {
		this.interviewers = interviewers;
	}

	@Length(min=0, max=1024, message="备注信息长度必须介于 0 和 1024 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getStartInterviewTime() {
		return startInterviewTime;
	}

	public void setStartInterviewTime(Date startInterviewTime) {
		this.startInterviewTime = startInterviewTime;
	}

	public Date getEndInterviewTime() {
		return endInterviewTime;
	}

	public void setEndInterviewTime(Date endInterviewTime) {
		this.endInterviewTime = endInterviewTime;
	}

	public Integer getInterviewStatus() {
		return interviewStatus;
	}

	public void setInterviewStatus(Integer interviewStatus) {
		this.interviewStatus = interviewStatus;
	}

	public Integer getRemindStatus() {
		return remindStatus;
	}

	public void setRemindStatus(Integer remindStatus) {
		this.remindStatus = remindStatus;
	}

	public User getAddPlanUser() {
		return addPlanUser;
	}

	public void setAddPlanUser(User addPlanUser) {
		this.addPlanUser = addPlanUser;
	}

	public Integer getIdentifying() {
		return identifying;
	}

	public void setIdentifying(Integer identifying) {
		this.identifying = identifying;
	}

	public Date getAppointInterviewTime() {
		return appointInterviewTime;
	}

	public void setAppointInterviewTime(Date appointInterviewTime) {
		this.appointInterviewTime = appointInterviewTime;
	}

	public Date getPlanInterviewTime() {
		return planInterviewTime;
	}

	public void setPlanInterviewTime(Date planInterviewTime) {
		this.planInterviewTime = planInterviewTime;
	}

	public String getAbandonCause() {
		return abandonCause;
	}

	public void setAbandonCause(String abandonCause) {
		this.abandonCause = abandonCause;
	}

	public Date getStartAppointInterviewTime() {
		return startAppointInterviewTime;
	}

	public void setStartAppointInterviewTime(Date startAppointInterviewTime) {
		this.startAppointInterviewTime = startAppointInterviewTime;
	}

	public Date getEndAppointInterviewTime() {
		return endAppointInterviewTime;
	}

	public void setEndAppointInterviewTime(Date endAppointInterviewTime) {
		this.endAppointInterviewTime = endAppointInterviewTime;
	}
}