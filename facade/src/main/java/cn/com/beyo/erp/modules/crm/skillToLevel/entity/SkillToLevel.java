/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.skillToLevel.entity;


import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.serivcelevel.entity.ServiceLevel;
import cn.com.beyo.erp.modules.crm.skill.entity.Skill;

import java.math.BigDecimal;

/**
 * 技能星级中间表Entity
 * @author Ashon
 * @version 2017-06-30
 */
public class SkillToLevel extends DataVo<SkillToLevel> {
	
	private static final long serialVersionUID = 1L;
	private Long skillId;		// skill_id
	private Long levelId;		// level_id
	private BigDecimal levelAmount;		// level_amount
	private ServiceLevel serviceLevel;
	private Skill skill;
	
	public SkillToLevel() {
		super();
	}

	public SkillToLevel(Long id){
		super(id);
	}

	public Long getSkillId() {
		return skillId;
	}

	public void setSkillId(Long skillId) {
		this.skillId = skillId;
	}
	
	public Long getLevelId() {
		return levelId;
	}

	public void setLevelId(Long levelId) {
		this.levelId = levelId;
	}

	public BigDecimal getLevelAmount() {
		return levelAmount;
	}

	public void setLevelAmount(BigDecimal levelAmount) {
		this.levelAmount = levelAmount;
	}

	public ServiceLevel getServiceLevel() {
		return serviceLevel;
	}

	public void setServiceLevel(ServiceLevel serviceLevel) {
		this.serviceLevel = serviceLevel;
	}

	public Skill getSkill() {
		return skill;
	}

	public void setSkill(Skill skill) {
		this.skill = skill;
	}
}