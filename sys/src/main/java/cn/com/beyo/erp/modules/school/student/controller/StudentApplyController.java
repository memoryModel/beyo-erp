/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.student.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.commons.utils.CodeUtil;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.order.facade.OrderFacade;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.erp.receivablebill.facade.ReceivableBillFacade;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;
import cn.com.beyo.erp.modules.school.areas.facade.AreasFacade;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.facade.ClassFacade;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.facade.ClassStudentsFacade;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormEmployeeLive;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormStudentLive;
import cn.com.beyo.erp.modules.school.dormlive.facade.DormEmployeeLiveFacade;
import cn.com.beyo.erp.modules.school.dormlive.facade.DormStudentLiveFacade;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.facade.StudentFacade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 学员报名Controller
 * @author beyo.com.cn
 * @version 2017-06-05
 */
@Controller
@RequestMapping(value = "erp/studentApply")
public class StudentApplyController extends BaseController {

	@Resource
	private AreasFacade areasFacade;

	@Resource
	private StudentFacade studentFacade;

	@Resource
	private ClassFacade classFacade;

	@Resource
	private ClassStudentsFacade classStudentsFacade;

	@Resource
	private OrderFacade orderFacade;

	@Resource
	private ReceivableBillFacade receivableBillFacade;

	@Resource
	private DormStudentLiveFacade dormStudentLiveFacade;

	@Resource
	private DormEmployeeLiveFacade dormEmployeeLiveFacade;




	@RequestMapping(value = "applyForm")
	public String applyForm(Student studentEnroll, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Areas> areasList = areasFacade.getAreasList();
		model.addAttribute("areasList",areasList);
		return "modules/erp/studentapply/studentApplyForm";
	}


	@RequestMapping(value = "form")
	public String form(Student student, Model model) {

		model.addAttribute("student", student);
		return "modules/erp/studentapply/studentApplyForm";
	}

	/**
	 * 学员
	 * @author Ashon
	 * @version 2017-07-25
	 */
	@RequestMapping(value = "save")
	public String save(Student student,
						Double prepaidAmount,
						Double tuitionAmount,
						Double miscellaneousAmount,
						Double tuitionFavorable,
						HttpServletRequest request,
						RedirectAttributes redirectAttributes) {

		//是否报班
		String classId = request.getParameter("classId");
		if(null==classId || classId.length()<=0){
			addMessage(redirectAttributes, "学员报名失败，未选择班级");
			return "redirect:/erp/studentApply/applyForm?repage";
		}

		Long payType = student.getSchoolClassStudents().getOrder().getPayType();
		String result = studentFacade.saveStudentApply(student,payType, prepaidAmount,tuitionAmount,
				miscellaneousAmount, tuitionFavorable, classId);
		if("success".equals(result)){
			addMessage(redirectAttributes, "学员报名成功");
		}
		return "redirect:/erp/studentApply/applyForm";
	}





	@RequestMapping(value = "save2")
	public String save2(Student student,
					   Double prepaidAmount,
					   Double tuitionAmount,
					   Double miscellaneousAmount,
					   Double tuitionFavorable,
					   HttpServletRequest request,
					   RedirectAttributes redirectAttributes) {

		//是否报班
		String[] classIdArray = request.getParameterValues("classId");
		if(null==classIdArray || classIdArray.length<=0){
			addMessage(redirectAttributes, "学员报名失败，未选择班级");
			return "redirect:/erp/studentApply/applyForm?repage";
		}

		Long payType = student.getSchoolClassStudents().getOrder().getPayType();
		/*String result = studentService.saveStudentApply(student,payType, prepaidAmount,tuitionAmount,
				 miscellaneousAmount, tuitionFavorable, classIdArray);*/

		//报班学员状态
		student.setStudentType(StudentTypeStatus.OFFICIAL.getValue());//学员类型 设置为 2.正式报名学员
		if(student.getStatus()!= StudentStatus.STUDY.getValue())student.setStatus(StudentStatus.UNREAD.getValue());//学员状态 设置为 0.未读

		if(null==student.getStudentNumber() || student.getStudentNumber().trim().equals("")){
			student.setStudentNumber(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_STUNUM));
		}

