/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.entry.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.serivcelevel.entity.ServiceLevel;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.employeeinfo.entity.EmployeeInfo;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.google.common.base.Strings;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 员工入职签约管理Entity
 * @author beyo.com.cn
 * @version 2017-07-18
 */
public class Entry extends DataVo<Entry> {

	private Employee employee;			// 员工信息
	private String contractCode;		// 合同信息
	private Integer settleStatus;		// 结算方式
	private Integer basePayStatus;		// 底薪
	private String bankName;			// 所属银行1
	private String secondBankName;		// 所属银行2
	private String bankNumber;			// 工资卡号1
	private String secondBankNumber;	// 工资卡号2
	private BigDecimal baseAmount;		// 底薪
	private Date deadlineTime;			//签约截止时间
	private Date takeTime;				//合同生效时间
	private Date approveTime;			//审批时间
	private Integer type;				//员工性质	EmployeeType (1员工制  ，0 劳务制)
	private ServiceLevel serviceLevel;		// 星级
	private String  region;		// 可服务范围
	private Area area ;//可服务范围
	private EmployeeInfo employeeInfo;//认证信息
	private Date workTime;		//可上岗日期
	private String serviceTime;		//可服务时间
	private List<Long> serviceTimeList;
	private Integer dormStatus;		//是否住宿
	private Date entryTime;		//入职日期
    private CustomerResource customerResource;//来源
	private Integer contractStatus;   //员工合同状态(1、已提交续约  2、续约已成功 3、已提交解约 4、解约已成功)

	//员工状态
	private Integer servingStatus;   //服务状态(1、待岗  2、在岗)EmployeeListStatus

	//定级
	private Integer entryStatus;		// 定级状态(审批定级通过状态为5:已审批)

	//签约
	private Integer	approveStatus;	//员工签约、入职审批状态（0 未提交，1 通过， 2 已退回）以及(3 入职未提交  4 入职已退回  5 入职提交未审批 6 入职审批通过 7 已离职)
	private String reason;		//审批意见(签约待审批意见)
	private User user;	//签约操作人
	private User approveUser;   //签约审批人

	//入职
	private String entryReason;		//审批意见(入职审批意见)
	private User entryUser;   //入职审批人

	//业务字段
	private Date startTime;    //业务时间字段
	private Date endTime;
	//以下都是上传图片业务字段
	private Long employeeInfoTypeFirst;
	private Long employeeInfoTypeSecond;
	private Long employeeInfoTypeThird;
	private String employeeInfoUrlFirst;
	private String employeeInfoUrlSecond;
	private String employeeInfoUrlThird;
	private String employeeInfoUrlFourth;
	private String employeeInfoUrlFifth;


	public List<Long> getServiceTimeList() {
		List<Long> list = new ArrayList<>();
		if (Strings.isNullOrEmpty(serviceTime))return list;

		String[] array = serviceTime.split(",");
		for(String id:array){
			if(Strings.isNullOrEmpty(id))continue;

			list.add(Long.parseLong(id));
		}

		return list;
	}

	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	public void setServiceTimeList(List<Long> serviceTimeList) {
		this.serviceTimeList = serviceTimeList;
	}

	public Long getEmployeeInfoTypeFirst() {
		return employeeInfoTypeFirst;
	}

	public void setEmployeeInfoTypeFirst(Long employeeInfoTypeFirst) {
		this.employeeInfoTypeFirst = employeeInfoTypeFirst;
	}

	public String getEmployeeInfoUrlFirst() {
		return employeeInfoUrlFirst;
	}

	public void setEmployeeInfoUrlFirst(String employeeInfoUrlFirst) {
		this.employeeInfoUrlFirst = employeeInfoUrlFirst;
	}

	public Long getEmployeeInfoTypeSecond() {
		return employeeInfoTypeSecond;
	}

	public void setEmployeeInfoTypeSecond(Long employeeInfoTypeSecond) {
		this.employeeInfoTypeSecond = employeeInfoTypeSecond;
	}

	public String getEmployeeInfoUrlSecond() {
		return employeeInfoUrlSecond;
	}

	public void setEmployeeInfoUrlSecond(String employeeInfoUrlSecond) {
		this.employeeInfoUrlSecond = employeeInfoUrlSecond;
	}

	public Long getEmployeeInfoTypeThird() {
		return employeeInfoTypeThird;
	}

	public void setEmployeeInfoTypeThird(Long employeeInfoTypeThird) {
		this.employeeInfoTypeThird = employeeInfoTypeThird;
	}

