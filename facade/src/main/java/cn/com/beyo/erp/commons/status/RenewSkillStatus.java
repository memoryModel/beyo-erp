package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:crm_employee_skill 字段名:renew_status
 * 续约管理：续约申请
 *
 */
public enum RenewSkillStatus {
    /**
     *续约单项技能项
     */

    NORMAL {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "技能项续约审批成功";
        }
    },
    /**
     * 续约单项技能审核退回
     */
    BACK {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "技能想续约审批失败";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static RenewSkillStatus[] renewSkillStatusList(){
        return RenewSkillStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String renewSkillStatusName(Integer value){
        if (RenewSkillStatus.NORMAL.getValue() == value){
            return RenewSkillStatus.NORMAL.getName();
        }else if (RenewSkillStatus.BACK.getValue() == value){
            return RenewSkillStatus.BACK.getName();
        }else {
            return "";
        }
    }
}
