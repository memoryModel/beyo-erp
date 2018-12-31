package cn.com.beyo.erp.commons.status;

/**
 *
 */
public enum AuditBillStatus {
    /**
     * 未审核
     */
    UNAUDIT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未审核";
        }
    },
    /**
     * 已审核
     */
    AUDIT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已审核";
        }
    };

    public static AuditBillStatus[] findAuditBillStatusList(){
        return AuditBillStatus.values();
    }

    public static String getAuditBillStatusName(Integer value){
        if(AuditBillStatus.UNAUDIT.getValue() == value){
            return AuditBillStatus.UNAUDIT.getName();
        }else if(AuditBillStatus.AUDIT.getValue() == value){
            return AuditBillStatus.AUDIT.getName();
        }else{
            return "";
        }
    }


    public abstract Integer getValue();

    public abstract String getName();
}
