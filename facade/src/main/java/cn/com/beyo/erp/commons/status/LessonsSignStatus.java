package cn.com.beyo.erp.commons.status;

/**
 * 上课签到状态
 * Created by Ashon on 2017/7/11.
 */
public enum LessonsSignStatus {
    /**
     * 已签到
     */
    SIGNED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "已签到";
        }
    },
    /**
     * 缺勤
     */
    NOSIGNED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "缺勤";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static LessonsSignStatus[] lessonSignStatusList(){
        return LessonsSignStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String lessonSignName(Integer value){
        if (LessonsSignStatus.SIGNED.getValue() == value){
            return LessonsSignStatus.SIGNED.getName();
        }else if (LessonsSignStatus.NOSIGNED.getValue() == value){
            return LessonsSignStatus.NOSIGNED.getName();
        }else {
            return "";
        }
    }
}
