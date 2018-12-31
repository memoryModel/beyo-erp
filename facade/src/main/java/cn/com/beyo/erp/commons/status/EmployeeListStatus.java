package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum EmployeeListStatus {

    /**
     * 待岗
     */
    AWAIT{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待岗";
        }
    },
    /**
     * 在岗
     */
    ONGUARD{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "在岗";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static EmployeeListStatus[] employeeListStatusList(){
        return EmployeeListStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeListStatusName(Integer value){

        if (EmployeeListStatus.AWAIT.getValue() == value){
            return EmployeeListStatus.AWAIT.getName();
        }else if (EmployeeListStatus.ONGUARD.getValue() == value){
            return EmployeeListStatus.ONGUARD.getName();
        }else {
            return "";
        }
    }
}
