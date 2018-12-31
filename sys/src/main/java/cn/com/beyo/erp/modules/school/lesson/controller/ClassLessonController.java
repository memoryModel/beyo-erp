/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.lesson.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.lesson.facade.LessonFacade;
import cn.com.beyo.erp.modules.school.subject.entity.Subject;
import cn.com.beyo.erp.modules.sys.entity.User;
import cn.com.beyo.erp.modules.sys.facade.SystemFacade;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 课程管理Controller
 * @author Ashon
 * @version 2017-06-01
 */
@Controller
@RequestMapping(value = "school/lesson")
public class ClassLessonController extends BaseController {

	@Resource
	private LessonFacade lessonFacade;

	@Resource
	private SystemFacade systemFacade;


	@ModelAttribute
	public ClassLesson get(@RequestParam(required=false) Long id) {
		ClassLesson entity = null;

		entity = lessonFacade.get(id);

		if (entity == null){
			return new ClassLesson();
		}
		return entity;
	}


	@RequestMapping(value = "list")
	public String list(ClassLesson schoolClassLesson, HttpServletRequest request, HttpServletResponse response, Model model) {
		//查询科目列表绑定下拉框
		schoolClassLesson.setStatus(Status.NORMAL.getValue());
		/*List<LessonType> lessonTypeList = lessonTypeService.findLessonTypeList();
		List<Subject> subjectList = schoolSubjectService.findSubjectList();*/
		Page<ClassLesson> page = lessonFacade.selectListAll(schoolClassLesson,new RpcHttp(new Page<ClassLesson>(request, response)));

		model.addAttribute("page", page);
		model.addAttribute("classLesson", schoolClassLesson);
		return "modules/school/lesson/classLessonList";
	}

	@RequestMapping(value = "form")
	public String form(ClassLesson schoolClassLesson, Model model){
		model.addAttribute("schoolClassLesson", schoolClassLesson);
		return "modules/school/lesson/classLessonForm";
	}



	@RequestMapping(value = "save")
	public String save(ClassLesson schoolClassLesson, Model model, RedirectAttributes redirectAttributes) {

		if(schoolClassLesson.getId()==null) {
			schoolClassLesson.setStatus(Status.NORMAL.getValue());
			lessonFacade.saveClassLesson(schoolClassLesson);
		}else{
			lessonFacade.updateClassLesson(schoolClassLesson);
		}

		addMessage(redirectAttributes, "保存课程成功");
		return "redirect:/school/lesson/list";
	}

	@RequestMapping(value = "delete")
	public String delete(ClassLesson schoolClassLesson, RedirectAttributes redirectAttributes){
		schoolClassLesson.setStatus(Status.DELETE.getValue());
		lessonFacade.deleteClassLesson(schoolClassLesson);
        addMessage(redirectAttributes, "删除课程成功");
        return "redirect:/school/lesson/list?repage";
	}

	/**
	 * @param id
	 * @param request
	 * @param response
	 * @param model
	 * @return 跳转到课程详情页面
	 */
	@RequestMapping(value = "info")
	public String info(Long id, HttpServletRequest request, HttpServletResponse response, Model model) {
		ClassLesson lesson = new ClassLesson();

		if(id!=null){
			lesson = lessonFacade.getClassLesson(id);
			/*Page<ClassLesson> lessonPage = schoolClassLessonService.findClassLessonList(new Page<ClassLesson>(request, response), lesson);
			for (ClassLesson Lesson : lessonPage.getList() ) {
				for (int i = 0; i <Lesson.getTeacherIdsList().size() ; i++) {
					User teacher = systemService.getUser(Lesson.getTeacherIdsList().get(i));
					if(i==0) {
						Lesson.setTeacherNames(teacher.getName());
					}else {
						Lesson.setTeacherNames(Lesson.getTeacherNames()+","+teacher.getName());
					}
					String teachNames = Lesson.getTeacherNames();
					lesson.setTeacherNames(teachNames);
				}
			}*/
		}
		model.addAttribute("schoolClassLesson", lesson);
		return "modules/school/lesson/classLessonInfo";
	}

	@RequestMapping(value = {"findTeacher"})
	public String findTeacher(Long id,User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*ClassLessonPlans schoolClassLessonPlans = new ClassLessonPlans();
		if(id!=null){//原有设置教师
			schoolClassLessonPlans.setSchoolClassLesson(new ClassLesson(id));
			schoolClassLessonPlansService.findList(schoolClassLessonPlans);
		}*/

		user.setDelFlag("0");//0：正常
		Page<User> page = systemFacade.findUser(new Page<User>(request, response), user);
		model.addAttribute("page", page);

		return "modules/school/lesson/teacherList";
	}

}