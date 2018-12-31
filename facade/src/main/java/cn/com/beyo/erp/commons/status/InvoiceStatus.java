package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum InvoiceStatus {
    /**
     * 未开票
     */
    KAIPIAO {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未开票";
        }
    },
    /**
     * 已开票
     */
    WEIKAI {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已开票";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static InvoiceStatus[] InvoiceStatusList(){
        return InvoiceStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String InvoiceStatusName(Integer value){
        if (InvoiceStatus.KAIPIAO.getValue() == value){
            return InvoiceStatus.KAIPIAO.getName();
        }else if (InvoiceStatus.WEIKAI.getValue() == value){
            return InvoiceStatus.WEIKAI.getName();
        }else {
            return "";
        }
    }
}
