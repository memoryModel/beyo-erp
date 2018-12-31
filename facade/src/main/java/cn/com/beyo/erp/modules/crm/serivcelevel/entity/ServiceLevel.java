/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.serivcelevel.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 技能项Entity
 * @author beyo.com.cn
 * @version 2017-06-29
 */
public class ServiceLevel extends DataVo<ServiceLevel> {

	private String name;		// 等级名称
	private Integer orderNumber;		// 达标服务单数
	private Integer orderBili;		// 达标完美单数比例
	private Integer minScore;		// 达标最低分
	private Integer maxScore;		// 达标上限分
	private String description;		// 描述
	private Integer status;		// 状态
	private Date createTime;		// 创建时间
	private Long createUser;		// 创建人


	private  Date startTime;   //业务字段
	private Date endTime;


	//wanghw add
	private BigDecimal levelAmount;

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

	public ServiceLevel() {
		super();
	}

	public ServiceLevel(Long id){
		super(id);
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}
	
	@Length(min=0, max=215, message="等级名称长度必须介于 0 和 215 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}
	
	public Integer getOrderBili() {
		return orderBili;
	}

	public void setOrderBili(Integer orderBili) {
		this.orderBili = orderBili;
	}
	
	public Integer getMinScore() {
		return minScore;
	}

	public void setMinScore(Integer minScore) {
		this.minScore = minScore;
	}
	
	public Integer getMaxScore() {
		return maxScore;
	}

	public void setMaxScore(Integer maxScore) {
		this.maxScore = maxScore;
	}
	
	@Length(min=0, max=215, message="描述长度必须介于 0 和 215 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public BigDecimal getLevelAmount() {
		return levelAmount;
	}

	public void setLevelAmount(BigDecimal levelAmount) {
		this.levelAmount = levelAmount;
	}
}