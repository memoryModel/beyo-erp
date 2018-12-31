package cn.com.beyo.erp.commons.status;

/**
 * 招工管理--erp-employee-assign
 * Created by Thinkpad on 2017/12/19.
 */
public enum AssignStatus {
    /**
     * 未指派
     */
    NOASSIGN {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未指派";
        }
    },
    /**
     * 已指派
     */
    ASSIGNED{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已指派";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();





    public static AssignStatus[] getAssignStatusList(){
        return AssignStatus.values();
    }

    public static String getAssginStatusName(Integer value) {
        if (AssignStatus.NOASSIGN.getValue() == value) {
            return AssignStatus.NOASSIGN.getName();
        } else if (AssignStatus.ASSIGNED.getValue() == value) {
            return AssignStatus.ASSIGNED.getName();
        } else {
            return "";
        }
    }
}
