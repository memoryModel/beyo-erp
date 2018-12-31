package cn.com.beyo.erp.commons.status;

public enum ExamQuestionType {
    SINGLE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "单选";
        }
    },

    MULTI{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "多选";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static ExamQuestionType[] all(){
        return ExamQuestionType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ExamQuestionType.SINGLE.getValue() == value){
            return ExamQuestionType.SINGLE.getName();
        }else if (ExamQuestionType.MULTI.getValue() == value){
            return ExamQuestionType.MULTI.getName();
        }else {
            return "";
        }
    }
}
