package cn.com.beyo.erp.commons.status;

/**
 * 客户意向（1 潜在客户，2 犹豫客户， 3 无意向客户， 4 准意向客户，5 成交客户，6 退费客户）customerIntention
 * Created by Thinkpad on 2018/2/8.
 */
public enum CustomerIntentionStatus {
    /**
     * 潜在客户
     */
    PROSPECTIVECUSTOMER {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "潜在客户";
        }
    },
    /**
     * 犹豫客户
     */
    INFANTCUSTOMER {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "犹豫客户";
        }
    }
    ,
    /**
     * 无意向客户
     */
    NOINTENTION {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "无意向客户";
        }
    }
    ,
    /**
     * 准意向客户
     */
    INTENTIONCUSTOMER {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "准意向客户";
        }
    }
    ,
    /**
     * 成交客户
     */
    PASSCUSTOMER {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "成交客户";
        }
    }
    ,
    /**
     * 退费客户
     */
    PREMIUMVCUSTOMER {
        public Integer getValue() {
            return 6;
        }

        public String getName() {
            return "退费客户";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static CustomerIntentionStatus[] customerIntentionStatusList(){
        return CustomerIntentionStatus.values();
    }

    /**
     * 返回 1 潜在客户，2 犹豫客户， 3 无意向客户， 4 准意向客户 状态列表
     */
    public static CustomerIntentionStatus[] customerIntentionList(){
        int i = 0;
        CustomerIntentionStatus[]  array = CustomerIntentionStatus.values();
        CustomerIntentionStatus[] customerIntentionArray = new CustomerIntentionStatus[4];
        for(CustomerIntentionStatus customerIntentionStatus:array){
            if(customerIntentionStatus.getValue() != 5 && customerIntentionStatus.getValue() != 6){
                customerIntentionArray[i] = customerIntentionStatus;
                i++;
            }
        }
        return customerIntentionArray;
    }

    /**
     * 查找返回状态名称
     * */
    public static String customerIntentionStatusName(Integer value){
        if (CustomerIntentionStatus.PROSPECTIVECUSTOMER.getValue() == value){
            return CustomerIntentionStatus.PROSPECTIVECUSTOMER.getName();
        }else if (CustomerIntentionStatus.INFANTCUSTOMER.getValue() == value){
            return CustomerIntentionStatus.INFANTCUSTOMER.getName();
        }else if (CustomerIntentionStatus.NOINTENTION.getValue() == value){
            return CustomerIntentionStatus.NOINTENTION.getName();
        }else if (CustomerIntentionStatus.INTENTIONCUSTOMER.getValue() == value){
            return CustomerIntentionStatus.INTENTIONCUSTOMER.getName();
        }else if (CustomerIntentionStatus.PASSCUSTOMER.getValue() == value){
            return CustomerIntentionStatus.PASSCUSTOMER.getName();
        }else if (CustomerIntentionStatus.PREMIUMVCUSTOMER.getValue() == value){
            return CustomerIntentionStatus.PREMIUMVCUSTOMER.getName();
        }else {
            return "";
        }
    }


}
