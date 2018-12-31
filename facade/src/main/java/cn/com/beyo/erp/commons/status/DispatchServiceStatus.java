package cn.com.beyo.erp.commons.status;

/**
 * 派工服务人员 上户状态--上户管理
 * DispatchEmployee.startServiceStatus/endServiceStatus
 * Created by Ashon on 2017/8/29.
 */
public enum DispatchServiceStatus {
    /**
     * 待处理
     * 指派员工后的初始状态
     */
    WAIT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待处理";
        }
    },
    /**
     * 待确认
     * 员工发起上户请求等待客户端确认
     */
    READY {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待确认";
        }
    },
    /**
     * 已确认
     * 客户端确认
     */
    CONFIRMED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已确认";
        }
    },
    /**
     * 已驳回
     */
    DISMISSED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已驳回";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchServiceStatus[] dispatchServiceStatusList(){
        return DispatchServiceStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchServiceStatusName(Integer value){
        if (DispatchServiceStatus.READY.getValue() == value){
            return DispatchServiceStatus.READY.getName();
        }else if (DispatchServiceStatus.WAIT.getValue() == value){
            return DispatchServiceStatus.WAIT.getName();
        }else if (DispatchServiceStatus.CONFIRMED.getValue() == value){
            return DispatchServiceStatus.CONFIRMED.getName();
        }else if (DispatchServiceStatus.DISMISSED.getValue() == value){
            return DispatchServiceStatus.DISMISSED.getName();
        }else {
            return "";
        }
    }
}
