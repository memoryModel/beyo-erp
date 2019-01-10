/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-08
 */
public class ExamineStore extends DataVo<ExamineStore> {

	private String name;		// 题库名称
	private String remark;		// 备注
	private Long subject; //科目
	private Integer type;
	private Integer questionCount;

	private List<ExamQuestion> examQuestionList;


	public ExamineStore() {
		super();
	}

	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束



	public ExamineStore(Long id){
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Length(min=0, max=1000, message="备注长度必须介于 0 和 1000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateTimeStart() {return createTimeStart;}

	public void setCreateTimeStart(Date createTimeStart) {this.createTimeStart = createTimeStart;}

	public Date getCreateTimeEnd() {return createTimeEnd;}

	public void setCreateTimeEnd(Date createTimeEnd) {this.createTimeEnd = createTimeEnd;}

	public Integer getQuestionCount() {
		return questionCount;
	}

	public void setQuestionCount(Integer questionCount) {
		this.questionCount = questionCount;
	}

	public Long getSubject() {
		return subject;
	}

	public void setSubject(Long subject) {
		this.subject = subject;
	}

	public void setExamQuestionList(List<ExamQuestion> examQuestionList) {
		this.examQuestionList = examQuestionList;
	}

	public List<ExamQuestion> getExamQuestionList() {
		return examQuestionList;
	}
}