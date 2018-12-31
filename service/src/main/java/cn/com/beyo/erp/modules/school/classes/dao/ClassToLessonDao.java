/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.classes.entity.ClassToLesson;

import java.util.List;

/**
 * 班级中间表DAO接口
 * @author Ashon
 * @version 2017-06-20
 */
//@MyBatisDao
public interface ClassToLessonDao extends BeyoDao<ClassToLesson> {

    public void saveClassLesson(ClassToLesson classToLesson);

    /*根据课程Id查询已排课的班级名称*/
    public List<ClassToLesson> selectClass(ClassToLesson classToLesson);
}