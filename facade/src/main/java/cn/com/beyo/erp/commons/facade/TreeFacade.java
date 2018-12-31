package cn.com.beyo.erp.commons.facade;

import cn.com.beyo.erp.commons.persistence.Page;

import java.util.List;

public interface TreeFacade<T> {


     T get(Long id);


     T get(T entity);


     List<T> findList(T entity);

     List<T> findAll();


     Page<T> findPage(Page<T> page, T entity);


     void save(T entity);


     void delete(T entity);
}
