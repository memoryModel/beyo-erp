package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/6/1.
 */
public enum NextCommunicationArrangementStatus {

    /**
     * 有
     * */
    YES{
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "有";
        }
    },
    /**
     * 无
     * */
    NO{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "无";
        }
    };


    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static NextCommunicationArrangementStatus[] nextCommunicationArrangementStatusList(){
        return NextCommunicationArrangementStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String nextCommunicationArrangementStatusName(Integer value){
        if (NextCommunicationArrangementStatus.YES.getValue() == value || value == null){
            return NextCommunicationArrangementStatus.YES.getName();
        }else if (NextCommunicationArrangementStatus.NO.getValue() == value){
            return NextCommunicationArrangementStatus.NO.getName();
        }else {
            return "";
        }
    }
}
