package cn.com.beyo.erp.commons.status;

public enum EmployeeType {
    WORK{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "劳务制";
        }
    },

    JOB{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "员工制";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static EmployeeType[] employeeTypeList(){
        return EmployeeType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeTypeName(Integer value){
        if (EmployeeType.WORK.getValue() == value){
            return EmployeeType.WORK.getName();
        }else if (EmployeeType.JOB.getValue() == value){
            return EmployeeType.JOB.getName();
        }else {
            return "";
        }
    }
}
