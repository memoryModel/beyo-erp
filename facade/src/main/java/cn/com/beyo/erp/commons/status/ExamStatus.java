package cn.com.beyo.erp.commons.status;

public enum ExamStatus {
    NORMAL {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "普通";
        }
    },
    MAKEUP {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "补考";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static ExamStatus[] all(){
        return ExamStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ExamStatus.NORMAL.getValue() == value){
            return ExamStatus.NORMAL.getName();
        }else if (ExamStatus.MAKEUP.getValue() == value){
            return ExamStatus.MAKEUP.getName();
        }else {
            return ExamStatus.NORMAL.getName();
        }
    }
}
