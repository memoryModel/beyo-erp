/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.clessstudents.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;

import java.util.List;

/**
 * 新增班级中间表DAO接口
 * @author beyo.com.cn
 * @version 2017-06-27
 */
@MyBatisDao
public interface ClassStudentsDao extends BeyoDao<ClassStudents> {

    /**
     * 转班
     * @param classStudents
     */
    int changeClass(ClassStudents classStudents);

    /**
     * 查询退班学生列表
     * @param schoolClassStudents
     * @return
     */
    List<ClassStudents> findQuitList(ClassStudents schoolClassStudents);

    /**
     * 证书办理查询办理学员班级
     * @param classStudents
     * @return
     */
    List<ClassStudents> findClassStudent(ClassStudents classStudents);

    /**
     * 添加证书后修改这条记录的状态
     * @param classStudents
     */
    void updateClassStudents(ClassStudents classStudents);

    void updateStudentsForStudy(ClassStudents classStudents);

    List<ClassStudents> findListByStu(ClassStudents classStudents);
}