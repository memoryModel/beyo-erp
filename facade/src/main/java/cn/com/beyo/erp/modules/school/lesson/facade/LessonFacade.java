package cn.com.beyo.erp.modules.school.lesson.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.modules.school.lesson.entity.ClassLesson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface LessonFacade extends BeyoFacade<ClassLesson> {

    Page<ClassLesson> selectListAll(ClassLesson classLesson, RpcHttp rpcHttp);

    Long updateClassLesson(ClassLesson schoolClassLesson);

    Long saveClassLesson(ClassLesson schoolClassLesson);

    Long deleteClassLesson(ClassLesson schoolClassLesson);

    ClassLesson getClassLesson(Long id);
}
