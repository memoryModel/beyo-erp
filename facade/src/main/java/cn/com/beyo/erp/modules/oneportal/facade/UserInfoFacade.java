package cn.com.beyo.erp.modules.oneportal.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.oneportal.entity.UserInfo;

import java.util.List;

public interface UserInfoFacade extends BeyoFacade<UserInfo> {

    List<UserInfo> findSignDetail(String[] employeNoArray);
}
