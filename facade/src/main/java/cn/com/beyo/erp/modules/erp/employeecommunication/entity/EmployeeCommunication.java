/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.employeecommunication.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 招工沟通管理表Entity
 * @author 陆宽
 * @version 2017-12-19
 */
public class EmployeeCommunication extends DataVo<EmployeeCommunication> {
	
	private static final long serialVersionUID = 1L;
	private Integer appointStatus;		// 指派状态 0:已指派 1:未指派
	private String appointId;		// 指派人
	private Date appointTime;		// 指派时间
	private String communicationId;		// 沟通人
	private Date communicationTime;		// 最近沟通时间
	private String remark;              //备注
	private Integer signingIntention;		// 最近签约意向  0:确定签约  1:犹豫中  2:不签约
	private String employeeId;     //招工人主键
	private String communicationCode;
	private Integer status;		// status
	private Date createTime;		// create_time

	//业务字段
	private String communicationPerson;  //沟通人
	private String appointName;          //指派人
	private Date appointStartTime;       //指派时间(开始)
	private Date appointEndTime;         //指派时间(结束)
	private Date communicationStartTime; //沟通时间(开始)
	private Date communicationEndTime;   //沟通时间(结束)
	private Integer communicationCount;        //沟通次数

	
	public EmployeeCommunication() {
		super();
	}

	public EmployeeCommunication(Long id){
		super(id);
	}

	public Integer getAppointStatus() {
		return appointStatus;
	}

	public void setAppointStatus(Integer appointStatus) {
		this.appointStatus = appointStatus;
	}
	
	@Length(min=0, max=280, message="指派人长度必须介于 0 和 280 之间")
	public String getAppointId() {
		return appointId;
	}

	public void setAppointId(String appointId) {
		this.appointId = appointId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAppointTime() {
		return appointTime;
	}

	public void setAppointTime(Date appointTime) {
		this.appointTime = appointTime;
	}
	
	@Length(min=0, max=280, message="沟通人长度必须介于 0 和 280 之间")
	public String getCommunicationId() {
		return communicationId;
	}

	public void setCommunicationId(String communicationId) {
		this.communicationId = communicationId;
	}

	public void setCommunicationTime(Date communicationTime) {
		this.communicationTime = communicationTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCommunicationTime() {
		return communicationTime;
	}

	public Integer getSigningIntention() {
		return signingIntention;
	}

	public void setSigningIntention(Integer signingIntention) {
		this.signingIntention = signingIntention;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRemark() {
		return remark;
	}

	public void setCommunicationPerson(String communicationPerson) {
		this.communicationPerson = communicationPerson;
	}

	public String getCommunicationPerson() {
		return communicationPerson;
	}

	public void setCommunicationCode(String communicationCode) {
		this.communicationCode = communicationCode;
	}

	public String getCommunicationCode() {
		return communicationCode;
	}

	public void setAppointName(String appointName) {
		this.appointName = appointName;
	}

	public String getAppointName() {
		return appointName;
	}

	public void setCommunicationCount(Integer communicationCount) {
		this.communicationCount = communicationCount;
	}

	public Integer getCommunicationCount() {
		return communicationCount;
	}

	public void setAppointStartTime(Date appointStartTime) {
		this.appointStartTime = appointStartTime;
	}

	public Date getAppointStartTime() {
		return appointStartTime;
	}

	public void setAppointEndTime(Date appointEndTime) {
		this.appointEndTime = appointEndTime;
	}

	public Date getAppointEndTime() {
		return appointEndTime;
	}

	public void setCommunicationStartTime(Date communicationStartTime) {
		this.communicationStartTime = communicationStartTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCommunicationStartTime() {
		return communicationStartTime;
	}

	public void setCommunicationEndTime(Date communicationEndTime) {
		this.communicationEndTime = communicationEndTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCommunicationEndTime() {
		return communicationEndTime;
	}
}