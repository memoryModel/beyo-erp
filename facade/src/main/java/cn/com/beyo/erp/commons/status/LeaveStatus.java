package cn.com.beyo.erp.commons.status;

/**
 * 请假状态
 *  2017/7/20.
 */
public enum LeaveStatus {
    /**
     * 待生效
     */
    EXECUTORY{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待生效";
        }
    },
    /**
     * 已生效
     */
    EXECUTED {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已生效";
        }
    },
    /**
     * 已销假
     */
    TERMINATELEAVE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已销假";
        }
    },
    /**
     * 已作废
     */
    DOZEE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已作废";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static LeaveStatus[] leaveStatusList(){
        return LeaveStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String leaveStatusName(Integer value){
        if (LeaveStatus.EXECUTORY.getValue() == value){
            return LeaveStatus.EXECUTORY.getName();
        }else if (LeaveStatus.EXECUTED.getValue() == value){
            return LeaveStatus.EXECUTED.getName();
        }else if (LeaveStatus.TERMINATELEAVE.getValue() == value){
            return LeaveStatus.TERMINATELEAVE.getName();
        }else if (LeaveStatus.DOZEE.getValue() == value){
            return LeaveStatus.DOZEE.getName();
        }else {
            return "";
        }
    }
}
