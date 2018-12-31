/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.educationcertificate.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 *  证书设置Entity
 * @author beyo.com.cn
 * @version 2017-06-05
 */
public class EducationCertificate extends DataVo<EducationCertificate> {

	private static final long serialVersionUID = 1L;
	private String photoUrl;		// 照片
	private String certificateName;		// 名称
	private String description;		// 描述

	private Date startTime;    //业务时间字段
	private Date endTime;

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

	public EducationCertificate() {
		super();
	}

	public EducationCertificate(Long id){
		super(id);
	}


	@Length(min=0, max=512, message="照片长度必须介于 0 和 512 之间")
	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	@Length(min=1, max=64, message="名称长度必须介于 1 和 64 之间")
	public String getCertificateName() {
		return certificateName;
	}

	public void setCertificateName(String certificateName) {
		this.certificateName = certificateName;
	}

	@Length(min=0, max=1024, message="描述长度必须介于 0 和 1024 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}