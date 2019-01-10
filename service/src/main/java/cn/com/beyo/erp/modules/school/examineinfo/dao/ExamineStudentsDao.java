/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;

import java.util.List;

/**
 * 考试学员DAO接口
 * @author beyo.com.cn
 * @version 2017-06-14
 */
@MyBatisDao
public interface ExamineStudentsDao extends BeyoDao<ExamineStudents> {

    public void deleteReal(ExamineStudents examineStudents);

    public List<ExamineStudents> examineList(Long id);

    /**
     *
     * 根据考试信息ID查询对应的学员信息
     * @param examineStudents
     * @return
     */
    public List<ExamineStudents> findStudent(ExamineStudents examineStudents);

    //成绩录入（根据考试ID查询对应的学员信息）
    List<ExamineStudents> selectStudent(ExamineStudents examineStudents);

    //添加成绩
    void updateScore(ExamineStudents examineStudents);
    int cleanExamineInfoStudents(ExamineStudents examineStudents);
    List<ExamineStudents> findExamineInfoStudentByExamineInfo(ExamineStudents examineStudents);

    int updateExamineInfoStudents(ExamineStudents examineStudents);
    int updateScoreByExamStuden(ExamineStudents examineStudents);
}