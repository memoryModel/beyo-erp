package cn.com.beyo.erp.commons.status;

public enum ClueStatus {

    /**
     * 有效
     */
    EFFECTIVE {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "有效";
        }
    },
    /**
     * 成交
     */
    DEAL {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "成交";
        }
    },
    /**
     * 放弃
     */
    GIBVEUP {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "放弃";
        }

    };

    public abstract Integer getValue();

    public abstract String getName();


    public static ClueStatus[] findClueStatusList(){
        return ClueStatus.values();
    }

    public static String getClueStatusName(Integer value){
        if (ClueStatus.EFFECTIVE.getValue() == value){
            return ClueStatus.EFFECTIVE.getName();
        }else if (ClueStatus.DEAL.getValue() == value){
            return ClueStatus.DEAL.getName();
        }else if (ClueStatus.GIBVEUP.getValue() == value){
            return ClueStatus.GIBVEUP.getName();
        }else {
            return "";
        }
    }
}
