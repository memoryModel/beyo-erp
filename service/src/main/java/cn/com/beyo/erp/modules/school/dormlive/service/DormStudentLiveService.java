/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlive.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.LiveStatus;
import cn.com.beyo.erp.modules.school.dormlive.dao.DormStudentLiveDao;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormStudentLive;
import cn.com.beyo.erp.modules.school.dormlive.facade.DormStudentLiveFacade;
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
@Service(value = "dormStudentLiveService")
public class DormStudentLiveService extends BeyoService<DormStudentLiveDao, DormStudentLive>
				implements DormStudentLiveFacade{

	@Autowired
	private DormStudentLiveDao dormStudentLiveDao;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public DormStudentLive get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<DormStudentLive> findList(DormStudentLive dormStudentLive) {
		return super.findList(dormStudentLive);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<DormStudentLive> findPage(Page<DormStudentLive> page, DormStudentLive dormStudentLive) {
		dormStudentLive.setPage(page);
		page.setList(dao.findList(dormStudentLive));
		return page;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<DormStudentLive> findPageLeave(Page<DormStudentLive> page, DormStudentLive dormStudentLive) {
		dormStudentLive.setPage(page);
		page.setList(dormStudentLiveDao.findStudentLeaveList(dormStudentLive));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(DormStudentLive dormStudentLive) {
		System.out.println("--------------DormStudentLiveService的save()方法执行成功-----------");
		//super.save(dormStudentLive);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(DormStudentLive dormStudentLive) {
		super.delete(dormStudentLive);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int getDormStudentLiveByStudentId(Long id) {
		return dormStudentLiveDao.getDormStudentLiveByStudentId(id);
	}
}