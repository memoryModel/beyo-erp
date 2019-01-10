/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.student.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.schedule.entity.ClassSchedule;
import cn.com.beyo.erp.modules.school.student.entity.Student;

import java.util.List;
import java.util.Map;

/**
 * 单表生成DAO接口
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@MyBatisDao
public interface StudentDao extends BeyoDao<Student> {


    /**
     * 根据标识符tagFlag判断有无人员跟进的生源列表
     * @param student
     * @return
     */
    List<Student> findStudentListAndFollow(Student student);

    List<Student> findStudentClass(Student studentEnroll);

    /**
     * 改班级所有学员状态
     * @param student
     * @author Ashon
     */
    void updateStatusByClass(Student student);


}