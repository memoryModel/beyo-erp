package cn.com.beyo.erp.commons.status;

public enum EmployeePayType {
    TIMING{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "固定账期结算";
        }
    },

    SPECIFY{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "T+N结算";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static EmployeePayType[] all(){
        return EmployeePayType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String find(Integer value){
        if (EmployeePayType.TIMING.getValue() == value){
            return EmployeePayType.TIMING.getName();
        }else if (EmployeePayType.SPECIFY.getValue() == value){
            return EmployeePayType.SPECIFY.getName();
        }else {
            return "";
        }
    }
}
