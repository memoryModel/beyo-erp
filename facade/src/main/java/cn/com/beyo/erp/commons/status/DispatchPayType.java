package cn.com.beyo.erp.commons.status;

/**
 * 服务结算方式--上户管理
 * Dispatch.payType
 * Created by Ashon on 2017/9/06.
 */
public enum DispatchPayType {
    /**
     * 按服务人员结算价结
     */
    BYEMPLOYEE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "按服务人员结算价结";
        }
    },
    /**
     * 按商品结算价结算
     */
    BYSALE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "按商品结算价结算";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchPayType[] dispatchPayTypeList(){
        return DispatchPayType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchPayTypeName(Integer value){
        if (DispatchPayType.BYEMPLOYEE.getValue() == value){
            return DispatchPayType.BYEMPLOYEE.getName();
        }else if (DispatchPayType.BYSALE.getValue() == value){
            return DispatchPayType.BYSALE.getName();
        }else {
            return "";
        }
    }
}
