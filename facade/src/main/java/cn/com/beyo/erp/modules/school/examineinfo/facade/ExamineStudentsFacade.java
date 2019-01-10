package cn.com.beyo.erp.modules.school.examineinfo.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;

import java.util.List;
import java.util.Map;

public interface ExamineStudentsFacade extends BeyoFacade<ExamineStudents> {

    void deleteReal(ExamineStudents examineStudents);

    List<ExamineStudents> examineList(Long id);

    List<ExamineStudents> findStudent(ExamineStudents examineStudents);

    List<ExamineStudents> selectStudent(ExamineStudents examineStudents);

    void updateScore(ExamineStudents examineStudents);

    int cleanExamineInfoStudents(ExamineStudents examineStudents);

    List<ExamineStudents> findExamineInfoStudentByExamineInfo(ExamineStudents examineStudents);

    int updateExamineInfoStudents(ExamineStudents examineStudents);

    int updateScoreByExamStuden(ExamineStudents examineStudents);

    String studentScoreSave(ExamineInfo examineInfo, String[] studentIdArray, String[] gradeArray);

    Map<String,String> updateScore(ExamineStudents examineStudents, String strVlaue);


}
