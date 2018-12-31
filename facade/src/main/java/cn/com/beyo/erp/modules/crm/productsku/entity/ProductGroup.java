package cn.com.beyo.erp.modules.crm.productsku.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;

/**
 * Created by wanghw on 2017/7/17.
 */
public class ProductGroup extends DataVo<ProductGroup> {
    private Long productId;		// 商品id
    private Long productItemId;
    private Long skuId;		// sku id

    private ProductSku productSku;  //业务字段

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getSkuId() {
        return skuId;
    }

    public void setSkuId(Long skuId) {
        this.skuId = skuId;
    }

    public Long getProductItemId() {
        return productItemId;
    }

    public void setProductItemId(Long productItemId) {
        this.productItemId = productItemId;
    }


    public void setProductSku(ProductSku productSku) {
        this.productSku = productSku;
    }

    public ProductSku getProductSku() {
        return productSku;
    }
}
