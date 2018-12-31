/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.crm.productsku.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.product.entity.Product;
import cn.com.beyo.erp.modules.crm.productcategory.entity.ProductCategory;
import cn.com.beyo.erp.modules.crm.serivcelevel.entity.ServiceLevel;
import cn.com.beyo.erp.modules.crm.skill.entity.Skill;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 商品SKUEntity
 * @author wanghw
 * @version 2017-07-13
 */
public class ProductSku extends DataVo<ProductSku> {

	private Long productId;		// 商品id
	private Long categoryId;	// 商品分类id
	private Long skillId;		// 技能id
	private Long levelId;		// 星级id
	private String code;
	private Integer unit;		// 单位
	private Integer single;		// 单独还是组合
	private Integer minStock;		// 最小售卖数量
	private Integer maxStock;		// 最大售卖数量
	private Integer saleStockNumber;//	售卖数量
	private BigDecimal price;		// 销售价格
	private BigDecimal salePrice;		// 销售单价
	private BigDecimal channelPrice;		// 渠道结算单价
	private BigDecimal servicePrice;		// 服务人员结算价
	private Integer stock;		// 库存

	private Product product;
	private Skill skill;//关联技能项
	private ProductCategory productCategory;//商品分类
	private ServiceLevel serviceLevel;

	private Date startTime;
	private Date endTime;
	private String skuIds;
	private String productIds;

	private BigDecimal itemPrice;
	private Integer sum;

	private String skillName;  //业务字段 技能名称
	private String measureWayName; //业务字段 计量方式名称
	private String levelName;  //业务字段 技能等级名称

	public ProductSku() {
		super();
	}
	public ProductSku(Long id){
		super(id);
	}

	@JsonSerialize(using=ToStringSerializer.class)
	@NotNull(message="商品id不能为空")
	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	@NotNull(message="技能id不能为空")
	public Long getSkillId() {
		return skillId;
	}

	public void setSkillId(Long skillId) {
		this.skillId = skillId;
	}

	@JsonSerialize(using=ToStringSerializer.class)
	@NotNull(message="星级id不能为空")
	public Long getLevelId() {
		return levelId;
	}

	public void setLevelId(Long levelId) {
		this.levelId = levelId;
	}
	
	@Length(min=1, max=1, message="单位长度必须介于 1 和 1 之间")
	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}
	
	@Length(min=1, max=30, message="最小售卖数量长度必须介于 1 和 30 之间")
	public Integer getMinStock() {
		return minStock;
	}

	public void setMinStock(Integer minStock) {
		this.minStock = minStock;
	}
	
	@Length(min=1, max=30, message="最大售卖数量长度必须介于 1 和 30 之间")
	public Integer getMaxStock() {
		return maxStock;
	}

	public void setMaxStock(Integer maxStock) {
		this.maxStock = maxStock;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
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

	@Length(min=1, max=20, message="库存长度必须介于 1 和 20 之间")
	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public Integer getSingle() {
		return single;
	}

	public void setSingle(Integer single) {
		this.single = single;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

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

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public ServiceLevel getServiceLevel() {
		return serviceLevel;
	}

	public void setServiceLevel(ServiceLevel serviceLevel) {
		this.serviceLevel = serviceLevel;
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

	public String[] getSkuIds() {
		if (null==this.skuIds || "".equals(skuIds))return new String[]{};
		return skuIds.split(",");
	}

	public void setSkuIds(String skuIds) {
		this.skuIds = skuIds;
	}

	public String[] getProductIds() {
		if (null==this.productIds || "".equals(productIds))return new String[]{};
		return productIds.split(",");
	}

	public void setProductIds(String productIds) {
		this.productIds = productIds;
	}

	public BigDecimal getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(BigDecimal itemPrice) {
		this.itemPrice = itemPrice;
	}

	public Integer getSum() {
		return sum;
	}

	public void setSum(Integer sum) {
		this.sum = sum;
	}

	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}

	public String getSkillName() {
		return skillName;
	}

	public void setMeasureWayName(String measureWayName) {
		this.measureWayName = measureWayName;
	}

	public String getMeasureWayName() {
		return measureWayName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setSaleStockNumber(Integer saleStockNumber) {
		this.saleStockNumber = saleStockNumber;
	}

	public Integer getSaleStockNumber() {
		return saleStockNumber;
	}
}