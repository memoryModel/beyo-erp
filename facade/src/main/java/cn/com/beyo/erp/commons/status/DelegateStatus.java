package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/6.
 */
public enum DelegateStatus {
    /**
     * 未委派
     */
    NODELEGATE {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未委派";
        }
    },
    /**
     * 已委派
     */
    ALREADYDELEGATE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已委派";
        }
    }
    ,
    /**
     * 撤回
     */
    CANCEL {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "撤回";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DelegateStatus[]delegateStatusList(){
        return DelegateStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String delegateStatusName(Integer value){
        if (DelegateStatus.NODELEGATE.getValue() == value){
            return DelegateStatus.NODELEGATE.getName();
        }else if (DelegateStatus.ALREADYDELEGATE.getValue() == value){
            return DelegateStatus.ALREADYDELEGATE.getName();
        }else if (DelegateStatus.CANCEL.getValue() == value){
            return DelegateStatus.CANCEL.getName();
        }else {
            return "";
        }
    }


}
