package cn.com.beyo.erp.commons.status;

/**
 * 收款单状态
 * Created by Ashon on 2017/7/3.
 */
public enum BillStatus {
    /**
     * 未确认
     */
    UNCONFIRMED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未确认";
        }
    },
    /**
     * 已确认
     */
    CONFIRMED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已确认";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    /**
     * 返回收款单状态列表
     * */
    public static BillStatus[] billStatusList(){
        return BillStatus.values();
    }

    /**
     * 查找返回收款单状态名称
     * */
    public static String billStatusName(Integer value){
        if (BillStatus.UNCONFIRMED.getValue() == value){
            return BillStatus.UNCONFIRMED.getName();
        }else if (BillStatus.CONFIRMED.getValue() == value){
            return BillStatus.CONFIRMED.getName();
        }else {
            return "";
        }
    }

}
