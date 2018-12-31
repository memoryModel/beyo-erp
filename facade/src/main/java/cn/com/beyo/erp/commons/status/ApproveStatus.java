package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/18.
 */
public enum ApproveStatus {
    /**
     * 待审批
     */
    APPROVEB {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待审批";
        }
    },
    /**
     * 已通过
     */
    PASS{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已通过";
        }
    },
    /**
     * 已驳回
     */
    REJECTED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已驳回";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();





    public static ApproveStatus[] approveStatusList(){
        return ApproveStatus.values();
    }

    public static String approveStatusName(Integer value) {
        if (ApproveStatus.APPROVEB.getValue() == value) {
            return ApproveStatus.APPROVEB.getName();
        } else if (ApproveStatus.PASS.getValue() == value) {
            return ApproveStatus.PASS.getName();
        } else if (ApproveStatus.REJECTED.getValue() == value) {
            return ApproveStatus.REJECTED.getName();
        } else {
            return "";
        }
    }
}
