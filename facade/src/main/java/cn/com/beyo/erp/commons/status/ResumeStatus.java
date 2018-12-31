package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/21.
 */
public enum ResumeStatus {
    /**
     * 工作经验
     */
    JOBEXPERIENCE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "工作经验";
        }
    },
    /**
     * 培训学校
     */
    TRAINSCHOOL{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "教育经验";
        }
    };
    public abstract Integer getValue();

    public abstract String getName();

    public static ResumeStatus[] resumeStatusList(){
        return ResumeStatus.values();
    }

    public static String resumeStatusName(Integer value){
        if (ResumeStatus.JOBEXPERIENCE.getValue() == value){
            return ResumeStatus.JOBEXPERIENCE.getName();
        }else if (ResumeStatus.TRAINSCHOOL.getValue() == value){
            return ResumeStatus.TRAINSCHOOL.getName();
        }else {
            return "";
        }
    }
}
