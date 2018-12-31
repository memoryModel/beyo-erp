/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlive.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.school.dormlive.dao.DormEmployeeLiveDao;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormEmployeeLive;
import cn.com.beyo.erp.modules.school.dormlive.facade.DormEmployeeLiveFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.List;

/**
 * 单表生成Service
 * @author beyo.com.cn
 * @version 2017-06-10
 */
@Service(value = "dormEmployeeLiveService")
public class DormEmployeeLiveService extends BeyoService<DormEmployeeLiveDao, DormEmployeeLive>
				implements DormEmployeeLiveFacade{
	@Autowired
	private DormEmployeeLiveDao dormEmployeeLiveDao;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public DormEmployeeLive get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<DormEmployeeLive> findList(DormEmployeeLive dormEmployeeLive) {
		return super.findList(dormEmployeeLive);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<DormEmployeeLive> findPage(Page<DormEmployeeLive> page, DormEmployeeLive dormEmployeeLive) {
		dormEmployeeLive.setPage(page);
		page.setList(dao.findList(dormEmployeeLive));
		return page;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<DormEmployeeLive> findPageLeave(Page<DormEmployeeLive> page, DormEmployeeLive dormEmployeeLive) {
		dormEmployeeLive.setPage(page);
		page.setList(dormEmployeeLiveDao.findEmployeeLeaveList(dormEmployeeLive));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(DormEmployeeLive dormEmployeeLive) {
		System.out.println("--------------DormEmployeeLiveService的save()方法执行成功-----------");
		//super.save(dormEmployeeLive);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(DormEmployeeLive dormEmployeeLive) {
		super.delete(dormEmployeeLive);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int getDormEmployeeLiveByEmployeeId(Long id) {
		return dormEmployeeLiveDao.getDormEmployeeLiveByEmployeeId(id);
	}


}