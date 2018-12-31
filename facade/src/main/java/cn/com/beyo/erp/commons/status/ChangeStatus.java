package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum ChangeStatus {
    /**
     * 未跟进
     */
    NOFOLLOW {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未跟进";
        }
    },
    /**
     * 跟进中
     */
    FOLLOW {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "跟进中";
        }
    },
    /**
     * 已完成
     */
    COMPLETE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已完成";
        }
    },
    /**
     * 已放弃
     */
    GIVEUP {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已放弃";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();





    public static ChangeStatus[] changeStatusList(){
        return ChangeStatus.values();
    }

    public static String changeStatusName(Integer value){
        if (ChangeStatus.NOFOLLOW.getValue() == value){
            return ChangeStatus.NOFOLLOW.getName();
        }else if (ChangeStatus.FOLLOW.getValue() == value){
            return ChangeStatus.FOLLOW.getName();
        }else if(ChangeStatus.COMPLETE.getValue() == value){
            return ChangeStatus.COMPLETE.getName();
        }else if(ChangeStatus.GIVEUP.getValue() == value){
            return ChangeStatus.GIVEUP.getName();
        }else {
            return "";
        }
    }
}
