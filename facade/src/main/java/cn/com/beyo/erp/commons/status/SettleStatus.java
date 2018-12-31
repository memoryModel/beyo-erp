package cn.com.beyo.erp.commons.status;

public enum SettleStatus {
    PRODUCT{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "按商品结算价结算";
        }
    },

    LEVEL{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "按星级日薪结算";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static SettleStatus[] all(){
        return SettleStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String find(Integer value){
        if (SettleStatus.PRODUCT.getValue() == value){
            return SettleStatus.PRODUCT.getName();
        }else if (SettleStatus.LEVEL.getValue() == value){
            return SettleStatus.LEVEL.getName();
        }else {
            return "";
        }
    }
}
