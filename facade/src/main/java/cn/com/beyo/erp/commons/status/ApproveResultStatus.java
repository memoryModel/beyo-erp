package cn.com.beyo.erp.commons.status;

/**
 * 升降级管理 crm_employee_level_approve 对应字段approve_result
 * Created by Thinkpad on 2018/1/14.
 */
public enum ApproveResultStatus {
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



    public static ApproveResultStatus[] findApproveResultList(){
        return ApproveResultStatus.values();
    }

    public static String getApproveResultName(Integer value) {
        if (ApproveResultStatus.PASS.getValue() == value) {
            return ApproveResultStatus.PASS.getName();
        } else if (ApproveResultStatus.NOPASS.getValue() == value) {
            return ApproveResultStatus.NOPASS.getName();
        } else {
            return "";
        }
    }
}
