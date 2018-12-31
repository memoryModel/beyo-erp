/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.baby.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 宝宝信息Entity
 * @author jiayw
 * @version 2018-03-05
 */
public class CustomerBaby extends DataVo<CustomerBaby> {
	
	private static final long serialVersionUID = 1L;
	private Long customerId;		// 客户id
	private String name;		// 宝宝姓名
	private Integer sex;		// 宝宝性别
	private Date birthTime;		// 宝宝出生日期
	
	public CustomerBaby() {
		super();
	}

	public CustomerBaby(Long id){
		super(id);
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	
	@Length(min=0, max=128, message="宝宝姓名长度必须介于 0 和 128 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBirthTime() {
		return birthTime;
	}

	public void setBirthTime(Date birthTime) {
		this.birthTime = birthTime;
	}
	
}