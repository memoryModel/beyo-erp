package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum EmployeeStatus {
    /**
     * 在职
     */
    WAIT {
        public Integer getValue() {
            return 6;
        }

        public String getName() {
            return "在职";
        }
    },
    LEAVE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已离职";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static EmployeeStatus[] employeeStatusList(){
        return EmployeeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeStatusName(Integer value){
        if (EmployeeStatus.WAIT.getValue() == value){
            return EmployeeStatus.WAIT.getName();
        }else if (EmployeeStatus.LEAVE.getValue() == value){
            return EmployeeStatus.LEAVE.getName();
        }else {
            return "";
        }
    }
}
