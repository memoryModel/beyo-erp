package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum ResideStatus {
    /**
     * 未住宿
     */
    WEIZHU {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未住宿";
        }
    },
    /**
     * 已住宿
     */
    YIZHU {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已住宿";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static ResideStatus[] resideStatusList(){
        return ResideStatus.values();
    }

    public static String resideStatusName(Integer value){
        if (ResideStatus.WEIZHU.getValue() == value){
            return ResideStatus.WEIZHU.getName();
        }else if (ResideStatus.YIZHU.getValue() == value){
            return ResideStatus.YIZHU.getName();
        }else {
            return "";
        }
    }
}
