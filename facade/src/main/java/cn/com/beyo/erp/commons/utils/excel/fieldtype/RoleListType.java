/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.commons.utils.excel.fieldtype;

import cn.com.beyo.erp.commons.utils.Collections3;
import cn.com.beyo.erp.modules.sys.entity.Role;

import java.util.List;

/**
 * 字段类型转换
 * @author beyo.com.cn
 * @version 2013-5-29
 */
public class RoleListType {

	
	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {

		return null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null){
			@SuppressWarnings("unchecked")
			List<Role> roleList = (List<Role>)val;
			return Collections3.extractToString(roleList, "name", ", ");
		}
		return "";
	}
	
}
