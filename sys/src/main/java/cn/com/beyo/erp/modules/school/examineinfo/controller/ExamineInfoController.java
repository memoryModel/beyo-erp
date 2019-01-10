/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.facade.ClassStudentsFacade;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;
import cn.com.beyo.erp.modules.school.examineinfo.facade.ExamineInfoFacade;
import cn.com.beyo.erp.modules.school.examineinfo.facade.ExamineStudentsFacade;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examineitems.facade.ExamQuestionFacade;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.examinestore.facade.ExamineStoreFacade;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;
import cn.com.beyo.erp.modules.school.student.entity.Student;
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
import java.util.List;

/**
 * 考试管理Controller
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@Controller
@RequestMapping(value = "school/examineInfo")
public class ExamineInfoController extends BaseController {


	@Resource
	private ExamineInfoFacade examineInfoFacade;

	@Resource
	private ExamineStoreFacade examineStoreFacade;

	@Resource
	private ExamQuestionFacade examQuestionFacade;

	@Resource
	private ExamineStudentsFacade examineStudentsFacade;

	@Resource
	private ClassStudentsFacade classStudentsFacade;


	@ModelAttribute
	public ExamineInfo get(@RequestParam(required=false) Long id) {
		ExamineInfo entity = null;

		entity = examineInfoFacade.get(id);

		if (entity == null){
			return new ExamineInfo();
		}
		return entity;
	}

	@RequestMapping("list")
	public String list(ExamineInfo schoolExamineInfo, HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<ExamineInfo> page = examineInfoFacade.findPage(new Page<ExamineInfo>(request, response), schoolExamineInfo);
		//题库列表 用于下拉查询
		List<ExamineStore> storeList=examineStoreFacade.findStoreList();

		model.addAttribute("page", page);
		model.addAttribute("storeList", storeList);
		return "modules/school/examineinfo/examineInfoList";
	}

	@RequestMapping(value = "form")
	public String form(ExamineInfo schoolExamineInfo, Model model){
		if(null==schoolExamineInfo.getExamineStatus())schoolExamineInfo.setExamineStatus(ExamStatus.NORMAL.getValue());
		//下拉查询课程
		List<ExamineStore> storeList=examineStoreFacade.findStoreList();

		ExamineStudents examineStudents = new ExamineStudents();
		examineStudents.setStatus(Status.NORMAL.getValue());
		examineStudents.setExamineInfo(schoolExamineInfo);
		List<ExamineStudents> studentsList = examineStudentsFacade.findExamineInfoStudentByExamineInfo(examineStudents);

		//如果是实操考试，直接读取题库
		if (null!=schoolExamineInfo.getExamineType() && schoolExamineInfo.getExamineType() == ExamStoreType.ACTUAL.getValue()){

			ExamineStore examineStore =  examineStoreFacade.get(schoolExamineInfo.getSchoolExamineStore().getId());
			if (null!=examineStore && examineStore.getType() == ExamStoreType.ACTUAL.getValue()){

				ExamQuestion examQuestionQuery = new ExamQuestion();
				examQuestionQuery.setExamineStore(examineStore);
				examQuestionQuery.setStatus(Status.NORMAL.getValue());
				List<ExamQuestion> questionList = examQuestionFacade.findQuestionListByStore(examQuestionQuery);

				model.addAttribute("questionList", questionList);

			}


		}

		model.addAttribute("schoolExamineInfo", schoolExamineInfo);
		model.addAttribute("storeList", storeList);
		model.addAttribute("studentsList", studentsList);
		return "modules/school/examineinfo/examineInfoForm";

	}

	@RequestMapping(value = "selectStudent")
	public String selectStudent(Integer examineStatus,
								String classStudentJson,
								Model model,
								ClassStudents classStudents,
								HttpServletRequest request,
								HttpServletResponse response) {

		if (null==classStudents)classStudents = new ClassStudents();
		if (null==classStudents.getStudent())classStudents.setStudent(new Student());

		classStudents.getStudent().setStatus(StudentStatus.STUDY.getValue());

		classStudents.setExamStatus(examineStatus);

		Page<ClassStudents> page = classStudentsFacade.findPage(new Page<ClassStudents>(request, response), classStudents);
		model.addAttribute("page", page);
		model.addAttribute("classStudents", classStudents);


		model.addAttribute("classStudentJson",classStudentJson);
		return "modules/school/examineinfo/selectStudent";
	}



}