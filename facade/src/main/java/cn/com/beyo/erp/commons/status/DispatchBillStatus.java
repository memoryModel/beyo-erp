package cn.com.beyo.erp.commons.status;

/**
 * 派工服务状态--上户管理
 * Dispatch.status
 * Created by Ashon on 2017/8/29.
 */
public enum DispatchBillStatus {
    /**
     * 待服务
     */
    READY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待服务";
        }
    },
    /**
     * 服务中
     */
    SERVICE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "服务中";
        }
    },
    /**
     * 已完成
     */
    COMPLETED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已完成";
        }
    },
    /**
     * 已取消
     */
    CANCELLED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已取消";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchBillStatus[] dispatchBillStatusList(){
        return DispatchBillStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchBillStatusName(Integer value){
        if (DispatchBillStatus.READY.getValue() == value){
            return DispatchBillStatus.READY.getName();
        }else if (DispatchBillStatus.SERVICE.getValue() == value){
            return DispatchBillStatus.SERVICE.getName();
        }else if (DispatchBillStatus.COMPLETED.getValue() == value){
            return DispatchBillStatus.COMPLETED.getName();
        }else if (DispatchBillStatus.CANCELLED.getValue() == value){
            return DispatchBillStatus.CANCELLED.getName();
        }else {
            return "";
        }
    }
}
