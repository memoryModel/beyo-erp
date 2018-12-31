/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.dao;

import cn.com.beyo.erp.commons.persistence.CrudDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.sys.entity.NotifyRecord;

import java.util.List;

/**
 * 通知通告记录DAO接口
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@MyBatisDao
public interface NotifyRecordDao extends CrudDao<NotifyRecord> {

	/**
	 * 插入通知记录
	 * @param notifyRecordList
	 * @return
	 */
	public int insertAll(List<NotifyRecord> notifyRecordList);
	
	/**
	 * 根据通知ID删除通知记录
	 * @param oaNotifyId 通知ID
	 * @return
	 */
	public int deleteByOaNotifyId(Long oaNotifyId);
	
}