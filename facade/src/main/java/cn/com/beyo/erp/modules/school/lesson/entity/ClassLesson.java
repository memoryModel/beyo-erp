/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.lesson.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;
import cn.com.beyo.erp.modules.school.classes.entity.ClassToLesson;
import cn.com.beyo.erp.modules.school.schedule.entity.ClassSchedule;
import cn.com.beyo.erp.modules.school.subject.entity.Subject;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.base.Strings;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * 课程管理Entity
 * @author Ashon
 * @version 2017-06-01
 */
public class ClassLesson extends DataVo<ClassLesson> {

	private static final long serialVersionUID = 1L;
	//private Long platformId;		// platform_id
	private String lessonName;		// 课程名称
	private ClassToLesson schoolClassToLesson;
	private Long schoolLessonType;  //课程类型
	private CommonsType commonsType; //通用类型（课程）
	private Subject schoolSubject; //科目
	private String teacherIds;   //授课老师Ids
	private List<Long> teacherIdsList;
	private List<User> teacherList;
	private String teacherNames;
	//	private Employee teacherId;		// 授课老师ID
	//private User teacher;   //授课老师
	private String photoUrl;		// 课程图片路径
	private String lessonContent;		// 课程内容

	private ClassSchedule schoolClassSchedule;
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束

//	private SchoolClassLessonPlans schoolClassLessonPlans;		// 授课计划Entity

	public ClassLesson() {
		super();
	}

	public ClassLesson(Long id){
		super(id);
	}

	@Length(min=1, max=512, message="课程名称长度必须介于 1 和 512 之间")
	public String getLessonName() {
		return lessonName;
	}

	public void setLessonName(String lessonName) {
		this.lessonName = lessonName;
	}

	public ClassToLesson getSchoolClassToLesson() {
		return schoolClassToLesson;
	}

	public void setSchoolClassToLesson(ClassToLesson schoolClassToLesson) {
		this.schoolClassToLesson = schoolClassToLesson;
	}

	public void setSchoolClassSchedule(ClassSchedule schoolClassSchedule) {
		this.schoolClassSchedule = schoolClassSchedule;
	}

	public Long getSchoolLessonType() {
		return schoolLessonType;
	}

	public void setSchoolLessonType(Long schoolLessonType) {
		this.schoolLessonType = schoolLessonType;
	}

	public ClassSchedule getSchoolClassSchedule() {
		return schoolClassSchedule;
	}

	public Subject getSchoolSubject() {
		return schoolSubject;
	}

	public void setSchoolSubject(Subject schoolSubject) {
		this.schoolSubject = schoolSubject;
	}

	/*public User getTeacher() {
		return teacher;
	}

	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}*/


	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public String getLessonContent() {
		return lessonContent;
	}

	public void setLessonContent(String lessonContent) {
		this.lessonContent = lessonContent;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public List<Long> getTeacherIdsList() {
		List<Long> list = new ArrayList<>();
		if (Strings.isNullOrEmpty(teacherIds))return list;

		String[] array = teacherIds.split(",");
		for(String id:array){
			if(Strings.isNullOrEmpty(id))continue;

			list.add(Long.parseLong(id));
		}

		return list;
	}

	public void setTeacherIdsList(List<Long> teacherIdsList) {
		this.teacherIdsList = teacherIdsList;
	}

	public String getTeacherIds() {
		return teacherIds;
	}

	public String getTeacherNames() {
		return teacherNames;
	}

	public void setTeacherNames(String teacherNames) {
		this.teacherNames = teacherNames;
	}

	public void setTeacherIds(String teacherIds) {
		this.teacherIds = teacherIds;
	}

	public CommonsType getCommonsType() {
		return commonsType;
	}

	public void setCommonsType(CommonsType commonsType) {
		this.commonsType = commonsType;
	}

	public void setTeacherList(List<User> teacherList) {
		this.teacherList = teacherList;
	}

	public List<User> getTeacherList() {
		return teacherList;
	}
}