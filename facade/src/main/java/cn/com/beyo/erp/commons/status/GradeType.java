package cn.com.beyo.erp.commons.status;

/**
 * crm_employee_grade
 * Created by Thinkpad on 2018/1/11.
 */
public enum GradeType {
    /**
     * 升级
     */
    UPGRADE {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "升级";
        }
    },
    /**
     * 降级
     */
    DOWNGRADE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "降级";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();


    /**
     * 返回生降级列表
     * */
    public static GradeType[] findGradeTypeList(){
        return GradeType.values();
    }

    /**
     * 查找升降级名称
     * */
    public static String getGradeTypeName(Integer value){
        if (GradeType.UPGRADE.getValue() == value){
            return GradeType.UPGRADE.getName();
        }else if (GradeType.DOWNGRADE.getValue() == value){
            return GradeType.DOWNGRADE.getName();
        } else {
            return "";
        }
    }

}
