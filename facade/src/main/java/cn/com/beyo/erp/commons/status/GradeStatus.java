package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2018/1/11.
 */
public enum GradeStatus {

    /**
     * 升(降)级待审批
     */
    NOAPPROVE{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "升(降)级待审批";
        }
    }
    ,
    /**
     * 已升(降)级
     */
    APPROVED{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已升(降)级";
        }
    },
    /**
     * 退回
     */
    UNAUDIT{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "退回";
        }
    },
    /**
     * 未提交
     */
    FILED{
        public Integer getValue() {
            return 3;
        }

    public String getName() {
        return "未提交";
    }
    };
    public abstract Integer getValue();

    public abstract String getName();

    public static GradeStatus[] findGradeStatusList(){
        return GradeStatus.values();
    }

    public static String getGradeStatusName(Integer value){
        if (GradeStatus.NOAPPROVE.getValue() == value){
            return GradeStatus.NOAPPROVE.getName();
        }else if (GradeStatus.APPROVED.getValue() == value){
            return GradeStatus.APPROVED.getName();
        }else if (GradeStatus.UNAUDIT.getValue() == value){
            return GradeStatus.UNAUDIT.getName();
        }else if (GradeStatus.FILED.getValue() == value){
            return GradeStatus.FILED.getName();
        } else {
            return "";
        }
    }
}
