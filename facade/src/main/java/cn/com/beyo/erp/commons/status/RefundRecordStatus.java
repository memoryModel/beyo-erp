package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/5.
 */
public enum RefundRecordStatus {
    /**
     *退费申请
     */
    CREATED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "退费申请";
        }
    },
    /**
     * 退费申请审核未通过
     * */
    NOAUDIT{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "审核未通过";
        }
    },
    /**
     *业务以审核就是财务待审核
     */
    FINANCECREATED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "业务审核通过";
        }
    },
    /**
     *财务已审核
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
     *财务付款
     */
    PAY {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "财务付款";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RefundRecordStatus[] getRefundRecordStatusNameList(){
        return RefundRecordStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getRefundRecordStatusName(Integer value){
        if (RefundRecordStatus.CREATED.getValue() == value){
            return RefundRecordStatus.CREATED.getName();
        }else if (RefundRecordStatus.NOAUDIT.getValue() == value){
            return RefundRecordStatus.NOAUDIT.getName();
        }else if (RefundRecordStatus.FINANCECREATED.getValue() == value){
            return RefundRecordStatus.FINANCECREATED.getName();
        }else if (RefundRecordStatus.FINANCEAUDIT.getValue() == value){
            return RefundRecordStatus.FINANCEAUDIT.getName();
        }else if (RefundRecordStatus.PAY.getValue() == value){
            return RefundRecordStatus.PAY.getName();
        }else {
            return "";
        }
    }
}
