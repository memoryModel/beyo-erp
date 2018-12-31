/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.areas.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;

import java.util.List;

/**
 * 所属校区DAO接口
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@MyBatisDao
public interface AreasDao extends BeyoDao<Areas> {


    Areas get(Long id);

    List<Areas> getAreasList();

    /**
     * 所属校区查询
     * @return
     */
    List<Areas> findAreasList();


}