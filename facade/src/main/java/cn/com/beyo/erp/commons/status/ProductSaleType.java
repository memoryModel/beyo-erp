package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/14.
 *
 * product.sale_type
 */
public enum ProductSaleType {

    SINGLE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "是";
        }
    },

    NOSINGLE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "否";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ProductSaleType[] all(){
        return ProductSaleType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ProductSaleType.SINGLE.getValue() == value){
            return ProductSaleType.SINGLE.getName();
        }else if (ProductSaleType.NOSINGLE.getValue() == value){
            return ProductSaleType.NOSINGLE.getName();
        }else {
            return "";
        }
    }
}
