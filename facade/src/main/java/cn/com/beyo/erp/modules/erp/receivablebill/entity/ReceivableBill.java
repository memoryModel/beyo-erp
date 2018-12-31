/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.receivablebill.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.billhistory.entity.BillHistory;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.paymentbill.entity.PaymentBill;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;

/**
 * 应收账单Entity
 * @author Ashon
 * @version 2017-06-28
 */
public class ReceivableBill extends DataVo<ReceivableBill> {
	

	private String financialCode;   //财务编号
	private BigDecimal receivableAmount;		// 应收金额
	private BigDecimal deliveredAmount;		// 已交费用
	//private Integer billStatus;		// 账单状态

	private String description;		// 备注


	private Order order;  //订单
	private cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll; //学生
	private Employee employee; //员工
	private SchoolClass schoolClass; //班级
	private PaymentBill erpPaymentBill;//收款单

	private BillHistory billHistory;     //账单处理的记录

	@JsonIgnore
	private String lessonName;

	public BillHistory getBillHistory() {
		return billHistory;
	}

	public void setBillHistory(BillHistory billHistory) {
		this.billHistory = billHistory;
	}

	public ReceivableBill() {
		super();
	}

	public ReceivableBill(Long id){
		super(id);
	}

	public ReceivableBill(Order order){
		super();
		this.order = order;
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}

	public String getFinancialCode() {
		return financialCode;
	}

	public void setFinancialCode(String financialCode) {
		this.financialCode = financialCode;
	}

	public BigDecimal getReceivableAmount() {
		return receivableAmount;
	}

	public void setReceivableAmount(BigDecimal receivableAmount) {
		this.receivableAmount = receivableAmount;
	}
	
	public BigDecimal getDeliveredAmount() {
		return deliveredAmount;
	}

	public void setDeliveredAmount(BigDecimal deliveredAmount) {
		this.deliveredAmount = deliveredAmount;
	}
	
	@Length(min=0, max=1024, message="备注长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getErpStudentEnroll() {
		return erpStudentEnroll;
	}

	public void setErpStudentEnroll(cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll) {
		this.erpStudentEnroll = erpStudentEnroll;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public PaymentBill getErpPaymentBill() {
		return erpPaymentBill;
	}

	public void setErpPaymentBill(PaymentBill erpPaymentBill) {
		this.erpPaymentBill = erpPaymentBill;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getLessonName() {
		return lessonName;
	}

	public void setLessonName(String lessonName) {
		this.lessonName = lessonName;
	}
}