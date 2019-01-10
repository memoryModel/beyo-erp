package cn.com.beyo.erp.modules.school.examineianswer.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;

import java.util.List;

public interface ExamineAnswerFacade extends BeyoFacade<ExamineAnswer> {

    int deleteAnswerByQuestion(ExamineAnswer examineAnswer);

    List<ExamineAnswer> findAnswerListByQuestion(ExamineAnswer examineAnswer);
}
