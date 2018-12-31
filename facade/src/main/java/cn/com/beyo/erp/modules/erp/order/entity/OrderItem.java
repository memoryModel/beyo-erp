package cn.com.beyo.erp.modules.erp.order.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;
import cn.com.beyo.erp.modules.crm.product.entity.Product;
import cn.com.beyo.erp.modules.crm.productsku.entity.ProductSku;

import java.math.BigDecimal;

/**
 * Created by wanghw on 2017/7/21.
 */
public class OrderItem extends DataVo<OrderItem> {

    private Order order;
    private Product parentProduct;
    private Product product;
    private ProductSku productSku;

    private Integer num;
    private BigDecimal salePrice;
    private BigDecimal amount;

    private Integer usedNum;

    //预约上户 业务字段
    private Integer dispatchNum;//预约次数
    //private Integer canRepetition;//是否可以重复派工   0.是  1.否


    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public ProductSku getProductSku() {
        return productSku;
    }

    public void setProductSku(ProductSku productSku) {
        this.productSku = productSku;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Integer getUsedNum() {
        return usedNum;
    }

    public void setUsedNum(Integer usedNum) {
        this.usedNum = usedNum;
    }

    public Integer getDispatchNum() {
        return dispatchNum;
    }

    public void setDispatchNum(Integer dispatchNum) {
        this.dispatchNum = dispatchNum;
    }

    public void setParentProduct(Product parentProduct) {
        this.parentProduct = parentProduct;
    }

    public Product getParentProduct() {
        return parentProduct;
    }
}
