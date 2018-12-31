/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.information.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 客户扩展信息Entity
 * @author jiayw
 * @version 2018-03-05
 */
public class Information extends DataVo<Information> {
	
	private static final long serialVersionUID = 1L;
	private Long customerId;		// 客户id
	private Long credentials;		// 证件类型
	private String idNumber;		// 证件号码
	private String hospital;		// 分娩医院
	private String delivery;		// 分娩方式
	private Date deliveryTime;		// 预产期
	private String unit;		// 所属单位
	private String department;		// 所属部门
	private String job;		// 职位
	private Long education;		// 学历
	private String school;		// 毕业学校
	private Date graduationTime;		// 毕业时间
	private Long constellation;		// 星座
	private Long blood;		// 血型
	private String remark;		// 客户偏好
	
	public Information() {
		super();
	}

	public Information(Long id){
		super(id);
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	
	public Long getCredentials() {
		return credentials;
	}

	public void setCredentials(Long credentials) {
		this.credentials = credentials;
	}
	
	@Length(min=0, max=128, message="证件号码长度必须介于 0 和 128 之间")
	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}
	
	@Length(min=0, max=128, message="分娩医院长度必须介于 0 和 128 之间")
	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}
	
	@Length(min=0, max=128, message="分娩方式长度必须介于 0 和 128 之间")
	public String getDelivery() {
		return delivery;
	}

	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(Date deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	
	@Length(min=0, max=128, message="所属单位长度必须介于 0 和 128 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=128, message="所属部门长度必须介于 0 和 128 之间")
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
	@Length(min=0, max=128, message="职位长度必须介于 0 和 128 之间")
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	public Long getEducation() {
		return education;
	}

	public void setEducation(Long education) {
		this.education = education;
	}
	
	@Length(min=0, max=128, message="毕业学校长度必须介于 0 和 128 之间")
	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getGraduationTime() {
		return graduationTime;
	}

	public void setGraduationTime(Date graduationTime) {
		this.graduationTime = graduationTime;
	}
	
	public Long getConstellation() {
		return constellation;
	}

	public void setConstellation(Long constellation) {
		this.constellation = constellation;
	}
	
	public Long getBlood() {
		return blood;
	}

	public void setBlood(Long blood) {
		this.blood = blood;
	}
	
	@Length(min=0, max=128, message="客户偏好长度必须介于 0 和 128 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}