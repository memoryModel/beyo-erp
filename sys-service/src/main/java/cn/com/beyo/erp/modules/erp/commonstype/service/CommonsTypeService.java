/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.commonstype.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.erp.commonstype.dao.CommonsTypeDao;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;
import cn.com.beyo.erp.modules.erp.commonstype.facade.CommonsTypeFacade;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 基础类型Service
 * @author beyo.com.cn
 * @version 2017-06-01
 */
@Service
public class CommonsTypeService extends BeyoService<CommonsTypeDao, CommonsType> implements CommonsTypeFacade{
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public CommonsType get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<CommonsType> findList(CommonsType commonsType) {
		return super.findList(commonsType);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<CommonsType> findPage(Page<CommonsType> page, CommonsType commonsType) {
		return super.findPage(page, commonsType);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(CommonsType commonsType) {
		super.save(commonsType);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(CommonsType commonsType) {
		super.delete(commonsType);
	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public List<CommonsType> findcomonsTypeList(CommonsType commonsType) {
		return dao.findcomonsTypeList(commonsType);
    }

}