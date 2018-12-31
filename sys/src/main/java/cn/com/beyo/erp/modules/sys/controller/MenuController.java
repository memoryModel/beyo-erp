/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.controller;

import cn.com.beyo.erp.commons.utils.StringUtils;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.sys.entity.Menu;
import cn.com.beyo.erp.modules.sys.facade.MenuFacade;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 菜单Controller
 * @author beyo.com.cn
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "/sys/menu")
public class MenuController extends BaseController {


	@Resource
	private MenuFacade menuFacade;

	@ModelAttribute("menu")
	public Menu get(@RequestParam(required=false) Long id) {
		if (null!=id){
			return menuFacade.get(id);
		}else{
			return new Menu();
		}
	}



	@RequestMapping(value = "tree")
	public String tree() {
		return "modules/sys/menuTree";
	}

}
