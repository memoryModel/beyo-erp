/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.sys.service;

import cn.com.beyo.erp.commons.service.TreeService;
import cn.com.beyo.erp.commons.utils.StringUtils;
import cn.com.beyo.erp.modules.sys.dao.OfficeDao;
import cn.com.beyo.erp.modules.sys.entity.Office;
import cn.com.beyo.erp.modules.sys.utils.UserUtils;
import libs.fastjson.com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 机构Service
 * @author beyo.com.cn
 * @version 2014-05-16
 */
@Service
public class OfficeService extends TreeService<OfficeDao, Office> {

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Office> findAll(){
		return dao.findAllList(new Office());
//		User user = UserUtils.getUser();
//		if (user.isAdmin()){
//			return dao.findAllList(new Office());
//		}else{
//			Office office = new Office();
//			office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
//			return  dao.findList(office);
//		}
	}

	/**
	 * 查询emp
	 * @author Ashon
	 * @version 2017-06-07
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Office> findEmployeeList(){
		return dao.findEmployeeList(new Office());
	}

	/**
	 * 查询学员
	 * @return
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Office> findStudentList(){
		return dao.findStudentList(new Office());
	}


	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return dao.findAllList(new Office());
		}else{
			return findAll();
		}
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<Office> findList(Office office){
		if(office != null){
			office.setParentIds(office.getParentIds());
			return dao.findByParentIdsLike(office);
		}
		return  new ArrayList<Office>();
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int findChildsByParentId(Office office){
		return dao.findChildsByParentId(office);
	}

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public int findUsersByParentId(Office office){
		return dao.findUsersByParentId(office);
	}

	/**
	 * 通过存储函数查询和拼接数据来源
	 */
	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<String> getOfficeNames(String[] createUsersArray,Long selfCompanyId){
		return dao.getOfficeNames(createUsersArray,selfCompanyId);
	};

	@Transactional(propagation = Propagation.SUPPORTS,isolation = Isolation.DEFAULT,readOnly = true)
	public List<JSONObject> getOfficeHtmlList(String createUsers,String ids){
		if(StringUtils.isBlank(createUsers) || StringUtils.isBlank(ids)){
			return null;
		}
		List<JSONObject> jsonObjectList = new ArrayList<>();
		String[] createUsersArray = createUsers.split(",");
		String[] idsArray = ids.split(",");
		List<String> officeJsonList = this.getOfficeNames
				(createUsersArray, UserUtils.getUser().getCompany().getId());
		if(officeJsonList != null && officeJsonList.size() > 0){
			for(int i=0;i<officeJsonList.size();i++){
				JSONObject jsonObject = (JSONObject) JSONObject.parse(officeJsonList.get(i));
				jsonObject.put("id",idsArray[i]);
				jsonObjectList.add(jsonObject);
			}
		}
		return jsonObjectList;
	}


}