		studentFacade.save(student);


		//入住
		if(student.getDormitory().intValue() == 1 && (student.getEmployee() == null || null==student.getEmployee().getId())){//学员入住
			DormStudentLive dormStudentLive = new DormStudentLive();
			dormStudentLive.setErpStudentEnroll(student);
			dormStudentLive.setStatus(LiveStatus.NORMAL.getValue());//设置默认未入住
			dormStudentLive.setLiveTime(new Date()); //设置入住时间
			dormStudentLiveFacade.save(dormStudentLive);
		}else if(student.getDormitory().intValue() == 1 && (student.getEmployee() != null && null!=student.getEmployee().getId())){//员工入住
			DormEmployeeLive dormEmployeeLive = new DormEmployeeLive();
			dormEmployeeLive.setErpEmployee(student.getEmployee());
			dormEmployeeLive.setStatus(LiveStatus.NORMAL.getValue());//设置默认未入住
			dormEmployeeLive.setLiveTime(new Date()); //设置入住时间
			dormEmployeeLiveFacade.save(dormEmployeeLive);
		}


		//订单
		if(tuitionFavorable==null) tuitionFavorable = 0.00;
		if(miscellaneousAmount==null) miscellaneousAmount = 0.00;
		//(预定金包含在学费里 在学费中减去优惠剩下的是学费)
		Double orderAmount = tuitionAmount+miscellaneousAmount-tuitionFavorable;

