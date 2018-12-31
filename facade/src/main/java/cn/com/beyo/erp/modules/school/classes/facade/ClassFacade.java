package cn.com.beyo.erp.modules.school.classes.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;

public interface ClassFacade extends BeyoFacade<SchoolClass> {

    int updateClassRealNumById(SchoolClass schoolClass);
}
