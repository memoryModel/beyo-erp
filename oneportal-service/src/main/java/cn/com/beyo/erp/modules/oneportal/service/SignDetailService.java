package cn.com.beyo.erp.modules.oneportal.service;

import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.oneportal.dao.SignDetailDao;
import cn.com.beyo.erp.modules.oneportal.entity.SignDetail;
import cn.com.beyo.erp.modules.oneportal.facade.SignDetailFacade;
import org.springframework.stereotype.Service;

@Service(value = "signDetailService")
public class SignDetailService extends BeyoService<SignDetailDao, SignDetail> implements SignDetailFacade {
}
