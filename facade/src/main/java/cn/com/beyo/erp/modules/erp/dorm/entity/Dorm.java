/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.dorm.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 单表Entity
 * @author beyo.com.cn
 * @version 2017-06-01
 */
public class Dorm extends DataVo<Dorm> {
	
	private static final long serialVersionUID = 1L;
	private Area area;		// 城市
	private String dormName;		// 宿舍名称
	private String dormAddress;		// 宿舍地址
	private String trafficInfo;		// 交通信息
	private User user;  //管理员
	private Integer todayCheck;		// 当日入住
	private Integer todayLeave;		// 当日退房
	private Integer liveNumber;    //可住人数
	private Integer realLiveNumber;     //实住人数
	private Integer emptyBedNumber;  //空床数量
	private Date startTime;
	private Date endTime;
	private String detailAddress;//详细地址

	public Dorm() {
		super();
	}

	public Dorm(Long id){
		super(id);
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	@Length(min=0, max=64, message="宿舍名称长度必须介于 0 和 64 之间")
	public String getDormName() {
		return dormName;
	}

	public void setDormName(String dormName) {
		this.dormName = dormName;
	}

	@Length(min=0, max=1024, message="宿舍地址长度必须介于 0 和 512 之间")
	public String getDormAddress() {
		return dormAddress;
	}

	public void setDormAddress(String dormAddress) {
		this.dormAddress = dormAddress;
	}
	
	@Length(min=0, max=1024, message="交通信息长度必须介于 0 和 512 之间")
	public String getTrafficInfo() {
		return trafficInfo;
	}

	public void setTrafficInfo(String trafficInfo) {
		this.trafficInfo = trafficInfo;
	}

	public Integer getTodayCheck() {
		return todayCheck;
	}

	public void setTodayCheck(Integer todayCheck) {
		this.todayCheck = todayCheck;
	}

	public Integer getTodayLeave() {
		return todayLeave;
	}

	public void setTodayLeave(Integer todayLeave) {
		this.todayLeave = todayLeave;
	}

	public Integer getLiveNumber() {
		return liveNumber;
	}

	public void setLiveNumber(Integer liveNumber) {
		this.liveNumber = liveNumber;
	}

	public Integer getRealLiveNumber() {
		return realLiveNumber;
	}

	public void setRealLiveNumber(Integer realLiveNumber) {
		this.realLiveNumber = realLiveNumber;
	}

	public Integer getEmptyBedNumber() {
		return emptyBedNumber;
	}

	public void setEmptyBedNumber(Integer emptyBedNumber) {
		this.emptyBedNumber = emptyBedNumber;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}