package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/6.
 */
public enum DepositStatus {
    /**
     * 未取件
     */
    PICKUP {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未取件";
        }
    },
    /**
     * 已取件
     */
    DEPOSIT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已取件";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DepositStatus[] depositStatusList(){
        return DepositStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String depositStatusName(Integer value){
        if (DepositStatus.DEPOSIT.getValue() == value){
            return DepositStatus.DEPOSIT.getName();
        }else if (DepositStatus.PICKUP.getValue() == value){
            return DepositStatus.PICKUP.getName();
        }else {
            return "";
        }
    }
}
