/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.expenditure.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.orderrefund.entity.OrderRefund;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 付款账单Entity
 * @author 陆宽
 * @version 2018-07-04
 */
public class Expenditure extends DataVo<Expenditure> {
	
	private static final long serialVersionUID = 1L;
	private Long platformId;		// platform_id
	private String expenditureCode;		// 付款单号
	private Long orderRefundId;		// order_refund
	private String amount;		// 付款金额
	private Long typeId;		// 付款方式
	private Long payType;		// 付款类别ID
	private String remark;		// 备注
	private Date createTime;		// 创建时间
	private Long createUser;		// 创建人
	private Integer status;		// 审核状态
	private User payUser;       //付款人
	private Date payTime;       //付款时间
	private User user;


	private Date createTimeStart;
	private Date createTimeEnd;

	private Date payTimeStart;
	private Date payTimeEnd;

	private OrderRefund orderRefund;
	
	public Expenditure() {
		super();
	}

	public Expenditure(Long id){
		super(id);
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}
	
	@Length(min=0, max=25, message="付款单号长度必须介于 0 和 25 之间")
	public String getExpenditureCode() {
		return expenditureCode;
	}

	public void setExpenditureCode(String expenditureCode) {
		this.expenditureCode = expenditureCode;
	}

	public void setOrderRefundId(Long orderRefundId) {
		this.orderRefundId = orderRefundId;
	}

	public Long getOrderRefundId() {
		return orderRefundId;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	
	public Long getPayType() {
		return payType;
	}

	public void setPayType(Long payType) {
		this.payType = payType;
	}
	
	@Length(min=0, max=255, message="备注长度必须介于 0 和 255 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Long getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

	public void setOrderRefund(OrderRefund orderRefund) {
		this.orderRefund = orderRefund;
	}

	public OrderRefund getOrderRefund() {
		return orderRefund;
	}

	public void setPayUser(User payUser) {
		this.payUser = payUser;
	}

	public User getPayUser() {
		return payUser;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setCreateTimeStart(Date createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	public Date getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setPayTimeStart(Date payTimeStart) {
		this.payTimeStart = payTimeStart;
	}

	public Date getPayTimeStart() {
		return payTimeStart;
	}

	public void setPayTimeEnd(Date payTimeEnd) {
		this.payTimeEnd = payTimeEnd;
	}

	public Date getPayTimeEnd() {
		return payTimeEnd;
	}
}