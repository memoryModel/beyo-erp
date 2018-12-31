package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/5.
 */
public enum PayStatus {
    /**
     * 未支付
     */
    CREATED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待付款";
        }
    },
    /**
     * 分期付款
     */
    INSTALLMENT {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "分期付款";
        }
    },
    /**
     * 已全部付款
     */
    PAID {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已全部付款";
        }
    },
    /**
     * 已取消
     */
    CANCELED {
        public Integer getValue() {
            return 4;
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
    public static PayStatus[] all(){
        return PayStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (PayStatus.CREATED.getValue() == value){
            return PayStatus.CREATED.getName();
        }else if (PayStatus.PAID.getValue() == value){
            return PayStatus.PAID.getName();
        }else if (PayStatus.INSTALLMENT.getValue() == value){
            return PayStatus.INSTALLMENT.getName();
        }else if (PayStatus.CANCELED.getValue() == value){
            return PayStatus.CANCELED.getName();
        }else {
            return "";
        }
    }
}