		Order order = new Order();
		order.setStudent(student);
		order.setFavorableAmount(new BigDecimal(tuitionFavorable));//优惠金额
		order.setOverallAmount(new BigDecimal(orderAmount));//总金额
		//order.setPaymentAmount(new BigDecimal(orderAmount-tuitionFavorable));//支付金额
		order.setPaymentAmount(new BigDecimal(0.00));//支付金额 在报名时支付金额为0.00
		order.setOrderCode(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_ORDER));//订单编号
		order.setPayType(payType);//付款类型
		order.setNum(1);//设置订单数量默认为 1
		order.setOrderType(OrderType.TRAIN.getValue());//设置订单类型为  培训订单
		order.setPayStatus(PayStatus.CREATED.getValue());//设置为未支付状态
		order.setStatus(OrderStatus.CREATED.getValue());//已创建-代付款

		orderFacade.save(order);//新增订单


		//合同
		OrderContract orderContract = new OrderContract();
		orderContract.setOrder(order);//设置订单ID
		orderContract.setCode(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_CONTRACT));//合同编号
		orderContract.setStatus(Status.NORMAL.getValue());
		orderFacade.saveOrderContract(orderContract);


		//应收
		ReceivableBill receivableBill = new ReceivableBill();
		receivableBill.setFinancialCode(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_FINANCIAL));//财务编号
		receivableBill.setReceivableAmount(new BigDecimal(orderAmount));//应收金额
		receivableBill.setDeliveredAmount(new BigDecimal("0.00"));//已交费用
		receivableBill.setStatus(ReceivableBillStatus.UNCLEARED.getValue());//设置为未结清状态
		receivableBill.setOrder(order);
		receivableBillFacade.save(receivableBill);//新增应收账单

		//报班
		for(String classId:classIdArray){
			SchoolClass schoolClass = classFacade.get(Long.parseLong(classId));

			Integer classRealNum = schoolClass.getClassRealNum() + 1;
			schoolClass.setClassRealNum(classRealNum);
			classFacade.save(schoolClass);//更新报班人数

			ClassStudents classStudents = new ClassStudents();
			classStudents.setSchoolClass(schoolClass);
			classStudents.setStudent(student);
			classStudents.setOrder(order);//订单
			classStudents.setApplyTime(student.getApplyTime());//报名日期
			classStudents.setStatus(ClassStudentsStatus.READY.getValue());//设置该班级学生状态  4.报名未开班
			classStudentsFacade.save(classStudents);//新增班级学生
		}

		return "redirect:/erp/studentApply/applyForm";

	}


	/**
	 * 选择报读 学员
	 * @param student
	 * @param tagFlag 标记
	 * @param model
	 * @param request
	 * @param response
	 * @author Ashon
	 * @version 2017-07-25
	 */
	@RequestMapping(value = "studentTable")
	public String StudentTable(Student student, Integer tagFlag, Model model,  HttpServletRequest request, HttpServletResponse response) {
		Page<Student> page = studentFacade.findStudentListAndFollow(new Page<Student>(request, response), student);
		model.addAttribute("page", page);
		model.addAttribute("tagFlag", tagFlag);
		return "modules/erp/studentapply/studentTable";
	}



	/**
	 * 选择报读班级
	 * @param schoolClass
	 * @param classJson
	 * @param tagFlag 标签隐藏标记
	 * @author Ashon
	 * @version 2017-07-25
	 */
	@RequestMapping(value = "selectStudentApply")
	public String selectStudentApply(SchoolClass schoolClass, Long studentId, Long employeeId, String classJson, Integer tagFlag,
									 HttpServletRequest request, HttpServletResponse response, Model model) {
		schoolClass.setStatus(ClassPlanStatus.NOGRADUAT.getValue());//查询不是结业的
		Page<SchoolClass> page = classFacade.findPage(new Page<SchoolClass>(request, response), schoolClass);
		List<SchoolClass> classList = new ArrayList<>();
		List<ClassStudents> classStudentsList = null;
		List<Student> stuList = null;
		if(studentId != null && !studentId.equals("")){
			ClassStudents classStudents = new ClassStudents();
			classStudents.setStatus(ClassStudentsStatus.READY.getValue());//查询未开班已报名的
			classStudents.setStudent(new Student(studentId));
			classStudentsList = classStudentsFacade.findListByStu(classStudents);
		}

		if(employeeId != null && !employeeId.equals("")){
			Student studentEnroll = new Student();
			studentEnroll.setEmployee(new Employee(employeeId));
			stuList = studentFacade.findStudentClass(studentEnroll);
		}

		//查询当班级实际人数等于 最大人数的时候 过滤数据
		for (int i = 0; i < page.getList().size(); i++) {
			Integer classRealNum =page.getList().get(i).getClassRealNum();
			Integer classMaxNum = page.getList().get(i).getClassMaxNum();
			Long classId = page.getList().get(i).getId();
			if(classRealNum == classMaxNum)
				continue;
			//page.getList().remove(i);
			if(classStudentsList == null && stuList == null) continue;
			if(classStudentsList != null) {
				Integer count = 0;
				for (int j = 0; j < classStudentsList.size(); j++) {
					Long currentclassId = classStudentsList.get(j).getSchoolClass().getId();

					if (classId.equals(currentclassId)) count++;
					if(count > 0)
						break;
				}
				if(count == 0)
					classList.add(page.getList().get(i));

			}
			if(stuList != null) {
				Integer count = 0;
				for (int k = 0; k < stuList.size(); k++) {
					Long currentclassId = null;
					if(stuList.get(k).getSchoolClassStudents()!=null && stuList.get(k).getSchoolClassStudents().getSchoolClass()!=null)
						currentclassId = stuList.get(k).getSchoolClassStudents().getSchoolClass().getId();
					if (currentclassId !=null && currentclassId.equals(classId)) count++;
					if(count > 0)
						break;
				}
				if(count == 0)
					classList.add(page.getList().get(i));
			}

		}

		if(classList.size()>0 && classList != null){
			page.setList(classList);
		}
		model.addAttribute("page", page);
		model.addAttribute("classJson", classJson);
		model.addAttribute("studentId",studentId);
		model.addAttribute("employeeId",employeeId);
		model.addAttribute("tagFlag",tagFlag);
		return "modules/erp/studentapply/selectStudentApply";
	}

}