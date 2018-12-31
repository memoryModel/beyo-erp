package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum FollowStatus {
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
            return "已跟进";
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
    },
    /**
     * 是否有添加跟进记录的功能
     * */
    HAVE {  //符合跟进的规则 有添加跟进记录功能
        public Integer getValue(){return 5;}

        public String getName() {return "未跟进";}
    },
    NOHAVE {  //不符合跟进的规则 没有添加跟进记录功能
        public Integer getValue() {return 6;}

        public String getName() {return "未跟进";}
    },
    HAVECOMPLETE { //在符合跟进的规则下 已经添加完跟进记录
        public Integer getValue() {return 7;}

        public String getName() {return "已跟进";}
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static FollowStatus[] findFollowStatusList(){
        return FollowStatus.values();
    }

    public static String getFollowStatusName(Integer value){
        if (FollowStatus.NOFOLLOW.getValue() == value){
            return FollowStatus.NOFOLLOW.getName();
        }else if (FollowStatus.FOLLOW.getValue() == value){
            return FollowStatus.FOLLOW.getName();
        }else if(FollowStatus.COMPLETE.getValue() == value){
            return FollowStatus.COMPLETE.getName();
        }else if(FollowStatus.GIVEUP.getValue() == value){
            return FollowStatus.GIVEUP.getName();
        }else if(FollowStatus.HAVE.getValue() == value){
            return FollowStatus.HAVE.getName();
        }else if(FollowStatus.NOHAVE.getValue() == value){
            return FollowStatus.NOHAVE.getName();
        }else if(FollowStatus.HAVECOMPLETE.getValue() == value){
            return FollowStatus.HAVECOMPLETE.getName();
        }else {
            return "";
        }
    }
}
