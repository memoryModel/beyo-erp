/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examinestore.entity.StoreToItems;

/**
 * 题库试题中间表DAO接口
 * @author beyo.com.cn
 * @version 2017-07-13
 */
@MyBatisDao
public interface StoreToItemsDao extends BeyoDao<StoreToItems> {

    public void deleteReal(StoreToItems storeToItems);
}