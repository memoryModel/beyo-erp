/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlive.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormStudentLive;

import java.util.List;

/**
 * 单表生成DAO接口
 * @author beyo.com.cn
 * @version 2017-06-10
 */
@MyBatisDao
public interface DormStudentLiveDao extends BeyoDao<DormStudentLive> {
    public List<DormStudentLive> findStudentLeaveList(DormStudentLive dormStudentLive);

    int getDormStudentLiveByStudentId(Long id);
}