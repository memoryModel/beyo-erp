/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineianswer.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;

/**
 * 试题答案Entity
 * @author beyo.com.cn
 * @version 2017-06-15
 */
public class ExamineAnswer extends DataVo<ExamineAnswer> {

	private String reference;		// 选项
	private String title;		// 选项内容
	private Integer solution;
	private ExamQuestion examQuestion;
	private ExamineStore examStore;


	public ExamineAnswer() {
		super();
	}

	public ExamineAnswer(Long id){
		super(id);
	}

	public ExamQuestion getExamQuestion() {
		return examQuestion;
	}

	public void setExamQuestion(ExamQuestion examQuestion) {
		this.examQuestion = examQuestion;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getSolution() {
		return solution;
	}

	public void setSolution(Integer solution) {
		this.solution = solution;
	}

	public ExamineStore getExamStore() {
		return examStore;
	}

	public void setExamStore(ExamineStore examStore) {
		this.examStore = examStore;
	}
}