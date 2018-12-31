package cn.com.beyo.erp.commons.status;

/**
 * 考勤类型状态--服务人员考勤管理
 * EmployeeWork.type
 * Created by Ashon on 2017/8/31.
 */
public enum DispatchType {
    /**
     * 开始服务确认
     */
    START {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "开始服务确认";
        }
    },
    /**
     * 结束服务确认
     */
    END {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "结束服务确认";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static DispatchType[] dispatchTypeList(){
        return DispatchType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchTypeName(Integer value){
        if (DispatchType.START.getValue() == value){
            return DispatchType.START.getName();
        }else if (DispatchType.END.getValue() == value){
            return DispatchType.END.getName();
        }else {
            return "";
        }
    }
}
