/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.controller;

import cn.com.beyo.erp.commons.utils.StringUtils;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.facade.AreaFacade;
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
 * 区域Controller
 * @author beyo.com.cn
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "/sys/area")
public class AreaController extends BaseController {

	@Resource
	private AreaFacade areaFacade;

	@ModelAttribute("area")
	public Area get(@RequestParam(required=false) Long id) {
		if (null!=id){
			return areaFacade.get(id);
		}else{
			return new Area();
		}
	}


	@RequestMapping(value = "list")
	public String list(Area area, Model model) {
		model.addAttribute("list", areaFacade.findAll());
		return "modules/sys/areaList";
	}


	/*@RequestMapping(value = "form")
	public String form(Area area, Model model) {
		if (area.getParent()==null || area.getParent().getId()==null){
			area.setParent(UserUtils.getUser().getOffice().getArea());
		}
		area.setParent(areaFacade.get(area.getParent().getId()));

		model.addAttribute("area", area);
		return "modules/sys/areaForm";
	}*/


	/*@RequestMapping(value = "save")
	public String save(Area area, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, area)){
			return form(area, model);
		}
		area.setPlatformId(UserUtils.getUser().getPlatformId());
		areaFacade.save(area);
		addMessage(redirectAttributes, "保存区域'" + area.getName() + "'成功");
		return "redirect:"  + "/sys/area/list";
	}*/





	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaFacade.findAll();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", String.valueOf(e.getId()));
				map.put("pId", String.valueOf(e.getParentId()));
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}
