package cn.com.beyo.erp.commons.status;

public enum FeeStatus {
    /**
     * 未结清
     */
    UNCLEARED{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未结清";
        }
    },
    /**
     * 已结清
     */
    FINISH {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已结清";
        }
    },
    /**
     * 已退费
     */
    REFUND {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已退费";
        }
    };




    public abstract Integer getValue();

    public abstract String getName();



    public static FeeStatus[] all(){
        return FeeStatus.values();
    }

    public static String findName(Integer value) {
        if (FeeStatus.UNCLEARED.getValue() == value) {
            return FeeStatus.UNCLEARED.getName();
        } else if (FeeStatus.FINISH.getValue() == value) {
            return FeeStatus.FINISH.getName();
        } else if (FeeStatus.REFUND.getValue() == value) {
            return FeeStatus.REFUND.getName();
        } else {
            return "";
        }
    }
}
