package cn.com.beyo.erp.modules.crm.productcategory.entity; /**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */

import cn.com.beyo.erp.commons.persistence.TreeVo;
import org.hibernate.validator.constraints.Length;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 商品分类Entity
 * @author beyo.com.cn
 * @version 2017-06-29
 */
public class ProductCategory extends TreeVo<ProductCategory> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 商品分类
	private Integer sort;		// 排序
	private String url;		// logo图片
	private String remark;		// 备注
	private String createDateStr;//时间转换业务字段


	private Date startTime;   //业务字段
	private Date endTime;

	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(Date lkj) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		createDateStr = sdf.format(lkj);
		this.createDateStr = createDateStr;
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

	public ProductCategory() {
		super();
	}

	public ProductCategory(Long id){
		super(id);
	}

	@Override
	public ProductCategory getParent() {
		return parent;
	}

	@Override
	public void setParent(ProductCategory parent) {
		this.parent = parent;
	}

	@Length(min=0, max=215, message="商品分类长度必须介于 0 和 215 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=215, message="url长度必须介于 0 和 215 之间")
	public String geturl() {
		return url;
	}

	public void seturl(String url) {
		this.url = url;
	}


	@Length(min=0, max=215, message="备注长度必须介于 0 和 215 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}