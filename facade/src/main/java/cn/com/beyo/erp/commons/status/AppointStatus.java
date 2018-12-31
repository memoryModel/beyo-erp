package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum AppointStatus {

    /**
     * 未指派
     * */
    WAITAPPOINT{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未指派";
        }
    },
    /**
     * 待联系
     * */
    WAITCONTACT{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "待联系";
        }
    },

    /**
     * 已联系
     */
    CONTACT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "已联系";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static AppointStatus[] appointStatusList(){
        return AppointStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String appointStatusName(Integer value){
        if (AppointStatus.WAITAPPOINT.getValue() == value || value == null){
            return AppointStatus.WAITAPPOINT.getName();
        }else if (AppointStatus.WAITCONTACT.getValue() == value){
            return AppointStatus.WAITCONTACT.getName();
        }else if (AppointStatus.CONTACT.getValue() == value){
            return AppointStatus.CONTACT.getName();
        }else {
            return "";
        }
    }
}
