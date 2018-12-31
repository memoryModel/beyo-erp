package cn.com.beyo.erp.commons.status;

/**
 * crm_sale_delegate_record 销售管理-线索管理  cancel_type
 * Created by Thinkpad on 2018/2/8.
 */
public enum CancelType {
    /**
     * 未及时跟进
     */
    NOFOLLOW {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未及时跟进";
        }
    },
    /**
     * 员工离职
     */
    EMPLOYEEQUIT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "员工离职";
        }
    }
    ,
    /**
     * 人工撤回
     */
    CANCEL {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "人工撤回";
        }
    }
    ,
    /**
     * 放弃
     */
    GIVEUP {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "自动放弃";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static CancelType[] findCancelTypeList(){
        return CancelType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getCancelTypeName(Integer value){
        if (CancelType.NOFOLLOW.getValue() == value){
            return CancelType.NOFOLLOW.getName();
        }else if (CancelType.EMPLOYEEQUIT.getValue() == value){
            return CancelType.EMPLOYEEQUIT.getName();
        }else if (CancelType.CANCEL.getValue() == value){
            return CancelType.CANCEL.getName();
        }else if (CancelType.GIVEUP.getValue() == value){
            return CancelType.GIVEUP.getName();
        }else {
            return "";
        }
    }


}
