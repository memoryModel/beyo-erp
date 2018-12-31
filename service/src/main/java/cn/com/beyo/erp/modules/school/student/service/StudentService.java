package cn.com.beyo.erp.modules.school.student.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.commons.utils.CodeUtil;
import cn.com.beyo.erp.commons.utils.IdWorker;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.order.entity.OrderContract;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.service.ClassService;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.service.ClassStudentsService;
import cn.com.beyo.erp.modules.school.student.dao.StudentDao;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.facade.StudentFacade;
import cn.com.beyo.erp.modules.school.student.mq.TransactionProducer;
import com.alibaba.fastjson.JSON;
import org.apache.rocketmq.client.producer.TransactionSendResult;
import org.apache.rocketmq.common.message.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service(value = "studentService")
public class StudentService extends BeyoService<StudentDao, Student> implements StudentFacade{

    public static final String TX_PAY_TOPIC = "tx_pay_topic";

    public static final String TX_PAY_TAGS = "pay";

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private TransactionProducer transactionProducer;

    @Autowired
    private ClassService classService;

    @Autowired
    private ClassStudentsService classStudentsService;

    @Autowired
    private Redis redis;

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
            boolean result = redis.getLock(2000L,3000L,
                    RedisKey.LOCK+"classId",classId);
            if(result){//获取锁情况下
                SchoolClass schoolClass = classService.get(Long.parseLong(classId));
                //当前版本
                currentVersion = schoolClass.getCurrentVersion();
                //班级招收最大人数
                Integer classMaxNum  = schoolClass.getClassMaxNum();
                //班级实际招收人数 + 1
                classRealNum = schoolClass.getClassRealNum() + 1;
                res = classMaxNum - classRealNum;
                schoolClass.setClassRealNum(classRealNum);

                //解锁
                redis.unLock(RedisKey.LOCK+"classId",classId);
            }

            //当班级的报名人数没有大于招收最大人数情况下
            if(res >= 0){
                Map<String ,Object> params = new HashMap<>();
                params.put("schoolClassId",Long.parseLong(classId));
                params.put("currentVersion",currentVersion);
                params.put("classRealNum",classRealNum);
                params.put("studentId",student.getId());
                params.put("payType",payType);
                params.put("prepaidAmount",prepaidAmount);
                params.put("tuitionAmount",tuitionAmount);
                params.put("miscellaneousAmount",miscellaneousAmount);
                params.put("tuitionFavorable",tuitionFavorable);
                params.put("orderId",IdWorker.getId());
                String keys = UUID.randomUUID().toString() + "$" + System.currentTimeMillis();

                Message message = new Message(TX_PAY_TOPIC,TX_PAY_TAGS,keys, JSON.toJSONString(params).getBytes());
                TransactionSendResult transactionSendResult = transactionProducer.sendMessage(message, student);

            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return null;
    }
}
