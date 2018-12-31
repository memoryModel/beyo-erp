package cn.com.beyo.erp.commons.status;

public enum BasePayStatus {
    BASE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "有底薪";
        }
    },

    EMPTY{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "无底薪";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static BasePayStatus[] basePayStatusList(){
        return BasePayStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String basePayStatusName(Integer value){
        if (BasePayStatus.BASE.getValue() == value){
            return BasePayStatus.BASE.getName();
        }else if (BasePayStatus.EMPTY.getValue() == value){
            return BasePayStatus.EMPTY.getName();
        }else {
            return "";
        }
    }
}
