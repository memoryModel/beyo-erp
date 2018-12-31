package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum InterviewSubmitStatus {
    /**
     * 未提交
     */
    PASS {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未提交";
        }
    },
    /**
     * 已提交
     */
    NOPASS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已提交";
        }
    };




    public abstract Integer getValue();

    public abstract String getName();



    public static InterviewSubmitStatus[] interviewSubmitStatusList(){
        return InterviewSubmitStatus.values();
    }

    public static String interviewSubmitStatusName(Integer value) {
        if (InterviewSubmitStatus.PASS.getValue() == value) {
            return InterviewSubmitStatus.PASS.getName();
        } else if (InterviewSubmitStatus.NOPASS.getValue() == value) {
            return InterviewSubmitStatus.NOPASS.getName();
        } else {
            return "";
        }
    }
}
