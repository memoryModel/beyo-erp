package cn.com.beyo.erp.modules.sys.utils;

import cn.com.beyo.erp.modules.sys.entity.Menu;
import cn.com.beyo.erp.modules.sys.facade.MenuFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

@Component
public class Util {

    @Resource
    private MenuFacade menuFacade;

    private static Util myUtil;

    @PostConstruct
    public void init(){
        myUtil = this;
        myUtil.menuFacade = this.menuFacade;

    }

    /**
     * 菜单
     * */
    public static List<Menu> getMenuList(){
        return myUtil.menuFacade.findAllList(new Menu());
    }
}
