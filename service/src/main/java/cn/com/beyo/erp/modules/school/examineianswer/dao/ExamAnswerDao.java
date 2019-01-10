/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineianswer.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 试题答案DAO接口
 * @author beyo.com.cn
 * @version 2017-06-15
 */
@MyBatisDao
public interface ExamAnswerDao extends BeyoDao<ExamineAnswer> {
	int deleteAnswerByQuestion(ExamineAnswer examineAnswer);
	List<ExamineAnswer> findAnswerListByQuestion(ExamineAnswer examineAnswer);
}