package cn.com.beyo.erp.commons.facade;

import cn.com.beyo.erp.commons.persistence.Page;



import java.util.List;

public interface BeyoFacade<T> {

    T get(Long id);

    T get(T entity);

    List<T> findList(T entity);

    Page<T> findPage(Page<T> page, T entity);

    void save(T entity);

    Long update(T entity);

    void delete(T entity);




}
