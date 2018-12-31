package cn.com.beyo.erp.commons.status;

/**
 * 派工服务人员 上户状态--上户管理
 * DispatchEmployee.startServiceStatus/endServiceStatus
 * Created by Ashon on 2017/8/29.
 */
public enum DispatchServiceForShow {
    /**
     * 待确认
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
    public static DispatchServiceForShow[] dispatchServiceForShowList(){
        return DispatchServiceForShow.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String dispatchServiceForShowName(Integer value){
        if (DispatchServiceForShow.READY.getValue() == value){
            return DispatchServiceForShow.READY.getName();
        }else if (DispatchServiceForShow.CONFIRMED.getValue() == value){
            return DispatchServiceForShow.CONFIRMED.getName();
        }else if (DispatchServiceForShow.DISMISSED.getValue() == value){
            return DispatchServiceForShow.DISMISSED.getName();
        }else {
            return "";
        }
    }
}
