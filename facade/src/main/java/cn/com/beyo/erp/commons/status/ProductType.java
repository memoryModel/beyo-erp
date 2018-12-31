package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/14.
 * product.type
 */
public enum  ProductType {
    /**
     * 单独售卖
     */
    SINGLE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "单品";
        }
    },
    /**
     * 套餐组合
     */
    GROUP {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "套餐";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ProductType[] all(){
        return ProductType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ProductType.SINGLE.getValue() == value){
            return ProductType.SINGLE.getName();
        }else if (ProductType.GROUP.getValue() == value){
            return ProductType.GROUP.getName();
        }else {
            return "";
        }
    }
}
