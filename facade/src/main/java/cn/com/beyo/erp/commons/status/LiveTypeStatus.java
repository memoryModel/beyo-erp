package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/27.
 */
public enum LiveTypeStatus {
    /**
     * 员工
     */
    EMPLOYEE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "员工";
        }
    },
    /**
     * 学员
     */
    STUDENT {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "学员";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static LiveTypeStatus[] liveTypeList(){

        return LiveTypeStatus.values();
    }

    public static String liveTypeName(Integer value){
        if (LiveTypeStatus.EMPLOYEE.getValue() == value){
            return LiveTypeStatus.EMPLOYEE.getName();
        }else if (LiveTypeStatus.STUDENT.getValue() == value){
            return LiveTypeStatus.STUDENT.getName();
        }else {
            return "";
        }
    }
}
