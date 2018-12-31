package cn.com.beyo.erp.modules.oneportal.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.oneportal.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface UserInfoDao extends BeyoDao<UserInfo> {

    List<UserInfo> findSignDetail(@Param("employeNoArray")String[] employeNoArray);
}
