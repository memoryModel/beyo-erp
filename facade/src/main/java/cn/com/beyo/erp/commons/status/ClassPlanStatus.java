package cn.com.beyo.erp.commons.status;

/**
 * 班级计划状态
 * Created by Ashon on 2017/7/11.
 */
public enum ClassPlanStatus {
    /**
     * 待开班
     */
    READYCREAT {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "待开班";
        }
    },
    /**
     * 停用
     */
    DELETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "停用";
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
    public static ClassPlanStatus[] classPlanStatusList(){
        return ClassPlanStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String classPlanStatusName(Integer value){
        if (ClassPlanStatus.READYCREAT.getValue() == value){
            return ClassPlanStatus.READYCREAT.getName();
        }else if (ClassPlanStatus.DELETE.getValue() == value){
            return ClassPlanStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}
