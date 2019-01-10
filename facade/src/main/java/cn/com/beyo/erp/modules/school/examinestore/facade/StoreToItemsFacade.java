package cn.com.beyo.erp.modules.school.examinestore.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.examinestore.entity.StoreToItems;

public interface StoreToItemsFacade extends BeyoFacade<StoreToItems> {

    void deleteReal(StoreToItems storeToItems);
}
