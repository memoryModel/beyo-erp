/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.subject.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 单表Entity
 * @author beyo.com.cn
 * @version 2017-06-01
 */
public class Subject extends DataVo<Subject> {
	
	private static final long serialVersionUID = 1L;
	private String subjectName;		// 名称
	private String description;		// 描述
	private Date startTime;
	private Date endTime;
	
	public Subject() {
		super();
	}

	public Subject(Long id){
		super(id);
	}
	
	@Length(min=0, max=512, message="名称长度必须介于 0 和 512 之间")
	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	
	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
}