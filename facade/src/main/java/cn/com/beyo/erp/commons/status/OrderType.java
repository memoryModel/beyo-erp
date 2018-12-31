package cn.com.beyo.erp.commons.status;

/**
 * 订单类别
 * Created by Ashon on 2017/07/18.
 */
public enum OrderType {
    /**
     * 培训订单
     */
    TRAIN {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "培训订单";
        }
    },
    /**
     * 服务订单
     */
    SERVICE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "服务订单";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static OrderType[] orderTypeList(){
        return OrderType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String orderTypeName(Integer value){
        if (OrderType.TRAIN.getValue() == value){
            return OrderType.TRAIN.getName();
        }else if (OrderType.SERVICE.getValue() == value){
            return OrderType.SERVICE.getName();
        }else {
            return "";
        }
    }
}
