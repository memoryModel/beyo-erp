package cn.com.beyo.erp.modules.school.examineitems.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examinepaper.entity.ExaminePaper;

import java.util.List;

public interface ExamQuestionFacade extends BeyoFacade<ExamQuestion>{

    int deleteQuestionByStore(ExamQuestion examQuestion);

    List<ExamQuestion> findQuestionListByStore(ExamQuestion examQuestion);

    List<ExamQuestion> findQuestionListByRandom(ExamQuestion examQuestion);

    List<ExamQuestion> findQuestionListByPaper(ExaminePaper examinePaper);

    List<ExamQuestion> findAnswer(List<ExamQuestion> questionList);

    void saveExamQuestion(ExamQuestion examQuestion, String options,
                          String optionContents, String statusess, String[] strings, String[] strings2);
}
