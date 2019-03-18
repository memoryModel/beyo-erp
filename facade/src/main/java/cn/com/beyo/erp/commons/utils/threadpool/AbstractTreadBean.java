package cn.com.beyo.erp.commons.utils.threadpool;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

//@Slf4j
public abstract class AbstractTreadBean {


    /**
     * 构建初始化参数
     * @return
     */
    public abstract ThreadInitParam initParam();


    /**
     * 构造线程池
     *
     * @return
     */
    public ExecutorService buildPool() {
        ThreadInitParam threadInitParam = initParam();
        ExecutorService executorService =
                new ThreadPoolExecutor(threadInitParam.getCorePoolNum(),
                        threadInitParam.getMaxPoolNum(),
                        threadInitParam.getKeepAliveTime(),
                        threadInitParam.getTimeUnit(),
                        threadInitParam.getWorkQueue(),
                        threadInitParam.getThreadFactory(),
                        threadInitParam.rejectedExecutionHandler) {


                    @Override
                    protected void beforeExecute(Thread t, Runnable r) {
                        super.beforeExecute(t, r);
                    }

                    @Override
                    protected void afterExecute(Runnable r, Throwable t) {
                        super.afterExecute(r, t);
                    }

                    @Override
                    protected void terminated() {
                        //log.info("thread pool is close , thread prefix is {}",threadInitParam.getThreadName());
                        super.terminated();
                    }

                    @Override
                    public void execute(Runnable command) {
                        Runnable wrap = wrap(command, clientTrace(), Thread.currentThread().getName());
                        super.execute(wrap);
                    }

                    @Override
                    public Future<?> submit(Runnable task) {
                        Runnable wrap = wrap(task, clientTrace(), Thread.currentThread().getName());
                        return super.submit(wrap);
                    }


                    @Override
                    public <T> Future<T> submit(Callable<T> task) {
                        Callable<T> wrap = wrap(task, clientTrace(), Thread.currentThread().getName());
                        return super.submit(wrap);
                    }

                    private Runnable wrap(final Runnable task, final Exception clientStack,
                                          String clientThreadName) {
                        return new Runnable() {
                            @Override
                            public void run() {
                                try {
                                    task.run();
                                } catch (Exception e) {
                                    clientStack.printStackTrace();
                                }
                            }
                        };
                    }

                    private <T> Callable<T> wrap(final Callable<T> task, final Exception clientStack,
                                                 String clientThreadName) {
                        return new Callable<T>() {

                            @Override
                            public T call() throws Exception {
                                try {
                                    return task.call();
                                } catch (Exception e) {
                                    clientStack.printStackTrace();
                                }
                                return null;
                            }
                        };
                    }

                    private Exception clientTrace() {
                        return new Exception("tread task root stack trace");
                    }


                };
//        return MoreExecutors.listeningDecorator(executorService);
        return executorService;
    }


    public class ThreadInitParam {

        private Integer corePoolNum = 20;
        private Integer maxPoolNum = 50;
        private Long keepAliveTime = 0L;
        private TimeUnit timeUnit = TimeUnit.MILLISECONDS;
        private BlockingQueue workQueue = new LinkedBlockingDeque(50);
        private RejectedExecutionHandler rejectedExecutionHandler = new ThreadPoolExecutor.AbortPolicy();
        private ThreadFactory threadFactory;
        private String threadName;


        public ThreadInitParam(String threadName, boolean isDaemon) {
            this.threadFactory = new InitThreadFactory(threadName, isDaemon);
            this.threadName = threadName;
        }

        public String getThreadName() {
            return threadName;
        }

        public ThreadInitParam setCorePoolNum(Integer corePoolNum) {
            this.corePoolNum = corePoolNum;
            return this;
        }

        public ThreadInitParam setMaxPoolNum(Integer maxPoolNum) {
            this.maxPoolNum = maxPoolNum;
            return this;
        }

        public ThreadInitParam setKeepAliveTime(Long keepAliveTime) {
            this.keepAliveTime = keepAliveTime;
            return this;
        }

        public ThreadInitParam setTimeUnit(TimeUnit timeUnit) {
            this.timeUnit = timeUnit;
            return this;
        }

        public ThreadInitParam setWorkQueue(BlockingQueue workQueue) {
            this.workQueue = workQueue;
            return this;
        }

        public ThreadInitParam setRejectedExecutionHandler(RejectedExecutionHandler rejectedExecutionHandler) {
            this.rejectedExecutionHandler = rejectedExecutionHandler;
            return this;
        }

        public Integer getCorePoolNum() {
            return corePoolNum;
        }

        public Integer getMaxPoolNum() {
            return maxPoolNum;
        }

        public Long getKeepAliveTime() {
            return keepAliveTime;
        }

        public TimeUnit getTimeUnit() {
            return timeUnit;
        }

        public BlockingQueue getWorkQueue() {
            return workQueue;
        }

        public RejectedExecutionHandler getRejectedExecutionHandler() {
            return rejectedExecutionHandler;
        }

        public ThreadFactory getThreadFactory() {
            return threadFactory;
        }
    }


    static class InitThreadFactory implements ThreadFactory {

        private static final Logger logger = LoggerFactory.getLogger(InitThreadFactory.class);

        private static final AtomicInteger poolNumber = new AtomicInteger(1);

        private final ThreadGroup group;

        private final AtomicInteger threadNumber = new AtomicInteger(1);

        private final String namePrefix;

        private final boolean isDaemon;

        InitThreadFactory(String prefix, boolean isDaemon) {
            SecurityManager s = System.getSecurityManager();
            group = (s != null) ? s.getThreadGroup() :
                    Thread.currentThread().getThreadGroup();
            if (StringUtils.isBlank(prefix)) {
                prefix = "initPool-";
                logger.warn("incoming pool name prefix config is null, use default");
            }
            this.isDaemon = isDaemon;
            namePrefix = org.apache.commons.lang3.StringUtils.join(prefix, poolNumber.getAndIncrement(), "-thread-");
        }

        @Override
        public Thread newThread(Runnable r) {
            Thread t = new Thread(group, r,
                    namePrefix + threadNumber.getAndIncrement(),
                    0);
            if (t.isDaemon()) {
                t.setDaemon(isDaemon);
            }
            if (t.getPriority() != Thread.NORM_PRIORITY) {
                t.setPriority(Thread.NORM_PRIORITY);
            }
            return t;
        }


    }


}
