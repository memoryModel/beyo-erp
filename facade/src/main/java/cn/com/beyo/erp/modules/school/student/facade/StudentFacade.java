package cn.com.beyo.erp.modules.school.student.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.student.entity.Student;

import java.util.List;

public interface StudentFacade extends BeyoFacade<Student> {

    /**
     * 根据标识符tagFlag判断有无人员跟进的生源列表
     * @param student
     * @return
     */
    Page<Student> findStudentListAndFollow(Page<Student> page, Student student);

    List<Student> findStudentClass(Student studentEnroll);

    String saveStudentApply(Student student,
                                   Long payType,
                                   Double prepaidAmount,
                                   Double tuitionAmount,
                                   Double miscellaneousAmount,
                                   Double tuitionFavorable,
                                   String classId);

    String updateStatus(SchoolClass aClass);
}
