package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/17.
 */
public enum ShowStatus {
    /**
     * 显示
     */
    SHOW {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "显示";
        }
    },
    /**
     * 隐藏
     */
    DELETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "隐藏";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ShowStatus[] all(){
        return ShowStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String showStatusName(Integer value){
        if (ShowStatus.SHOW.getValue() == value){
            return ShowStatus.SHOW.getName();
        }else if (ShowStatus.DELETE.getValue() == value){
            return ShowStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}
