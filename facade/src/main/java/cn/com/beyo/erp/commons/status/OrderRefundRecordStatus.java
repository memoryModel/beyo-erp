package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum OrderRefundRecordStatus {

    /**
     * 退费申请
     * */
    CREATED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "退费申请";
        }
    },
    /**
     * 业务审核拒绝
     * */
    NO{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "业务审核拒绝";
        }
    },
    /**
     * 业务已审核
     * */
    FINANCECREATED{
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "业务已审核";
        }
    },

    /**
     * 财务已审核
     */
    FINANCEAUDIT {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "财务已审核";
        }
    },
    /**
     * 已付款
     */
    PAY {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "已付款";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static OrderRefundRecordStatus[] orderRefundRecordStatusList(){
        return OrderRefundRecordStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String orderRefundRecordStatusName(Integer value){
        if (OrderRefundRecordStatus.CREATED.getValue() == value || value == null){
            return OrderRefundRecordStatus.CREATED.getName();
        }else if (OrderRefundRecordStatus.NO.getValue() == value){
            return OrderRefundRecordStatus.NO.getName();
        }else if (OrderRefundRecordStatus.FINANCECREATED.getValue() == value){
            return OrderRefundRecordStatus.FINANCECREATED.getName();
        }else if (OrderRefundRecordStatus.FINANCEAUDIT.getValue() == value){
            return OrderRefundRecordStatus.FINANCEAUDIT.getName();
        }else if (OrderRefundRecordStatus.PAY.getValue() == value){
            return OrderRefundRecordStatus.PAY.getName();
        }else {
            return "";
        }
    }
}
