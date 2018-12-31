/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.classes.service;

import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.service.BaseService;
import cn.com.beyo.erp.commons.service.BeyoService;
import cn.com.beyo.erp.modules.school.classes.dao.ClassDao;
import cn.com.beyo.erp.modules.school.classes.entity.SchoolClass;
import cn.com.beyo.erp.modules.school.classes.facade.ClassFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 班级管理Service
 * @author Ashon
 * @version 2017-06-01
 */
@Service(value = "classService")
public class ClassService extends BeyoService<ClassDao, SchoolClass> implements ClassFacade{

	@Autowired
	private ClassDao schoolClassDao;

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public SchoolClass get(Long id) {
		if(null==id)return null;
		return super.get(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<SchoolClass> findList(SchoolClass schoolClass) {
		return super.findList(schoolClass);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<SchoolClass> findPage(Page<SchoolClass> page, SchoolClass schoolClass) {
		schoolClass.setPage(page);
		page.setList(schoolClassDao.findList(schoolClass));
		return page;
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public Long update(SchoolClass schoolClass) {
		System.out.println("----------SchoolClass的update()方法执行成功--------");
		return 1L;
		//return schoolClassDao.update(schoolClass);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(SchoolClass schoolClass) {
		System.out.println("-------------classService的save()方法执行成功-----------");
		//super.save(schoolClass);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void saveClass(SchoolClass schoolClass){dao.saveClass(schoolClass);};

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(SchoolClass schoolClass) {
		dao.delete(schoolClass);
	}

	/**
	 * 变更业务状态
	 * @author Ashon
	 * @version 2017-06-13
	 */
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void updateStatus(SchoolClass schoolClass) {
		dao.updateStatus(schoolClass);
	}

	/**
	 * 查询班级列表
	 * 绑定下拉框
	 * @return List<SchoolClass>
	 * @author Ashon
	 * @version 2017-06-06
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<SchoolClass> findClassList(){
		return dao.findClassList(new SchoolClass());
	}





	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public SchoolClass getById(SchoolClass schoolClass) {
		return dao.getById(schoolClass);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<SchoolClass> findClassListByEmployee(Long id) {
		return schoolClassDao.findClassListByEmployee(id);
	}

	/**
	 * 转班：查看所有班级
	 * @param page
	 * @param schoolClass
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public Page<SchoolClass> selectClassList(Page<SchoolClass> page, SchoolClass schoolClass) {
		schoolClass.setPage(page);
		page.setList(dao.selectClassList(schoolClass));
		return page;
	}

	//查询未结业的班级
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List selectClass() {
		SchoolClass schoolClass = new SchoolClass();
		return dao.selectClass(schoolClass);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Class> findClassByOrderId(Long id) {
		return schoolClassDao.findClassByOrderId(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Class> findClassListByStudentId(Long id) {
		return schoolClassDao.findClassListByStudentId(id);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Class> selectCourseSchedule(List<Map> scheduleList){
		return dao.selectCourseSchedule(scheduleList);
	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int updateClassRealNumById(SchoolClass schoolClass) {
		System.out.println("ClassService的updateClassRealNumById()方法更新成功");
		return 1;
		//return schoolClassDao.updateClassRealNumById(schoolClass) ;
	}
}