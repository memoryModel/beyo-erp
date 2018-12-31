/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.student.entity;


import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.communication.entity.Communication;
import cn.com.beyo.erp.modules.erp.customerresource.entity.CustomerResource;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classlessonsignhistory.entity.ClassLessonSignHistory;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormStudentLive;
import cn.com.beyo.erp.modules.school.dormlivehistory.entity.DormLiveHistory;
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
 * @version 2017-06-05
 */
public class Student extends DataVo<Student> {

	private Employee employee;       //员工ID  (员工报名)
	private Long supplierId;		// 供应商
	private User teacher;		// 招聘老师
	private User learningTeacher;  //学管师
	private User follow;		// 跟进人
	private Integer studentType;		// 学员类型
	private String name;		// 学生姓名
	private Integer sex;		// 学生性别
	private String phone;		// 手机号码
	private String studentNumber;		// 学号
	private Date dateBirth;		// 出生日期
	private String stuNumber;		// 身份证号
	private String stuNumberAddress; //身份证号地址
	private Area nativePlace;		// 籍贯
	private Area stuCity;		// 生活城市
	private String qqNumber;		// QQ号码
	private Integer dormitory;		// 是否住宿
	private String emergencyContact;		// 紧急联系人
	private String urgencyPhone;		// 紧急联络人电话
	private Long invoiceStatus;      //开票状态
	private Date classTimeId;		// 入班日期
	private Date applyTime;			//报名时间
	private Date predictApplyTime;		//预计报名时间
	private Long education;		// 学历
	private Integer status;		// 状态(0启用    1停用)
	private BigDecimal shouldTuitionAmount;//应付学费
	private BigDecimal tuitionFavorable;//学费优惠
	private CustomerResource customerResource;//招生来源(客户来源)
	private ClassStudents schoolClassStudents; //新增班级中间表
	private Communication communication;    //沟通记录
	private Integer countCommunication;     //统计沟通记录的个数
	private String occupationId;    //职业方向
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private Areas areas;//所属校区
	private Order order;    //订单
	private User referrer;   //推荐人
	private User user;   //创建人（当前登录用户)
	private String remark;   //备注
	private Integer studentStatus;  //学院在读状态（0、未读  1、停用  2、在读）

	private DormLiveHistory dormLiveHistory;//退房记录（取退房时间）
	private DormStudentLive dormStudentLive;//入住记录（取入住时间）
	private ClassLessonSignHistory classLessonSignHistory;//签到历史记录

	private Integer assigned; //业务字段 -- 该学生是否被分配
	private Integer tagFlag;   //业务字段

	//业务字段
	private Integer filter; // 1.学生所在班级为结业班级
	private int age;	//年龄

	private Long notSelectClassId; //业务字段

	private List<Long> occupationList;

	private  Integer studentsStatus; //列表展示业务字段

	private SchoolClass schoolClass; //班级信息表

	public User getReferrer() {
		return referrer;
	}

	public void setReferrer(User referrer) {
		this.referrer = referrer;
	}

	public Areas getAreas() {
		return areas;
	}

	public void setAreas(Areas areas) {
		this.areas = areas;
	}

	public Student() {
		super();
	}

	public Student(Long id){
		super(id);
	}

	public Communication getCommunication() {
		return communication;
	}

	public void setCommunication(Communication communication) {
		this.communication = communication;
	}

	public User getTeacher() {
		return teacher;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}

	public User getFollow() {
		return follow;
	}

