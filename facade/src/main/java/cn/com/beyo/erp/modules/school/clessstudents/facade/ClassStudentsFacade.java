package cn.com.beyo.erp.modules.school.clessstudents.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;

import java.util.List;

public interface ClassStudentsFacade extends BeyoFacade<ClassStudents> {

    List<ClassStudents> findListByStu(ClassStudents classStudents);

    List<ClassStudents> findByParam(ClassStudents classStudents);
}


