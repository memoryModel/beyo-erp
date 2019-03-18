package cn.com.beyo.erp.thread.threadpool;

import cn.com.beyo.erp.commons.utils.threadpool.AbstractTreadBean;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.stereotype.Component;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;

@Component
public class ConfigurationFactoryBean implements FactoryBean<ExecutorService> {

    public ExecutorService businessExecutor() {
        return new AbstractTreadBean() {
            @Override
            public ThreadInitParam initParam() {
                return new ThreadInitParam("BusinessExecutor", false)
                        .setCorePoolNum(80).setMaxPoolNum(100)
                        .setKeepAliveTime(60000L)
                        .setWorkQueue(new ArrayBlockingQueue(800))
                        ;
            }
        }.buildPool();
    }


    @Override
    public ExecutorService getObject() throws Exception {
        return businessExecutor();
    }

    @Override
    public Class<?> getObjectType() {
        return ExecutorService.class;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }
}
