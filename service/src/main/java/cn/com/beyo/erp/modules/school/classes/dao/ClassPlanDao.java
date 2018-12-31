/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;

import java.util.List;

/**
 * 开班计划DAO接口
 * @author Ashon
 * @version 2017-06-01
 */
//@MyBatisDao
public interface ClassPlanDao extends BeyoDao<SchoolClass> {

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

    /**
     * 更新班级数据
     * @author Ashon
     * @version 2017-06-19
     */
    public int updateClass(SchoolClass schoolClass);

    /**
     * 查询一条班级
     * 根据班级ID
     * @author Ashon
     * @version 2017-06-20
     */
    public SchoolClass getById(SchoolClass schoolClass);
}