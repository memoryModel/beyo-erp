/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlive.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import cn.com.beyo.erp.modules.school.dormroom.entity.DormRoom;
import cn.com.beyo.erp.modules.sys.entity.User;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-10
 */
public class DormEmployeeLive extends DataVo<DormEmployeeLive> {
	
	private static final long serialVersionUID = 1L;
	private Employee erpEmployee; //员工
	private Date startTime;//开始时间
	private Date endTime;//结束时间
	private DormRoom dormRoom; //房间
	private User handleName; //员工管理老师
	private Date liveTime; //入住时间
	//业务字段
	private String professionName; //专业名字

	public Employee getErpEmployee() {
		return erpEmployee;
	}

	public DormEmployeeLive() {
		super();
	}

	public DormEmployeeLive(Long id){
		super(id);
	}

	public void setErpEmployee(Employee erpEmployee) {
		this.erpEmployee = erpEmployee;
	}

	public DormRoom getDormRoom() {
		return dormRoom;
	}

	public void setDormRoom(DormRoom dormRoom) {
		this.dormRoom = dormRoom;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getLiveTime() {
		return liveTime;
	}

	public void setLiveTime(Date liveTime) {
		this.liveTime = liveTime;
	}

	public User getHandleName() {
		return handleName;
	}

	public void setHandleName(User handleName) {
		this.handleName = handleName;
	}

	public void setProfessionName(String professionName) {
		this.professionName = professionName;
	}

	public String getProfessionName() {
		return professionName;
	}
}