/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;

/**
 * 题库试题中间表Entity
 * @author beyo.com.cn
 * @version 2017-07-13
 */
public class StoreToItems extends DataVo<StoreToItems> {

	private static final long serialVersionUID = 1L;
	private ExamineStore examineStore;    //题库ID
	private ExamQuestion examQuestion;    //试题ID


	public StoreToItems() {
		super();
	}

	public StoreToItems(Long id){
		super(id);
	}

	public StoreToItems(ExamineStore examineStore){
		super();
		this.examineStore = examineStore;
	}

	public StoreToItems(ExamQuestion examQuestion){

		super();
		this.examQuestion = examQuestion;
	}

	public StoreToItems(ExamineStore examineStore, ExamQuestion examQuestion){
		super();
		this.examineStore = examineStore;
		this.examQuestion = examQuestion;
	}

	public ExamineStore getExamineStore() {
		return examineStore;
	}

	public void setExamineStore(ExamineStore examineStore) {
		this.examineStore = examineStore;
	}

	public ExamQuestion getExamQuestion() {
		return examQuestion;
	}

	public void setExamQuestion(ExamQuestion examQuestion) {
		this.examQuestion = examQuestion;
	}
}