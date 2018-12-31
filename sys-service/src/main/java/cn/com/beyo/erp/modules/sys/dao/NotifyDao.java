/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.dao;

import cn.com.beyo.erp.commons.persistence.CrudDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.sys.entity.Notify;

/**
 * 通知通告DAO接口
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@MyBatisDao
public interface NotifyDao extends CrudDao<Notify> {
	
	/**
	 * 获取通知数目
	 * @param notify
	 * @return
	 */
	public Long findCount(Notify notify);
	
}