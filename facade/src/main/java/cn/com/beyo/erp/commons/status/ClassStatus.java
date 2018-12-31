package cn.com.beyo.erp.commons.status;

/**
 * 班级状态
 * Created by Ashon on 2017/7/11.
 */
public enum ClassStatus {
    /**
     * 新开班
     */
    CREATED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "新开班";
        }
    },
    /**
     * 停用
     */
    /*DELETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "停用";
        }
    },*/
    /**
     * 已排课
     */
    ARRANGED {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已排课";
        }
    },
    /**
     * 上课中
     */
    UNGRADUAT {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "上课中";
        }
    },
    /**
     * 已结业
     */
    GRADUAT {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已结业";
        }
    },
    /**
     * 不结业的(做为报名时查询的班级用)
     */
    NOGRADUAT {
        public Integer getValue() {
            return 9;
        }

        public String getName() {
            return "不是结业";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ClassStatus[] classStatusList(){
        return ClassStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String classStatusName(Integer value){
        if (ClassStatus.CREATED.getValue() == value){
            return ClassStatus.CREATED.getName();
        }
        /*else if (ClassStatus.DELETE.getValue() == value){
            return ClassStatus.DELETE.getName();
        }*/
        else if (ClassStatus.ARRANGED.getValue() == value){
            return ClassStatus.ARRANGED.getName();
        }else if (ClassStatus.UNGRADUAT.getValue() == value){
            return ClassStatus.UNGRADUAT.getName();
        }else if (ClassStatus.GRADUAT.getValue() == value){
            return ClassStatus.GRADUAT.getName();
        }else {
            return "";
        }
    }
}
