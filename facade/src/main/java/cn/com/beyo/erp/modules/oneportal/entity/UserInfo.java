package cn.com.beyo.erp.modules.oneportal.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;


import java.util.Date;

/**
 * 用户信息实体类
 * 
 * @author tracy
 *
 */
public class UserInfo extends DataVo<UserInfo> {

	private String loginId; // 用户登录名
	private String loginPwd; // 登录密码
	private String userName; // 用户名称
	private String userEmail; // 用户邮箱
	private String userPhone; // 用户手机号码
	private String company; // 所属公司
	private String companyName;//所属公司名称
	private String department; // 部门
	private String deptName; // 部门名称
	private String post; // 职位
	private String workplace; // 工作地点
	private String employeNo; // 员工号
	private String createDate; // 创建时间
	private String updateDate; // 更新时间
	private String companyId; // 公司标识
	private String isAdmin; // 是否为管理员
	private String superAdmin; // 是否为超级管理员
	private String sex; // 性别
	private String headImage; //人物头像
	private String remainLeave;//年假剩余天数
	private String openId;//微信用户唯一标识
	private Integer isDelete;//是否删除
	private String vacation;//假期字段 用于签到
	private String isEnableb;//是否冻结
	private String registrationid;//安卓或ios安装后获取极光推送的唯一标示
	private String source; //来源
	private String namePinYin; // 拼音

	private Date lastlogindate;

	private String oldLoginPwd; // 旧密码, 用于密码修改的时候保持页面传过来的旧密码

	private String hideUserPhone; // 是否隐藏手机号码; 隐藏
	private String hideUserEmail; // 是否隐藏邮箱; 隐藏
	private String canViewAllPhoneAndEmail; // 是否可查看隐藏的邮箱和手机号码; true - 可查看

	//业务字段
	private String userInfocd;//迟到
	private String userInfozt;//早退
	private String userInfocq;//出勤
	private String userInfoqk;//缺卡
	private String userInfozc;//正常
	private String userInfokg;//旷工


	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}

	public void setEmployeNo(String employeNo) {
		this.employeNo = employeNo;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public void setSuperAdmin(String superAdmin) {
		this.superAdmin = superAdmin;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}

	public void setRemainLeave(String remainLeave) {
		this.remainLeave = remainLeave;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public void setVacation(String vacation) {
		this.vacation = vacation;
	}

	public void setIsEnableb(String isEnableb) {
		this.isEnableb = isEnableb;
	}

	public void setRegistrationid(String registrationid) {
		this.registrationid = registrationid;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public void setNamePinYin(String namePinYin) {
		this.namePinYin = namePinYin;
	}

	public void setLastlogindate(Date lastlogindate) {
		this.lastlogindate = lastlogindate;
	}

	public void setOldLoginPwd(String oldLoginPwd) {
		this.oldLoginPwd = oldLoginPwd;
	}

	public void setHideUserPhone(String hideUserPhone) {
		this.hideUserPhone = hideUserPhone;
	}

	public void setHideUserEmail(String hideUserEmail) {
		this.hideUserEmail = hideUserEmail;
	}

	public void setCanViewAllPhoneAndEmail(String canViewAllPhoneAndEmail) {
		this.canViewAllPhoneAndEmail = canViewAllPhoneAndEmail;
	}

	public void setUserInfocd(String userInfocd) {
		this.userInfocd = userInfocd;
	}

	public void setUserInfozt(String userInfozt) {
		this.userInfozt = userInfozt;
	}

	public void setUserInfocq(String userInfocq) {
		this.userInfocq = userInfocq;
	}

	public void setUserInfoqk(String userInfoqk) {
		this.userInfoqk = userInfoqk;
	}

	public void setUserInfozc(String userInfozc) {
		this.userInfozc = userInfozc;
	}

	public void setUserInfokg(String userInfokg) {
		this.userInfokg = userInfokg;
	}

	public String getLoginId() {
		return loginId;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public String getUserName() {
		return userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public String getCompany() {
		return company;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getDepartment() {
		return department;
	}

	public String getDeptName() {
		return deptName;
	}

	public String getPost() {
		return post;
	}

	public String getWorkplace() {
		return workplace;
	}

	public String getEmployeNo() {
		return employeNo;
	}

	public String getCreateDate() {
		return createDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public String getCompanyId() {
		return companyId;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public String getSuperAdmin() {
		return superAdmin;
	}

	public String getSex() {
		return sex;
	}

	public String getHeadImage() {
		return headImage;
	}

	public String getRemainLeave() {
		return remainLeave;
	}

	public String getOpenId() {
		return openId;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public String getVacation() {
		return vacation;
	}

	public String getIsEnableb() {
		return isEnableb;
	}

	public String getRegistrationid() {
		return registrationid;
	}

	public String getSource() {
		return source;
	}

	public String getNamePinYin() {
		return namePinYin;
	}

	public Date getLastlogindate() {
		return lastlogindate;
	}

	public String getOldLoginPwd() {
		return oldLoginPwd;
	}

	public String getHideUserPhone() {
		return hideUserPhone;
	}

	public String getHideUserEmail() {
		return hideUserEmail;
	}

	public String getCanViewAllPhoneAndEmail() {
		return canViewAllPhoneAndEmail;
	}

	public String getUserInfocd() {
		return userInfocd;
	}

	public String getUserInfozt() {
		return userInfozt;
	}

	public String getUserInfocq() {
		return userInfocq;
	}

	public String getUserInfoqk() {
		return userInfoqk;
	}

	public String getUserInfozc() {
		return userInfozc;
	}

	public String getUserInfokg() {
		return userInfokg;
	}

	@Override
	public String toString() {
		return "UserInfo{" +
				"loginId='" + loginId + '\'' +
				", loginPwd='" + loginPwd + '\'' +
				", userName='" + userName + '\'' +
				", userEmail='" + userEmail + '\'' +
				", userPhone='" + userPhone + '\'' +
				", company='" + company + '\'' +
				", companyName='" + companyName + '\'' +
				", department='" + department + '\'' +
				", deptName='" + deptName + '\'' +
				", post='" + post + '\'' +
				", workplace='" + workplace + '\'' +
				", employeNo='" + employeNo + '\'' +
				", createDate='" + createDate + '\'' +
				", updateDate='" + updateDate + '\'' +
				", companyId='" + companyId + '\'' +
				", isAdmin='" + isAdmin + '\'' +
				", superAdmin='" + superAdmin + '\'' +
				", sex='" + sex + '\'' +
				", headImage='" + headImage + '\'' +
				", remainLeave='" + remainLeave + '\'' +
				", openId='" + openId + '\'' +
				", isDelete=" + isDelete +
				", vacation='" + vacation + '\'' +
				", isEnableb='" + isEnableb + '\'' +
				", registrationid='" + registrationid + '\'' +
				", source='" + source + '\'' +
				", namePinYin='" + namePinYin + '\'' +
				", lastlogindate=" + lastlogindate +
				", oldLoginPwd='" + oldLoginPwd + '\'' +
				", hideUserPhone='" + hideUserPhone + '\'' +
				", hideUserEmail='" + hideUserEmail + '\'' +
				", canViewAllPhoneAndEmail='" + canViewAllPhoneAndEmail + '\'' +
				", userInfocd='" + userInfocd + '\'' +
				", userInfozt='" + userInfozt + '\'' +
				", userInfocq='" + userInfocq + '\'' +
				", userInfoqk='" + userInfoqk + '\'' +
				", userInfozc='" + userInfozc + '\'' +
				", userInfokg='" + userInfokg + '\'' +
				", id=" + id +
				'}';
	}
}
