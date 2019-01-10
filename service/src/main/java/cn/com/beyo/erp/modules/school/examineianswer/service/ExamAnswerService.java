/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineianswer.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.school.examineianswer.dao.ExamAnswerDao;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examineianswer.facade.ExamineAnswerFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 试题答案Service
 * @author beyo.com.cn
 * @version 2017-06-15
 */
@Service
public class ExamAnswerService extends BeyoService<ExamAnswerDao, ExamineAnswer> implements ExamineAnswerFacade {

	@Autowired
	private ExamAnswerDao examAnswerDao;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ExamineAnswer get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineAnswer> findList(ExamineAnswer examineAnswer) {
		return super.findList(examineAnswer);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ExamineAnswer> findPage(Page<ExamineAnswer> page, ExamineAnswer examineAnswer) {
		return super.findPage(page, examineAnswer);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ExamineAnswer examineAnswer) {
		super.save(examineAnswer);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ExamineAnswer examineAnswer) {
		super.delete(examineAnswer);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int deleteAnswerByQuestion(ExamineAnswer examineAnswer){
		return examAnswerDao.deleteAnswerByQuestion(examineAnswer);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ExamineAnswer> findAnswerListByQuestion(ExamineAnswer examineAnswer){
		return examAnswerDao.findAnswerListByQuestion(examineAnswer);
	}
}