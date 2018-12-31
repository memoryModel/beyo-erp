package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum EmployeeCancellationStatus {
    /**
     * 待审批
     */
    PENDING {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待审批";
        }
    },
    /**
     * 已退回
     */
    NOPASS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已退回";
        }
    },
    /**
     * 已通过
     */
    PASSED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已通过";
        }
    },
    /**
     * 已通过
     */
    PASSEDEXECUTION {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "通过已执行解约";
        }

    };




    public abstract Integer getValue();

    public abstract String getName();



    public static EmployeeCancellationStatus[] employeeCancellationStatusList(){
        return EmployeeCancellationStatus.values();
    }

    public static String employeeCancellationStatusName(Integer value) {
        if (EmployeeCancellationStatus.PENDING.getValue() == value) {
            return EmployeeCancellationStatus.PENDING.getName();
        } else if (EmployeeCancellationStatus.NOPASS.getValue() == value) {
            return EmployeeCancellationStatus.NOPASS.getName();
        } else if (EmployeeCancellationStatus.PASSED.getValue() == value) {
            return EmployeeCancellationStatus.PASSED.getName();
        } else if (EmployeeCancellationStatus.PASSEDEXECUTION.getValue() == value) {
            return EmployeeCancellationStatus.PASSEDEXECUTION.getName();
        } else {
            return "";
        }
    }
}
