package cn.com.beyo.erp.modules.sys.service;

import cn.com.beyo.erp.commons.service.CrudService;
import cn.com.beyo.erp.commons.service.TreeService;
import cn.com.beyo.erp.modules.sys.dao.MenuDao;
import cn.com.beyo.erp.modules.sys.entity.Menu;
import cn.com.beyo.erp.modules.sys.facade.MenuFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service(value = "menuService")
public class MenuService extends CrudService<MenuDao, Menu> implements MenuFacade{

    @Autowired
    private MenuDao menuDao;

    @Override
    public List<Menu> findByParentIdsLike(Menu menu) {
        return null;
    }

    @Override
    public List<Menu> findByUserId(Menu menu) {
        return null;
    }

    @Override
    public int updateParentIds(Menu menu) {
        return 0;
    }

    @Override
    public int updateSort(Menu menu) {
        return 0;
    }

    @Override
    public int updateIsShow(Menu menu) {
        return 0;
    }

    @Override
    public List<Menu> findAllList(Menu menu) {
        return menuDao.findAllList(menu);
    }
}
