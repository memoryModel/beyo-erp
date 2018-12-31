package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/26.
 */
public enum  ContractSignStatus {
    NOTSIGNED{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未签约";
        }
    },
    SIGNED{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已签约";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ContractSignStatus[] all(){
        return ContractSignStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ContractSignStatus.NOTSIGNED.getValue() == value){
            return ContractSignStatus.NOTSIGNED.getName();
        }else if (ContractSignStatus.SIGNED.getValue() == value){
            return ContractSignStatus.SIGNED.getName();
        }else {
            return ContractSignStatus.NOTSIGNED.getName();
        }
    }


}
