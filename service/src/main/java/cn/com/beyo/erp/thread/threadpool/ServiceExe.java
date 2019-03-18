package cn.com.beyo.erp.thread.threadpool;

import cn.com.beyo.erp.modules.school.student.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;


@Service
public class ServiceExe {
    @Autowired
    ExecutorService executorService;

    public Student execute() {
        Student result = CompletableFuture.
                supplyAsync(() -> {
                        System.out.println("supplyAsync方法开始执行");Student s = new Student(1L);
                        System.out.println("supplyAsync方法执行后student的值:"+s);return s;}, executorService)
                .thenApplyAsync(s -> {System.out.println("thenApplyAsync方法开始执行");s.setName("测试");
                        System.out.println("thenApplyAsync方法执行后student的值:"+s);return s;}, executorService)
                .whenCompleteAsync((s, t) ->
                        executorService.submit(() -> {
                            try {
                                System.out.println("whenCompleteAsync方法执行后student的值:"+s);
                                System.out.println("加入日志");
                            } catch (Exception e) {
                                //log.warn("callLog return result modify fail, callLog is {}", JSON.toJSONString(callLog),e);
                            }
                        })
                )
                .join();
        executorService.shutdown();
        return result;
    }

//    private static ExecutorService executorService1 = Executors.newSingleThreadExecutor();
//
//
//    public static void main(String[] args) {
//        String s = get();
//        System.out.println("final===" + s);
//    }
//
//
//    private static String get() {
//        Integer two = CompletableFuture.supplyAsync(() -> 10 / 2)
////                .whenCompleteAsync((s, t) -> {
////                    System.out.println(t.getMessage());
////                })
//                .thenApplyAsync(i -> {
//                    System.out.println("two");
//                    i++;
//                    return i;
//                }).whenCompleteAsync((s, t) -> {
//
//                    Runnable wait = new Runnable() {
//                        @Override
//                        public void run() {
//                            try {
//                                Thread.sleep(5000);
//                                System.out.println("thread test");
//                            } catch (InterruptedException e) {
//                                e.printStackTrace();
//                            }
//                        }
//                    };
//                    executorService1.execute(wait);
//
//                    if (Objects.nonNull(t)) {
//                        System.out.println(t.getMessage());
//                    } else {
//                        System.out.println("test when" + s);
//                    }
//                })
//                .join();
//        return two.toString();
//    }
}


