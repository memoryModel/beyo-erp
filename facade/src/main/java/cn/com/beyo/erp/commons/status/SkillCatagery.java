package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/27.
 */
public enum SkillCatagery {
    /**
     * 单项服务
     */
    SINGLE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "单项服务";
        }
    },
    /**
     * 基础服务
     */
    BESIC {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "基础服务";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static SkillCatagery[] skillCatageryList(){
        return SkillCatagery.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String skillCatageryName(Integer value){
        if (SkillCatagery.SINGLE.getValue() == value){
            return SkillCatagery.SINGLE.getName();
        } else if (SkillCatagery.BESIC.getValue() == value){
            return SkillCatagery.BESIC.getName();
        }else {
            return "";
        }
    }

}
