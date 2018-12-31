/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classroom.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 教室设置Entity
 * @author beyo.com.cn
 * @version 2017-06-05
 */
public class Classroom extends DataVo<Classroom> {

	private static final long serialVersionUID = 1L;
	private String classroomName;		// 教室名称
	private String description;		// 描述
	private Integer marksNumber;		// 容纳人数

	private Date startTime;    //业务时间字段
	private Date endTime;

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

	public Classroom() {
		super();
	}

	public Classroom(Long id){
		super(id);
	}


	@Length(min=1, max=64, message="教室名称长度必须介于 1 和 64 之间")
	public String getClassroomName() {
		return classroomName;
	}

	public void setClassroomName(String classroomName) {
		this.classroomName = classroomName;
	}

	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@NotNull(message="容纳人数不能为空")
	public Integer getMarksNumber() {
		return marksNumber;
	}

	public void setMarksNumber(Integer marksNumber) {
		this.marksNumber = marksNumber;
	}



}