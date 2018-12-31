/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.clessstudents.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.commons.status.*;
import cn.com.beyo.erp.modules.erp.order.entity.Order;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.service.ClassService;
import cn.com.beyo.erp.modules.school.clessstudents.dao.ClassStudentsDao;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.clessstudents.facade.ClassStudentsFacade;
import cn.com.beyo.erp.modules.school.student.entity.Student;
import cn.com.beyo.erp.modules.school.student.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.Date;
import java.util.List;

/**
 * 新增班级中间表Service
 * @author beyo.com.cn
 * @version 2017-06-27
 */
@Service(value = "classStudentsService")
public class ClassStudentsService extends BeyoService<ClassStudentsDao, ClassStudents> implements ClassStudentsFacade {



	@Autowired
	private ClassStudentsDao classStudentsDao;


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public ClassStudents get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassStudents> findList(ClassStudents schoolClassStudents) {
		return super.findList(schoolClassStudents);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassStudents> findPage(Page<ClassStudents> page, ClassStudents schoolClassStudents) {
		schoolClassStudents.setPage(page);
		page.setList(dao.findList(schoolClassStudents));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(ClassStudents classStudents) {
		System.out.println("--------------ClassStudentsService的save()方法执行成功----------");
		//super.save(classStudents);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(ClassStudents schoolClassStudents) {
		super.delete(schoolClassStudents);
	}

	/**
	 * 转班
	 * @param classStudents
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void changeClass(ClassStudents classStudents) {
		int count = dao.changeClass(classStudents);
		logger.info("数"+count);
	}

	/**
	 * 查询退班学生列表
	 * @param schoolClassStudents
	 * @param schoolClassStudents
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassStudents> findQuitList(Page<ClassStudents> page, ClassStudents schoolClassStudents) {
		schoolClassStudents.setPage(page);
		page.setList(dao.findQuitList(schoolClassStudents));
		return page;
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassStudents> findQuitList(ClassStudents schoolClassStudents) {
		return dao.findQuitList(schoolClassStudents);
	}

	/**
	 * 证书办理查询办理学员班级
	 * @param page
	 * @param classStudents
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<ClassStudents> findClassStudent(Page<ClassStudents> page, ClassStudents classStudents) {
		classStudents.setPage(page);
		page.setList(dao.findClassStudent(classStudents));
		return page;
	}


	/**
	 * 添加证书后修改这条记录的状态
	 * @param classStudents
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateClassStudents(ClassStudents classStudents) {
		dao.updateClassStudents(classStudents);
	}

	/**
	 * 变更学员为 报名未开班的 状态
	 * @param classStudents
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateStudentsForStudy(ClassStudents classStudents) { dao.updateStudentsForStudy(classStudents); }

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassStudents> findListByStu(ClassStudents classStudents) {
		return dao.findListByStu(classStudents);
	}



	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<ClassStudents> findAllList(ClassStudents classStudents) {
		return classStudentsDao.findAllList(classStudents);
	}
}