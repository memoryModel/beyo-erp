package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum InterviewStatus {
    /**
     * 通过
     */
    PASS {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "通过";
        }
    },
    /**
     * 未通过
     */
    NOPASS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未通过";
        }
    },

    /**
     * 待定
     */
    UNDERERMINDE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "待定";
        }
    /*},
    *//**
     * 删除
     *//*
    DELETE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "删除";
        }*/
    };




    public abstract Integer getValue();

    public abstract String getName();



    public static InterviewStatus[] interviewStatusList(){
        return InterviewStatus.values();
    }

    public static String interviewStatusName(Integer value) {
        if (InterviewStatus.PASS.getValue() == value) {
            return InterviewStatus.PASS.getName();
        } else if (InterviewStatus.NOPASS.getValue() == value) {
            return InterviewStatus.NOPASS.getName();
        } else if (InterviewStatus.UNDERERMINDE.getValue() == value) {
            return InterviewStatus.UNDERERMINDE.getName();
       /* } else if (InterviewStatus.DELETE.getValue() == value) {
            return InterviewStatus.DELETE.getName();*/
        } else {
            return "";
        }
    }
}
