package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum ApprovedRenewStatus {
    /**
     * 审批通过
     */
    PASS {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "审批通过";
        }
    },
    /**
     * 退回
     */
    NOPASS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "退回";
        }

    };




    public abstract Integer getValue();

    public abstract String getName();



    public static ApprovedRenewStatus[] approvedRenewList(){
        return ApprovedRenewStatus.values();
    }

    public static String approvedRenewName(Integer value) {
        if (ApprovedRenewStatus.PASS.getValue() == value) {
            return ApprovedRenewStatus.PASS.getName();
        } else if (ApprovedRenewStatus.NOPASS.getValue() == value) {
            return ApprovedRenewStatus.NOPASS.getName();
        } else {
            return "";
        }
    }
}
