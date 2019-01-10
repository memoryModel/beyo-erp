/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examinestore.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.ExamStoreType;
import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.school.examineianswer.entity.ExamineAnswer;
import cn.com.beyo.erp.modules.school.examineianswer.facade.ExamineAnswerFacade;
import cn.com.beyo.erp.modules.school.examineitems.entity.ExamQuestion;
import cn.com.beyo.erp.modules.school.examineitems.facade.ExamQuestionFacade;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import cn.com.beyo.erp.modules.school.examinestore.facade.ExamineStoreFacade;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 单表生成Controller
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@Controller
@RequestMapping(value = "school/examineStore")
public class ExamineStoreController extends BaseController {


	@Resource
	private ExamineStoreFacade examineStoreFacade;

	@Resource
	private ExamQuestionFacade examQuestionFacade;

	@Resource
	private ExamineAnswerFacade examineAnswerFacade;



	@ModelAttribute
	public ExamineStore get(@RequestParam(required=false) Long id) {
		ExamineStore entity = null;

		entity = examineStoreFacade.get(id);

		if (entity == null){
			return new ExamineStore();
		}
		return entity;
	}

	@RequestMapping(value = "list")
	public String list(ExamineStore examineStore, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ExamineStore> page = examineStoreFacade.findPageList(examineStore,new RpcHttp(new Page<ExamineStore>(request, response)));
		model.addAttribute("page", page);
		return "modules/school/examinestore/examineStoreList";
	}


	@RequestMapping(value = "form")
	public String form(ExamineStore examineStore, Model model) {
		if (null==examineStore.getType())examineStore.setType(ExamStoreType.THEORY.getValue());

		ExamQuestion examQuestionQuery = new ExamQuestion();
		examQuestionQuery.setExamineStore(examineStore);
		examQuestionQuery.setStatus(Status.NORMAL.getValue());
		List<ExamQuestion> questionList = examQuestionFacade.findQuestionListByStore(examQuestionQuery);


		//List<Subject> subjectList = schoolSubjectService.findSubjectList();
		model.addAttribute("schoolExamineStore", examineStore);
		//model.addAttribute("subjectList", subjectList);
		model.addAttribute("questionList",questionList);
		return "modules/school/examinestore/examineStoreForm";
	}

	@RequestMapping(value = "save")
	public String save(ExamineStore examineStore, String examJson, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model,examineStore)){
			return form(examineStore,model);
		}

		if (null==examineStore.getStatus())examineStore.setStatus(Status.NORMAL.getValue());


		String result = examineStoreFacade.saveExamineStore(examineStore,examJson);
		if("success".equals(result)){
			addMessage(redirectAttributes, "保存题库成功");
		}

		return "redirect:/school/examineStore/list?repage";
	}

	@RequestMapping(value = "delete")
	public String delete(ExamineStore examineStore, RedirectAttributes redirectAttributes) {
		examineStore.setStatus(Status.DELETE.getValue());
		examineStoreFacade.delete(examineStore);
		addMessage(redirectAttributes, "删除题库管理成功");
		return "redirect:/school/examineStore/list?repage";
	}

	@RequestMapping(value = "selectItems")
	public String selectItems(ExamQuestion examQuestion, Model model, HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("examQuestion", examQuestion);
		return "modules/school/examineitems/examineItemsForm";
	}

	@RequestMapping("/queryAnswer")
	public ModelAndView queryAnswer(HttpServletRequest request, ExamineAnswer examineAnswer){

		List<ExamineAnswer> list =examineAnswerFacade.findList(examineAnswer);
		//要返回的页面
		return  new ModelAndView("modules/school/examinestore/examineStoreForm","list",list);
	}

	@RequestMapping(value = "examineStoreInfo")
	@ResponseBody
	public Map<String,Object> examineStoreInfo(ExamineStore examineStore){
		Map<String,Object> returnMap = new HashMap<>();

		if (null==examineStore || examineStore.getId() == null) {
			returnMap.put("status","error");
			return returnMap;
		}
		examineStore = examineStoreFacade.get(examineStore.getId());

		ExamQuestion examQuestionQuery = new ExamQuestion();
		examQuestionQuery.setExamineStore(examineStore);
		examQuestionQuery.setStatus(Status.NORMAL.getValue());
		List<ExamQuestion> questionList = examQuestionFacade.findQuestionListByStore(examQuestionQuery);
		int single = 0;
		int multi = 0;
		for(ExamQuestion examQuestion:questionList){
			if (examQuestion.getType() == 1){
				single++;
			}else if(examQuestion.getType() == 2 ){
				multi++;
			}
		}

		returnMap.put("examineStore",examineStore);
		returnMap.put("single",single);
		returnMap.put("multi",multi);
		returnMap.put("status","success");
		return returnMap;
	}

}