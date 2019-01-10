package cn.com.beyo.erp.modules.school.classes.mq;

import libs.fastjson.com.alibaba.fastjson.JSON;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerConcurrently;
import org.apache.rocketmq.client.exception.MQClientException;
import org.apache.rocketmq.common.consumer.ConsumeFromWhere;
import org.apache.rocketmq.common.message.MessageExt;

import java.util.List;
import java.util.Map;

public class ClassConsumer {

    private DefaultMQPushConsumer consumer;

    private static final String NAMESERVER = "192.168.67.103:9876;192.168.67.104:9876";

    private static final String CONSUMER_GROUP_NAME = "class_consumer_group_name";

    public static final String CLASS_TOPIC = "class_topic";

    public static final String CLASS_TAGS = "class";


    private ClassConsumer() {
        try {
            this.consumer = new DefaultMQPushConsumer(CONSUMER_GROUP_NAME);
            this.consumer.setConsumeThreadMin(10);
            this.consumer.setConsumeThreadMax(30);
            this.consumer.setNamesrvAddr(NAMESERVER);
            this.consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_LAST_OFFSET);
            this.consumer.subscribe(CLASS_TOPIC, CLASS_TAGS);
            this.consumer.registerMessageListener(new MessageListenerConcurrentlyImpl());
            this.consumer.start();
        } catch (MQClientException e) {
            e.printStackTrace();
        }
    }


    class MessageListenerConcurrentlyImpl implements MessageListenerConcurrently{

        @Override
        public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> list, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
            MessageExt messageExt = list.get(0);
            try{
                Map<String,Object> params = JSON.parseObject(new String(messageExt.getBody()),Map.class);
                String className = (String)params.get("className");
                Long classId = (Long)params.get("classId");
                String content = "班级:" + className + "已经开班，请尽快安排排课";

                //用websocket进行站内信的通知

                return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;

            }catch (Exception e){
                e.printStackTrace();
                return ConsumeConcurrentlyStatus.RECONSUME_LATER;
            }
        }
    }

}
