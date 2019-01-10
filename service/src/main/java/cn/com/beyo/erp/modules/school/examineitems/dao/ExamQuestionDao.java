/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineitems.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examinepaper.entity.ExaminePaper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 考试试题DAO接口
 * @author beyo.com.cn
 * @version 2017-06-15
 */
@MyBatisDao
public interface ExamQuestionDao extends BeyoDao<ExamQuestion> {


    int deleteQuestionByStore(ExamQuestion examQuestion);
    List<ExamQuestion> findQuestionListByStore(ExamQuestion examQuestion);
    List<ExamQuestion> findQuestionListByRandom(ExamQuestion examQuestion);
    List<ExamQuestion> findQuestionListByPaper(ExaminePaper examinePaper);

}