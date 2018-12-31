package cn.com.beyo.erp.commons.status;

/**
 * 派工服务人员 推荐状态--上户管理
 * DispatchEmployee.recommendStatus
 * Created by Ashon on 2017/8/29.
 */
public enum DispatchEmployeeStatus {
    /**
     * 待确认
     */
    READY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "待确认";
        }
    },
    /**
     * 删除
     */
    DELETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "删除";
        }
    },
    /**
     * 已落选
     */
    LOSING {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已落选";
        }
    },
    /**
     * 已选中
     */
    SELECTED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已选中";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchEmployeeStatus[] dispatchEmployeeStatusList(){
        return DispatchEmployeeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchEmployeeStatusName(Integer value){
        if (DispatchEmployeeStatus.READY.getValue() == value){
            return DispatchEmployeeStatus.READY.getName();
        }else if (DispatchEmployeeStatus.DELETE.getValue() == value){
            return DispatchEmployeeStatus.DELETE.getName();
        }else if (DispatchEmployeeStatus.LOSING.getValue() == value){
            return DispatchEmployeeStatus.LOSING.getName();
        }else if (DispatchEmployeeStatus.SELECTED.getValue() == value){
            return DispatchEmployeeStatus.SELECTED.getName();
        }else {
            return "";
        }
    }
}
