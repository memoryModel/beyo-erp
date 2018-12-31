package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/14.
 */
public enum UploadStatus {
    /**
     * 上传中
     */
    UPLOADMIDDLE{
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "上传中";
        }
    },
    /**
     * 已上传
     */
    ALREADYUPLOAD{
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "已上传";
        }
    }
    ,
    /**
     * 已删除
     */
    ALREADYDELETE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已删除";
        }
    };
    public abstract Integer getValue();

    public abstract String getName();

    public static UploadStatus[] uploadStatusList(){
        return UploadStatus.values();
    }

    public static String uploadStatusName(Integer value){
        if (UploadStatus.UPLOADMIDDLE.getValue() == value){
            return UploadStatus.UPLOADMIDDLE.getName();
        }else if (UploadStatus.ALREADYUPLOAD.getValue() == value){
            return UploadStatus.ALREADYUPLOAD.getName();
        }else if (UploadStatus.ALREADYDELETE.getValue() == value){
            return UploadStatus.ALREADYDELETE.getName();
        }else {
            return "";
        }
    }
}
