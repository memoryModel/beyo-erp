package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum MarriageStatus {
    /**
     * 已婚
     */
    Marriage {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已婚";
        }
    },
    /**
     * 未婚
     */
    NOMarriage {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "未婚";
        }
    },

    /**
     * 离异
     */
    DIVORCED {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "离异";
        }
    };




    public abstract Integer getValue();

    public abstract String getName();



    public static MarriageStatus[] marriageStatusList(){
        return MarriageStatus.values();
    }

    public static String marriageStatusName(Integer value) {
        if (MarriageStatus.Marriage.getValue() == value) {
            return MarriageStatus.Marriage.getName();
        } else if (MarriageStatus.NOMarriage.getValue() == value) {
            return MarriageStatus.NOMarriage.getName();
        } else if (MarriageStatus.DIVORCED.getValue() == value) {
            return MarriageStatus.DIVORCED.getName();
        } else {
            return "";
        }
    }
}
