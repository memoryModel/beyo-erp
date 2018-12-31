package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/5.
 */
public enum RefundStatus {
    /**
     *
     */
    CREATED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "业务待审核";
        }
    },
    /**
     *业务以审核就是财务待审核
     */
    FINANCECREATED {
        public Integer getValue() {
            return 7;
        }

        public String getName() {
            return "财务待审核";
        }
    },
    /**
     *
     */
    FINANCEAUDIT {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "财务已审核";
        }
    },
    /**
     *
     */
    REJECT {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "业务已拒绝";
        }
    },
    /**
     * 退款处理中-待支付
     */
    PROGRESS {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "退款中";
        }
    },
    /**
     * 已完成
     */
    FINISHED {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "已退款";
        }
    },
    /**
     * 已取消
     */
    CANCELED {
        public Integer getValue() {
            return 6;
        }

        public String getName() {
            return "已取消";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RefundStatus[] refundStatusList(){
        return RefundStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String refundStatusName(Integer value){
        if (RefundStatus.CREATED.getValue() == value){
            return RefundStatus.CREATED.getName();
        }else if (RefundStatus.FINANCECREATED.getValue() == value){
            return RefundStatus.FINANCECREATED.getName();
        }else if (RefundStatus.FINANCEAUDIT.getValue() == value){
            return RefundStatus.FINANCEAUDIT.getName();
        }else if (RefundStatus.REJECT.getValue() == value){
            return RefundStatus.REJECT.getName();
        }else if (RefundStatus.PROGRESS.getValue() == value){
            return RefundStatus.PROGRESS.getName();
        }else if (RefundStatus.FINISHED.getValue() == value){
            return RefundStatus.FINISHED.getName();
        }else if (RefundStatus.CANCELED.getValue() == value){
            return RefundStatus.CANCELED.getName();
        }else {
            return "";
        }
    }
}
