/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.CrudService;
import cn.com.beyo.erp.modules.sys.dao.NotifyDao;
import cn.com.beyo.erp.modules.sys.dao.NotifyRecordDao;
import cn.com.beyo.erp.modules.sys.entity.Notify;
import cn.com.beyo.erp.modules.sys.entity.NotifyRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 通知通告Service
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@Service
public class NotifyService extends CrudService<NotifyDao, Notify> {

	@Autowired
	private NotifyRecordDao notifyRecordDao;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Notify get(Long id) {
		Notify entity = dao.get(id);
		return entity;
	}
	
	/**
	 * 获取通知发送记录
	 * @param notify
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Notify getRecordList(Notify notify) {
		notify.setNotifyRecordList(notifyRecordDao.findList(new NotifyRecord(notify)));
		return notify;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<Notify> find(Page<Notify> page, Notify notify) {
		notify.setPage(page);
		page.setList(dao.findList(notify));
		return page;
	}
	
	/**
	 * 获取通知数目
	 * @param notify
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Long findCount(Notify notify) {
		return dao.findCount(notify);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(Notify notify) {
		super.save(notify);
		
		// 更新发送接受人记录
		notifyRecordDao.deleteByOaNotifyId(notify.getId());
		if (notify.getNotifyRecordList().size() > 0){
			notifyRecordDao.insertAll(notify.getNotifyRecordList());
		}
	}
	
	/**
	 * 更新阅读状态
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateReadFlag(Notify notify) {
		NotifyRecord notifyRecord = new NotifyRecord(notify);
		notifyRecord.setUser(notifyRecord.getCurrentUser());
		notifyRecord.setReadDate(new Date());
		notifyRecord.setReadFlag("1");
		notifyRecordDao.update(notifyRecord);
	}
}