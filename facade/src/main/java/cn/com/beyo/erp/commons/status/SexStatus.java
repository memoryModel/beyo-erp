package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum SexStatus {
    /**
     * 男
     */
    MEN {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "男";
        }
    },
    /**
     * 女
     */
    WOMEN {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "女";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static SexStatus[] sexStatusList(){
        return SexStatus.values();
    }

    public static String sexStatusName(Integer value){
        if (SexStatus.MEN.getValue() == value){
            return SexStatus.MEN.getName();
        }else if (SexStatus.WOMEN.getValue() == value){
            return SexStatus.WOMEN.getName();
        }else {
            return "";
        }
    }
}
