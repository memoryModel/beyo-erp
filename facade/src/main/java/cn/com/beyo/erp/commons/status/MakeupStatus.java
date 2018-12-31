package cn.com.beyo.erp.commons.status;

public enum MakeupStatus {
    NOORDER{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未预约";
        }
    },
    ORDER{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已预约";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static MakeupStatus[] all(){
        return MakeupStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (MakeupStatus.NOORDER.getValue() == value){
            return MakeupStatus.NOORDER.getName();
        }else if (MakeupStatus.ORDER.getValue() == value){
            return MakeupStatus.ORDER.getName();
        }else {
            return MakeupStatus.NOORDER.getName();
        }
    }
}
