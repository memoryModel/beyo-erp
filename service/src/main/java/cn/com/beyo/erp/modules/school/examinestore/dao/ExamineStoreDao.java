/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;

import java.util.List;

/**
 * 单表生成DAO接口
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@MyBatisDao
public interface ExamineStoreDao extends BeyoDao<ExamineStore> {
    /**
     * 查询题库列表
     * 绑定下拉框
     * @param examineStore
     * @return
     */
    public List<ExamineStore> findStoreList(ExamineStore examineStore);

    List<ExamineStore> findStoreAllList();
}