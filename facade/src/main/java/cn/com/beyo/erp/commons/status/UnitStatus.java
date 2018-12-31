package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/27.
 */
public enum UnitStatus {
    /**
     * 天
     */
    DAY {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "天";
        }
    },
    /**
     * 次
     */
    SECODE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "次";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static UnitStatus[] unitStatusList(){
        return UnitStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String unitStatusName(Integer value){
        if (UnitStatus.DAY.getValue() == value){
            return UnitStatus.DAY.getName();
        } else if (UnitStatus.SECODE.getValue() == value){
            return UnitStatus.SECODE.getName();
        }else {
            return "";
        }
    }


}