	public void setFollow(User follow) {
		this.follow = follow;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
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

	public User getLearningTeacher() {
		return learningTeacher;
	}

	public void setLearningTeacher(User learningTeacher) {
		this.learningTeacher = learningTeacher;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Long getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Long supplierId) {
		this.supplierId = supplierId;
	}

	public Long getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(Long invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

	public Integer getStudentType() {
		return studentType;
	}

	public void setStudentType(Integer studentType) {
		this.studentType = studentType;
	}

	@Length(min=0, max=50, message="学生姓名长度必须介于 0 和 50 之间")
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

	@Length(min=0, max=50, message="手机号码长度必须介于 0 和 50 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Length(min=0, max=128, message="学号长度必须介于 0 和 128 之间")
	public String getStudentNumber() {
		return studentNumber;
	}

	public void setStudentNumber(String studentNumber) {
		this.studentNumber = studentNumber;
	}

	public CustomerResource getCustomerResource() {
		return customerResource;
	}

	public void setCustomerResource(CustomerResource customerResource) {
		this.customerResource = customerResource;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getDateBirth() {
		return dateBirth;
	}

	public void setDateBirth(Date dateBirth) {
		this.dateBirth = dateBirth;
	}

	@Length(min=0, max=50, message="身份证号长度必须介于 0 和 50 之间")
	public String getStuNumber() {
		return stuNumber;
	}

	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}

	public Area getNativePlace() {
		return nativePlace;
	}

	public void setNativePlace(Area nativePlace) {
		this.nativePlace = nativePlace;
	}

	public Area getStuCity() {
		return stuCity;
	}

	public void setStuCity(Area stuCity) {
		this.stuCity = stuCity;
	}

	@Length(min=0, max=50, message="QQ号码长度必须介于 0 和 50 之间")
	public String getQqNumber() {
		return qqNumber;
	}

	public void setQqNumber(String qqNumber) {
		this.qqNumber = qqNumber;
	}

	public Integer getDormitory() {
		return dormitory;
	}

	public void setDormitory(Integer dormitory) {
		this.dormitory = dormitory;
	}

	@Length(min=0, max=50, message="紧急联系人长度必须介于 0 和 50 之间")
	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	@Length(min=0, max=50, message="紧急联络人电话长度必须介于 0 和 50 之间")
	public String getUrgencyPhone() {
		return urgencyPhone;
	}

	public void setUrgencyPhone(String urgencyPhone) {
		this.urgencyPhone = urgencyPhone;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getClassTimeId() {
		return classTimeId;
	}

	public void setClassTimeId(Date classTimeId) {
		this.classTimeId = classTimeId;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	public Long getEducation() {
		return education;
	}

	public void setEducation(Long education) {
		this.education = education;
	}
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getPredictApplyTime() {
		return predictApplyTime;
	}

	public void setPredictApplyTime(Date predictApplyTime) {
		this.predictApplyTime = predictApplyTime;
	}

	@Override
	public Integer getStatus() {
		return status;
	}
	@Override
	public void setStatus(Integer status) {
		this.status = status;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public ClassStudents getSchoolClassStudents() {
		return schoolClassStudents;
	}

	public void setSchoolClassStudents(ClassStudents schoolClassStudents) {
		this.schoolClassStudents = schoolClassStudents;
	}

	public BigDecimal getShouldTuitionAmount() {
		return shouldTuitionAmount;
	}

	public void setShouldTuitionAmount(BigDecimal shouldTuitionAmount) {
		this.shouldTuitionAmount = shouldTuitionAmount;
	}

	public Integer getAssigned() {
		return assigned;
	}

	public void setAssigned(Integer assigned) {
		this.assigned = assigned;
	}

	public BigDecimal getTuitionFavorable() {
		return tuitionFavorable;
	}

	public void setTuitionFavorable(BigDecimal tuitionFavorable) {
		this.tuitionFavorable = tuitionFavorable;
	}

	public DormLiveHistory getDormLiveHistory() {
		return dormLiveHistory;
	}

	public void setDormLiveHistory(DormLiveHistory dormLiveHistory) {
		this.dormLiveHistory = dormLiveHistory;
	}

	public DormStudentLive getDormStudentLive() {
		return dormStudentLive;
	}

	public void setDormStudentLive(DormStudentLive dormStudentLive) {
		this.dormStudentLive = dormStudentLive;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ClassLessonSignHistory getClassLessonSignHistory() {
		return classLessonSignHistory;
	}

	public void setClassLessonSignHistory(ClassLessonSignHistory classLessonSignHistory) {
		this.classLessonSignHistory = classLessonSignHistory;
	}

	public List<Long> getOccupationLists() {

		return occupationList;
	}

	public List<Long> getOccupationList() {
		List<Long> list = new ArrayList<>();
		if (Strings.isNullOrEmpty(occupationId))return list;

		String[] array = occupationId.split(",");
		for(String id:array){
			if(Strings.isNullOrEmpty(id))continue;

			list.add(Long.parseLong(id));
		}

		return list;
	}

	public void setOccupationList(List<Long> occupationList) {
		this.occupationList = occupationList;
	}

	public String getOccupationId() {
		return occupationId;
	}

	public void setOccupationId(String occupationId) {
		this.occupationId = occupationId;
	}

	public Integer getCountCommunication() {
		return countCommunication;
	}

	public void setCountCommunication(Integer countCommunication) {
		this.countCommunication = countCommunication;
	}

	public Integer getStudentsStatus() {
		return studentsStatus;
	}

	public void setStudentsStatus(Integer studentsStatus) {
		this.studentsStatus = studentsStatus;
	}

	public Integer getFilter() {
		return filter;
	}

	public void setFilter(Integer filter) {
		this.filter = filter;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStudentStatus() {
		return studentStatus;
	}

	public void setStudentStatus(Integer studentStatus) {
		this.studentStatus = studentStatus;
	}

	public Integer getTagFlag() {
		return tagFlag;
	}

	public void setTagFlag(Integer tagFlag) {
		this.tagFlag = tagFlag;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public void setStuNumberAddress(String stuNumberAddress) {
		this.stuNumberAddress = stuNumberAddress;
	}

	public String getStuNumberAddress() {
		return stuNumberAddress;
	}

	public void setNotSelectClassId(Long notSelectClassId) {
		this.notSelectClassId = notSelectClassId;
	}

	public Long getNotSelectClassId() {
		return notSelectClassId;
	}

	@Override
	public String toString() {
		return "Student{" +
				"employee=" + employee +
				", supplierId=" + supplierId +
				", teacher=" + teacher +
				", learningTeacher=" + learningTeacher +
				", follow=" + follow +
				", studentType=" + studentType +
				", name='" + name + '\'' +
				", sex=" + sex +
				", phone='" + phone + '\'' +
				", studentNumber='" + studentNumber + '\'' +
				", dateBirth=" + dateBirth +
				", stuNumber='" + stuNumber + '\'' +
				", stuNumberAddress='" + stuNumberAddress + '\'' +
				", nativePlace=" + nativePlace +
				", stuCity=" + stuCity +
				", qqNumber='" + qqNumber + '\'' +
				", dormitory=" + dormitory +
				", emergencyContact='" + emergencyContact + '\'' +
				", urgencyPhone='" + urgencyPhone + '\'' +
				", invoiceStatus=" + invoiceStatus +
				", classTimeId=" + classTimeId +
				", applyTime=" + applyTime +
				", predictApplyTime=" + predictApplyTime +
				", education=" + education +
				", status=" + status +
				", shouldTuitionAmount=" + shouldTuitionAmount +
				", tuitionFavorable=" + tuitionFavorable +
				", customerResource=" + customerResource +
				", schoolClassStudents=" + schoolClassStudents +
				", communication=" + communication +
				", countCommunication=" + countCommunication +
				", occupationId='" + occupationId + '\'' +
				", createTimeStart=" + createTimeStart +
				", createTimeEnd=" + createTimeEnd +
				", areas=" + areas +
				", order=" + order +
				", referrer=" + referrer +
				", user=" + user +
				", remark='" + remark + '\'' +
				", studentStatus=" + studentStatus +
				", dormLiveHistory=" + dormLiveHistory +
				", dormStudentLive=" + dormStudentLive +
				", classLessonSignHistory=" + classLessonSignHistory +
				", assigned=" + assigned +
				", tagFlag=" + tagFlag +
				", filter=" + filter +
				", age=" + age +
				", notSelectClassId=" + notSelectClassId +
				", occupationList=" + occupationList +
				", studentsStatus=" + studentsStatus +
				", schoolClass=" + schoolClass +
				'}';
	}
}