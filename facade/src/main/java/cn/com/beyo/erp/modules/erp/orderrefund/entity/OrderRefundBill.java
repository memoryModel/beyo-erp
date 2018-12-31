/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.orderrefund.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.finacetype.entity.FinaceType;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 退费表（子表）Entity
 * @author beyo.com.cn
 * @version 2017-06-28
 */
public class OrderRefundBill extends DataVo<OrderRefundBill> {
	
	private static final long serialVersionUID = 1L;
	private OrderRefund orderRefund; //账单
	private Long refundType;	// 退款类别
	private FinaceType erpFinaceType;  //退款科目
	private BigDecimal refundAmount;		// 退费金额
	private BigDecimal deductAmount;		// 扣款金额
	private Date createTimeStart;   //创建开始时间
	private Date createTimeEnd;		//创建结束时间

	private BigDecimal aggregateAmount;  //
	public OrderRefundBill() {
		super();
	}

	public OrderRefundBill(Long id){
		super(id);
	}

	public OrderRefund getOrderRefund() {
		return orderRefund;
	}


	public BigDecimal getAggregateAmount() {
		return aggregateAmount;
	}

	public void setAggregateAmount(BigDecimal aggregateAmount) {
		this.aggregateAmount = aggregateAmount;
	}

	public void setOrderRefund(OrderRefund orderRefund) {
		this.orderRefund = orderRefund;
	}

	public FinaceType getErpFinaceType() {
		return erpFinaceType;
	}

	public void setErpFinaceType(FinaceType erpFinaceType) {
		this.erpFinaceType = erpFinaceType;
	}

	@NotNull(message="退费金额不能为空")
	public BigDecimal getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
	
	@NotNull(message="扣款金额不能为空")
	public BigDecimal getDeductAmount() {
		return deductAmount;
	}

	public void setDeductAmount(BigDecimal deductAmount) {
		this.deductAmount = deductAmount;
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

	public Long getRefundType() {
		return refundType;
	}

	public void setRefundType(Long refundType) {
		this.refundType = refundType;
	}
}