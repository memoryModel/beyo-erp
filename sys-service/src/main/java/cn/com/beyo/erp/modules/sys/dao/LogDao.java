/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.dao;

import cn.com.beyo.erp.commons.persistence.CrudDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.sys.entity.Log;

/**
 * 日志DAO接口
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {

}
