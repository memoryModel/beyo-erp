package cn.com.beyo.erp.commons.status;

public enum  ExamRuleType {
    IDENTICAL{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "每个学员相同试卷";
        }
    },
    /**
     * 健康证
     */
    RANDOM{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "每个学员随机试卷";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static ExamRuleType[] all(){
        return ExamRuleType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ExamRuleType.IDENTICAL.getValue() == value){
            return ExamRuleType.IDENTICAL.getName();
        }else if (ExamRuleType.RANDOM.getValue() == value){
            return ExamRuleType.RANDOM.getName();
        }else {
            return "";
        }
    }
}
