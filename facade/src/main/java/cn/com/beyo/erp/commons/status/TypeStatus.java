package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum TypeStatus {

    /**
     * 培训服务
     * */
     TRAIN{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "培训服务";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static TypeStatus[] typeStatusList(){
        return TypeStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String getTypeStatusName(Integer value){
        if (TypeStatus.TRAIN.getValue() == value || value == null){
            return TypeStatus.TRAIN.getName();
        }else {
            return "";
        }
    }
}
