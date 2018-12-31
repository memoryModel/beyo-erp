/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.skillweight.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 基础技能的权重记录Entity
 * @author 陆宽
 * @version 2018-01-05
 */
public class CrmSkillWeight extends DataVo<CrmSkillWeight> {
	
	private static final long serialVersionUID = 1L;
	private Long employeeSkillId; //员工定级表的id
	private Long skillId;		// 等级表的id
	private Long weightId;		// 权重表的id
	private BigDecimal weightScore;    //权重的得分
	private Long employeeId;		// 招工表的id
	private Integer status;		// 状态
	private Long createUser;		// 创建人
	private Date createTime;		// 创建时间

	
	public CrmSkillWeight() {
		super();
	}

	public CrmSkillWeight(Long id){
		super(id);
	}

	public void setSkillId(Long skillId) {
		this.skillId = skillId;
	}

	public Long getSkillId() {
		return skillId;
	}

	public Long getWeightId() {
		return weightId;
	}

	public void setWeightId(Long weightId) {
		this.weightId = weightId;
	}
	
	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Length(min=0, max=20, message="创建人长度必须介于 0 和 20 之间")
	public Long getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setWeightScore(BigDecimal weightScore) {
		this.weightScore = weightScore;
	}

	public BigDecimal getWeightScore() {
		return weightScore;
	}

	public Long getEmployeeSkillId() {
		return employeeSkillId;
	}

	public void setEmployeeSkillId(Long employeeSkillId) {
		this.employeeSkillId = employeeSkillId;
	}
}