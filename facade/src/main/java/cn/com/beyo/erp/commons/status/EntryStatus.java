package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum EntryStatus {
    /**
     * 未提交
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
     * 已签约
     */
    APPROVE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已签约";
        }
    },
    /**
     * 已退回
     */
    UNAUDIT {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已退回";
        }
    },
    /**
     * 已放弃
     */
    GIVEUP {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已放弃";
        }
    },
    /**
     * 待审批
     */
    PASS {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "待审批";
        }
    },
    /*
    * 已审批
    * */
    ALREADYPASS {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "已审批";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();


    public static EntryStatus[] all(){
        return EntryStatus.values();
    }

    public static String find(Integer value) {
        if (EntryStatus.FILED.getValue() == value) {
            return EntryStatus.FILED.getName();
        } else if (EntryStatus.APPROVE.getValue() == value) {
            return EntryStatus.APPROVE.getName();
        } else if (EntryStatus.UNAUDIT.getValue() == value) {
            return EntryStatus.UNAUDIT.getName();
        } else if (EntryStatus.GIVEUP.getValue() == value) {
            return EntryStatus.GIVEUP.getName();
        }else if (EntryStatus.PASS.getValue() == value) {
            return EntryStatus.PASS.getName();
        }else {
            return "";
        }
    }
}
