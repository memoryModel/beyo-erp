/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classlessonsignhistory.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.classlessonsign.entity.ClassLessonSign;
import cn.com.beyo.erp.modules.school.schedule.entity.ClassSchedule;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 课程签到子表Entity
 * @author beyo.com.cn
 * @version 2017-06-08
 */
public class ClassLessonSignHistory extends DataVo<ClassLessonSignHistory> {
	
	private static final long serialVersionUID = 1L;

	private cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll; //学员id
	private ClassLessonSign classLessonSign; //课程签到
	private Long absenceReason;		// 缺勤原因
	private String remark;		// 备注

	public ClassLessonSignHistory() {
		super();
	}
	public ClassLessonSignHistory(Long id){
		super(id);
	}

	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private Integer arrangeStatus;    //补课状态

	private Integer absenceNum;   //缺勤次数

	private ClassSchedule classSchedule;
	public Long getAbsenceReason() {
		return absenceReason;
	}

	public void setAbsenceReason(Long absenceReason) {
		this.absenceReason = absenceReason;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getErpStudentEnroll() {
		return erpStudentEnroll;
	}

	public void setErpStudentEnroll(cn.com.beyo.erp.modules.school.student.entity.Student erpStudentEnroll) {
		this.erpStudentEnroll = erpStudentEnroll;
	}

	public Date getCreateTimeStart() {return createTimeStart;}

	public void setCreateTimeStart(Date createTimeStart) {this.createTimeStart = createTimeStart;}

	public Date getCreateTimeEnd() {return createTimeEnd;}

	public void setCreateTimeEnd(Date createTimeEnd) {this.createTimeEnd = createTimeEnd;}

	public ClassLessonSign getClassLessonSign() {
		return classLessonSign;
	}

	public void setClassLessonSign(ClassLessonSign classLessonSign) {
		this.classLessonSign = classLessonSign;
	}

	public Integer getArrangeStatus() {
		return arrangeStatus;
	}

	public void setArrangeStatus(Integer arrangeStatus) {
		this.arrangeStatus = arrangeStatus;
	}

	public Integer getAbsenceNum() {
		return absenceNum;
	}

	public void setAbsenceNum(Integer absenceNum) {
		this.absenceNum = absenceNum;
	}

	public ClassSchedule getClassSchedule() {
		return classSchedule;
	}

	public void setClassSchedule(ClassSchedule classSchedule) {
		this.classSchedule = classSchedule;
	}

}