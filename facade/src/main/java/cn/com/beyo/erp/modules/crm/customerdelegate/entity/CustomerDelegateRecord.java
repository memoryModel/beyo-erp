/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.customerdelegate.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 待委派客户Entity
 * @author jiayw
 * @version 2018-02-28
 */
public class CustomerDelegateRecord extends DataVo<CustomerDelegateRecord> {
	
	private static final long serialVersionUID = 1L;
	private Long customerId;		// 客户id
	private Long saleAdviserId;		// 客户跟进人
	private Date delegateTime;		// 委派操作时间
	private Long delegtatePersonId;		// 委派操作人
	private Date cancelTime;		// 撤回时间
	private Integer cancelType;		// 撤回类型
	private String cancelReason;		// 撤回原因
	private Long cancelPersonId;		// 撤回操作人

	//业务字段
	private User saleAdviserName; //销售顾问
	private User delegtatePersonName; //委派操作人姓名
	private User cancelPersonName; //撤回操作人姓名
	private Date delegateStartTime; //委派开始时间
	private Date delegateEndTime;//委派结束时间

	private Date cancelStartTime; //撤回开始时间
	private Date cancelEndTime; //撤回结束时间




	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public User getSaleAdviserName() {
		return saleAdviserName;
	}

	public void setSaleAdviserName(User saleAdviserName) {
		this.saleAdviserName = saleAdviserName;
	}

	public User getDelegtatePersonName() {
		return delegtatePersonName;
	}

	public void setDelegtatePersonName(User delegtatePersonName) {
		this.delegtatePersonName = delegtatePersonName;
	}

	public User getCancelPersonName() {
		return cancelPersonName;
	}

	public void setCancelPersonName(User cancelPersonName) {
		this.cancelPersonName = cancelPersonName;
	}

	public Date getDelegateStartTime() {
		return delegateStartTime;
	}

	public void setDelegateStartTime(Date delegateStartTime) {
		this.delegateStartTime = delegateStartTime;
	}

	public Date getDelegateEndTime() {
		return delegateEndTime;
	}

	public void setDelegateEndTime(Date delegateEndTime) {
		this.delegateEndTime = delegateEndTime;
	}

	public Date getCancelStartTime() {
		return cancelStartTime;
	}

	public void setCancelStartTime(Date cancelStartTime) {
		this.cancelStartTime = cancelStartTime;
	}

	public Date getCancelEndTime() {
		return cancelEndTime;
	}

	public void setCancelEndTime(Date cancelEndTime) {
		this.cancelEndTime = cancelEndTime;
	}

	public CustomerDelegateRecord() {
		super();
	}

	public CustomerDelegateRecord(Long id){
		super(id);
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	
	public Long getSaleAdviserId() {
		return saleAdviserId;
	}

	public void setSaleAdviserId(Long saleAdviserId) {
		this.saleAdviserId = saleAdviserId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDelegateTime() {
		return delegateTime;
	}

	public void setDelegateTime(Date delegateTime) {
		this.delegateTime = delegateTime;
	}
	
	public Long getDelegtatePersonId() {
		return delegtatePersonId;
	}

	public void setDelegtatePersonId(Long delegtatePersonId) {
		this.delegtatePersonId = delegtatePersonId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(Date cancelTime) {
		this.cancelTime = cancelTime;
	}
	
	public Integer getCancelType() {
		return cancelType;
	}

	public void setCancelType(Integer cancelType) {
		this.cancelType = cancelType;
	}
	
	@Length(min=0, max=1028, message="撤回原因长度必须介于 0 和 1028 之间")
	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	
	public Long getCancelPersonId() {
		return cancelPersonId;
	}

	public void setCancelPersonId(Long cancelPersonId) {
		this.cancelPersonId = cancelPersonId;
	}
	
}