/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.skill.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 技能项Entity
 * @author beyo.com.cn
 * @version 2017-06-29
 */
public class Skill extends DataVo<Skill> {

	private String skillName;		// 技能名称
	private Integer unit;		// 计价单位
	private Integer category;		// 类型
	private BigDecimal settlementPrice; //结算单价
	private String settlementTotalPrice; //服务人员结算单价
	private Date startTime;
	private Date endTime;



	private String unitName;   //业务字段  单位名称

	public Skill() {
		super();
	}

	public Skill(Long id){
		super(id);
	}
	
	@Length(min=0, max=512, message="技能名称长度必须介于 0 和 512 之间")
	public String getSkillName() {
		return skillName;
	}

	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
	
	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}
	
	public Integer getCategory() {
		return category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}



	public BigDecimal getSettlementPrice() {
		return settlementPrice;
	}

	public void setSettlementPrice(BigDecimal settlementPrice) {
		this.settlementPrice = settlementPrice;
	}

	public String getSettlementTotalPrice() {
		return settlementTotalPrice;
	}

	public void setSettlementTotalPrice(String settlementTotalPrice) {
		this.settlementTotalPrice = settlementTotalPrice;
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

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getUnitName() {
		return unitName;
	}
}