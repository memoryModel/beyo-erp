package cn.com.beyo.erp.commons.status;

/**
 * 课表状态
 * Created by Ashon on 2017/7/11.
 */
public enum ScheduleStatus {
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
    },
    /**
     * 逻辑删除
     */
    DELETE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "逻辑删除";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ScheduleStatus[] scheduleStatusList(){
        return ScheduleStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String scheduleStatusName(Integer value){
        if (ScheduleStatus.NOCLASSES.getValue() == value){
            return ScheduleStatus.NOCLASSES.getName();
        }else if (ScheduleStatus.HAVECLASSES.getValue() == value){
            return ScheduleStatus.HAVECLASSES.getName();
        }else if (ScheduleStatus.DELETE.getValue() == value){
            return ScheduleStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}
