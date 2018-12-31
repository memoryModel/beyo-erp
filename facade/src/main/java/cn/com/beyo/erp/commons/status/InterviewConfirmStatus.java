package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:cem_interview 字段名:interview_status
 * 面试管理：面试确认状态
 * 1、已面试
 * 2、未面试
 */
public enum InterviewConfirmStatus {
    /**
     *未面试
     */

    TOBEFIRMED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "未面试";
        }
    },
    /**
     * 已面试
     */
    FIRMED {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已面试";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static InterviewConfirmStatus[] interviewConfirmList(){
        return InterviewConfirmStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String interviewConfirmName(Integer value){
        if (InterviewConfirmStatus.TOBEFIRMED.getValue() == value){
            return InterviewConfirmStatus.TOBEFIRMED.getName();
        }else if (InterviewPlanStatus.FIRMED.getValue() == value){
            return InterviewPlanStatus.FIRMED.getName();
        }else {
            return "";
        }
    }
}
