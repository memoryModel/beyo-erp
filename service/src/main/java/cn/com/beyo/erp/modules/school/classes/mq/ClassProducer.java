package cn.com.beyo.erp.modules.school.classes.mq;

import org.apache.rocketmq.client.exception.MQBrokerException;
import org.apache.rocketmq.client.exception.MQClientException;
import org.apache.rocketmq.client.producer.DefaultMQProducer;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.common.message.Message;
import org.apache.rocketmq.remoting.exception.RemotingException;
import org.springframework.stereotype.Component;

@Component
public class ClassProducer {

    private DefaultMQProducer producer;

    private static final String NAMESERVER = "192.168.67.103:9876;192.168.67.104:9876";

    private static final String PRODUCER_GROUP_NAME = "class_producer_group_name";

    private ClassProducer(){
            producer = new DefaultMQProducer(PRODUCER_GROUP_NAME);
            producer.setNamesrvAddr(NAMESERVER);
            //设置重试的次数
            producer.setRetryTimesWhenSendFailed(10);
            //大于这个数值会mq会进行压缩
            producer.setCompressMsgBodyOverHowmuch(1024*1024*5);
            producer.setHeartbeatBrokerInterval(1000*15);
            producer.setMaxMessageSize(1024*1024*50);
            start();
    }

    private void start(){
        try {
            producer.start();
        } catch (MQClientException e) {
            e.printStackTrace();
        }
    }

    public void shutdown(){
        this.producer.shutdown();
    }

    public SendResult sendMessage(Message message){
        SendResult sendResult = null;
        try {
            try {
                sendResult = this.producer.send(message);
            } catch (RemotingException e) {
                e.printStackTrace();
            } catch (MQBrokerException e) {
                e.printStackTrace();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        } catch (MQClientException e) {
            e.printStackTrace();
        }
        return sendResult;
    }
}
