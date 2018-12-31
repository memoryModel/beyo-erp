/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.customerresource.entity;

import cn.com.beyo.erp.commons.persistence.TreeVo;
import org.hibernate.validator.constraints.Length;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 客户来源Entity
 * @author beyo.com.cn
 * @version 2017-06-05
 */
public class CustomerResource extends TreeVo<CustomerResource> {  //TreeVo

	private String customerName;   // 来源类型名称
	private String description;	   // 描述
	private String createDateStr;//时间转换业务字段
	private Long number;           //序号

	private Date startTime;    //业务时间字段
	private Date endTime;



	//构造函数方法
	public CustomerResource(Long id) {
		super(id);
	}




	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}


	/////////////////////
	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(Date lkj) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		createDateStr = sdf.format(lkj);
		this.createDateStr = createDateStr;
	}

	public Long getNumber() {
		return number;
	}

	public void setNumber(Long number) {
		this.number = number;
	}


	public CustomerResource() {
		super();
	}

	@Override
	public CustomerResource getParent() {
		return parent;
	}

	@Override
	public void setParent(CustomerResource parent) {
		this.parent = parent;
	}



	@Length(min=0, max=215, message="parent_ids长度必须介于 0 和 215 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	@Length(min=0, max=64, message="名称长度必须介于 0 和 64 之间")
	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}






}