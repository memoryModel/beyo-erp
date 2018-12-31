/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.commons.utils.excel.fieldtype;

import cn.com.beyo.erp.commons.utils.StringUtils;
import cn.com.beyo.erp.modules.sys.entity.Area;

/**
 * 字段类型转换
 * @author beyo.com.cn
 * @version 2013-03-10
 */
public class AreaType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {

		return null;
	}

	/**
	 * 获取对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((Area)val).getName() != null){
			return ((Area)val).getName();
		}
		return "";
	}
}
