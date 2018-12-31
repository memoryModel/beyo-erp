package cn.com.beyo.erp.commons.status;

/**
 * 签约管理
 * 未用！！
 */
public enum EmployeeEntryStatus {
    /**
     * 未提交
     */
    FILED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未提交";
        }
    },
    /**
     * 已退回
     */
    UNAUDIT {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已退回";
        }
    },
    /*
    * 提交未审批
    * */
    FILEDAPPROVE{
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "提交未审批";
        }
    },
    /*
    * 审批通过
    * */
    APPROVEPASS{
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "审批通过";
        }
    }
    ;


    public abstract Integer getValue();

    public abstract String getName();


    public static EmployeeEntryStatus[] employeeEntryList(){
        return EmployeeEntryStatus.values();
    }

    public static String employeeEntryName(Integer value){
        if (EmployeeEntryStatus.FILED.getValue() == value || value == null ){
            return EmployeeEntryStatus.FILED.getName();
        }else if (EmployeeEntryStatus.UNAUDIT.getValue() == value) {
            return EmployeeEntryStatus.UNAUDIT.getName();
        }else if (EmployeeEntryStatus.FILEDAPPROVE.getValue() == value) {
            return EmployeeEntryStatus.FILEDAPPROVE.getName();
        }else if (EmployeeEntryStatus.APPROVEPASS.getValue() == value){
            return EmployeeEntryStatus.APPROVEPASS.getName();
        }else {
            return "";
        }
    }
}
