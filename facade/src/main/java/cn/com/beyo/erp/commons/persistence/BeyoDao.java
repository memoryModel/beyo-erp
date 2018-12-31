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
public interface BeyoDao<T> {

	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public T get(Long id);

	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	public T get(T entity);

	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity
	 * @return
	 */
	public List<T> findList(T entity);

	/**
	 * 查询所有数据列表
	 * @param entity
	 * @return
	 */
	public List<T> findAllList(T entity);

	/**
	 * 查询所有数据列表
	 * @see public List<T> findAllList(T entity)
	 * @return
	 */
	@Deprecated
	public List<T> findAllList();

	/**
	 * 插入数据
	 * @param entity
	 * @return
	 */
	public Long insert(T entity);

	/**
	 * 更新数据
	 * @param entity
	 * @return
	 */
	public Long update(T entity);

	/**
	 * 删除数据（一般为逻辑删除，更新del_flag字段为1）
	 * @param id
	 * @see public int delete(T entity)
	 * @return
	 */
	@Deprecated
	public int delete(Long id);

	/**
	 * 删除数据（一般为逻辑删除，更新del_flag字段为1）
	 * @param entity
	 * @return
	 */
	public int delete(T entity);
	/**
	 * 开票申请的发票金额
	 * @param ids
	 * @return
	 */
	long getFaPiaoCount(Long[] ids);
	/**
	 * 交费信息显示
	 * @param ids
	 * @return
	 */
	List getJiaoFeiCount(Long[] ids);
}