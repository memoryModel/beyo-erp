package cn.com.beyo.erp.modules.oneportal.service;

import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.oneportal.dao.UserInfoDao;
import cn.com.beyo.erp.modules.oneportal.entity.UserInfo;
import cn.com.beyo.erp.modules.oneportal.facade.UserInfoFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service(value = "userInfoService")
public class UserInfoService extends BeyoService<UserInfoDao, UserInfo> implements UserInfoFacade {


    @Autowired
    private UserInfoDao userInfoDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public List<UserInfo> findSignDetail(String[] employeNoArray) {
        return userInfoDao.findSignDetail(employeNoArray);
    }
}
