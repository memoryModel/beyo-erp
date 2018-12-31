/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.product.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.productcategory.entity.ProductCategory;
import cn.com.beyo.erp.modules.crm.productsku.entity.ProductGroup;
import cn.com.beyo.erp.modules.crm.productsku.entity.ProductSku;
import cn.com.beyo.erp.modules.crm.skill.entity.Skill;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 商品管理Entity
 * @author beyo.com.cn
 * @version 2017-07-03
 */
public class Product extends DataVo<Product> {

	private String title;		// 商品名称
	private Integer type;		// 商品类型 1单品2套餐

	private Integer  stock;		// 总库存
	private String code;		// 商品编码
	private String description;		// 商品简介
	private String url;		// 商品图片
	private Integer saleType;	//单独售卖 1是2否
	private Integer measureWay;		// 计量方式

	private String details;		// 商品详情
	private Integer sign;		// 是否需要线下签约
	private Date planTime;		// 上架时间

	private BigDecimal salePrice;	//销售价格
	private BigDecimal channelPrice;	//渠道价格
	private BigDecimal servicePrice;	//服务人员价格
	private BigDecimal price;	//商品价格


	private Date startTime;   //业务字段
	private Date endTime;
	private Integer unit;//计量单位
	private Skill skill;//关联技能项
	private ProductCategory productCategory;//商品分类

	private String productIds;

	private List<ProductSku> productSkuList; //业务字段
	private List<ProductGroup> productGroupList; //业务字段

	private Integer parentType;    //业务字段 判断这个商品是套餐中的 还是单品

	public Skill getSkill() {
		return skill;
	}

	public void setSkill(Skill skill) {
		this.skill = skill;
	}

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
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

	public Product() {
		super();
	}

	public Product(Long id){
		super(id);
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Long getPlatformId() {
		return platformId;
	}

	public void setPlatformId(Long platformId) {
		this.platformId = platformId;
	}
	
	@Length(min=0, max=215, message="商品名称长度必须介于 0 和 215 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}




	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	@Length(min=0, max=64, message="商品编码长度必须介于 0 和 64 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Length(min=0, max=215, message="商品简介长度必须介于 0 和 215 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=215, message="商品图片长度必须介于 0 和 215 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public Integer getMeasureWay() {
		return measureWay;
	}

	public void setMeasureWay(Integer measureWay) {
		this.measureWay = measureWay;
	}
	
	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}
	
	public Integer getSign() {
		return sign;
	}

	public void setSign(Integer sign) {
		this.sign = sign;
	}

	public Date getPlanTime() {
		return planTime;
	}

	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}


	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}

	public BigDecimal getChannelPrice() {
		return channelPrice;
	}

	public void setChannelPrice(BigDecimal channelPrice) {
		this.channelPrice = channelPrice;
	}

	public BigDecimal getServicePrice() {
		return servicePrice;
	}

	public void setServicePrice(BigDecimal servicePrice) {
		this.servicePrice = servicePrice;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String[] getProductIds() {
		if (null==this.productIds || "".equals(productIds))return new String[]{};
		return productIds.split(",");
	}

	public void setProductIds(String productIds) {
		this.productIds = productIds;
	}

	public Integer getSaleType() {
		return saleType;
	}

	public void setSaleType(Integer saleType) {
		this.saleType = saleType;
	}

	public void setProductSkuList(List<ProductSku> productSkuList) {
		this.productSkuList = productSkuList;
	}

	public List<ProductSku> getProductSkuList() {
		return productSkuList;
	}

	public void setProductGroupList(List<ProductGroup> productGroupList) {
		this.productGroupList = productGroupList;
	}

	public List<ProductGroup> getProductGroupList() {
		return productGroupList;
	}

	public void setParentType(Integer parentType) {
		this.parentType = parentType;
	}

	public Integer getParentType() {
		return parentType;
	}
}