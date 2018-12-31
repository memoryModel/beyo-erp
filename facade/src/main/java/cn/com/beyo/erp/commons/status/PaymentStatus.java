package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum PaymentStatus {
    /**
     * 已付款
     */
    ALREADY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "已付款";
        }
    },
    /**
     * 未付款
     */
    NOT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未付款";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();





    public static PaymentStatus[] paymentStatusList(){
        return PaymentStatus.values();
    }

    public static String paymentStatusName(Integer value){
        if (PaymentStatus.NOT.getValue() == value){
            return PaymentStatus.NOT.getName();
        }else if (PaymentStatus.ALREADY.getValue() == value){
            return PaymentStatus.ALREADY.getName();
        }else {
            return "";
        }
    }
}
