package cn.com.beyo.erp.commons.status;

public enum CustomerSaleStatus {

    INCOMPLETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "未成单";
        }
    },

    COMPLETE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已成单";
        }
    },
    DELETE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已删除";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static CustomerSaleStatus[] all(){
        return CustomerSaleStatus.values();
    }

    public static String find(Integer value){
        if (CustomerSaleStatus.INCOMPLETE.getValue() == value){
            return CustomerSaleStatus.INCOMPLETE.getName();
        }else if (CustomerSaleStatus.COMPLETE.getValue() == value){
            return CustomerSaleStatus.COMPLETE.getName();
        }else if (CustomerSaleStatus.DELETE.getValue() == value){
            return CustomerSaleStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}
