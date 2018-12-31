/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;

/**
 * 学校班级课程中间表Entity
 * @author Ashon
 * @version 2017-06-01
 */
public class ClassToLesson extends DataVo<ClassToLesson> {

	private static final long serialVersionUID = 1L;
	private ClassLesson schoolClassLesson;
	private SchoolClass schoolClass;
	private CommonsType commonsType;
	//private Integer status;	// 状态  通用状态枚举  0.正常  1.删除

	public ClassToLesson() {
		super();
	}

	public ClassToLesson(Long id){
		super(id);
	}

	public ClassToLesson(ClassLesson schoolClassLesson){
		super();
		this.schoolClassLesson = schoolClassLesson;
	}

	public ClassToLesson(SchoolClass schoolClass){
		super();
		this.schoolClass = schoolClass;
	}

	public ClassToLesson(ClassLesson schoolClassLesson, SchoolClass schoolClass){
		super();
		this.schoolClassLesson = schoolClassLesson;
		this.schoolClass = schoolClass;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public ClassLesson getSchoolClassLesson() {
		return schoolClassLesson;
	}

	public void setSchoolClassLesson(ClassLesson schoolClassLesson) {
		this.schoolClassLesson = schoolClassLesson;
	}

	public SchoolClass getSchoolClass() {
		return schoolClass;
	}

	public void setSchoolClass(SchoolClass schoolClass) {
		this.schoolClass = schoolClass;
	}

	public CommonsType getCommonsType() {
		return commonsType;
	}

	public void setCommonsType(CommonsType commonsType) {
		this.commonsType = commonsType;
	}
}