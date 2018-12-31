/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.finacetype.entity;

import cn.com.beyo.erp.commons.persistence.TreeVo;
import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 财务科目设置Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class FinaceType extends TreeVo<FinaceType> {


	private String subjectName;		// 科目名称
	private String subjectCode;		// 科目编码
	private String remarks;		// 备注
	private String createDateStr;//时间转换业务字段
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

	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(Date lkj) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		createDateStr = sdf.format(lkj);
		this.createDateStr = createDateStr;
	}
	public FinaceType() {
		super();
	}

	public FinaceType(Long id){
		super(id);
	}

	@JsonBackReference
	public FinaceType getParent() {
		return parent;
	}

	public void setParent(FinaceType parent) {
		this.parent = parent;
	}

	@Length(min=1, max=512, message="科目名称长度必须介于 1 和 512 之间")
	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	@Length(min=1, max=255, message="科目编码长度必须介于 1 和 255 之间")
	public String getSubjectCode() {
		return subjectCode;
	}

	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}



}