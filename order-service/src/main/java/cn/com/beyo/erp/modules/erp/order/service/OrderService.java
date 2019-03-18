/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.order.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.ContractSignStatus;
import cn.com.beyo.erp.modules.erp.order.dao.OrderDao;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.order.entity.OrderItem;
import cn.com.beyo.erp.modules.erp.order.facade.OrderFacade;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.erp.receivablebill.service.ReceivableBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.Date;
import java.util.List;

/**
 * 单表生成Service
 * @author beyo.com.cn
 * @version 2017-06-01
 */
@Service(value = "orderService")
public class OrderService extends BeyoService<OrderDao, Order> implements OrderFacade {

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private ReceivableBillService receivableBillService;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Order get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Order> findList(Order order) {
		return super.findList(order);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<Order> findPage(Page<Order> page, Order order) {
		order.setPage(page);
		page.setList(orderDao.findList(order));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(Order order) {
		System.out.println("-------------order的save()方法执行成功-------------");
		//super.save(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(Order order) {
		super.delete(order);
	}

	/*public List findAllList(ErpOrder erpOrder) {
		return dao.findAllList(erpOrder);
	}*/

	/**
	 * 根据orderId查询班级--应交费用信息
	 * @author Ashon
	 * @version 2017-06-29
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Order findClassAmount(Order order) {
		return dao.findClassAmount(order);
	}

	/**查询订单中的学生信息
	 *order
	 * @author
	 * @version 2017-07-21
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<Order> findPageOrderStudent(Page<Order> page, Order order) {
		order.setPage(page);
		page.setList(dao.findPageOrderStudent(order));
		return page;
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<OrderItem> findOrderItemByOrder(OrderItem orderItem){
		return orderDao.findOrderItemByOrder(orderItem);
	}
	public int saveOrderItem(OrderItem orderItem){
		try{
			orderItem.nextId();
		}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
		}
		orderItem.setCreateTime(new Date());
		return orderDao.insertOrderItem(orderItem);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateOrderItem(OrderItem orderItem){
		return orderDao.updateOrderItem(orderItem);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateOrderItemStatus(OrderItem orderItem){
		return orderDao.updateOrderItemStatus(orderItem);
	}





	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateOrderNum(Order order){
		return dao.updateOrderNum(order);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Order findOrderById(Order order){
		return dao.findOrderById(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateOrderStatus(Order order){
		return dao.updateOrderStatus(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int saveOrderContract(OrderContract orderContract){
		/*try{
			orderContract.nextId();
		}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
		}
		orderContract.setCreateTime(new Date());
		return orderDao.insertOrderContract(orderContract);*/
		System.out.println("------------order的saveOrderContract()方法执行成功---------");
		return 1;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int findContractCountByOrder(Order order){
		return orderDao.findContractCountByOrder(order);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<Order> findOrderByDispatch(Page<Order> page, Order order){
		order.setPage(page);
		page.setList(orderDao.findOrderByDispatch(order));
		return page;

	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<OrderItem> findOrderItemInfoByOrder(OrderItem orderItem){
		return orderDao.findOrderItemInfoByOrder(orderItem);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<Order> findAllOrderPage(Page<Order> page, Order order) {
		order.setPage(page);
		page.setList(orderDao.findAllOrderPage(order));
		return page;

	};

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Order getAllOrderById(Long id) {
		return orderDao.getAllOrderById(id);

	}

	/**
	 * 根据orderItemId查询 单条订单详情(正常状态)
	 * @param orderItem
	 * @author Ashon
	 * @version 2017-09-06
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public OrderItem getOrderItemById(OrderItem orderItem) {
		return orderDao.getOrderItemById(orderItem);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Order> findListByCustomerId(Long id) {
		return orderDao.findListByCustomerId(id);
	}


	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public String contractSave(OrderContract contract){
		try{
			Order order = this.findOrderById(contract.getOrder());
			if (null==order){

				return null;
			}

			//根据订单id查询合同记录是否存在
			int count = this.findContractCountByOrder(order);
			if (count > 0){
				return "error";
			}

			this.saveOrderContract(contract);

			order.setContract(contract);
			order.setSignStatus(ContractSignStatus.SIGNED.getValue());
			this.update(order);
			return "success";
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return "fail";
		}
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updatePaymentAmountAndStatusById(Order order){
		return orderDao.updatePaymentAmountAndStatusById(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateStatusById(Order order){
		return orderDao.updateStatusById(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public int updateStatusByStudentId(Order order){
		return orderDao.updateStatusByStudentId(order);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Long> findIdListByStudentId(Order order){
		return orderDao.findIdListByStudentId(order);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public String contractSave(OrderContract contract, Order order){
		try{
			this.saveOrderContract(contract);

			order.setContract(contract);
			order.setSignStatus(ContractSignStatus.SIGNED.getValue());
			this.update(order);
			return "success";
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			logger.error(e.getMessage());
			return "fail";
		}
	}
	//新增订单，订单合同，应收账单
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public String saveOrder(Order order,OrderContract orderContract,ReceivableBill receivableBill){
		try{
			this.save(order);//新增订单
			this.saveOrderContract(orderContract);//新增合同
			receivableBillService.save(receivableBill);//新增应收账单
		}catch (Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			//新增订单，订单合同，应收账单是MQ的分布式事务的处理的操作，在进行数据库操作出现异常的话要加入日志
			//以便于和MQ的异常信息结合查询
			return "fail";
		}
		return "success";
	}
}