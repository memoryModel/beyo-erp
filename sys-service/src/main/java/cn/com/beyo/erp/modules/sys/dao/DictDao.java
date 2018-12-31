/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.dao;

import cn.com.beyo.erp.commons.persistence.CrudDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.sys.entity.Dict;

import java.util.List;

/**
 * 字典DAO接口
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
