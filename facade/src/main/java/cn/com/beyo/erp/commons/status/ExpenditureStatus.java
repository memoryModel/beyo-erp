package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum ExpenditureStatus {

    /**
     * 未付款
     * */
    NOPAY{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未付款";
        }
    },
    /**
     * 已付款
     * */
    PAY{
        public Integer getValue() {
            return 0;
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
    public static ExpenditureStatus[] expenditureStatusList(){
        return ExpenditureStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String expenditureStatusName(Integer value){
        if (ExpenditureStatus.NOPAY.getValue() == value || value == null){
            return ExpenditureStatus.NOPAY.getName();
        }else if (ExpenditureStatus.PAY.getValue() == value){
            return ExpenditureStatus.PAY.getName();
        }else {
            return "";
        }
    }
}
