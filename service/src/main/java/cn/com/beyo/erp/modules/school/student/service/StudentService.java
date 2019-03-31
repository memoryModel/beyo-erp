package cn.com.beyo.erp.modules.school.student.service;

import cn.com.beyo.erp.commons.curator.Curator;
import cn.com.beyo.erp.commons.curator.CuratorPath;
import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.commons.utils.CodeUtil;
import cn.com.beyo.erp.commons.utils.IdWorker;
import cn.com.beyo.erp.commons.utils.TimeUtils;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.order.facade.OrderFacade;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.mq.ClassProducer;
import cn.com.beyo.erp.modules.school.classes.service.ClassService;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.service.ClassStudentsService;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineStudents;
import cn.com.beyo.erp.modules.school.student.dao.StudentDao;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.facade.StudentFacade;
import cn.com.beyo.erp.modules.school.student.mq.TransactionProducer;
import com.alibaba.fastjson.JSON;
import org.apache.curator.framework.recipes.locks.InterProcessMultiLock;
import org.apache.curator.framework.recipes.locks.InterProcessMutex;
import org.apache.rocketmq.client.producer.LocalTransactionState;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.client.producer.SendStatus;
import org.apache.rocketmq.client.producer.TransactionSendResult;
import org.apache.rocketmq.common.message.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

@Service(value = "studentService")
public class StudentService extends BeyoService<StudentDao, Student> implements StudentFacade{

    public static final String TX_PAY_TOPIC = "tx_pay_topic";

    public static final String TX_PAY_TAGS = "pay";

    public static final String CLASS_TOPIC = "class_topic";

    public static final String CLASS_TAGS = "class";

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private TransactionProducer transactionProducer;

    @Autowired
    private ClassService classService;

    @Autowired
    private ClassStudentsService classStudentsService;

    @Autowired
    private Curator curator;

    @Autowired
    private ClassProducer classProducer;


