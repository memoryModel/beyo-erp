package cn.com.beyo.erp.commons.status;

/**
 * 上课签到状态
 * Created by Ashon on 2017/7/11.
 */
public enum LessonsStatus {
    /**
     * 未开课
     */
    NOCLASSES {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未开课";
        }
    },
    /**
     * 已开课
     */
    HAVECLASSES {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已开课";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static LessonsStatus[] lessonsStatusList(){
        return LessonsStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String lessonsStatusName(Integer value){
        if (LessonsStatus.NOCLASSES.getValue() == value){
            return LessonsStatus.NOCLASSES.getName();
        }else if (LessonsStatus.HAVECLASSES.getValue() == value){
            return LessonsStatus.HAVECLASSES.getName();
        }else {
            return "";
        }
    }
}
