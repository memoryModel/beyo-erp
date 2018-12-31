package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum BabyStatus {
    /**
     * 有
     */
    YES {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "有";
        }
    },
    /**
     * 无
     */
    NO {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "无";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    public static BabyStatus[] babyStatusList(){
        return BabyStatus.values();
    }

    public static String babyStatusName(Integer value){
        if (BabyStatus.YES.getValue() == value){
            return BabyStatus.YES.getName();
        }else if (BabyStatus.NO.getValue() == value){
            return BabyStatus.NO.getName();
        }else {
            return "";
        }
    }
}
