package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2018/1/11.
 */
public enum UpgradeType {
    /**
     * 定级
     */
    BEFOREUPGRADE{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "定级";
        }
    },
    /**
     * 升降级
     */
    AFTERUPGRADE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "升降级";
        }
    }
    ,
    /**
     * 最新升级
     */
    NEWESTUPGRADE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "最新升降级";
        }
    };
    public abstract Integer getValue();

    public abstract String getName();

    public static UpgradeType[] findUpgradeNameList(){
        return UpgradeType.values();
    }

    public static String getUpgradeTypeName(Integer value){
        if (UpgradeType.BEFOREUPGRADE.getValue() == value){
            return UpgradeType.BEFOREUPGRADE.getName();
        }else if (UpgradeType.AFTERUPGRADE.getValue() == value){
            return UpgradeType.AFTERUPGRADE.getName();
        }else if (UpgradeType.NEWESTUPGRADE.getValue() == value){
            return UpgradeType.NEWESTUPGRADE.getName();
        }else {
            return "";
        }
    }
}
