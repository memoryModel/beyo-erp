/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.employee.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.customer.entity.Customer;
import cn.com.beyo.erp.modules.crm.employeeskill.entity.EmployeeSkill;
import cn.com.beyo.erp.modules.crm.entry.entity.Entry;
import cn.com.beyo.erp.modules.crm.interview.entity.Interview;
import cn.com.beyo.erp.modules.crm.serivcelevel.entity.ServiceLevel;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.erp.employeecommunication.entity.EmployeeCommunication;
import cn.com.beyo.erp.modules.erp.employeeinfo.entity.EmployeeInfo;
import cn.com.beyo.erp.modules.erp.employresume.entity.EmployeeResume;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.google.common.base.Strings;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class Employee extends DataVo<Employee> {

	private String name;		// 员工姓名
	private Integer sex;		// 员工性别
	private String code;		// 工号
	private Date birthTime;		// 员工出生日期
	private String idcard;		// 身份证号
	private Long education;    //最高学历
	private String phone;		// 手机号码
	private String homePhone;		// 住宅电话
	private Long registerPlace;		// 户口性质
	private Long marriage;		// 婚姻状态
	private Long political;		// 政治面貌
	private Long english;	//外语等级
	private String serviceCity;	//服务城市
	private String serviceYear;		//服务年限
	private String profession;	//工种
	private List<Long> professionList;
	private Date jobTime;		// 参加工作日期
	private Date entryTime;		// 入职日期
	private Area currentArea;	//地区
	private Area originalArea;	//籍贯
	private String originalStreet;		// 籍贯(文本)
	private String currentStreet;		// 现住地（文本）
	private String remark;		// 备注
	private String emergencyContact;		// 紧急联系人
	private String emergencyContactPhone;		// 紧急联系人电话
	private Date leaveTime;		// 离职日期
	private String leaveReason;		// 离职原因
	private String email;		// 电子邮件
	private Long nation;		//民族
	private CustomerResource customerResource;	//来源
	private String  blood;	//血型
	private String constellation;	//星座
	private String motto;	//座右铭
	private String hobby;	//爱好
	private String language;	//外语种类
	private Integer	dormStatus;		//是否住宿
	private Long age;	//年龄
	private String specialityId;    //特长
	private List<Long> specialityList;
	private Integer signStatus;//签约状态   ContractSignStatus ，0 未签约  1 已签约
	private Integer employeeStatus;// 员工职位状态，  EmployeeStatus  0 在职 ，1 在岗，2 离职
	private Integer type;   //员工性质：员工制、劳务制
	private ServiceLevel serviceLevel; //星级





	private Entry entry;	//财务信息
	private EmployeeResume employeeResume;
	private EmployeeInfo employeeInfo;
	private EmployeeSkill employeeSkill;
	private Interview interview;
	private User creater;


	private Integer filter;



	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private Date startTime;    //业务时间字段
	private Date endTime;
	private Integer dispatchSum;

	//业务字段 上户管理--推荐服务人员
	private BigDecimal skillServicePrice;//结算价格
	private String serviceLevelName;//星级名称
	private String professionName;//专业名称
	private Long customerId;//员工服务的客户Id
	private Integer assignStatus;//指派状态 0：未指派 1：已指派
	private Long recommendId;//推荐人
	private User infoCollectId;//信息获取人
	private Long communicateId;//沟通人
	private Integer tableType;//区分推荐人
	private Customer customer;


	private EmployeeCommunication employeeCommunication;

	public List<Long> getSpecialityList() {
		List<Long> list = new ArrayList<>();
		if (Strings.isNullOrEmpty(specialityId))return list;

		String[] array = specialityId.split(",");
		for(String id:array){
			if(Strings.isNullOrEmpty(id))continue;

			list.add(Long.parseLong(id));
		}

		return list;
	}
	public List<Long> getProfessionList() {
		List<Long> list = new ArrayList<>();
		if (Strings.isNullOrEmpty(profession))return list;

		String[] array = profession.split(",");
		for(String id:array){
			if(Strings.isNullOrEmpty(id))continue;

			list.add(Long.parseLong(id));
		}

		return list;
	}

	public void setProfessionList(List<Long> professionList) {
		this.professionList = professionList;
	}

	public List<Long> getSpecialityLists() {
		return specialityList;
	}

	public void setSpecialityList(List<Long> specialityList) {
		this.specialityList = specialityList;
	}

	public String getSpecialityId() {
		return specialityId;
	}

	public void setSpecialityId(String specialityId) {
		this.specialityId = specialityId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	private User user;






	public String getBlood() {
		return blood;
	}

	public void setBlood(String blood) {
		this.blood = blood;
	}

	public String getConstellation() {
		return constellation;
	}

	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}

	public String getMotto() {
		return motto;
	}

	public void setMotto(String motto) {
		this.motto = motto;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}


	public Integer getDormStatus() {
		return dormStatus;
	}

	public void setDormStatus(Integer dormStatus) {
		this.dormStatus = dormStatus;
	}


	public EmployeeSkill getEmployeeSkill() {
		return employeeSkill;
	}

	public void setEmployeeSkill(EmployeeSkill employeeSkill) {
		this.employeeSkill = employeeSkill;
	}

	public Long getAge() {
		return age;
	}

	public void setAge(Long age) {
		this.age = age;
	}


	public Entry getEntry() {
		return entry;
	}

	public void setEntry(Entry entry) {
		this.entry = entry;
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


	public Area getCurrentArea() {
		return currentArea;
	}

	public void setCurrentArea(Area currentArea) {
		this.currentArea = currentArea;
	}

	public Area getOriginalArea() {
		return originalArea;
	}

	public void setOriginalArea(Area originalArea) {
		this.originalArea = originalArea;
	}

	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	public Employee() {
		super();
	}

	public Employee(Long id){
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public Date getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(Date createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}


	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getBirthTime() {
		return birthTime;
	}

	public void setBirthTime(Date birthTime) {
		this.birthTime = birthTime;
	}


	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getJobTime() {
		return jobTime;
	}

	public void setJobTime(Date jobTime) {
		this.jobTime = jobTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEntryTime() {
		return entryTime;
	}

	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}



	@Length(min=0, max=1024, message="籍贯(文本)长度必须介于 0 和 1024 之间")
	public String getOriginalStreet() {
		return originalStreet;
	}

	public void setOriginalStreet(String originalStreet) {
		this.originalStreet = originalStreet;
	}


	@Length(min=0, max=1024, message="现住地（文本）长度必须介于 0 和 1024 之间")
	public String getCurrentStreet() {
		return currentStreet;
	}

	public void setCurrentStreet(String currentStreet) {
		this.currentStreet = currentStreet;
	}

	@Length(min=0, max=1280, message="备注长度必须介于 0 和 1280 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	@Length(min=0, max=50, message="住宅电话长度必须介于 0 和 50 之间")
	public String getHomePhone() {
		return homePhone;
	}

	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}

	@Length(min=0, max=128, message="电子邮件长度必须介于 0 和 128 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Length(min=0, max=50, message="紧急联系人长度必须介于 0 和 50 之间")
	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	@Length(min=0, max=50, message="紧急联系人电话长度必须介于 0 和 50 之间")
	public String getEmergencyContactPhone() {
		return emergencyContactPhone;
	}

	public void setEmergencyContactPhone(String emergencyContactPhone) {
		this.emergencyContactPhone = emergencyContactPhone;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getLeaveTime() {
		return leaveTime;
	}

	public void setLeaveTime(Date leaveTime) {
		this.leaveTime = leaveTime;
	}

	@Length(min=0, max=1024, message="离职原因长度必须介于 0 和 1024 之间")
	public String getLeaveReason() {
		return leaveReason;
	}

	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}

	public EmployeeResume getEmployeeResume() {
		return employeeResume;
	}

	public void setEmployeeResume(EmployeeResume employeeResume) {
		this.employeeResume = employeeResume;
	}

	public Integer getFilter() {
		return filter;
	}

	public void setFilter(Integer filter) {
		this.filter = filter;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	public Long getEducation() {
		return education;
	}

	public void setEducation(Long education) {
		this.education = education;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Long getRegisterPlace() {
		return registerPlace;
	}

	public void setRegisterPlace(Long registerPlace) {
		this.registerPlace = registerPlace;
	}

	public Long getMarriage() {
		return marriage;
	}

	public void setMarriage(Long marriage) {
		this.marriage = marriage;
	}

	public Long getPolitical() {
		return political;
	}

	public void setPolitical(Long political) {
		this.political = political;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	public Long getEnglish() {
		return english;
	}

	public void setEnglish(Long english) {
		this.english = english;
	}

	public String getServiceCity() {
		return serviceCity;
	}

	public void setServiceCity(String serviceCity) {
		this.serviceCity = serviceCity;
	}

	public String getServiceYear() {
		return serviceYear;
	}

	public void setServiceYear(String serviceYear) {
		this.serviceYear = serviceYear;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	public Long getNation() {
		return nation;
	}

	public void setNation(Long nation) {
		this.nation = nation;
	}

	public Integer getSignStatus() {
		return signStatus;
	}

	public void setSignStatus(Integer signStatus) {
		this.signStatus = signStatus;
	}

	public EmployeeInfo getEmployeeInfo() {
		return employeeInfo;
	}

	public void setEmployeeInfo(EmployeeInfo employeeInfo) {
		this.employeeInfo = employeeInfo;
	}

	public Interview getInterview() {
		return interview;
	}

	public void setInterview(Interview interview) {
		this.interview = interview;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public User getCreater() {
		return creater;
	}

	public void setCreater(User creater) {
		this.creater = creater;
	}

	public Integer getEmployeeStatus() {
		return employeeStatus;
	}

	public void setEmployeeStatus(Integer employeeStatus) {
		this.employeeStatus = employeeStatus;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getDispatchSum() {
		return dispatchSum;
	}

	public void setDispatchSum(Integer dispatchSum) {
		this.dispatchSum = dispatchSum;
	}

	public ServiceLevel getServiceLevel() {
		return serviceLevel;
	}

	public void setServiceLevel(ServiceLevel serviceLevel) {
		this.serviceLevel = serviceLevel;
	}

	public BigDecimal getSkillServicePrice() {
		return skillServicePrice;
	}

	public void setSkillServicePrice(BigDecimal skillServicePrice) {
		this.skillServicePrice = skillServicePrice;
	}

	public String getServiceLevelName() {
		return serviceLevelName;
	}

	public void setServiceLevelName(String serviceLevelName) {
		this.serviceLevelName = serviceLevelName;
	}

	public String getProfessionName() {
		return professionName;
	}

	public void setProfessionName(String professionName) {
		this.professionName = professionName;
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public Integer getAssignStatus() {
		return assignStatus;
	}

	public void setAssignStatus(Integer assignStatus) {
		this.assignStatus = assignStatus;
	}

	public Long getRecommendId() {
		return recommendId;
	}

	public void setRecommendId(Long recommendId) {
		this.recommendId = recommendId;
	}

	public User getInfoCollectId() {
		return infoCollectId;
	}

	public void setInfoCollectId(User infoCollectId) {
		this.infoCollectId = infoCollectId;
	}

	public Long getCommunicateId() {
		return communicateId;
	}

	public void setCommunicateId(Long communicateId) {
		this.communicateId = communicateId;
	}

	public Integer getTableType() {
		return tableType;
	}

	public void setTableType(Integer tableType) {
		this.tableType = tableType;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setEmployeeCommunication(EmployeeCommunication employeeCommunication) {
		this.employeeCommunication = employeeCommunication;
	}

	public EmployeeCommunication getEmployeeCommunication() {
		return employeeCommunication;
	}

}