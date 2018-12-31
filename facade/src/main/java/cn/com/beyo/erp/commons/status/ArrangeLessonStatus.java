package cn.com.beyo.erp.commons.status;

/**
 * 补课状态
 *  on 2017/7/24.
 */
public enum ArrangeLessonStatus {
    /**
     * 未安排补课
     */
    NOMAKEUP {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未安排补课";
        }
    },
    /**
     * 已安排补课
     */
    MAKEUP {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已安排补课";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    /**
     * 返回补课状态列表
     * */
    public static ArrangeLessonStatus[] lessonStatusList(){
        return ArrangeLessonStatus.values();
    }

    /**
     * 查找返回补课状态名称
     * */
    public static String lessonStatusName(Integer value){
        if (ArrangeLessonStatus.NOMAKEUP.getValue() == value){
            return ArrangeLessonStatus.NOMAKEUP.getName();
        }else if (ArrangeLessonStatus.MAKEUP.getValue() == value){
            return ArrangeLessonStatus.MAKEUP.getName();
        } else {
            return "";
        }
    }

}
