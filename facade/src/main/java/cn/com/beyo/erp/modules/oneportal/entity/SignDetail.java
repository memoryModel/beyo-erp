package cn.com.beyo.erp.modules.oneportal.entity;


import cn.com.beyo.erp.commons.persistence.DataVo;

import java.util.Date;

public class SignDetail extends DataVo<SignDetail> {
	private String requestId; // 请求id
	private String employeeNo; // 员工编号
	private String userId;// 员工ID
	private String xmwb; // 姓名
	private String signDate; // 考勤时间
	private Date firstCheckTime; // 上班签到时间
	private Date lastCheckTime;// 下班签到时间

	private Integer signStateM; // 上午签到状态 0:未签到、1：正常签到、2：迟到
	private Integer signStateA; // 下午签到状态 0:未签到、1：正常签到、2：早退

	private String signType;// 签到类型 1：移动考勤 2：考勤机
	// 业务字段

	private String timeM;
	private String timeA;

	public String getRequestId() {
		return requestId;
	}

	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}

	public String getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getXmwb() {
		return xmwb;
	}

	public void setXmwb(String xmwb) {
		this.xmwb = xmwb;
	}

	public String getSignDate() {
		return signDate;
	}

	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

	public Date getFirstCheckTime() {
		return firstCheckTime;
	}

	public void setFirstCheckTime(Date firstCheckTime) {
		this.firstCheckTime = firstCheckTime;
	}

	public Date getLastCheckTime() {
		return lastCheckTime;
	}

	public void setLastCheckTime(Date lastCheckTime) {
		this.lastCheckTime = lastCheckTime;
	}

	public String getTimeM() {
		return timeM;
	}

	public void setTimeM(String timeM) {
		this.timeM = timeM;
	}

	public String getTimeA() {
		return timeA;
	}

	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	public Integer getSignStateM() {
		return signStateM;
	}

	public void setSignStateM(Integer signStateM) {
		this.signStateM = signStateM;
	}

	public Integer getSignStateA() {
		return signStateA;
	}

	public void setSignStateA(Integer signStateA) {
		this.signStateA = signStateA;
	}

	@Override
	public String toString() {
		return "SignDetail{" +
				"requestId='" + requestId + '\'' +
				", employeeNo='" + employeeNo + '\'' +
				", userId='" + userId + '\'' +
				", xmwb='" + xmwb + '\'' +
				", signDate='" + signDate + '\'' +
				", firstCheckTime=" + firstCheckTime +
				", lastCheckTime=" + lastCheckTime +
				", signStateM=" + signStateM +
				", signStateA=" + signStateA +
				", signType='" + signType + '\'' +
				", timeM='" + timeM + '\'' +
				", timeA='" + timeA + '\'' +
				", id=" + id +
				'}';
	}
}
