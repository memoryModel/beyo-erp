package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/12.
 */
public enum EmployeeLeaveStatus {
    /**
     * 待客户确认
     */
    WAIT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待客户确认";
        }
    }
    ,
    /**
     * 客户已驳回
     */
    REFUSE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "客户已驳回";
        }
    },
    /**
     * 待管理老师确认
     */
    AGREE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "待管理老师确认";
        }
    }
    ,
    /**
     * 已生效
     */
    EFFECT {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已生效";
        }
    }
    ,
    /**
     * 已作废
     */
    CANCELLATION {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "已作废";
        }
    };




    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static EmployeeLeaveStatus[] employeeLeaveStatusList(){
        return EmployeeLeaveStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeLeaveStatusName(Integer value){
        if(EmployeeLeaveStatus.WAIT.getValue() == value){
            return EmployeeLeaveStatus.WAIT.getName();
        }else if(EmployeeLeaveStatus.EFFECT.getValue() == value){
            return EmployeeLeaveStatus.EFFECT.getName();
        }else if (EmployeeLeaveStatus.REFUSE.getValue() == value) {
            return EmployeeLeaveStatus.REFUSE.getName();
        }else if(EmployeeLeaveStatus.CANCELLATION.getValue()==value) {
            return EmployeeLeaveStatus.CANCELLATION.getName();
        }else if(EmployeeLeaveStatus.AGREE.getValue() == value){
            return EmployeeLeaveStatus.AGREE.getName();
        }else {
            return "";
        }
    }
}