	public String getEmployeeInfoUrlThird() {
		return employeeInfoUrlThird;
	}

	public void setEmployeeInfoUrlThird(String employeeInfoUrlThird) {
		this.employeeInfoUrlThird = employeeInfoUrlThird;
	}


	public String getEmployeeInfoUrlFourth() {
		return employeeInfoUrlFourth;
	}

	public void setEmployeeInfoUrlFourth(String employeeInfoUrlFourth) {
		this.employeeInfoUrlFourth = employeeInfoUrlFourth;
	}

	public String getEmployeeInfoUrlFifth() {
		return employeeInfoUrlFifth;
	}

	public void setEmployeeInfoUrlFifth(String employeeInfoUrlFifth) {
		this.employeeInfoUrlFifth = employeeInfoUrlFifth;
	}

	public EmployeeInfo getEmployeeInfo() {
		return employeeInfo;
	}

	public void setEmployeeInfo(EmployeeInfo employeeInfo) {
		this.employeeInfo = employeeInfo;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Integer getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(Integer approveStatus) {
		this.approveStatus = approveStatus;
	}


	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	private List<Integer> entryStatusValueList;

	public Date getApproveTime() {
		return approveTime;
	}

	public void setApproveTime(Date approveTime) {
		this.approveTime = approveTime;
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

	public Date getDeadlineTime() {
		return deadlineTime;
	}

	public void setDeadlineTime(Date deadlineTime) {
		this.deadlineTime = deadlineTime;
	}

	public Date getTakeTime() {
		return takeTime;
	}

	public void setTakeTime(Date takeTime) {
		this.takeTime = takeTime;
	}

	public ServiceLevel getServiceLevel() {
		return serviceLevel;
	}

	public void setServiceLevel(ServiceLevel serviceLevel) {
		this.serviceLevel = serviceLevel;
	}

	public Entry() {
		super();
	}

	public Entry(Long id){
		super(id);
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Integer getEntryStatus() {
		return entryStatus;
	}

	public void setEntryStatus(Integer entryStatus) {
		this.entryStatus = entryStatus;
	}

	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}

	public Integer getSettleStatus() {
		return settleStatus;
	}

	public void setSettleStatus(Integer settleStatus) {
		this.settleStatus = settleStatus;
	}


	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getSecondBankName() {
		return secondBankName;
	}

	public void setSecondBankName(String secondBankName) {
		this.secondBankName = secondBankName;
	}

	public String getBankNumber() {
		return bankNumber;
	}

	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}

	public String getSecondBankNumber() {
		return secondBankNumber;
	}

	public void setSecondBankNumber(String secondBankNumber) {
		this.secondBankNumber = secondBankNumber;
	}

	public BigDecimal getBaseAmount() {
		return baseAmount;
	}

	public void setBaseAmount(BigDecimal baseAmount) {
		this.baseAmount = baseAmount;
	}

	public Integer getBasePayStatus() {
		return basePayStatus;
	}

	public void setBasePayStatus(Integer basePayStatus) {
		this.basePayStatus = basePayStatus;
	}

	public List<Integer> getEntryStatusValueList() {
		return entryStatusValueList;
	}

	public void setEntryStatusValueList(List<Integer> entryStatusValueList) {
		this.entryStatusValueList = entryStatusValueList;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getEntryReason() {
		return entryReason;
	}

	public void setEntryReason(String entryReason) {
		this.entryReason = entryReason;
	}

	public Date getEntryTime() {
		return entryTime;
	}

	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}

	public Date getWorkTime() {
		return workTime;
	}

	public void setWorkTime(Date workTime) {
		this.workTime = workTime;
	}

	public String getServiceTime() {
		return serviceTime;
	}

	public void setServiceTime(String serviceTime) {
		this.serviceTime = serviceTime;
	}


	public Integer getDormStatus() {
		return dormStatus;
	}

	public void setDormStatus(Integer dormStatus) {
		this.dormStatus = dormStatus;
	}

	public Integer getServingStatus() {
		return servingStatus;
	}

	public void setServingStatus(Integer servingStatus) {
		this.servingStatus = servingStatus;
	}

	public Integer getContractStatus() {
		return contractStatus;
	}

	public void setContractStatus(Integer contractStatus) {
		this.contractStatus = contractStatus;
	}

	public User getApproveUser() {
		return approveUser;
	}

	public void setApproveUser(User approveUser) {
		this.approveUser = approveUser;
	}

	public User getEntryUser() {
		return entryUser;
	}

	public void setEntryUser(User entryUser) {
		this.entryUser = entryUser;
	}
}