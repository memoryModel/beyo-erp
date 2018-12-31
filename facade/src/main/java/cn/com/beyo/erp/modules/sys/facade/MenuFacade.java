package cn.com.beyo.erp.modules.sys.facade;

import cn.com.beyo.erp.modules.sys.entity.Menu;

import java.util.List;

public interface MenuFacade {

    List<Menu> findByParentIdsLike(Menu menu);

     List<Menu> findByUserId(Menu menu);

     int updateParentIds(Menu menu);

     int updateSort(Menu menu);

     int updateIsShow(Menu menu);

    List<Menu> findAllList(Menu menu);

    Menu get(Long id);
}
