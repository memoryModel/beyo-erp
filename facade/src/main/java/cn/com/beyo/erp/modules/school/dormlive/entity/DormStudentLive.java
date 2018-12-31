/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlive.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classes.entity.ClassToLesson;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.dormroom.entity.DormRoom;
import cn.com.beyo.erp.modules.sys.entity.Area;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-10
 */
public class DormStudentLive extends DataVo<DormStudentLive> {
	
	private static final long serialVersionUID = 1L;
	private cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll; //学员
	private DormRoom dormRoom;
	private Area area;
	private Date startTime;
	private Date endTime;
	private ClassStudents schoolClassStudents;
	private ClassToLesson schoolClassToLesson;
	private Date liveTime;

	public DormStudentLive(Long id){
		super(id);
	}

	public DormStudentLive() {

	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getErpStudentEnroll() {
		return erpStudentEnroll;
	}

	public void setErpStudentEnroll(cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll) {
		this.erpStudentEnroll = erpStudentEnroll;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
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

	public ClassStudents getSchoolClassStudents() {
		return schoolClassStudents;
	}

	public void setSchoolClassStudents(ClassStudents schoolClassStudents) {
		this.schoolClassStudents = schoolClassStudents;
	}

	public ClassToLesson getSchoolClassToLesson() {
		return schoolClassToLesson;
	}

	public void setSchoolClassToLesson(ClassToLesson schoolClassToLesson) {
		this.schoolClassToLesson = schoolClassToLesson;
	}

	public DormRoom getDormRoom() {
		return dormRoom;
	}

	public void setDormRoom(DormRoom dormRoom) {
		this.dormRoom = dormRoom;
	}

	public Date getLiveTime() {
		return liveTime;
	}

	public void setLiveTime(Date liveTime) {
		this.liveTime = liveTime;
	}
}