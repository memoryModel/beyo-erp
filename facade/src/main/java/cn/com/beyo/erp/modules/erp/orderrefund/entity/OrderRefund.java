/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.orderrefund.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.expenditure.entity.Expenditure;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.orderrefundrecord.entity.OrderRefundRecord;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 退费表Entity
 * @author beyo.com.cn
 * @version 2017-06-01
 */
public class OrderRefund extends DataVo<OrderRefund> {

	private static final long serialVersionUID = 1L;
	private String financialBillsCode;	// 编号
	private Order order;  //订单
	private Integer paymentType; //付款方式
	private Integer  billId;  //应收账单ID
	private BigDecimal tuitionWithholdAmount; //学费扣款金额
	private BigDecimal tuitionReturnAmount;  //学费退费金额
	private BigDecimal miscellaneousWithholdAmount; //学杂费扣款金额
	private BigDecimal miscellaneousReturnAmount;  //学杂费退费金额
	private BigDecimal grossAmount; //退费总金额
	/*private Integer confirmId;*/ //退费审核人ID
	private Employee auditEmployee;     //退费审核人
	private Employee expenditureEmployee; //支出确认人
	private Date  expenditureTime;    //支出确认时间
	private Employee paymentEmployee;  //付款人
	private Date paymentTime;   //付款确认时间
	private Date paymentTimeStart; //付款开始时间
	private Date paymentTimeEnd; //付款结束时间
	private String accountName;		// 持卡人
	private String accountBank;		// 开户银行
	private String bankCardNumber;		// 银行卡号
	private Integer receipts;     //单据是否退还
	private String remark;   //退费原因
	private Integer paymentStatus; //付款状态
	private Integer expenditureStatus; //支出状态
	private Date createTimeStart; //创建开始时间
	private Date createTimeEnd;   //创建结束时间
	private Integer type;         //业务类别 0:培训服务
	private Integer refundType;   //退款类型 0:学费退款
	private Date financeCreateTime; //业务以审核就是财务待审核时间
	private Date financeAuditTime;      //财务已审核时间

	private BigDecimal prepaidAmountRefund;		// 预付金
	private BigDecimal tuitionAmountRefund;		// 学费
	private BigDecimal miscellaneousAmountRefund;		// 学杂费
	private BigDecimal depositAmountRefund;		// 保证金
	private BigDecimal insuranceAmountRefund;		// 保险费
	private String reason;                     //审核通过/未通过原因

	private OrderRefundBill orderRefundBill;
	private Expenditure expenditure;         //业务字段 付款单
	private Integer applyQueryStatus;        //业务字段 用于查询业务待审核 财务待审核 待退款 已退款状态的退费列表
	private Date financeAuditTimeStart;     //业务字段 用于查询财务审核时间
	private Date financeAuditTimeEnd;       //业务字段 用于查询财务审核时间
	private List<OrderRefundRecord> orderRefundRecordList;  //业务字段
	private ReceivableBill receivableBill;  //业务字段

	public OrderRefund() {
		super();
	}

	public OrderRefund(Long id){
		super(id);
	}

	public String getFinancialBillsCode() {
		return financialBillsCode;
	}

