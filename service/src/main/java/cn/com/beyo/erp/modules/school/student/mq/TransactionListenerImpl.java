package cn.com.beyo.erp.modules.school.student.mq;

import cn.com.beyo.erp.commons.status.ClassStudentsStatus;
import cn.com.beyo.erp.commons.status.StudentStatus;
import cn.com.beyo.erp.commons.status.StudentTypeStatus;
import cn.com.beyo.erp.commons.utils.CodeUtil;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.service.ClassService;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.service.ClassStudentsService;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.service.StudentService;
import libs.fastjson.com.alibaba.fastjson.JSON;
import org.apache.rocketmq.client.producer.LocalTransactionState;
import org.apache.rocketmq.client.producer.TransactionListener;
import org.apache.rocketmq.common.message.Message;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.HashMap;
import java.util.Map;

@Component
public class TransactionListenerImpl implements TransactionListener{

    @Autowired
    private ClassService classService;

    @Autowired
    private ClassStudentsService classStudentsService;

    @Autowired
    private StudentService studentService;


    @Override
    public LocalTransactionState executeLocalTransaction(Message message, Object o) {
        System.err.println("----------执行本地事务单元-------------");
        try{
            Map<String,Object> params = JSON.parseObject(new String(message.getBody()),Map.class);
            Long schoolClassId = (Long)params.get("schoolClassId");
            Integer classRealNum = (Integer)params.get("classRealNum");
            Long orderId = (Long)params.get("orderId");
            Integer currentVersion = (Integer)params.get("currentVersion");
            SchoolClass schoolClass = new SchoolClass();
            schoolClass.setId(schoolClassId);
            schoolClass.setClassRealNum(classRealNum);
            schoolClass.setCurrentVersion(currentVersion);
            Integer res = classService.updateClassRealNumById(schoolClass);//更新报班人数
            Student student = (Student)o;
            if(res > 0){
                //报班学员状态
                student.setStudentType(StudentTypeStatus.OFFICIAL.getValue());//学员类型 设置为 2.正式报名学员
                if(student.getStatus()!= StudentStatus.STUDY.getValue())student.setStatus(StudentStatus.UNREAD.getValue());//学员状态 设置为 0.未读

                if(null==student.getStudentNumber() || student.getStudentNumber().trim().equals("")){
                    student.setStudentNumber(CodeUtil.genOrderNo(CodeUtil.CODE_PREFIX_STUNUM));
                }
                studentService.update(student);

                ClassStudents classStudents = new ClassStudents();
                classStudents.setSchoolClass(schoolClass);
                classStudents.setStudent(student);
                classStudents.setOrder(new Order(orderId));//订单
                classStudents.setApplyTime(student.getApplyTime());//报名日期
                classStudents.setStatus(ClassStudentsStatus.READY.getValue());//设置该班级学生状态  4.报名未开班
                classStudentsService.save(classStudents);//新增班级学生
                return LocalTransactionState.COMMIT_MESSAGE;
            }else{//没有更新成功的话，则让MQ的prepare状态的消息回滚
                return LocalTransactionState.ROLLBACK_MESSAGE;
            }
        }catch (Exception e){
            e.printStackTrace();
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return LocalTransactionState.ROLLBACK_MESSAGE;
        }
    }

    @Override
    public LocalTransactionState checkLocalTransaction(MessageExt messageExt) {
        return null;
    }
}
