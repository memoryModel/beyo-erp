package cn.com.beyo.erp.commons.status;

/**
 * 客户类型 （1 母婴客户，2 服务员工 ，3早教客户，4学校生源）CustomerType
 * Created by Thinkpad on 2018/2/8.
 */
public enum CustomerType {
    /**
     * 母婴客户
     */
    INFANTCUSTOMER {
        public Integer getValue() {return 1;}

        public String getName() {return "母婴客户";}
    }
    ,
    /**
     * 服务员工
     */
    SERVICESTAFF {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "服务员工";
        }
    },

    /**
     * 早教客户
     */
    EARLYEDUCATION {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "早教客户";
        }
    }
    ,
    /**
     * 学校生源
     */
    FEEDERSCHOOLS {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "学校生源";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static CustomerType[] customerTypeList(){
        return CustomerType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String customerTypeName(Integer value){
        if (CustomerType.INFANTCUSTOMER.getValue() == value){
            return CustomerType.INFANTCUSTOMER.getName();
        }else if (CustomerType.SERVICESTAFF.getValue() == value){
            return CustomerType.SERVICESTAFF.getName();
        }else if (CustomerType.EARLYEDUCATION.getValue() == value){
            return CustomerType.EARLYEDUCATION.getName();
        }else if (CustomerType.FEEDERSCHOOLS.getValue() == value){
            return CustomerType.FEEDERSCHOOLS.getName();
        }else {
            return "";
        }
    }


}
