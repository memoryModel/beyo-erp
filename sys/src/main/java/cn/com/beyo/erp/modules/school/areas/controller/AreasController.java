/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.areas.controller;

import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;
import cn.com.beyo.erp.modules.school.areas.facade.AreasFacade;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


/**
 * 所属校区Controller
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@Controller
@RequestMapping(value = "school/areas")
public class AreasController extends BaseController {

	@Resource
	private AreasFacade areasFacade;
	
	@RequestMapping(value = "/get/{id}")
	public String get(@PathVariable("id") String id, Model model){
		Areas areas = areasFacade.get(Long.parseLong(id));
		model.addAttribute("areas",areas);
		return "modules/school/areas/areasForm";
	}

	@RequestMapping(value = "applyForm")
	public String applyForm(Student studentEnroll, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Areas> areasList = areasFacade.getAreasList();
		model.addAttribute("areasList",areasList);
		return "modules/erp/studentapply/studentApplyForm";
	}

}