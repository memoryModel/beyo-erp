/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.order.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.order.entity.OrderItem;

import java.util.List;

/**
 * 单表生成DAO接口
 * @author beyo.com.cn
 * @version 2017-06-01
 */
@MyBatisDao
public interface OrderDao extends BeyoDao<Order> {


    public Order findClassAmount(Order order);
    List<Order> findPageOrderStudent(Order order);

    public List<OrderItem> findOrderItemByOrder(OrderItem orderItem);
    public int insertOrderItem(OrderItem orderItem);
    public int updateOrderItem(OrderItem orderItem);
    public int updateOrderItemStatus(OrderItem orderItem);

    /**
     * 查询学生信息管理列表
     * @param order
     * @return
     */
    List<Order> findOrderStudent(Order order);
    public int updateOrderNum(Order order);
    public int updateOrderStatus(Order order);
    public Order findOrderById(Order order);
    public int insertOrderContract(OrderContract orderContract);
    int findContractCountByOrder(Order order);
    List<Order> findOrderByDispatch(Order order);

    List<OrderItem> findOrderItemInfoByOrder(OrderItem orderItem);
    /*全部订单*/
    List<Order> findAllOrderPage(Order order);
    /*全部订单*/
    Order getAllOrderById(Long id);
    /*客户管理*/
    List<Order> findListByCustomerId(Long id);

    OrderItem getOrderItemById(OrderItem orderItem);

    int updatePaymentAmountAndStatusById(Order order);

    int updateStatusById(Order order);

    int updateStatusByStudentId(Order order);

    List<Long> findIdListByStudentId(Order order);
}