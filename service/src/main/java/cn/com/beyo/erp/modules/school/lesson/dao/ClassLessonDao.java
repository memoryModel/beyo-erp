/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.lesson.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;

import java.util.List;

/**
 * 课程管理DAO接口
 * @author Ashon
 * @version 2017-06-01
 */
@MyBatisDao
public interface ClassLessonDao extends BeyoDao<ClassLesson> {

    /**
     * 根据Id查询课程
     */
    public ClassLesson findById(ClassLesson schoolClassLesson);


    /**
     * 查询课程列表
     */
    public List<ClassLesson> findLessonList(ClassLesson schoolClassLesson);

    public List<ClassLesson> findLessonLists(ClassLesson schoolClassLesson);

    //新开班补课课程
    public void saveClassLesson(ClassLesson classLesson);

    /**
     * 查询班级课程列表
     * @return List<SchoolClassLesson>
     * @author Ashon
     * @version 2017-07-29
     */
    List<ClassLesson> findClassLessonList(ClassLesson classLesson);


    List<ClassLesson> selectListAll(ClassLesson classLesson);

}