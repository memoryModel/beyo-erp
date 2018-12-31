package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/12/21.
 * 沟通方式
 */
public enum CommunicationModeStatus {

    /**
     * 电话
     * */
    PHONE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "电话";
        }
    },
    /**
     * 上门
     * */
    VISIT{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "上门";
        }
    },

    /**
     * 手机短信
     */
    MESSAGES {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "手机短信";
        }
    },

    /**
     * 微信
     */
    WECHAT {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "微信";
        }
    },

    /**
     * 邮箱
     */
    EMAIL {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "邮箱";
        }
    },

    /**
     * 传真
     */
    FAX {
        public Integer getValue() {
            return 6;
        }

        public String getName() {
            return "传真";
        }
    },

    /**
     * 其他
     */
    OTHER {
        public Integer getValue() {
            return 7;
        }

        public String getName() {
            return "其他";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static CommunicationModeStatus[] all(){
        return CommunicationModeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String communicationModeStatusName(Integer value){
        if (CommunicationModeStatus.PHONE.getValue() == value){
            return CommunicationModeStatus.PHONE.getName();
        }else if (CommunicationModeStatus.VISIT.getValue() == value){
            return CommunicationModeStatus.VISIT.getName();
        }else if (CommunicationModeStatus.MESSAGES.getValue() == value){
            return CommunicationModeStatus.MESSAGES.getName();
        }else if (CommunicationModeStatus.WECHAT.getValue() == value){
            return CommunicationModeStatus.WECHAT.getName();
        }else if (CommunicationModeStatus.EMAIL.getValue() == value){
            return CommunicationModeStatus.EMAIL.getName();
        }else if (CommunicationModeStatus.FAX.getValue() == value){
            return CommunicationModeStatus.FAX.getName();
        }else if (CommunicationModeStatus.OTHER.getValue() == value){
            return CommunicationModeStatus.OTHER.getName();
        }else {
            return "";
        }
    }
}
