package cn.com.beyo.erp.commons.status;

public enum  ExamStoreType {
    THEORY{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "理论考试";
        }
    },
    /**
     * 健康证
     */
    ACTUAL{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "实操考试";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static ExamStoreType[] all(){
        return ExamStoreType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ExamStoreType.THEORY.getValue() == value){
            return ExamStoreType.THEORY.getName();
        }else if (ExamStoreType.ACTUAL.getValue() == value){
            return ExamStoreType.ACTUAL.getName();
        }else {
            return "";
        }
    }
}
