/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classlessonsign.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classlessonsignhistory.entity.ClassLessonSignHistory;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 课程签到Entity
 * @author beyo.com.cn
 * @version 2017-07-13
 */
public class ClassLessonSign extends DataVo<ClassLessonSign> {

	private SchoolClass schoolClass;  	//班级表
	private ClassLesson schoolClassLesson; 	//课程表
	private User teacher;   //授课老师
	private String lessonContent;		// 授课内容
	private Date beginTime;    //上课开始时间
	private Date endTime;  		//上课结束时间
	private String remark;		// 备注

	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束

	private ClassLessonSignHistory classLessonSignHistory; // 课程签到历史
	public ClassLessonSign() {
		super();
	}

	public ClassLessonSign(Long id){
		super(id);
	}


	public String getLessonContent() {
		return lessonContent;
	}

	public void setLessonContent(String lessonContent) {
		this.lessonContent = lessonContent;
	}
	
	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public User getTeacher() {
		return teacher;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public ClassLessonSignHistory getClassLessonSignHistory() {
		return classLessonSignHistory;
	}

	public void setClassLessonSignHistory(ClassLessonSignHistory classLessonSignHistory) {
		this.classLessonSignHistory = classLessonSignHistory;
	}
}