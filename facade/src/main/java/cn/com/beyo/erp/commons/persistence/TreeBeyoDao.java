/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.commons.persistence;

import java.util.List;

/**
 * DAO支持类实现
 * @author beyo.com.cn
 * @version 2014-05-16
 * @param <T>
 */
public interface TreeBeyoDao<T extends TreeVo<T>> extends BeyoDao<T> {

	/**
	 * 找到所有子节点
	 * @param entity
	 * @return
	 */
	public List<T> findByParentIdsLike(T entity);

	/**
	 * 更新所有父节点字段
	 * @param entity
	 * @return
	 */
	public int updateParentIds(T entity);
	
}