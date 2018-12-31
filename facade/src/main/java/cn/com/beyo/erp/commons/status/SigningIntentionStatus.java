package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/12/21.
 * 签约意向
 */
public enum SigningIntentionStatus {

    /**
     * 有意向
     * */
    INTENTION{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "有意向";
        }
    },
    /**
     * 犹豫
     * */
    HESITATE{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "犹豫";
        }
    },

    /**
     * 无意向
     */
    NOINTENTION {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "无意向";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static SigningIntentionStatus[] all(){
        return SigningIntentionStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String signingIntentionStatusName(Integer value){
        if (SigningIntentionStatus.INTENTION.getValue() == value){
            return SigningIntentionStatus.INTENTION.getName();
        }else if (SigningIntentionStatus.HESITATE.getValue() == value){
            return SigningIntentionStatus.HESITATE.getName();
        }else if (SigningIntentionStatus.NOINTENTION.getValue() == value){
            return SigningIntentionStatus.NOINTENTION.getName();
        }else {
            return "";
        }
    }
}
