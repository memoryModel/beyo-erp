package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/5.
 */
public enum  OrderStatus {

    /**
     * 已创建-代付款
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
     * 部分付款
     * */
    PARTIALPAY {
        public Integer getValue() {return 6;}

        public String getName() {return "部分付款";}
    },
    /**
     * 已付款-待处理
     */
    PAID {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已付款";
        }
    },
    /**
     * 服务中/学习中
     */
    PROGRESS {
        public Integer getValue() {
            return 10;
        }

        public String getName() {
            return "服务中";
        }
    },
    /**
     * 已完成
     */
    FINISHED {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已完成";
        }
    },
    /**
     * 已取消
     */
    CANCELED {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "已取消";
        }
    },
    /**
     * 业务审核中
     */
     AUDIT{
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "业务审核中";
        }
    },/**
     * 财务审核中
     */
    FINANCEAUDIT {
        public Integer getValue() {
            return 7;
        }

        public String getName() {
            return "财务审核中";
        }
    },/**
     * 退款中
     */
    ONPAY {
        public Integer getValue() {
            return 8;
        }

        public String getName() {
            return "退款中";
        }
    },/**
     * 已退款
     */
    PAY {
        public Integer getValue() {
            return 9;
        }

        public String getName() {
            return "已退款";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static OrderStatus[] all(){
        return OrderStatus.values();
    }

    /**
     * 返回状态列表(学校订单没有服务中的状态)
     * */
    public static OrderStatus[] schoolAll(){
        OrderStatus[] schoolOrderStatus = new OrderStatus[5];
        OrderStatus[] orderStatuses = OrderStatus.values();
        int j=0;
        for(int i=0;i<orderStatuses.length;i++){
            if(orderStatuses[i].getValue() != 3){
                schoolOrderStatus[j] = orderStatuses[i];
                j++;
            }
        }
        return schoolOrderStatus;
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (OrderStatus.CREATED.getValue() == value){
            return OrderStatus.CREATED.getName();
        }else if (OrderStatus.PARTIALPAY.getValue() == value){
            return OrderStatus.PARTIALPAY.getName();
        }else if (OrderStatus.PAID.getValue() == value){
            return OrderStatus.PAID.getName();
        }else if (OrderStatus.PROGRESS.getValue() == value){
            return OrderStatus.PROGRESS.getName();
        }else if (OrderStatus.FINISHED.getValue() == value){
            return OrderStatus.FINISHED.getName();
        }else if (OrderStatus.CANCELED.getValue() == value){
            return OrderStatus.CANCELED.getName();
        }else if (OrderStatus.AUDIT.getValue() == value){
            return OrderStatus.AUDIT.getName();
        }else if (OrderStatus.FINANCEAUDIT.getValue() == value){
            return OrderStatus.FINANCEAUDIT.getName();
        }else if (OrderStatus.ONPAY.getValue() == value){
            return OrderStatus.ONPAY.getName();
        }else if (OrderStatus.PAY.getValue() == value){
            return OrderStatus.PAY.getName();
        }else {
            return "";
        }
    }
}
