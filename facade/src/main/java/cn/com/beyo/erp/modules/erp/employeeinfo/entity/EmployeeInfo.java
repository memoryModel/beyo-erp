/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.employeeinfo.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import org.hibernate.validator.constraints.Length;

/**
 * 员工签约Entity
 * @author beyo.com.cn
 * @version 2017-07-17
 */
public class EmployeeInfo extends DataVo<EmployeeInfo> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private Long type;		// 类型
	private String url;		// 图片
	private Employee employee; //员工
	
	public EmployeeInfo() {
		super();
	}

	public EmployeeInfo(Long id){
		super(id);
	}
	
	@Length(min=0, max=200, message="名称长度必须介于 0 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}
	
	/*@Length(min=0, max=200, message="图片长度必须介于 0 和 200 之间")*/
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}