/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.orderrefundrecord.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.orderrefund.entity.OrderRefund;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 订单退款记录Entity
 * @author 陆宽
 * @version 2018-07-06
 */
public class OrderRefundRecord extends DataVo<OrderRefundRecord> {
	
	private static final long serialVersionUID = 1L;
	private Long platformId;		// platform_id
	private OrderRefund orderRefund; //退费单
	private String remark;		// 备注
	private Long operationUserId;		// 操作人
	private Integer status;		// 状态
	private Date operationTime;		// 操作时间
	private Date createTime;		// 创建时间
	private Long createUser;		// 创建人

	private User operater;
	private User creater;
	
	public OrderRefundRecord() {
		super();
	}

	public OrderRefundRecord(Long id){
		super(id);
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}
	
	@Length(min=0, max=200, message="备注长度必须介于 0 和 200 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public Long getOperationUserId() {
		return operationUserId;
	}

	public void setOperationUserId(Long operationUserId) {
		this.operationUserId = operationUserId;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
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

	public void setOrderRefund(OrderRefund orderRefund) {
		this.orderRefund = orderRefund;
	}

	public OrderRefund getOrderRefund() {
		return orderRefund;
	}

	public void setOperater(User operater) {
		this.operater = operater;
	}

	public User getOperater() {
		return operater;
	}

	public void setCreater(User creater) {
		this.creater = creater;
	}

	public User getCreater() {
		return creater;
	}
}