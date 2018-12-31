/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.family.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 客户家庭信息Entity
 * @author jiayw
 * @version 2018-03-05
 */
public class Family extends DataVo<Family> {
	
	private static final long serialVersionUID = 1L;
	private Long customerId;		// 客户id
	private String peoples;		// 家庭人数
	private String member;		// 家庭成员
	private Integer babyStatus;		// 有无宝宝
	private String babyNumber;		// 宝宝数量
	private Long relation;		// 客户与宝宝的关系
	private String rests;		// 其他
	private String fatherName;		// 宝爸姓名
	private String fatherPhone;		// 宝爸联系方式
	private Date fatherBirthTime;		// 宝爸出生日期
	private Long fatherConstellation;		// 宝爸星座
	private Long fatherBlood;		// 宝爸血型
	private String fatherJob;		// 宝爸职业
	private String motherName;		// 宝妈姓名
	private String motherPhone;		// 宝妈联系方式
	private Date motherBirthTime;		// 宝妈出生日期
	private Long motherConstellation;		// 宝妈星座
	private Long motherBlood;		// 宝妈血型
	private String motherJob;		// 宝妈职业
	
	public Family() {
		super();
	}

	public Family(Long id){
		super(id);
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	
	@Length(min=0, max=128, message="家庭人数长度必须介于 0 和 128 之间")
	public String getPeoples() {
		return peoples;
	}

	public void setPeoples(String peoples) {
		this.peoples = peoples;
	}
	
	@Length(min=0, max=128, message="家庭成员长度必须介于 0 和 128 之间")
	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}
	
	public Integer getBabyStatus() {
		return babyStatus;
	}

	public void setBabyStatus(Integer babyStatus) {
		this.babyStatus = babyStatus;
	}
	
	@Length(min=0, max=128, message="宝宝数量长度必须介于 0 和 128 之间")
	public String getBabyNumber() {
		return babyNumber;
	}

	public void setBabyNumber(String babyNumber) {
		this.babyNumber = babyNumber;
	}
	
	public Long getRelation() {
		return relation;
	}

	public void setRelation(Long relation) {
		this.relation = relation;
	}
	
	@Length(min=0, max=128, message="其他长度必须介于 0 和 128 之间")
	public String getRests() {
		return rests;
	}

	public void setRests(String rests) {
		this.rests = rests;
	}
	
	@Length(min=0, max=128, message="宝爸姓名长度必须介于 0 和 128 之间")
	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}
	
	@Length(min=0, max=128, message="宝爸联系方式长度必须介于 0 和 128 之间")
	public String getFatherPhone() {
		return fatherPhone;
	}

	public void setFatherPhone(String fatherPhone) {
		this.fatherPhone = fatherPhone;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFatherBirthTime() {
		return fatherBirthTime;
	}

	public void setFatherBirthTime(Date fatherBirthTime) {
		this.fatherBirthTime = fatherBirthTime;
	}
	
	public Long getFatherConstellation() {
		return fatherConstellation;
	}

	public void setFatherConstellation(Long fatherConstellation) {
		this.fatherConstellation = fatherConstellation;
	}
	
	public Long getFatherBlood() {
		return fatherBlood;
	}

	public void setFatherBlood(Long fatherBlood) {
		this.fatherBlood = fatherBlood;
	}
	
	@Length(min=0, max=128, message="宝爸职业长度必须介于 0 和 128 之间")
	public String getFatherJob() {
		return fatherJob;
	}

	public void setFatherJob(String fatherJob) {
		this.fatherJob = fatherJob;
	}
	
	@Length(min=0, max=128, message="宝妈姓名长度必须介于 0 和 128 之间")
	public String getMotherName() {
		return motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}
	
	@Length(min=0, max=128, message="宝妈联系方式长度必须介于 0 和 128 之间")
	public String getMotherPhone() {
		return motherPhone;
	}

	public void setMotherPhone(String motherPhone) {
		this.motherPhone = motherPhone;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getMotherBirthTime() {
		return motherBirthTime;
	}

	public void setMotherBirthTime(Date motherBirthTime) {
		this.motherBirthTime = motherBirthTime;
	}
	
	public Long getMotherConstellation() {
		return motherConstellation;
	}

	public void setMotherConstellation(Long motherConstellation) {
		this.motherConstellation = motherConstellation;
	}
	
	public Long getMotherBlood() {
		return motherBlood;
	}

	public void setMotherBlood(Long motherBlood) {
		this.motherBlood = motherBlood;
	}
	
	@Length(min=0, max=128, message="宝妈职业长度必须介于 0 和 128 之间")
	public String getMotherJob() {
		return motherJob;
	}

	public void setMotherJob(String motherJob) {
		this.motherJob = motherJob;
	}
	
}