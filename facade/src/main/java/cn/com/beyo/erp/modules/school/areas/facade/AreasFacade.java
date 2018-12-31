package cn.com.beyo.erp.modules.school.areas.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;

import java.util.List;

public interface AreasFacade extends BeyoFacade<Areas> {

    List<Areas> getAreasList();

}
