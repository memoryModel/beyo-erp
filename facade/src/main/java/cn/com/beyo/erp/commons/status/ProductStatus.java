package cn.com.beyo.erp.commons.status;

/**
 * Created by wanghw on 2017/7/13.
 */

public enum ProductStatus {
    /**
     * 未上架
     */
    DRAFT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "仓库中";
        }
    },
    /**
     * 已上架
     */
    PUBLISH {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "已上架";
        }
    },
    /**
     * 已下架
     */
    /*CANCEL {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "下架";
        }
    },*/
    /**
     * 定时上架
     */
    PLAN {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "定时上架";
        }
    },
    /**
     * 删除
     */
    DELETE {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "已删除";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ProductStatus[] all(){
        return ProductStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (ProductStatus.DRAFT.getValue() == value){
            return ProductStatus.DRAFT.getName();
        }else if (ProductStatus.PUBLISH.getValue() == value){
            return ProductStatus.PUBLISH.getName();
        /*}else if (ProductStatus.CANCEL.getValue() == value){
            return ProductStatus.CANCEL.getName();*/
        }else if (ProductStatus.PLAN.getValue() == value){
            return ProductStatus.PLAN.getName();
        }else if (ProductStatus.DELETE.getValue() == value){
            return ProductStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}

/*
public enum ProductStatus {
    */
/**
     * 未上架
     *//*

    DRAFT {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "仓库";
        }
    },
    */
/**
     * 已上架
     *//*

    PUBLISH {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "上架";
        }
    },
    */
/**
     * 已下架
     *//*

    CANCEL {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "下架";
        }
    },
    */
/**
     * 定时上架
     *//*

    PLAN {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "定时上架";
        }
    },
    */
/**
     * 删除
     *//*

    DELETE {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "删除";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();




    */
/**
     * 返回状态列表
     * *//*

    public static ProductStatus[] all(){
        return ProductStatus.values();
    }

    */
/**
     * 查找返回状态名称
     * *//*

    public static String findName(Integer value){
        if (ProductStatus.DRAFT.getValue() == value){
            return ProductStatus.DRAFT.getName();
        }else if (ProductStatus.PUBLISH.getValue() == value){
            return ProductStatus.PUBLISH.getName();
        }else if (ProductStatus.CANCEL.getValue() == value){
            return ProductStatus.CANCEL.getName();
        }else if (ProductStatus.PLAN.getValue() == value){
            return ProductStatus.PLAN.getName();
        }else if (ProductStatus.DELETE.getValue() == value){
            return ProductStatus.DELETE.getName();
        }else {
            return "";
        }
    }
}*/
