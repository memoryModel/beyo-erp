/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.areas.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 所属校区Entity
 * @author beyo.com.cn
 * @version 2017-06-05
 */
public class Areas extends DataVo<Areas> {

	private static final long serialVersionUID = 1L;
	private String areaName;		// 名称
	private String description;		// 描述

	private Date startTime;    //业务时间字段
	private Date endTime;

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

	public Areas() {
		super();
	}

	public Areas(Long id){
		super(id);
	}

	@Length(min=0, max=512, message="名称长度必须介于 0 和 512 之间")
	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "Areas{" +
				"areaName='" + areaName + '\'' +
				", description='" + description + '\'' +
				", startTime=" + startTime +
				", endTime=" + endTime +
				", id=" + id +
				'}';
	}
}