/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.commons.service;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.commons.persistence.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Service基类
 * @author beyo.com.cn
 * @version 2014-05-16
 */

public abstract class BeyoService<D extends BeyoDao<T>, T extends DataVo<T>> extends BaseService implements BeyoFacade<T> {

	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;

	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public T get(Long id) {
		return dao.get(id);
	}

	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public T get(T entity) {
		return dao.get(entity);
	}

	/**
	 * 查询列表数据
	 * @param entity
	 * @return
	 */
	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}

	/**
	 * 查询分页数据findList
	 * @param page 分页对象
	 * @param entity
	 * @return
	 */
	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<T> findPage(Page<T> page, T entity) {
		entity.setPage(page);
		page.setList(dao.findList(entity));
		return page;
	}

	/**
	 * 保存数据（插入或更新）
	 * @param entity
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(T entity){
		if (null==entity.getId()){
			try{
				entity.nextId();
			}catch (Exception e){
				e.printStackTrace();
				//entity.setId(null);
			}
		}
		entity.setCreateTime(new Date());
		dao.insert(entity);

	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public Long update(T entity) {
		return dao.update(entity);
	}

	/**
	 * 删除数据
	 * @param entity
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(T entity) {
		 dao.delete(entity);
	}

}
