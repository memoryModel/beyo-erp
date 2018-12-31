package cn.com.beyo.erp.commons.status;

/**
 * Created by Ashon on 2017/7/3.
 */
public enum ReceivableBillStatus {
    /**
     * 未结清
     */
    UNCLEARED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未结清";
        }
    },
    /**
     * 已结清
     */
    CLEARED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已结清";
        }
    },
    /**
     * 账单挂起
     */
    SUSPENDED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "账单挂起";
        }
    },
    /**
     * 已确认
     */
    CONFIRMED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已确认";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();

    public static ReceivableBillStatus[] receivableBillList(){
        return ReceivableBillStatus.values();
    }

    public static String receivableBillName(Integer value){
        if (ReceivableBillStatus.UNCLEARED.getValue() == value){
            return ReceivableBillStatus.UNCLEARED.getName();
        }else if (ReceivableBillStatus.CLEARED.getValue() == value){
            return ReceivableBillStatus.CLEARED.getName();
        }else if(ReceivableBillStatus.SUSPENDED.getValue() == value){
            return ReceivableBillStatus.SUSPENDED.getName();
        }else if(ReceivableBillStatus.CONFIRMED.getValue() == value){
            return ReceivableBillStatus.CONFIRMED.getName();
        }else {
            return "";
        }
    }
}
