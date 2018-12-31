/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.paymentbill.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.paymentbillrecord.entity.PaymentBillRecord;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.sys.entity.User;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 收款单Entity
 * @author Ashon
 * @version 2017-06-26
 */
public class PaymentBill extends DataVo<PaymentBill> {

	private String billsCode;			// 收款单编号
	private Long typeId;				// 收款方式    现金  微信  支付宝
	private BigDecimal totalAmount;		// 收款总金额
	private String remark;                //备注
	private Date payTime;
	private User payUser;


	//显示用
	private BigDecimal prepaidAmount;			// 预付金
	private BigDecimal tuitionAmount;			// 学费
	private BigDecimal miscellaneousAmount;		// 学杂费
	private BigDecimal depositAmount;			// 保证金
	private BigDecimal insuranceAmount;			// 保险费


	private Order order;   			  //订单
	private User collectionEmployee;  //收款人
	private User confirmEmployee;     //收款确认人
	private Date confirmTime;  		  //收款确认时间


	private Long finaceId;
	private Long payCategory;
	private Date createTimeStart; //创建起始时间
	private Date createTimeEnd; //创建结束时间
	private PaymentBillRecord erpPaymentBillRecord;
	private ReceivableBill receivableBill; //应收账单
	private User user;// 创建人

	
	public PaymentBill() {
		super();
	}

	public PaymentBill(Long id){
		super(id);
	}

	@NotNull(message="账单编号不能为空")
	public String getBillsCode() {
		return billsCode;
	}

	public void setBillsCode(String billsCode) {
		this.billsCode = billsCode;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	@NotNull(message="账单编号不能为空")
	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}


	public void setConfirmEmployee(User confirmEmployee) {
		this.confirmEmployee = confirmEmployee;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
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

	public BigDecimal getPrepaidAmount() {
		return prepaidAmount;
	}

	public void setPrepaidAmount(BigDecimal prepaidAmount) {
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

	public PaymentBillRecord getErpPaymentBillRecord() {
		return erpPaymentBillRecord;
	}

	public void setErpPaymentBillRecord(PaymentBillRecord erpPaymentBillRecord) {
		this.erpPaymentBillRecord = erpPaymentBillRecord;
	}

	public ReceivableBill getReceivableBill() {
		return receivableBill;
	}

	public void setReceivableBill(ReceivableBill receivableBill) {
		this.receivableBill = receivableBill;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public User getCollectionEmployee() {
		return collectionEmployee;
	}

	public void setCollectionEmployee(User collectionEmployee) {
		this.collectionEmployee = collectionEmployee;
	}

	public User getConfirmEmployee() {
		return confirmEmployee;
	}

	public Long getFinaceId() {
		return finaceId;
	}

	public void setFinaceId(Long finaceId) {
		this.finaceId = finaceId;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public User getPayUser() {
		return payUser;
	}

	public void setPayUser(User payUser) {
		this.payUser = payUser;
	}

	public Long getPayCategory() {
		return payCategory;
	}

	public void setPayCategory(Long payCategory) {
		this.payCategory = payCategory;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}