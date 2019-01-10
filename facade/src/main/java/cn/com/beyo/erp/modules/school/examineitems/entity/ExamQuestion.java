/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineitems.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;

import java.util.List;

/**
 * 考试试题Entity
 * @author beyo.com.cn
 * @version 2017-06-15
 */
public class ExamQuestion extends DataVo<ExamQuestion> {

	private Integer type;		// 类型  试题类型
	private String title;		//试题题目
	private Integer point;
	private ExamineStore examineStore; // 题库


	private Integer limit;
	private List<ExamineAnswer> answerList;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public ExamineStore getExamineStore() {
		return examineStore;
	}
	public void setExamineStore(ExamineStore examineStore) {
		this.examineStore = examineStore;
	}

	public List<ExamineAnswer> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<ExamineAnswer> answerList) {
		this.answerList = answerList;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}
}