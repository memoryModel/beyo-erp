package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum StudentTypeStatus {
    /**
     * 潜在学员
     */
    POTENTIAL {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "潜在学员";
        }
    },
    /**
     * 准意向学员
     */
    MEDITATE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "准意向学员";
        }
    },
    /**
     * 正式报名学员
     */
    OFFICIAL {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "正式报名学员";
        }
    },
    /**
     * 无意向学员
     */
    WITHOUT {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "无意向学员";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static StudentTypeStatus[] StudentTypeList(){
        return StudentTypeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String studentTypeName(Integer value){
        if (StudentTypeStatus.POTENTIAL.getValue() == value){
            return StudentTypeStatus.POTENTIAL.getName();
        }else if (StudentTypeStatus.MEDITATE.getValue() == value){
            return StudentTypeStatus.MEDITATE.getName();
        }else if (StudentTypeStatus.OFFICIAL.getValue() == value){
            return StudentTypeStatus.OFFICIAL.getName();
        }else if (StudentTypeStatus.WITHOUT.getValue() == value){
            return StudentTypeStatus.WITHOUT.getName();
        }else {
            return "";
        }
    }
}
