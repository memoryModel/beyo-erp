package cn.com.beyo.erp.commons.status;

/**工资结算状态
 * Created by jiayw on 2017/09/21.
 */
public enum EmployeePayRecordStatus {
    /**
     * 待确认工资
     */
    WAITPAY {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待确认工资";
        }
    },
    /**
     * 待结算工资
     */
    SETTLEPAY {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "待结算工资";
        }
    },
    /**
     * 已结算工资
     */
    EFFECTPAY {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已结算工资";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();





    public static EmployeePayRecordStatus[] employeePayRecordStatusList(){
        return EmployeePayRecordStatus.values();
    }

    public static String EmployeePayRecordStatusName(Integer value){
        if (EmployeePayRecordStatus.WAITPAY.getValue() == value){
            return EmployeePayRecordStatus.WAITPAY.getName();
        }else if (EmployeePayRecordStatus.SETTLEPAY.getValue() == value){
            return EmployeePayRecordStatus.SETTLEPAY.getName();
        }else if(EmployeePayRecordStatus.EFFECTPAY.getValue() == value){
            return EmployeePayRecordStatus.EFFECTPAY.getName();
        }else {
            return "";
        }
    }
}
