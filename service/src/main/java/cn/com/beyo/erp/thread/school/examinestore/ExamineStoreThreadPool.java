package cn.com.beyo.erp.thread.school.examinestore;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.concurrent.*;

@Component
public class ExamineStoreThreadPool {

    /**
     * 日志对象
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    private ThreadPoolExecutor thradPool;

    public ExamineStoreThreadPool(){
        ArrayBlockingQueue arrayBlockingQueue = new ArrayBlockingQueue(20);
        this.thradPool =
                new ThreadPoolExecutor(5,
                        Runtime.getRuntime().availableProcessors(),
                        60,
                        TimeUnit.SECONDS,
                        arrayBlockingQueue,
                        new ThreadFactory() {
                            @Override
                            public Thread newThread(Runnable r) {
                                Thread t = new Thread(r);
                                t.setName("ExamineStore存入redis---Thread");
                                return t;
                            }
                        },
                        new RejectedExecutionHandler() {
                            @Override
                            public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
                                System.err.println("当前被拒绝任务为："+r.toString());
                                logger.error(r.toString());
                            }
                        });
    }


    public void execute(Runnable runnable){
        thradPool.execute(runnable);
    }

    public void shutdown(){
        thradPool.shutdown();
    }

}
