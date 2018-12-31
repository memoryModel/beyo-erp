package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2018/1/24.
 */
public enum NumberType {

    /**
     * 星级管理
     */
    SERVICELEVELNUMBER {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "星级管理";
        }
    },
    /**
     * 服务管理
     */
    DISPATCHNUMBER {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "服务管理";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static NumberType[] findNumberTypeList(){
        return NumberType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getNumberType(Integer value){
        if (NumberType.SERVICELEVELNUMBER.getValue() == value){
            return NumberType.SERVICELEVELNUMBER.getName();
        }else if (NumberType.DISPATCHNUMBER.getValue() == value){
            return NumberType.DISPATCHNUMBER.getName();
        }else {
            return "";
        }
    }
}
