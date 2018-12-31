/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.schedule.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classlessonsign.entity.ClassLessonSign;
import cn.com.beyo.erp.modules.school.classroom.entity.Classroom;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 课表管理Entity
 * @author Ashon
 * @version 2017-06-01
 */
public class ClassSchedule extends DataVo<ClassSchedule> {

	private SchoolClass schoolClass;		// 班级ID
	private ClassLesson schoolClassLesson;	// 课程ID
	private User teacher;					// 授课老师 （默认为课程表的授课老师）
	private Classroom schoolClassroom;		// 教室ID
	private ClassLessonSign classLessonSign; //课程签到ID
	private Date beginTime;		// 开始日期
	private Date endTime;		// 结束日期
	private String remark;		// 备注

	private Integer studentCount; //班级总人数
	private Integer signCount;   //签到人数
	private Integer noSignCount; //未签到人数
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束

	//业务字段
	private Integer lessonSignNum; //课程总次数

	private Long studentId;

	public ClassSchedule() {
		super();
	}

	public ClassSchedule(Long id){
		super(id);
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public ClassLesson getSchoolClassLesson() {
		return schoolClassLesson;
	}

	public void setSchoolClassLesson(ClassLesson schoolClassLesson) {
		this.schoolClassLesson = schoolClassLesson;
	}

	public User getTeacher() {
		return teacher;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}

	public Classroom getSchoolClassroom() {
		return schoolClassroom;
	}

	public void setSchoolClassroom(Classroom schoolClassroom) {
		this.schoolClassroom = schoolClassroom;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public ClassLessonSign getClassLessonSign() {
		return classLessonSign;
	}

	public void setClassLessonSign(ClassLessonSign classLessonSign) {
		this.classLessonSign = classLessonSign;
	}

	public Integer getSignCount() {
		return signCount;
	}

	public void setSignCount(Integer signCount) {
		this.signCount = signCount;
	}

	public Integer getLessonSignNum() {
		return lessonSignNum;
	}

	public void setLessonSignNum(Integer lessonSignNum) {
		this.lessonSignNum = lessonSignNum;
	}

	public Integer getNoSignCount() {
		return noSignCount;
	}

	public void setNoSignCount(Integer noSignCount) {
		this.noSignCount = noSignCount;
	}

	public Integer getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(Integer studentCount) {
		this.studentCount = studentCount;
	}

	public Long getStudentId() {
		return studentId;
	}

	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}
}