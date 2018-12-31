/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.order.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.customer.entity.Customer;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.erp.orderrefund.entity.OrderRefund;
import cn.com.beyo.erp.modules.erp.paymentbill.entity.PaymentBill;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.invoice.entity.Invoice;
import cn.com.beyo.erp.modules.sys.entity.User;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-01
 */
public class Order extends DataVo<Order> {

	private Order extendOrder;			//续单，为空是新单，id是旧订单的id
	private String orderCode;		// 订单号
	private Integer payStatus;       //交费状态
	private Long payType;			//订单支付类型
	private Integer refundStatus;   //退费状态
	private Date payTime;			//支付时间
	private Date finishTime;		//结束时间
	private Integer orderType; //订单类别  1，报名；2，服务
	private BigDecimal favorableAmount;    //优惠金额
	private BigDecimal paymentAmount;//支付金额
	private BigDecimal overallAmount;//总金额
	private Integer num;			//商品总件数
	private Integer sign;			//是否线下签约
	private Integer signStatus;		//如果线下签约，签约状态


	//客户订单
	private User sale;							//销售顾问
	private CustomerResource customerResource;	//客户来源
	private Customer customer;					//客户
	private OrderContract contract;				//合同
	private ReceivableBill receivableBill;//应收账单

	//财务
	private OrderRefund orderRefund; //退费Id
	private PaymentBill erpPaymentBill;  //收款单

	//学校订单
	private cn.com.beyo.erp.modules.school.student.entity.Student student;
	private SchoolClass schoolClass;
	private Integer feeStatus;
	private ClassStudents classStudents;
	private User teacher;//班主任
	//发票
	private Invoice invoice;




	//查询
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private Date finishTimeStart;   //完成时间开始
	private Date finishTimeEnd;   //完成时间结束
	private Date payTimeStart;   //支付时间开始
	private Date payTimeEnd;   //支付时间结束

	public Long getPayType() {
		return payType;
	}

	public void setPayType(Long payType) {
		this.payType = payType;
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



	public Integer getOrderType() {
		return orderType;
	}

	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}

	public Order() {
		super();
	}

	public Order(Long id){
		super(id);
	}

	public Integer getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(Integer payStatus) {
		this.payStatus = payStatus;
	}

	public Integer getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(Integer refundStatus) {
		this.refundStatus = refundStatus;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public OrderRefund getOrderRefund() {
		return orderRefund;
	}

	public void setOrderRefund(OrderRefund orderRefund) {
		this.orderRefund = orderRefund;
	}


	public BigDecimal getFavorableAmount() {
		return favorableAmount;
	}

	public void setFavorableAmount(BigDecimal favorableAmount) {
		this.favorableAmount = favorableAmount;
	}

	public BigDecimal getOverallAmount() {
		return overallAmount;
	}

	public void setOverallAmount(BigDecimal overallAmount) {
		this.overallAmount = overallAmount;
	}

	public BigDecimal getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(BigDecimal paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public PaymentBill getErpPaymentBill() {
		return erpPaymentBill;
	}

	public void setErpPaymentBill(PaymentBill erpPaymentBill) {
		this.erpPaymentBill = erpPaymentBill;
	}


	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public ReceivableBill getReceivableBill() {
		return receivableBill;
	}

	public void setReceivableBill(ReceivableBill receivableBill) {
		this.receivableBill = receivableBill;
	}

	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}

	public Date getFinishTimeStart() {
		return finishTimeStart;
	}

	public void setFinishTimeStart(Date finishTimeStart) {
		this.finishTimeStart = finishTimeStart;
	}

	public Date getFinishTimeEnd() {
		return finishTimeEnd;
	}

	public void setFinishTimeEnd(Date finishTimeEnd) {
		this.finishTimeEnd = finishTimeEnd;
	}

	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	public User getSale() {
		return sale;
	}

	public void setSale(User sale) {
		this.sale = sale;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Order getExtendOrder() {
		return extendOrder;
	}

	public void setExtendOrder(Order extendOrder) {
		this.extendOrder = extendOrder;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public Date getPayTimeStart() {
		return payTimeStart;
	}

	public void setPayTimeStart(Date payTimeStart) {
		this.payTimeStart = payTimeStart;
	}

	public Date getPayTimeEnd() {
		return payTimeEnd;
	}

	public void setPayTimeEnd(Date payTimeEnd) {
		this.payTimeEnd = payTimeEnd;
	}

	public OrderContract getContract() {
		return contract;
	}

	public void setContract(OrderContract contract) {
		this.contract = contract;
	}

	public Integer getSign() {
		return sign;
	}

	public void setSign(Integer sign) {
		this.sign = sign;
	}

	public Integer getSignStatus() {
		return signStatus;
	}

	public void setSignStatus(Integer signStatus) {
		this.signStatus = signStatus;
	}


	public cn.com.beyo.erp.modules.school.student.entity.Student getStudent() {
		return student;
	}

	public void setStudent(cn.com.beyo.erp.modules.school.student.entity.Student student) {
		this.student = student;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public Integer getFeeStatus() {
		return feeStatus;
	}

	public void setFeeStatus(Integer feeStatus) {
		this.feeStatus = feeStatus;
	}

	public Invoice getInvoice() {
		return invoice;
	}

	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}

	public void setClassStudents(ClassStudents classStudents) {
		this.classStudents = classStudents;
	}

	public ClassStudents getClassStudents() {
		return classStudents;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}

	public User getTeacher() {
		return teacher;
	}
}