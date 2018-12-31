package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum ClientStatus {
    /**
     * 未分配
     */
    EMPTY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未分配";
        }
    },
    /**
     * 待跟进
     */
    DAIHUIFANG {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待跟进";
        }
    },
    /**
     * 跟进中
     */
    YIHUIFANG {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "跟进中";
        }
    },
    /**
     * 已完成
     */
    ACCOMPLISH {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已完成";
        }
    },
    /**
     * 已放弃
     */
    ABANDON {
        public Integer getValue() {
            return 4;
        }

        public String getName() { return "已放弃"; }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static ClientStatus[] clientStatusList(){
        return ClientStatus.values();
    }

    public static String clientStatusName(Integer value){
        if (ClientStatus.DAIHUIFANG.getValue() == value){//如果客户状态为空的话,则客户状态就是待跟进状态
            return ClientStatus.DAIHUIFANG.getName();
        }else if (ClientStatus.YIHUIFANG.getValue() == value){
            return ClientStatus.YIHUIFANG.getName();
        }else if (ClientStatus.ACCOMPLISH.getValue() == value){
            return ClientStatus.ACCOMPLISH.getName();
        }else if (ClientStatus.ABANDON.getValue() == value){
            return ClientStatus.ABANDON.getName();
        }else if (ClientStatus.EMPTY.getValue() == value){
            return ClientStatus.EMPTY.getName();
        }else {
            return "";
        }
    }
}
