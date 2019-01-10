/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.school.examinestore.dao.StoreToItemsDao;
import cn.com.beyo.erp.modules.school.examinestore.entity.StoreToItems;
import cn.com.beyo.erp.modules.school.examinestore.facade.StoreToItemsFacade;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 题库试题中间表Service
 * @author beyo.com.cn
 * @version 2017-07-13
 */
@Service
public class StoreToItemsService extends BeyoService<StoreToItemsDao, StoreToItems> implements StoreToItemsFacade {

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public StoreToItems get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<StoreToItems> findList(StoreToItems storeToItems) {
		return super.findList(storeToItems);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<StoreToItems> findPage(Page<StoreToItems> page, StoreToItems storeToItems) {
		return super.findPage(page, storeToItems);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(StoreToItems storeToItems) {
		super.save(storeToItems);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(StoreToItems storeToItems) {
		super.delete(storeToItems);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void deleteReal(StoreToItems storeToItems) {
		dao.deleteReal(storeToItems);
	}
}