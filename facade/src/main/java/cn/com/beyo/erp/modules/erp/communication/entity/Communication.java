/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.communication.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class Communication extends DataVo<Communication> {
	
	private static final long serialVersionUID = 1L;
	private Long commonsTypeId;		// 沟通类型的ID
	private Long nextType;		// 下次跟进类型
	private Integer cotegory;		// 区别学员，员工
	private Date nextTime;		// 下次跟进日期
	private String content;		// 沟通内容
	private cn.com.beyo.erp.modules.school.student.entity.Student student;    //学员
	private User user;     //跟进人（取当前操作的用户）
	public Communication() {
		super();
	}

	public Communication(Long id){
		super(id);
	}

	
	public Long getCommonsTypeId() {
		return commonsTypeId;
	}

	public void setCommonsTypeId(Long commonsTypeId) {
		this.commonsTypeId = commonsTypeId;
	}

	public Long getNextType() {
		return nextType;
	}

	public void setNextType(Long nextType) {
		this.nextType = nextType;
	}

	public Integer getCotegory() {
		return cotegory;
	}

	public void setCotegory(Integer cotegory) {
		this.cotegory = cotegory;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getNextTime() {
		return nextTime;
	}

	public void setNextTime(Date nextTime) {
		this.nextTime = nextTime;
	}

	
	@Length(min=0, max=1024, message="沟通内容长度必须介于 0 和 1024 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public cn.com.beyo.erp.modules.school.student.entity.Student getStudent() {
		return student;
	}

	public void setStudent(cn.com.beyo.erp.modules.school.student.entity.Student student) {
		this.student = student;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public Integer getStatus() {
		return status;
	}

	@Override
	public void setStatus(Integer status) {
		this.status = status;
	}
}