package cn.com.beyo.erp.modules.erp.order.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import org.aspectj.weaver.ast.Or;

public interface OrderFacade extends BeyoFacade<Order> {

    int saveOrderContract(OrderContract orderContract);

    Order findOrderById(Order order);
}
