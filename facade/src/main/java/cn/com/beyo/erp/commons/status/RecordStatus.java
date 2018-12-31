package cn.com.beyo.erp.commons.status;

public enum RecordStatus {

    /**
     * 最新记录
     */
    NEW {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "最新记录";
        }
    },
    /**
     * 之前的记录
     */
    OLD {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "之前的记录";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RecordStatus[] findRecordStatusList(){
        return RecordStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (RecordStatus.NEW.getValue() == value){
            return RecordStatus.NEW.getName();
        }else if (RecordStatus.OLD.getValue() == value){
            return RecordStatus.OLD.getName();
        }else {
            return "";
        }
    }
}
