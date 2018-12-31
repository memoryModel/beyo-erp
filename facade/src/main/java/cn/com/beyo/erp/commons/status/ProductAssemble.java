package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/14.
 */
public enum ProductAssemble {

    SINGLE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "单品";
        }
    },
    GROUP {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "套装";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ProductAssemble[] all(){
        return ProductAssemble.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ProductAssemble.SINGLE.getValue() == value){
            return ProductAssemble.SINGLE.getName();
        }else if (ProductAssemble.GROUP.getValue() == value){
            return ProductAssemble.GROUP.getName();
        }else {
            return "";
        }
    }
}
