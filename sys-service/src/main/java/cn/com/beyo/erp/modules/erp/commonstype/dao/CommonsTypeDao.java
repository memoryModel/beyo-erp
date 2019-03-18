/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.commonstype.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;

import java.util.List;

/**
 * 基础类型DAO接口
 * @author beyo.com.cn
 * @version 2017-06-01
 */
@MyBatisDao
public interface CommonsTypeDao extends BeyoDao<CommonsType> {

    List<CommonsType> findcomonsTypeList(CommonsType commonsType);


}