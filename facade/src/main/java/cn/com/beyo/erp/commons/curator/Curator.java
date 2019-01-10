package cn.com.beyo.erp.commons.curator;

import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.locks.InterProcessLock;
import org.apache.curator.framework.recipes.locks.InterProcessMutex;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.springframework.stereotype.Component;

@Component
public class Curator {

    /** zookeeper地址 */
    private static final String CONNECT_ADDR = "192.168.1.171:2181,192.168.1.172:2181,192.168.1.173:2181";
    /** session超时时间 */
    private static final int SESSION_OUTTIME = 5000;//ms
    /**重试策略*/
    private static RetryPolicy retryPolicy;

    private CuratorFramework cf;

    public Curator(){
        //1 重试策略：初试时间为1s 重试10次
        retryPolicy = new ExponentialBackoffRetry(1000, 10);
        CuratorFramework cf = CuratorFrameworkFactory.builder()
                .connectString(CONNECT_ADDR)
                .sessionTimeoutMs(SESSION_OUTTIME)
                .retryPolicy(retryPolicy)
                .build();
        //3 开启连接
        cf.start();
    }

    public CuratorFramework getCuratorFramework(){
        return cf;
    }
}
