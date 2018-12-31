package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/13.
 */
public enum LiveStatus {
    /**
     * 未入住
     */
    NORMAL {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未入住";
        }
    },
    /**
     * 已入住
     */
    LIVE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已入住";
        }
    },
    /**
     * 已离开
     */
    LEAVE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已离开";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static LiveStatus[] liveStatusList(){
        return LiveStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String liveStatusName(Integer value){
        if (LiveStatus.NORMAL.getValue() == value){
            return LiveStatus.NORMAL.getName();
        } else if (LiveStatus.LIVE.getValue() == value){
            return LiveStatus.LIVE.getName();
        }else if (LiveStatus.LEAVE.getValue() == value){
            return LiveStatus.LEAVE.getName();
        }else {
            return "";
        }
    }
}
