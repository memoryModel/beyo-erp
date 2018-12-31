package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/21.
 */
public enum EmployeeInfoType {
    /**
     * 身份证
     */
    ID{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "身份证";
        }
    },
    /**
     * 健康证
     */
   HEALTH{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "健康证";
        }
    },
    /**
     * 职业
     */
    PROFESSION{
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "职业";
        }
    },
    /**
     * 视频秀
     */
    VIOEDSHOW{
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "视频秀";
        }
    },
    /**
     * 作品秀
     */
    PRODUCTION{
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "作品秀";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();

    public static EmployeeInfoType[] employeeInfoTypeList(){
        return EmployeeInfoType.values();
    }

    public static String employeeInfoTypeName(Integer value){
        if (EmployeeInfoType.ID.getValue() == value){
            return EmployeeInfoType.ID.getName();
        }else if (EmployeeInfoType.HEALTH.getValue() == value){
            return EmployeeInfoType.HEALTH.getName();
        }else if (EmployeeInfoType.PROFESSION.getValue() == value){
            return EmployeeInfoType.PROFESSION.getName();
        }else if (EmployeeInfoType.VIOEDSHOW.getValue() == value){
            return EmployeeInfoType.VIOEDSHOW.getName();
        }else if (EmployeeInfoType.PRODUCTION.getValue() == value){
            return EmployeeInfoType.PRODUCTION.getName();
        }else {
            return "";
        }
    }
}
