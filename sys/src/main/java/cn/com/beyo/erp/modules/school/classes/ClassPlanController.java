/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.ClassPlanStatus;
import cn.com.beyo.erp.commons.status.ClassStudentsStatus;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.classes.entity.ClassToLesson;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.facade.ClassFacade;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.facade.StudentFacade;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 开班计划Controller
 * @author Ashon
 * @version 2017-06-05
 */
@Controller
@RequestMapping(value = "school/classPlan")
public class ClassPlanController extends BaseController {


	@Resource
	private ClassFacade classFacade;

	@Resource
	private StudentFacade studentFacade;


	@ModelAttribute
	/*public SchoolClass get(@RequestParam(required=false) Long id, @RequestParam(required=false) Long lessonId) {
		SchoolClass entity = null;
		if(lessonId !=null) {
			entity = new SchoolClass(id);
			entity.setSchoolClassToLesson(new ClassToLesson(new ClassLesson(lessonId)));
			entity = schoolClassPlanService.getById(entity);
		}else if(lessonId == null && id != null) {
			entity = schoolClassPlanService.get(id);
		}
		if (entity == null){
			return new SchoolClass();
		}
		return entity;
	}*/

	/**
	 * @param aClass
	 * @param request
	 * @param response
	 * @param model
	 * @return 跳转开班计划信息列表页面
	 */
	@RequestMapping(value = "list")
	public String list(SchoolClass aClass, HttpServletRequest request, HttpServletResponse response, Model model) {
		aClass.setStatus(ClassPlanStatus.READYCREAT.getValue());
		Page<SchoolClass> page = classFacade.findPage(new Page<SchoolClass>(request, response), aClass);

		model.addAttribute("page", page);
		model.addAttribute("schoolClass", aClass);
		return "modules/school/classPlan/classPlanList";
	}

	@RequestMapping(value = "updateStatus")
	public String updateStatus(SchoolClass aClass, RedirectAttributes redirectAttributes) {
		//  5.未开班状态状态--开班操作-----进行排课处理   0.新开班状态
		if (null == aClass.getStatus() && aClass.getStatus().intValue() != ClassPlanStatus.READYCREAT.getValue()){
			addMessage(redirectAttributes, "开班失败");
			return "redirect:/school/classPlan/list?repage";
		}
		String result = studentFacade.updateStatus(aClass);
		if("success".equals(result)){
			addMessage(redirectAttributes, "开班成功,请对该班级排课！");
		}

		return "redirect:/school/classPlan/list?repage";
	}
}