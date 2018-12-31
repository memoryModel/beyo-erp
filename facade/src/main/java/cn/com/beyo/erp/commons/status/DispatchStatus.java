package cn.com.beyo.erp.commons.status;

/**
 * 派工状态--上户管理
 * Dispatch.dispatchStatus
 * Created by Ashon on 2017/7/26.
 */
public enum DispatchStatus {
    /**
     * 未派工
     */
    NOTDISPATCHED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未派工";
        }
    },
    /**
     * 已派工
     */
    DISPATCHED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已派工";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchStatus[] dispatchStatusList(){
        return DispatchStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchStatusName(Integer value){
        if (DispatchStatus.NOTDISPATCHED.getValue() == value){
            return DispatchStatus.NOTDISPATCHED.getName();
        }else if (DispatchStatus.DISPATCHED.getValue() == value){
            return DispatchStatus.DISPATCHED.getName();
        }else {
            return "";
        }
    }
}
