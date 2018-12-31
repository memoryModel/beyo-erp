package cn.com.beyo.erp.commons.status;

/**
 * 入职管理--ApprovebStatus
 * Created by Thinkpad on 2017/12/19.
 */
public enum ApprovebStatus {
    /**
     * 签约未提交
     */
    FILED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未提交";
        }
    },
    /**
     * 签约已提交
     */
    PASS {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已提交";
        }
    },
    /**
     * 签约已退回
     */
    REJECTED{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已退回";
        }

    },
    /**
     * 入职未提交
     */
    ENTRYFILED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "未提交";
        }
    },
    /**
     * 入职已退回
     */
    ENTRYUNAUDIT {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已退回";
        }
    },
    /*
    * 入职提交未审批
    * */
    ENTRYFILEDAPPROVE{
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "提交未审批";
        }
    },
    /*
    * 入职审批通过(为在职 EmployeeStatus)
    * */
    ENTRYAPPROVEPASS{
        public Integer getValue() {
            return 6;
        }

        public String getName() {
            return "审批通过";
        }
    },
    /*
    * 已离职
    * */
    LEAVE {
        public Integer getValue() {
            return 7;
        }

        public String getName() {
            return "已离职";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();





    public static ApprovebStatus[] ApprovebStatusList(){
        return ApprovebStatus.values();
    }

    public static String approvebStatusName(Integer value) {
        //当定级审核通过后进入待签约列表 此时的待签约状态 为5或者是null时 都是待签约状态
        if (ApprovebStatus.FILED.getValue() == value || value == null) {
            return ApprovebStatus.FILED.getName();
        } else if (ApprovebStatus.REJECTED.getValue() == value) {
            return ApprovebStatus.REJECTED.getName();
        } else if (ApprovebStatus.PASS.getValue() == value) {
            return ApprovebStatus.PASS.getName();
        } else if (ApprovebStatus.ENTRYFILED.getValue() == value) {
            return ApprovebStatus.ENTRYFILED.getName();
        } else if (ApprovebStatus.ENTRYUNAUDIT.getValue() == value) {
            return ApprovebStatus.ENTRYUNAUDIT.getName();
        } else if (ApprovebStatus.ENTRYFILEDAPPROVE.getValue() == value) {
            return ApprovebStatus.ENTRYFILEDAPPROVE.getName();
        } else if (ApprovebStatus.ENTRYAPPROVEPASS.getValue() == value) {
            return ApprovebStatus.ENTRYAPPROVEPASS.getName();
        } else if (ApprovebStatus.LEAVE.getValue() == value){
            return ApprovebStatus.LEAVE.getName();
        }else{
            return "";
        }
    }
}
