/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.paymentbillrecord.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.finacetype.entity.FinaceType;
import cn.com.beyo.erp.modules.erp.paymentbill.entity.PaymentBill;
import cn.com.beyo.erp.modules.sys.entity.User;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class PaymentBillRecord extends DataVo<PaymentBillRecord> {

	private PaymentBill erpPaymentBill;   //账单

	private Long payType;    //收款类型
	private FinaceType erpFinaceType; // 收款科目
	private BigDecimal amount;		// 收款金额
	private BigDecimal aggregateAmount;  //已交金额  （该科目当前缴费总和）
	private String remark;                //备注
	private Date createTimeStart; //创建起始时间
	private Date createTimeEnd; //创建结束时间



	private User user;  //业务字段


	public PaymentBillRecord() {
		super();
	}

	public PaymentBillRecord(Long id){
		super(id);
	}

	public PaymentBillRecord(Long id, Long payType){
		super();
		this.id = id;
		this.payType = payType;
	}

	public PaymentBill getErpPaymentBill() {
		return erpPaymentBill;
	}

	public void setErpPaymentBill(PaymentBill erpPaymentBill) {
		this.erpPaymentBill = erpPaymentBill;
	}

	public Long getPayType() {
		return payType;
	}

	public void setPayType(Long payType) {
		this.payType = payType;
	}

	public FinaceType getErpFinaceType() {
		return erpFinaceType;
	}

	public void setErpFinaceType(FinaceType erpFinaceType) {
		this.erpFinaceType = erpFinaceType;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public BigDecimal getAggregateAmount() {
		return aggregateAmount;
	}

	public void setAggregateAmount(BigDecimal aggregateAmount) {
		this.aggregateAmount = aggregateAmount;
	}


	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

}