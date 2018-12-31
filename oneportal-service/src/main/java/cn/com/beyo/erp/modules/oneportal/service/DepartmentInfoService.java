package cn.com.beyo.erp.modules.oneportal.service;

import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.oneportal.dao.DepartmentInfoDao;
import cn.com.beyo.erp.modules.oneportal.entity.DepartmentInfo;
import cn.com.beyo.erp.modules.oneportal.facade.DepartmentInfoFacade;
import org.springframework.stereotype.Service;

@Service(value = "departmentInfoService")
public class DepartmentInfoService extends BeyoService<DepartmentInfoDao, DepartmentInfo> implements DepartmentInfoFacade {
}
