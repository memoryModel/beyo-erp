package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum ExpendStatus {
    /**
     * 已确认
     */
    ALREADY{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "已确认";
        }
    },

    /**
     * 未确认
     */
    NOT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未确认";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();





    public static ExpendStatus[] expendStatusList(){
        return ExpendStatus.values();
    }

    public static String expendStatusName(Integer value){
        if (ExpendStatus.NOT.getValue() == value){
            return ExpendStatus.NOT.getName();
        }else if (ExpendStatus.ALREADY.getValue() == value){
            return ExpendStatus.ALREADY.getName();
        }else {
            return "";
        }
    }
}