	public void setFinancialBillsCode(String financialBillsCode) {
		this.financialBillsCode = financialBillsCode;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Integer getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(Integer paymentType) {
		this.paymentType = paymentType;
	}

	public Integer getBillId() {
		return billId;
	}

	public void setBillId(Integer billId) {
		this.billId = billId;
	}

	public BigDecimal getGrossAmount() {
		return grossAmount;
	}

	public void setGrossAmount(BigDecimal grossAmount) {
		this.grossAmount = grossAmount;
	}

	public Employee getAuditEmployee() {
		return auditEmployee;
	}

	public void setAuditEmployee(Employee auditEmployee) {
		this.auditEmployee = auditEmployee;
	}

	public Employee getPaymentEmployee() {
		return paymentEmployee;
	}

	public void setPaymentEmployee(Employee paymentEmployee) {
		this.paymentEmployee = paymentEmployee;
	}


	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountBank() {
		return accountBank;
	}

	public void setAccountBank(String accountBank) {
		this.accountBank = accountBank;
	}

	public String getBankCardNumber() {
		return bankCardNumber;
	}

	public void setBankCardNumber(String bankCardNumber) {
		this.bankCardNumber = bankCardNumber;
	}

	public Integer getReceipts() {
		return receipts;
	}

	public void setReceipts(Integer receipts) {
		this.receipts = receipts;
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

	public BigDecimal getPrepaidAmountRefund() {
		return prepaidAmountRefund;
	}

	public void setPrepaidAmountRefund(BigDecimal prepaidAmountRefund) {
		this.prepaidAmountRefund = prepaidAmountRefund;
	}

	public BigDecimal getTuitionAmountRefund() {
		return tuitionAmountRefund;
	}

	public void setTuitionAmountRefund(BigDecimal tuitionAmountRefund) {
		this.tuitionAmountRefund = tuitionAmountRefund;
	}

	public BigDecimal getMiscellaneousAmountRefund() {
		return miscellaneousAmountRefund;
	}

	public void setMiscellaneousAmountRefund(BigDecimal miscellaneousAmountRefund) {
		this.miscellaneousAmountRefund = miscellaneousAmountRefund;
	}

	public BigDecimal getDepositAmountRefund() {
		return depositAmountRefund;
	}

	public void setDepositAmountRefund(BigDecimal depositAmountRefund) {
		this.depositAmountRefund = depositAmountRefund;
	}

	public BigDecimal getInsuranceAmountRefund() {
		return insuranceAmountRefund;
	}

	public void setInsuranceAmountRefund(BigDecimal insuranceAmountRefund) {
		this.insuranceAmountRefund = insuranceAmountRefund;
	}

	public Employee getExpenditureEmployee() {
		return expenditureEmployee;
	}

	public void setExpenditureEmployee(Employee expenditureEmployee) {
		this.expenditureEmployee = expenditureEmployee;
	}

	public Date getExpenditureTime() {
		return expenditureTime;
	}

	public void setExpenditureTime(Date expenditureTime) {
		this.expenditureTime = expenditureTime;
	}

	public Date getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}

	public Date getPaymentTimeStart() {
		return paymentTimeStart;
	}

	public void setPaymentTimeStart(Date paymentTimeStart) {
		this.paymentTimeStart = paymentTimeStart;
	}

	public Date getPaymentTimeEnd() {
		return paymentTimeEnd;
	}

	public void setPaymentTimeEnd(Date paymentTimeEnd) {
		this.paymentTimeEnd = paymentTimeEnd;
	}

	public Integer getExpenditureStatus() {
		return expenditureStatus;
	}

	public void setExpenditureStatus(Integer expenditureStatus) {
		this.expenditureStatus = expenditureStatus;
	}

	public OrderRefundBill getOrderRefundBill() {
		return orderRefundBill;
	}

	public void setOrderRefundBill(OrderRefundBill orderRefundBill) {
		this.orderRefundBill = orderRefundBill;
	}

	public Integer getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(Integer paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public void setTuitionReturnAmount(BigDecimal tuitionReturnAmount) {
		this.tuitionReturnAmount = tuitionReturnAmount;
	}

	public BigDecimal getTuitionReturnAmount() {
		return tuitionReturnAmount;
	}

	public void setMiscellaneousReturnAmount(BigDecimal miscellaneousReturnAmount) {
		this.miscellaneousReturnAmount = miscellaneousReturnAmount;
	}

	public BigDecimal getMiscellaneousReturnAmount() {
		return miscellaneousReturnAmount;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getReason() {
		return reason;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getType() {
		return type;
	}

	public void setRefundType(Integer refundType) {
		this.refundType = refundType;
	}

	public Integer getRefundType() {
		return refundType;
	}

	public void setFinanceCreateTime(Date financeCreateTime) {
		this.financeCreateTime = financeCreateTime;
	}

	public Date getFinanceCreateTime() {
		return financeCreateTime;
	}

	public void setExpenditure(Expenditure expenditure) {
		this.expenditure = expenditure;
	}

	public Expenditure getExpenditure() {
		return expenditure;
	}

	public void setApplyQueryStatus(Integer applyQueryStatus) {
		this.applyQueryStatus = applyQueryStatus;
	}

	public Integer getApplyQueryStatus() {
		return applyQueryStatus;
	}

	public void setFinanceAuditTime(Date financeAuditTime) {
		this.financeAuditTime = financeAuditTime;
	}

	public Date getFinanceAuditTime() {
		return financeAuditTime;
	}

	public void setFinanceAuditTimeStart(Date financeAuditTimeStart) {
		this.financeAuditTimeStart = financeAuditTimeStart;
	}

	public Date getFinanceAuditTimeStart() {
		return financeAuditTimeStart;
	}

	public void setFinanceAuditTimeEnd(Date financeAuditTimeEnd) {
		this.financeAuditTimeEnd = financeAuditTimeEnd;
	}

	public Date getFinanceAuditTimeEnd() {
		return financeAuditTimeEnd;
	}

	public void setOrderRefundRecordList(List<OrderRefundRecord> orderRefundRecordList) {
		this.orderRefundRecordList = orderRefundRecordList;
	}

	public List<OrderRefundRecord> getOrderRefundRecordList() {
		return orderRefundRecordList;
	}

	public void setReceivableBill(ReceivableBill receivableBill) {
		this.receivableBill = receivableBill;
	}

	public ReceivableBill getReceivableBill() {
		return receivableBill;
	}

	public void setTuitionWithholdAmount(BigDecimal tuitionWithholdAmount) {
		this.tuitionWithholdAmount = tuitionWithholdAmount;
	}

	public BigDecimal getTuitionWithholdAmount() {
		return tuitionWithholdAmount;
	}

	public void setMiscellaneousWithholdAmount(BigDecimal miscellaneousWithholdAmount) {
		this.miscellaneousWithholdAmount = miscellaneousWithholdAmount;
	}

	public BigDecimal getMiscellaneousWithholdAmount() {
		return miscellaneousWithholdAmount;
	}
}