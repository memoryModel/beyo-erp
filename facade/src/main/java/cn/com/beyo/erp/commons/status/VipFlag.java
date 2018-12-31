package cn.com.beyo.erp.commons.status;

/**
 * 销售管理-线索管理-添加线索 crm_sale vip_flag
 * Created by Thinkpad on 2018/1/31.
 */
public enum VipFlag {
    /**
     * 是
     */
    YES {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "是";
        }
    },
    /**
     * 否
     */
    NO {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "否";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();

    /**
     * 返回状态列表
     * */
    public static VipFlag[] findVipFlagList(){
        return VipFlag.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getVipFlagName(Integer value){
        if (VipFlag.YES.getValue() == value){
            return VipFlag.YES.getName();
        } else if (VipFlag.NO.getValue() == value){
            return VipFlag.NO.getName();
        }else {
            return "";
        }
    }

}
