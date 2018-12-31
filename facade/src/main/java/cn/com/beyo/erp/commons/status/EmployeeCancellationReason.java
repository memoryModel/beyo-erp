package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:cem_interview 字段名:interview_status
 * 面试管理：面试确认状态
 * 0、合同到期
 * 1、辞退
 * 2、自动离职
 * 3、其他
 */
public enum EmployeeCancellationReason {
    /**
     *合同到期
     */

    CONTRACTMATURITY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "合同到期";
        }
    },
    /**
     * 辞退
     */
    DISMISS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "辞退";
        }
    },
    /**
     * 自动离职
     */
    LEAVEAUTOMATICALLY {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "自动离职";
        }
    },
    /**
     * 其他
     */
    OTHER {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "其他";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static EmployeeCancellationReason[] employeeCancellationList(){
        return EmployeeCancellationReason.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeCancellationName(Integer value){
        if (EmployeeCancellationReason.CONTRACTMATURITY.getValue() == value){
            return EmployeeCancellationReason.CONTRACTMATURITY.getName();
        }else if (EmployeeCancellationReason.DISMISS.getValue() == value){
            return EmployeeCancellationReason.DISMISS.getName();
        }else if (EmployeeCancellationReason.LEAVEAUTOMATICALLY.getValue() == value){
            return EmployeeCancellationReason.LEAVEAUTOMATICALLY.getName();
        }else if (EmployeeCancellationReason.OTHER.getValue() == value){
            return EmployeeCancellationReason.OTHER.getName();
        }else {
            return "";
        }
    }
}
