/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.student.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.facade.StudentFacade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 单表生成Controller
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@Controller
@RequestMapping(value = "school/student")
public class StudentController extends BaseController {

	@Resource
	private StudentFacade studentFacade;


	@ModelAttribute
	public Student get(@RequestParam(required=false) Long id) {
		Student entity = null;
		entity = studentFacade.get(id);

		if (entity == null){
			return new Student();
		}
		return entity;
	}


	@RequestMapping(value = "studentInfo")
	@ResponseBody
	public Map<String,Object> studentInfo(Student student){
		Map<String,Object> returnMap = new HashMap<>();

		if (null==student||null==student.getId()){
			returnMap.put("status","error");
			return returnMap;
		}
		returnMap.put("status","success");
		returnMap.put("student",student);

		return returnMap;
	}
}