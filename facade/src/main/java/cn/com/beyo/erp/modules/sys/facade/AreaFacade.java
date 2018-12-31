package cn.com.beyo.erp.modules.sys.facade;


import cn.com.beyo.erp.commons.facade.TreeFacade;
import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.modules.sys.entity.Area;

import java.util.List;

public interface AreaFacade /*extends TreeFacade<Area>*/
{
    Area get(Long id);


    Area get(Area area);


    List<Area> findList(Area area);


    Page<Area> findPage(Page<Area> page, Area area);


    void save(Area area);


    void delete(Area area);

    List<Area> findAllList(Area area);

    List<Area> findAll();
}
