package cn.com.beyo.erp.commons.status;

/**     客户状态    customerStatus
 * Created by Thinkpad on 2017/7/5.
 */
public enum CustomerStatus {
    /**
     * 待委派客户
     */
    NODELEGATE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "待委派客户";
        }
    },
    /**
     * 再委派客户
     */
    AGAINDELEGATE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "再委派客户";
        }
    },
    /*
    * 待跟进客户
    * */
    NOFOLLOWUP {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "待跟进客户";
        }
    },
    /*
    * 跟进中客户
    * */
    FOLLOWUP {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "跟进中客户";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static CustomerStatus[] customerStatusList(){
        return CustomerStatus.values();
    }

    public static String customerStatusName(Integer value){
        if (CustomerStatus.NODELEGATE.getValue() == value){
            return CustomerStatus.NODELEGATE.getName();
        }else if (CustomerStatus.AGAINDELEGATE.getValue() == value){
            return CustomerStatus.AGAINDELEGATE.getName();
        }else if (CustomerStatus.NOFOLLOWUP.getValue() == value){
            return CustomerStatus.NOFOLLOWUP.getName();
        }else if (CustomerStatus.FOLLOWUP.getValue() == value){
            return CustomerStatus.FOLLOWUP.getName();
        }
        else {
            return "";
        }
    }
}
