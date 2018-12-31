/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.dao;

import cn.com.beyo.erp.commons.persistence.TreeDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.sys.entity.Office;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * 机构DAO接口
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

    /**
     * 查询emp
     * @author Ashon
     * @version 2017-06-07
     */
    public List<Office> findEmployeeList(Office Office);

    /**
     * 查询学员
     * @param
     * @return
     */
    public List<Office> findStudentList(Office Office);

    public int findChildsByParentId(Office Office);
    public int findUsersByParentId(Office Office);

    /**
     *
     * 异步加载数据来源
     */
    List<String> getOfficeNames(@Param("createUsersArray") String[] createUsersArray, @Param("selfCompanyId") Long selfCompanyId);
}
