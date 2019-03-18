package cn.com.beyo.erp.modules.school.student.mq;

import org.apache.rocketmq.client.exception.MQClientException;
import org.apache.rocketmq.client.producer.TransactionMQProducer;
import org.apache.rocketmq.client.producer.TransactionSendResult;
import org.apache.rocketmq.common.message.Message;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.concurrent.*;

@Component
public class TransactionProducer implements InitializingBean {

    private TransactionMQProducer producer;

    private ExecutorService executorService;

    @Autowired
    private TransactionListenerImpl transactionListenerImpl;

    //private static final String NAMESERVER = "192.168.67.103:9876;192.168.67.104:9876";
    private static final String NAMESERVER = "192.168.67.103:9876;192.168.67.104:9876";


    private static final String PRODUCER_GROUP_NAME = "tx_pay_producer_group_name";


    private TransactionProducer(){
        this.producer = new TransactionMQProducer(PRODUCER_GROUP_NAME);
        this.executorService = new ThreadPoolExecutor(2,
                5, 100, TimeUnit.SECONDS,
                new ArrayBlockingQueue<Runnable>(200),
                new ThreadFactory() {
                    @Override
                    public Thread newThread(Runnable r) {
                        Thread thread = new Thread(r);
                        thread.setName(PRODUCER_GROUP_NAME + "-check-thread");
                        return thread;
                    }
                });
        //设置重试次数
        this.producer.setRetryTimesWhenSendFailed(3);
        this.producer.setExecutorService(executorService);
        this.producer.setNamesrvAddr(NAMESERVER);
    }


    @Override
    public void afterPropertiesSet() throws Exception {
        this.producer.setTransactionListener(transactionListenerImpl);
        start();
    }

    private void start(){
        try {
            this.producer.start();
        } catch (MQClientException e) {
            e.printStackTrace();
        }
    }

    public void shutdown(){
        this.producer.shutdown();
    }

    public TransactionSendResult sendMessage(Message message,Object argument){
        TransactionSendResult transactionSendResult = null;
        try {
            transactionSendResult = this.producer.sendMessageInTransaction(message, argument);

        } catch (MQClientException e) {
            e.printStackTrace();
        }
        return transactionSendResult;
    }

}
