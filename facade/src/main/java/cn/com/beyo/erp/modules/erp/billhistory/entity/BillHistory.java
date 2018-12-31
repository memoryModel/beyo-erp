/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.billhistory.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 账单处理Entity
 * @author beyo.com.cn
 * @version 2017-07-06
 */
public class BillHistory extends DataVo<BillHistory> {
	
	private static final long serialVersionUID = 1L;
//	private Long receivableBillId;		// 应收账单ID
	private ReceivableBill erpReceivableBill; // 应收账单
	private Integer status;		// status
	private Date createTime;		// 创建时间
	private Long createUser;		// 创建人
	private String remark;		// 备注

	private Date lastDate;    //记录时间

	public Date getLastDate() {
		return lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

	public BillHistory() {
		super();
	}

	public BillHistory(Long id){
		super(id);
	}

	public ReceivableBill getErpReceivableBill() {
		return erpReceivableBill;
	}

	public void setErpReceivableBill(ReceivableBill erpReceivableBill) {
		this.erpReceivableBill = erpReceivableBill;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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
	
	@Length(min=0, max=1280, message="备注长度必须介于 0 和 1280 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}