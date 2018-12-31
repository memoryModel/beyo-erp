package cn.com.beyo.erp.modules.sys.facade;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.modules.sys.entity.User;

public interface SystemFacade {
    Page<User> findUser(Page<User> page, User user);
}
