package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum StudentStatus {
    /**
     * 未读
     */
    UNREAD {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未读";
        }
    },
    /**
     * 停用
     */
    DISABLE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "停用";
        }
    },
    /**
     * 在读
     */
    STUDY {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "在读";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static StudentStatus[] studentStatusList(){
        return StudentStatus.values();
    }

    public static String studentStatusName(Integer value){
        if (StudentStatus.UNREAD.getValue() == value) {
            return StudentStatus.UNREAD.getName();
        }else if (StudentStatus.DISABLE.getValue() == value){
            return StudentStatus.DISABLE.getName();
        }else if (StudentStatus.STUDY.getValue() == value){
            return StudentStatus.STUDY.getName();
        }else {
            return "";
        }
    }
}
