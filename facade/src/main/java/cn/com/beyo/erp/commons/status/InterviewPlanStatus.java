package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:cem_interview 字段名:interview_status
 * 面试管理：面试计划状态
 * 0、待确认
 * 1、已确认
 * 2、已放弃
 */
public enum InterviewPlanStatus {
    /**
     *待确认
     */
    TOBEFIRMED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待确认";
        }
    },
    /**
     * 已确认
     */
    FIRMED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已确认";
        }

    },
    /**
     * 已放弃
     */
    ABANDON {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已放弃";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static InterviewPlanStatus[] interviewPlanList(){
        return InterviewPlanStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String interviewPlanName(Integer value){
        if (InterviewPlanStatus.TOBEFIRMED.getValue() == value){
            return InterviewPlanStatus.TOBEFIRMED.getName();
        }else if (InterviewPlanStatus.FIRMED.getValue() == value){
            return InterviewPlanStatus.FIRMED.getName();
        }else if (InterviewPlanStatus.ABANDON.getValue() == value){
            return InterviewPlanStatus.ABANDON.getName();
        }else {
            return "";
        }
    }
}
