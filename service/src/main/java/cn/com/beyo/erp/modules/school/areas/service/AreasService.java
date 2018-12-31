/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.areas.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.school.areas.dao.AreasDao;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;
import cn.com.beyo.erp.modules.school.areas.facade.AreasFacade;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.xml.ws.RespectBinding;
import java.util.List;

/**
 * 所属校区Service
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@Service("areasService")
public class AreasService extends BeyoService<AreasDao, Areas> implements AreasFacade {

    @Autowired
    private AreasDao areasDao;


    @Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public List<Areas> getAreasList() {
        return areasDao.getAreasList();
    }

}