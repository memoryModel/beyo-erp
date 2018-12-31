/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;

/**
 * 班级管理Entity
 * @author Ashon
 * @version 2017-06-01
 */
public class ClassTuition extends DataVo<ClassTuition> {

	private static final long serialVersionUID = 1L;

	private Long classId;		// 班级ID
	private BigDecimal prepaidAmount;		// 预付金
	private BigDecimal tuitionAmount;		// 学费
	private BigDecimal miscellaneousAmount;		// 学杂费
	private BigDecimal depositAmount;		// 保证金
	private BigDecimal insuranceAmount;		// 保险费

	private String remark;		// 备注
//	private Date createTime;		// 创建时间
//	private Long createUser;		// 创建人
//	private Integer status;		// 状态

	public ClassTuition() {
		super();
	}

	public ClassTuition(Long id){
		super(id);
	}

	public Long getClassId() {
		return classId;
	}

	public void setClassId(Long classId) {
		this.classId = classId;
	}

	public BigDecimal getPrepaidAmount() {
		return prepaidAmount;
	}

	public void setPuitionAmount(BigDecimal tuitionAmount) {
		this.prepaidAmount = prepaidAmount;
	}

	public BigDecimal getTuitionAmount() {
		return tuitionAmount;
	}

	public void setTuitionAmount(BigDecimal tuitionAmount) {
		this.tuitionAmount = tuitionAmount;
	}

	public BigDecimal getMiscellaneousAmount() {
		return miscellaneousAmount;
	}

	public void setMiscellaneousAmount(BigDecimal miscellaneousAmount) {
		this.miscellaneousAmount = miscellaneousAmount;
	}

	public BigDecimal getDepositAmount() {
		return depositAmount;
	}

	public void setDepositAmount(BigDecimal depositAmount) {
		this.depositAmount = depositAmount;
	}

	public BigDecimal getInsuranceAmount() {
		return insuranceAmount;
	}

	public void setInsuranceAmount(BigDecimal insuranceAmount) {
		this.insuranceAmount = insuranceAmount;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
//	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	public Date getCreateTime() {
//		return createTime;
//	}
//
//	public void setCreateTime(Date createTime) {
//		this.createTime = createTime;
//	}
//
//	public Long getCreateUser() {
//		return createUser;
//	}
//
//	public void setCreateUser(Long createUser) {
//		this.createUser = createUser;
//	}
//
//	public Integer getStatus() {
//		return status;
//	}
//
//	public void setStatus(Integer status) {
//		this.status = status;
//	}
	
}