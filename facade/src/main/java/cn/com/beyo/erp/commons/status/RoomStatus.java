package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum RoomStatus {
    /**
     * 住宿
     */
    YES {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "是";
        }
    },
    /**
     * 女
     */
    NO {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "否";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static RoomStatus[] roomStatusList(){
        return RoomStatus.values();
    }

    public static String roomStatusName(Integer value){
        if (RoomStatus.YES.getValue() == value){
            return RoomStatus.YES.getName();
        }else if (RoomStatus.NO.getValue() == value){
            return RoomStatus.NO.getName();
        }else {
            return "";
        }
    }
}
