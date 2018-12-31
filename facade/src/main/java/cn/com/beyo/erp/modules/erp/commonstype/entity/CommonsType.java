/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.commonstype.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 基础类型Entity
 * @author beyo.com.cn
 * @version 2017-06-01
 */
public class CommonsType extends DataVo<CommonsType> {

	private String commonsName;		// 名称
	private String description;		// 描述
	private Integer category;		// category
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

	public CommonsType() {
		super();
	}

	public CommonsType(Long id){
		super(id);
	}


	@Length(min=0, max=255, message="名称长度必须介于 0 和 255 之间")
	public String getCommonsName() {
		return commonsName;
	}

	public void setCommonsName(String commonsName) {
		this.commonsName = commonsName;
	}

	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getCategory() {
		return category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}



}