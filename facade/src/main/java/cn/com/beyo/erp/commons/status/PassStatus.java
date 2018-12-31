package cn.com.beyo.erp.commons.status;

/**
 * 及格标记
 *  2017/7/20.
 */
public enum PassStatus {
    NOPASS {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "不及格";
        }
    },
    PASS{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "及格";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static PassStatus[] passStatusList(){
        return PassStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String passStatusName(Integer value){
        if (PassStatus.PASS.getValue() == value){
            return PassStatus.PASS.getName();
        }else if (PassStatus.NOPASS.getValue() == value){
            return PassStatus.NOPASS.getName();
        }else {
            return "";
        }
    }
}
