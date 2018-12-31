/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.service;

import cn.com.beyo.erp.commons.service.TreeService;
import cn.com.beyo.erp.modules.sys.dao.AreaDao;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.facade.AreaFacade;
import cn.com.beyo.erp.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 区域Service
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@Service(value = "areaService")
public class AreaService extends TreeService<AreaDao, Area> implements AreaFacade {

	@Autowired
	private AreaDao areaDao;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}



	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Area> findAllList(Area area) {
		return areaDao.findAllList(area);
	}
}
