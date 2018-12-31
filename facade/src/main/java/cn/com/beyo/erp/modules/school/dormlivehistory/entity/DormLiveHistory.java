/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormlivehistory.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormEmployeeLive;
import cn.com.beyo.erp.modules.school.dormlive.entity.DormStudentLive;
import cn.com.beyo.erp.modules.school.dormroombed.entity.DormRoomBed;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-12
 */
public class DormLiveHistory extends DataVo<DormLiveHistory> {
	
	private static final long serialVersionUID = 1L;
	private Integer type;		// 类型
	private Date leaveTime;		// 退房时间
	private Long handleName;		// 经办人
	private DormRoomBed dormRoomBed; //床位
	private Date startTime;
	private Date endTime;
	private DormStudentLive dormStudentLive;
	private DormEmployeeLive dormEmployeeLive;
	private User user;

	
	public DormLiveHistory() {
		super();
	}

	public DormLiveHistory(Long id){
		super(id);
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getLeaveTime() {
		return leaveTime;
	}

	public void setLeaveTime(Date leaveTime) {
		this.leaveTime = leaveTime;
	}
	
	public Long getHandleName() {
		return handleName;
	}

	public void setHandleName(Long handleName) {
		this.handleName = handleName;
	}

	public DormRoomBed getDormRoomBed() {
		return dormRoomBed;
	}

	public void setDormRoomBed(DormRoomBed dormRoomBed) {
		this.dormRoomBed = dormRoomBed;
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

	public DormStudentLive getDormStudentLive() {
		return dormStudentLive;
	}

	public void setDormStudentLive(DormStudentLive dormStudentLive) {
		this.dormStudentLive = dormStudentLive;
	}

	public DormEmployeeLive getDormEmployeeLive() {
		return dormEmployeeLive;
	}

	public void setDormEmployeeLive(DormEmployeeLive dormEmployeeLive) {
		this.dormEmployeeLive = dormEmployeeLive;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}