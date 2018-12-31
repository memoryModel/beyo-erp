/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.dormroom.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.dorm.entity.Dorm;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 房间Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class DormRoom extends DataVo<DormRoom> {
	
	private static final long serialVersionUID = 1L;
	private Dorm erpDorm;   //宿舍id
	private String roomName;		// 房间
	private Integer availableNumber;		// 可入住人数
	private Integer bedNumber;		// 床位数量
	private Integer alreadyNumber;		// 已入住人数
	private Date startTime;
	private Date endTime;
	
	public DormRoom() {
		super();
	}

	public DormRoom(Long id){
		super(id);
	}

	public Dorm getErpDorm() {
		return erpDorm;
	}

	public void setErpDorm(Dorm erpDorm) {
		this.erpDorm = erpDorm;
	}

	@Length(min=0, max=64, message="房间长度必须介于 0 和 64 之间")
	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public Integer getAvailableNumber() {
		return availableNumber;
	}

	public void setAvailableNumber(Integer availableNumber) {
		this.availableNumber = availableNumber;
	}

	public Integer getBedNumber() {
		return bedNumber;
	}

	public void setBedNumber(Integer bedNumber) {
		this.bedNumber = bedNumber;
	}

	public Integer getAlreadyNumber() {
		return alreadyNumber;
	}

	public void setAlreadyNumber(Integer alreadyNumber) {
		this.alreadyNumber = alreadyNumber;
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