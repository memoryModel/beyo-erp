package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum RefundTypeStatus {

    /**
     * 学费退费
     * */
     TUITION{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "学费退费";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RefundTypeStatus[] refundTypeStatusList(){
        return RefundTypeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getRefundTypeStatusName(Integer value){
        if (RefundTypeStatus.TUITION.getValue() == value || value == null){
            return RefundTypeStatus.TUITION.getName();
        }else {
            return "";
        }
    }
}
