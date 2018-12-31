/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.customer.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.baby.entity.CustomerBaby;
import cn.com.beyo.erp.modules.crm.customerdelegate.entity.CustomerDelegateRecord;
import cn.com.beyo.erp.modules.crm.family.entity.Family;
import cn.com.beyo.erp.modules.crm.information.entity.Information;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 考核权重Entity
 * @author beyo.com.cn
 * @version 2017-06-30
 */
public class Customer extends DataVo<Customer> {

	private String code;		// 客户编号
	private String name;		// 客户姓名
	private Integer sex;		// 客户性别
	private String phone;		// 手机号码
	private Integer type;		// 客户类型 （1母婴客户，2服务员工，3早教客户，4学校生源）CustomerType
	private String email;		// 邮箱地址
	private Long  region;		// 地区
	private String address;		// 详情地址
	private String qqCode;		//客户QQ
	private CustomerResource customerResource;//客户来源
	private Long  recommendId;		//推荐人recommend_user
	private Date birthTime;		// 出生日期


	private User user;             //添加人
	private User follow;   			//跟进人
	private String abandonReason;  	//放弃跟进原因
	private Date delegateTime;      //委派时间
	private Date delegateStartTime;  //委派开始时间
	private Date delegateEndTime;  	 //委派结束时间
	private Integer meClientFlagValue;//业务字段：是否为我获取的客户的value
	private String meClientFlagName; //业务字段：是否为我获取的客户的key
	private int customerCount;   	 //业务字段：统计客户的跟进次数
	private Date maxFollowTime;      //业务字段：同一个人最大的跟进时间
	private Date followStartTime;    //业务字段：最近跟进开始时间
	private Date followEndTime;		 //业务字段：最近跟进结束时间
	private Integer flag;    	 	 //业务字段：待跟进客户和跟进客户标识

	private Area area ;//地区
	private Date startTime;    //业务时间字段
	private Date endTime;
	private User creater;
	private Integer customerStatus;		//客户状态CustomerStatus
	private Integer	customerIntention;	//客户意向（1 潜在客户，2 犹豫客户， 3 无意向客户， 4 准意向客户，5 成交客户，6 退费客户） CustomerIntentionStatus

	private User infoCollect;		//信息获取人
	private Integer delegateStatus; //委派状态
	private Integer followStatus ;// 跟进状态
	private CustomerDelegateRecord customerDelegateRecord;//委派记录表
	private Family family;		//家庭信息
	private CustomerBaby customerBaby;	//宝宝信息
	private Information information;	//扩展信息

	private int customerDeleCount;    //业务字段：委派中统计委派次数

	public int getCustomerDeleCount() {
		return customerDeleCount;
	}

	public void setCustomerDeleCount(int customerDeleCount) {
		this.customerDeleCount = customerDeleCount;
	}

	public Information getInformation() {
		return information;
	}

	public void setInformation(Information information) {
		this.information = information;
	}

	public Family getFamily() {
		return family;
	}

	public void setFamily(Family family) {
		this.family = family;
	}

	public CustomerBaby getCustomerBaby() {
		return customerBaby;
	}

	public void setCustomerBaby(CustomerBaby customerBaby) {
		this.customerBaby = customerBaby;
	}

	public CustomerDelegateRecord getCustomerDelegateRecord() {
		return customerDelegateRecord;
	}

	public void setCustomerDelegateRecord(CustomerDelegateRecord customerDelegateRecord) {
		this.customerDelegateRecord = customerDelegateRecord;
	}

	public Integer getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(Integer followStatus) {
		this.followStatus = followStatus;
	}

	public Integer getDelegateStatus() {
		return delegateStatus;
	}

	public void setDelegateStatus(Integer delegateStatus) {
		this.delegateStatus = delegateStatus;
	}

	public User getCreater() {return creater;}

	public void setCreater(User creater) {this.creater = creater;}

	public Integer getCustomerIntention() {
		return customerIntention;
	}

	public void setCustomerIntention(Integer customerIntention) {
		this.customerIntention = customerIntention;
	}

	public Integer getCustomerStatus() {
		return customerStatus;
	}

	public void setCustomerStatus(Integer customerStatus) {
		this.customerStatus = customerStatus;
	}

	public User getInfoCollect() {
		return infoCollect;
	}

	public void setInfoCollect(User infoCollect) {
		this.infoCollect = infoCollect;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getBirthTime() {
		return birthTime;
	}

	public void setBirthTime(Date birthTime) {
		this.birthTime = birthTime;
	}

	public Long getRecommendId() {return recommendId;}

	public void setRecommendId(Long recommendId) {this.recommendId = recommendId;}

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

	public Long getRegion() {
		return region;
	}

	public void setRegion(Long region) {
		this.region = region;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}


	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	public Customer() {
		super();
	}

	public Customer(Long id){
		super(id);
	}



	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getQqCode() {
		return qqCode;
	}

	public void setQqCode(String qqCode) {
		this.qqCode = qqCode;
	}

	@Length(min=0, max=128, message="邮箱地址长度必须介于 0 和 128 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Length(min=0, max=200, message="详情地址长度必须介于 0 和 200 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public User getFollow() {
		return follow;
	}

	public void setFollow(User follow) {
		this.follow = follow;
	}

	public String getAbandonReason() {
		return abandonReason;
	}

	public void setAbandonReason(String abandonReason) {
		this.abandonReason = abandonReason;
	}

	public Date getDelegateTime() {
		return delegateTime;
	}

	public void setDelegateTime(Date delegateTime) {
		this.delegateTime = delegateTime;
	}

	public Date getDelegateStartTime() {
		return delegateStartTime;
	}

	public void setDelegateStartTime(Date delegateStartTime) {
		this.delegateStartTime = delegateStartTime;
	}

	public Date getDelegateEndTime() {
		return delegateEndTime;
	}

	public void setDelegateEndTime(Date delegateEndTime) {
		this.delegateEndTime = delegateEndTime;
	}


	public int getCustomerCount() {
		return customerCount;
	}

	public void setCustomerCount(int customerCount) {
		this.customerCount = customerCount;
	}

	public Date getMaxFollowTime() {
		return maxFollowTime;
	}

	public void setMaxFollowTime(Date maxFollowTime) {
		this.maxFollowTime = maxFollowTime;
	}

	public Date getFollowStartTime() {
		return followStartTime;
	}

	public void setFollowStartTime(Date followStartTime) {
		this.followStartTime = followStartTime;
	}

	public Date getFollowEndTime() {
		return followEndTime;
	}

	public void setFollowEndTime(Date followEndTime) {
		this.followEndTime = followEndTime;
	}

	public Integer getMeClientFlagValue() {
		return meClientFlagValue;
	}

	public void setMeClientFlagValue(Integer meClientFlagValue) {
		this.meClientFlagValue = meClientFlagValue;
	}

	public String getMeClientFlagName() {
		return meClientFlagName;
	}

	public void setMeClientFlagName(String meClientFlagName) {
		this.meClientFlagName = meClientFlagName;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}
}