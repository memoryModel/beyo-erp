package cn.com.beyo.erp.modules.erp.order.mq;

import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.commons.utils.CodeUtil;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.order.service.OrderService;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import libs.fastjson.com.alibaba.fastjson.JSON;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerConcurrently;
import org.apache.rocketmq.client.exception.MQClientException;
import org.apache.rocketmq.common.consumer.ConsumeFromWhere;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

@Component
public class PayConsumer{

    private DefaultMQPushConsumer consumer;

    private static final String NAMESERVER = "192.168.67.103:9876;192.168.67.104:9876";

    private static final String CONSUMER_GROUP_NAME = "tx_pay_consumer_group_name";

    public static final String TX_PAY_TOPIC = "tx_pay_topic";

    public static final String TX_PAY_TAGS = "pay";

    @Autowired
    private OrderService orderService;

    @Autowired
    private Redis redis;



    private PayConsumer() {
        try {
            this.consumer = new DefaultMQPushConsumer(CONSUMER_GROUP_NAME);
            this.consumer.setConsumeThreadMin(10);
            this.consumer.setConsumeThreadMax(30);
            this.consumer.setNamesrvAddr(NAMESERVER);
            this.consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_LAST_OFFSET);
            this.consumer.subscribe(TX_PAY_TOPIC, TX_PAY_TAGS);
            this.consumer.registerMessageListener(new MessageListenerConcurrentlyImpl());
            this.consumer.start();
        } catch (MQClientException e) {
            e.printStackTrace();
        }
    }


    class MessageListenerConcurrentlyImpl implements MessageListenerConcurrently {


        @Override
        public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> list, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
            MessageExt msg = list.get(0);
            Map<String,Object> params = JSON.parseObject(new String(msg.getBody()),Map.class);
            try{
                String topic = msg.getTopic();
                String tags = msg.getTags();
                String keys = msg.getKeys();

                System.err.println("收到事务消息, topic: " + topic + ", tags: " + tags + ", keys: " + keys + ", map: " + params);

                Long studentId = (Long)params.get("studentId");
                Long payType = (Long)params.get("payType");
                Long orderId = (Long)params.get("orderId");
                Long schoolClassId = (Long)params.get("schoolClassId");

                //通过设置redis的schoolClassId和orderId实现MQ消息接收方的幂等性
                Long count = redis.incrMQ(RedisKey.MQ + schoolClassId + orderId,3000L);
                if (count > 1) {
                    return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
                }

                Double tuitionAmount = 0.00;
                if(params.get("tuitionAmount") != null){
                    tuitionAmount = Double.valueOf(String.valueOf(params.get("tuitionAmount")));
                }
                Double miscellaneousAmount = 0.00;
                if(params.get("miscellaneousAmount") != null){
                    miscellaneousAmount = Double.valueOf(String.valueOf(params.get("miscellaneousAmount")));
                }
                Double tuitionFavorable = 0.00;
                if(params.get("tuitionFavorable") != null){
                    tuitionFavorable = Double.valueOf(String.valueOf(params.get("tuitionFavorable")));
                }

                //(预定金包含在学费里 在学费中减去优惠剩下的是学费)
                Double orderAmount = tuitionAmount+miscellaneousAmount-tuitionFavorable;

                Order order = new Order();
                order.setId(orderId);
                order.setStudent(new Student(studentId));
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

                //合同
                OrderContract orderContract = new OrderContract();
                orderContract.setOrder(order);//设置订单ID
                orderContract.setCode(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_CONTRACT));//合同编号
                orderContract.setStatus(Status.NORMAL.getValue());


                //应收
                ReceivableBill receivableBill = new ReceivableBill();
                receivableBill.setFinancialCode(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_FINANCIAL));//财务编号
                receivableBill.setReceivableAmount(new BigDecimal(orderAmount));//应收金额
                receivableBill.setDeliveredAmount(new BigDecimal("0.00"));//已交费用
                receivableBill.setStatus(ReceivableBillStatus.UNCLEARED.getValue());//设置为未结清状态
                receivableBill.setOrder(order);

                String result = orderService.saveOrder(order,orderContract,receivableBill);
                if("fail".equals(result)){
                    //加日志
                    if(msg.getReconsumeTimes() == 2){//如果又重试了2次还不行就直接返回成功，这条信息加日志
                        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
                    }
                    return ConsumeConcurrentlyStatus.RECONSUME_LATER;
                }
                return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
            }catch (Exception e){
                e.printStackTrace();
                if(msg.getReconsumeTimes() == 2){//如果又重试了2次还不行就直接返回成功，这条信息加日志
                    return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
                }
                return ConsumeConcurrentlyStatus.RECONSUME_LATER;
            }
        }

    }



}
