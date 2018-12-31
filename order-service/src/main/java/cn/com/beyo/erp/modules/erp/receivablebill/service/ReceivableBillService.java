/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.receivablebill.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.receivablebill.dao.ReceivableBillDao;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.erp.receivablebill.facade.ReceivableBillFacade;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 应收账单Service
 * @author Ashon
 * @version 2017-06-28
 */
@Service(value = "receivableBillService")
public class ReceivableBillService extends BeyoService<ReceivableBillDao, ReceivableBill> implements ReceivableBillFacade {

	@Autowired
	private ReceivableBillDao receivableBillDao;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ReceivableBill get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ReceivableBill> findList(ReceivableBill erpReceivableBill) {
		return super.findList(erpReceivableBill);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ReceivableBill> findPage(Page<ReceivableBill> page, ReceivableBill erpReceivableBill) {
		erpReceivableBill.setPage(page);
		page.setList(dao.findList(erpReceivableBill));
		return page;
	}

	/**
	 * 收款单分页
	 * @param page
	 * @param erpReceivableBill
	 * @author Ashon
	 * @version 2017-08-07
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ReceivableBill> findPayBillPage(Page<ReceivableBill> page, ReceivableBill erpReceivableBill) {
		erpReceivableBill.setPage(page);
		page.setList(dao.findPayBillList(erpReceivableBill));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ReceivableBill erpReceivableBill) {
		System.out.println("-----------------ReceivableBillService的save()方法执行成功-----------");
		//super.save(erpReceivableBill);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ReceivableBill erpReceivableBill) {
		super.delete(erpReceivableBill);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ReceivableBill> findPageByPayStatus(Page<ReceivableBill> page, ReceivableBill erpReceivableBill) {
		erpReceivableBill.setPage(page);
		page.setList(receivableBillDao.findPageByPayStatus(erpReceivableBill));
		return page;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ReceivableBill getErpReceiveBillById(Long id) {
		return receivableBillDao.getErpReceiveBillById(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ReceivableBill getById(ReceivableBill erpReceivableBill) {
		return receivableBillDao.getById(erpReceivableBill);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ReceivableBill getByOrderId(Long orderId) {
		ReceivableBill erpReceivableBill = new ReceivableBill(new Order(orderId));
		return receivableBillDao.getByOrderId(erpReceivableBill);
	}

	/**
	 * 账单挂起功能
	 * @param erpReceivableBill
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void freeze(ReceivableBill erpReceivableBill) {
		receivableBillDao.freeze(erpReceivableBill);
	}

	/**
	 * 账单解挂功能
	 * @param erpReceivableBill
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void unlock(ReceivableBill erpReceivableBill) {
		receivableBillDao.unlock(erpReceivableBill);
	}
	/*确认收入功能键*/
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void affirm(ReceivableBill erpReceivableBill) {
		receivableBillDao.affirm(erpReceivableBill);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ReceivableBill findReceivableBillByOrder(ReceivableBill receivableBill){
		return receivableBillDao.findReceivableBillByOrder(receivableBill);
	}
}