    @Override
    @Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public Page<Student> findStudentListAndFollow(Page<Student> page, Student student) {
        student.setPage(page);
        List<Student> studentList = studentDao.findStudentListAndFollow(student);
        if (studentList != null){
            for (Student student1:studentList) {
                System.out.println(student);
            }
        }
        page.setList(studentList);
        return page;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
    public List<Student> findStudentClass(Student studentEnroll) {
        return studentDao.findStudentClass(studentEnroll);
    }

    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public void save(Student student){
        System.out.println("------------------Studentd的save()方法执行成功----------");
    }

    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public Long update(Student student){
        System.out.println("------------------Studentd的update()方法执行成功----------");
        return 1L;
    }

    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public void updateStatusByClass(Student student) { studentDao.updateStatusByClass(student); }


    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public String updateStatus(SchoolClass aClass){
//  5.未开班状态状态--开班操作-----进行排课处理   0.新开班状态
        try{
            aClass.setStatus(ClassStatus.CREATED.getValue());   //状态0 ： 新开班
            aClass.setRealBeginTime(new Date());  //设置开班时间
            //classService.updateStatus(aClass);
            ClassStudents classStudents = new ClassStudents();
            classStudents.setSchoolClass(aClass);
            classStudents.setStatus(ClassStudentsStatus.STUDY.getValue());
            //classStudentsService.updateStudentsForStudy(classStudents);

            //改班级所有 报读未开班 学员状态置 2.在读
            Student student = new Student();
            student.setStudentStatus(StudentStatus.STUDY.getValue());
            classStudents.setStatus(ClassStudentsStatus.STUDY.getValue());
            student.setSchoolClassStudents(classStudents);
            //this.updateStatusByClass(student);

            Map<String,Object> params = new HashMap<>();
            params.put("classId",aClass.getId());
            params.put("className",aClass.getClassName());
            String keys = UUID.randomUUID().toString() + "$" + System.currentTimeMillis();
            Message message = new Message(CLASS_TOPIC,CLASS_TAGS,keys, JSON.toJSONString(params).getBytes());
            SendResult sendResult = classProducer.sendMessage(message);
            return "success";
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            return "fail";
        }

    }


    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public String saveStudentApply(Student student,
                                   Long payType,
                                   Double prepaidAmount,
                                   Double tuitionAmount,
                                   Double miscellaneousAmount,
                                   Double tuitionFavorable,
                                   String classId){

        try{
            //订单
            if(prepaidAmount==null) prepaidAmount = 0.00;
            if(tuitionAmount==null) tuitionAmount = 0.00;
            if(tuitionFavorable==null) tuitionFavorable = 0.00;
            if(miscellaneousAmount==null) miscellaneousAmount = 0.00;

            //报班
            //分布式锁加锁
            Integer res = 0;
            Integer classRealNum = 0;
            Integer currentVersion = 0;
            /**
             * reids分布式锁方案
             * */
            /*boolean result = redis.getLock(2000L,3000L,
                    RedisKey.LOCK+"classId",classId);
            if(result){//获取锁情况下
                try{
                    SchoolClass schoolClass = classService.get(Long.parseLong(classId));
                    //当前版本
                    currentVersion = schoolClass.getCurrentVersion();
                    //班级招收最大人数
                    Integer classMaxNum  = schoolClass.getClassMaxNum();
                    //班级实际招收人数 + 1
                    classRealNum = schoolClass.getClassRealNum() + 1;
                    res = classMaxNum - classRealNum;
                    schoolClass.setClassRealNum(classRealNum);
                }catch (Exception e){
                    e.printStackTrace();
                }finally {
                    //解锁
                    redis.unLock(RedisKey.LOCK+"classId",classId);
                }
            }*/
            /**
             * curator分布式锁方案
             * */
            InterProcessMutex lock =
                    new InterProcessMutex(curator.getCuratorFramework(),
                            CuratorPath.LOCK + "classId" + classId);
            lock.acquire(5, TimeUnit.SECONDS);
            try{
                SchoolClass schoolClass = classService.get(Long.parseLong(classId));
                //当前版本
                currentVersion = schoolClass.getCurrentVersion();
                //班级招收最大人数
                Integer classMaxNum  = schoolClass.getClassMaxNum();
                //班级实际招收人数 + 1
                classRealNum = schoolClass.getClassRealNum() + 1;
                res = classMaxNum - classRealNum;
                schoolClass.setClassRealNum(classRealNum);
            }catch (Exception e){
                e.printStackTrace();
            }finally {
                lock.release();
            }
            //当班级的报名人数没有大于招收最大人数情况下
            if(res >= 0){
                Map<String ,Object> params = new HashMap<>();
                params.put("schoolClassId",Long.parseLong(classId));
                params.put("currentVersion",currentVersion);
                params.put("classRealNum",classRealNum);
                params.put("studentId",student.getId());
                params.put("studentNumber",CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_STUNUM));
                params.put("payType",payType);
                params.put("prepaidAmount",prepaidAmount);
                params.put("tuitionAmount",tuitionAmount);
                params.put("miscellaneousAmount",miscellaneousAmount);
                params.put("tuitionFavorable",tuitionFavorable);
                Long orderId = IdWorker.getId();
                params.put("orderId",orderId);
                //如果得到的发送事务消息结果是失败的情况下，countDownLatch会根据实际业务等待时间再给mq
                //回查机会
                CountDownLatch countDownLatch = new CountDownLatch(1);
                params.put("countDownLatch",countDownLatch);
                String keys = UUID.randomUUID().toString() + "$" + System.currentTimeMillis();

                Message message = new Message(TX_PAY_TOPIC,TX_PAY_TAGS,keys, JSON.toJSONString(params).getBytes());
                TransactionSendResult transactionSendResult = transactionProducer.sendMessage(message, student);
                //在MQ发送消息成功并且本地事务也执行成功了则返回报名成功，如果MQ的分布式事务也就是订单操作一段
                //失败的话，则人工解决
                if(transactionSendResult.getSendStatus() == SendStatus.SEND_OK &&
                        transactionSendResult.getLocalTransactionState() == LocalTransactionState.COMMIT_MESSAGE){
                        return "success";
                }else if(transactionSendResult.getSendStatus() == SendStatus.SEND_OK &&
                        transactionSendResult.getLocalTransactionState() == LocalTransactionState.UNKNOW){
                        countDownLatch.await(3,TimeUnit.SECONDS);
                        if(transactionSendResult.getLocalTransactionState() == LocalTransactionState.COMMIT_MESSAGE){
                            return "success";
                        }
                        return "fail";
                }
            }
            return "fail";
        }catch (Exception e){
            e.printStackTrace();
            return "fail";
        }
    }
}
