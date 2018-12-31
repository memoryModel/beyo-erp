/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.employeeskill.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.entry.entity.Entry;
import cn.com.beyo.erp.modules.crm.serivcelevel.entity.ServiceLevel;
import cn.com.beyo.erp.modules.crm.skill.entity.Skill;
import cn.com.beyo.erp.modules.crm.skillToLevel.entity.SkillToLevel;
import cn.com.beyo.erp.modules.crm.skillweight.entity.CrmSkillWeight;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 员工技能Entity
 * @author beyo.com.cn
 * @version 2017-07-19
 */
public class EmployeeSkill extends DataVo<EmployeeSkill> {

	private Employee employee;//员工
	private Skill skill;		// 技能
	private ServiceLevel systemServiceLevel; //系统星级
	private ServiceLevel serviceLevel;		// 星级
	private BigDecimal score;               // 得分
	private BigDecimal servicePrice;		// 结算价格
	private Integer type; //类型
	private User skillUser;      //定级人
	private Date skillTime;      //定级时间
	private User passSkillUser;  //审核人
	private Date passSkillTime;  //审核时间
	private String passSkillContent; //审核意见
	private SkillToLevel skillToLevel;
	private Entry entry;
	private Integer gradeType;//升降级区分
	private Integer numberType;// 服务单数和完美单数区分 0:星级管理里的服务单数和完美单数 1:服务管理里的服务单数和完美单数
	private BigDecimal renewalAmount;   //续约改变的单项服务价格
	private Integer renewStatus;   //续约状态（0、技能项续约审批成功  1、技能想续约审批失败）

	//业务字段
	private List<CrmSkillWeight> skillWeightList;


	@JsonIgnore
	private String skillLevel;
	@JsonIgnore
	private int serviceNumber; //服务单数
	@JsonIgnore
	private int perfectNumber;//完美单数



	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public EmployeeSkill() {
		super();
	}

	public EmployeeSkill(Long id){
		super(id);
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

	public SkillToLevel getSkillToLevel() {
		return skillToLevel;
	}

	public void setSkillToLevel(SkillToLevel skillToLevel) {
		this.skillToLevel = skillToLevel;
	}

	public BigDecimal getServicePrice() {
		return servicePrice;
	}

	public void setServicePrice(BigDecimal servicePrice) {
		this.servicePrice = servicePrice;
	}

	public String getSkillLevel() {
		return skillLevel;
	}

	public void setSkillLevel(String skillLevel) {
		this.skillLevel = skillLevel;
	}

	public Entry getEntry() {
		return entry;
	}

	public void setEntry(Entry entry) {
		this.entry = entry;
	}

	public void setSystemServiceLevel(ServiceLevel systemServiceLevel) {
		this.systemServiceLevel = systemServiceLevel;
	}

	public ServiceLevel getSystemServiceLevel() {
		return systemServiceLevel;
	}

	public void setScore(BigDecimal score) {
		this.score = score;
	}

	public BigDecimal getScore() {
		return score;
	}

	public List<CrmSkillWeight> getSkillWeightList() {
		return skillWeightList;
	}

	public void setSkillWeightList(List<CrmSkillWeight> skillWeightList) {
		this.skillWeightList = skillWeightList;
	}

	public void setSkillUser(User skillUser) {
		this.skillUser = skillUser;
	}

	public User getSkillUser() {
		return skillUser;
	}

	public void setSkillTime(Date skillTime) {
		this.skillTime = skillTime;
	}

	public Date getSkillTime() {
		return skillTime;
	}

	public void setPassSkillUser(User passSkillUser) {
		this.passSkillUser = passSkillUser;
	}

	public User getPassSkillUser() {
		return passSkillUser;
	}

	public void setPassSkillTime(Date passSkillTime) {
		this.passSkillTime = passSkillTime;
	}

	public Date getPassSkillTime() {
		return passSkillTime;
	}

	public void setPassSkillContent(String passSkillContent) {
		this.passSkillContent = passSkillContent;
	}

	public String getPassSkillContent() {
		return passSkillContent;
	}

	public Integer getGradeType() {
		return gradeType;
	}

	public void setGradeType(Integer gradeType) {
		this.gradeType = gradeType;
	}

	public BigDecimal getRenewalAmount() {
		return renewalAmount;
	}

	public void setRenewalAmount(BigDecimal renewalAmount) {
		this.renewalAmount = renewalAmount;
	}

	public int getServiceNumber() {
		return serviceNumber;
	}

	public void setServiceNumber(int serviceNumber) {
		this.serviceNumber = serviceNumber;
	}

	public int getPerfectNumber() {
		return perfectNumber;
	}

	public void setPerfectNumber(int perfectNumber) {
		this.perfectNumber = perfectNumber;
	}

	public Integer getNumberType() {
		return numberType;
	}

	public void setNumberType(Integer numberType) {
		this.numberType = numberType;
	}

	public Integer getRenewStatus() {
		return renewStatus;
	}

	public void setRenewStatus(Integer renewStatus) {
		this.renewStatus = renewStatus;
	}
}