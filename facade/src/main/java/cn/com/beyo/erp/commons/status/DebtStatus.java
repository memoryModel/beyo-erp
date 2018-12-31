package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum DebtStatus {
    /**
     * 有欠款
     */
    DEBT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "有底薪";
        }
    },
    /**
     * 无欠款
     */
    NODEBT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "无底薪";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    public static DebtStatus[] debtStatusList(){
        return DebtStatus.values();
    }

    public static String debtStatusName(Integer value){
        if (DebtStatus.DEBT.getValue() == value){
            return DebtStatus.DEBT.getName();
        }else if (DebtStatus.NODEBT.getValue() == value){
            return DebtStatus.NODEBT.getName();
        }else {
            return "";
        }
    }
}
