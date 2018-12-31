/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.order.controller;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.status.OrderType;
import cn.com.beyo.erp.commons.web.BaseController;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.facade.OrderFacade;
import cn.com.beyo.erp.modules.erp.paymentbill.entity.PaymentBill;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
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

/**
 * 单表生成Controller
 * @author beyo.com.cn
 * @version 2017-06-01
 */
@Controller
@RequestMapping(value = "erp/studentOrder")
public class StudentOrderController extends BaseController {

	@Resource
	private OrderFacade orderFacade;

	@ModelAttribute
	public Order get(@RequestParam(required=false) Long id) {
		Order entity = null;

		entity = orderFacade.get(id);

		if (entity == null){
			return new Order();
		}
		return entity;
	}


	@RequestMapping("list")
	public String list(Order order, Integer status, HttpServletRequest request, HttpServletResponse response, Model model) {

		if(null==status)status = -1;

		order.setStatus(status);

		order.setOrderType(OrderType.TRAIN.getValue());
		Page<Order> page = orderFacade.findPage(new Page<Order>(request, response), order);
		model.addAttribute("page", page);
		return "modules/erp/order/studentOrderList";
	}

	@RequestMapping("view")
	public String view(Order order, Model model){
		model.addAttribute("readonly",true);
		return form(order,model);
	}

	/**
	 * 交费记录
	 * @param
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "paymentInfo")
		public String paymentInfo(ReceivableBill erpReceivableBill, Long orderId, Model model, HttpServletRequest request, HttpServletResponse response) {
		PaymentBill erpPaymentBill = new PaymentBill();
		ReceivableBill receivableBill = new ReceivableBill();
		receivableBill.setOrder(new Order(orderId));
		erpPaymentBill.setReceivableBill(receivableBill);
		//Page<PaymentBill> page = paymentBillService.findPayInfoList(new Page<PaymentBill>(request, response), erpPaymentBill);
		//model.addAttribute("page", page);
		return "modules/erp/order/paymentRecordList";
	}

	/**
	 * 退费详情
	 * @param id
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "refundHistory")
	public String infos(Long id, HttpServletRequest request, HttpServletResponse response, Model model) {
		Order order = new Order();
		if(id!=null){
			order = orderFacade.get(id);
		}
		model.addAttribute("erpOrder", order);
		return "modules/erp/order/returnAmountList";
	}

	@RequestMapping(value = "form")
	public String form(Order order, Model model) {
		order = orderFacade.findOrderById(order);
		model.addAttribute("erpOrder", order);
		return "modules/erp/order/studentOrderForm";
	}

	@RequestMapping(value = "save")
	public String save(Order order, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, order)){
			return form(order, model);
		}
		orderFacade.save(order);
		addMessage(redirectAttributes, "保存订单管理成功");
		return "redirect:/erp/studentOrder/list?repage";
	}

	@RequiresPermissions("erp:studentOrder:delete")
	@RequestMapping(value = "delete")
	public String delete(Order order, RedirectAttributes redirectAttributes) {
		orderFacade.delete(order);
		addMessage(redirectAttributes, "删除订单管理成功");
		return "redirect:/erp/studentOrder/list?repage";
	}

}
