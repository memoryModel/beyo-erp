/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 班级管理DAO接口
 * @author Ashon
 * @version 2017-06-01
 */
@MyBatisDao
public interface ClassDao extends BeyoDao<SchoolClass> {

    /**
     * 查询班级列表
     * 绑定下拉框
     * @author Ashon
     * @version 2017-06-06
     */
    public List<SchoolClass> findClassList(SchoolClass schoolClass);

    /**
     * 变更业务状态
     * @author Ashon
     * @version 2017-06-13
     */
    public void updateStatus(SchoolClass schoolClass);

    public SchoolClass changeClass(SchoolClass sc);


    public SchoolClass getById(SchoolClass schoolClass);

    List<SchoolClass> findClassListByEmployee(Long id);

    public  void saveClass(SchoolClass schoolClass);

    /**
     * 转班：查询所有班级
     * @param schoolClass
     * @return
     */
    List<SchoolClass> selectClassList(SchoolClass schoolClass);

    //查询未结业的班级
    List selectClass(SchoolClass schoolClass);
    /*全部订单*/
    List<Class> findClassByOrderId(Long id);
    /*订单管理*/
    List<Class> findClassListByStudentId(Long id);

    List<Class> selectCourseSchedule(@Param("scheduleList") List<Map> scheduleList);

    int updateClassRealNumById(SchoolClass schoolClass);
}