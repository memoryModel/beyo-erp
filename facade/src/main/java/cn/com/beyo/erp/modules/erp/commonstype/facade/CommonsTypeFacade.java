package cn.com.beyo.erp.modules.erp.commonstype.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;

import java.util.List;

public interface CommonsTypeFacade extends BeyoFacade<CommonsType> {

    List<CommonsType> findcomonsTypeList(CommonsType commonsType);
}
