/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormroombed.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.dormroom.entity.DormRoom;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-14
 */
public class DormRoomBed extends DataVo<DormRoomBed> {
	
	private static final long serialVersionUID = 1L;
	private Integer bedCode;		// 床位号
	private DormRoom dormRoom; // 房间id
	private Date startTime;
	private Date endTime;


	
	public DormRoomBed() {
		super();
	}

	public DormRoomBed(Long id){
		super(id);
	}

	public Integer getBedCode() {
		return bedCode;
	}

	public void setBedCode(Integer bedCode) {
		this.bedCode = bedCode;
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
}