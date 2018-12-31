package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:cem_interview 字段名:remind_status
 * 面试管理：提醒状态
 * 0、未提醒
 * 1、已提醒
 */
public enum RemindStatus {
    /**
     *未提醒
     */
    NORNMIND {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未提醒";
        }
    },
    /**
     * 已提醒
     */
    RNMIND {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已提醒";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RemindStatus[] remindStatusList(){
        return RemindStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String remindStatusName(Integer value){
        if (RemindStatus.NORNMIND.getValue() == value){
            return RemindStatus.NORNMIND.getName();
        }else if (RemindStatus.RNMIND.getValue() == value){
            return RemindStatus.RNMIND.getName();
        }else {
            return "";
        }
    }
}
