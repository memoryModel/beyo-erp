/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.transactioncertificate.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.school.clessstudents.entity.ClassStudents;
import cn.com.beyo.erp.modules.school.educationcertificate.entity.EducationCertificate;
import cn.com.beyo.erp.modules.sys.entity.Office;
import cn.com.beyo.erp.modules.sys.entity.User;

import java.util.Date;

/**
 * 单表生成Entity
 * @author beyo.com.cn
 * @version 2017-06-02
 */
public class TransactionCertificate extends DataVo<TransactionCertificate> {

	private static final long serialVersionUID = 1L;
	private String transactionCertificateId;    //证书
	private EducationCertificate certificate;		// 证书表
	private Date createTimeStart;   //创建时间开始
	private Date createTimeEnd;   //创建时间结束
	private ClassStudents classStudents;   //新增证书时查询学生信息
	private String transactionCertificateNames;  //一个学员所办全部证书

	private User user;   //用户
	private Office office;   //部门

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public TransactionCertificate() {
		super();
	}

	public TransactionCertificate(Long id){
		super(id);
	}

	public Date getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(Date createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public EducationCertificate getCertificate() {
		return certificate;
	}

	public void setCertificate(EducationCertificate certificate) {
		this.certificate = certificate;
	}

	public ClassStudents getClassStudents() {
		return classStudents;
	}

	public void setClassStudents(ClassStudents classStudents) {
		this.classStudents = classStudents;
	}

	public String getTransactionCertificateId() {
		return transactionCertificateId;
	}

	public void setTransactionCertificateId(String transactionCertificateId) {
		this.transactionCertificateId = transactionCertificateId;
	}

	public String getTransactionCertificateNames() {
		return transactionCertificateNames;
	}

	public void setTransactionCertificateNames(String transactionCertificateNames) {
		this.transactionCertificateNames = transactionCertificateNames;
	}
}