package cn.com.beyo.erp.commons.status;

/**
 * 考试状态
 * Created by Ashon on 2017/7/3.
 */
public enum InfoStatus {
    /**
     * 未开考
     */
    NOTEXAMIN {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未开考";
        }
    },
    /**
     * 考试中
     */
    EXAMINATION {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "考试中";
        }
    },

    /**
     * 已结束
     */
    FINIESHED  {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已结束";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    /**
     * 返回考试状态列表
     * */
    public static InfoStatus[] infoStatusList(){
        return InfoStatus.values();
    }

    /**
     * 查找返回考试状态名称
     * */
    public static String infoStatusName(Integer value){
        if (InfoStatus.NOTEXAMIN.getValue() == value){
            return InfoStatus.NOTEXAMIN.getName();
        }else if (InfoStatus.EXAMINATION.getValue() == value){
            return InfoStatus.EXAMINATION.getName();
        }else if(InfoStatus.FINIESHED.getValue() == value){
            return InfoStatus.FINIESHED.getName();
        } else {
            return "";
        }
    }

}
