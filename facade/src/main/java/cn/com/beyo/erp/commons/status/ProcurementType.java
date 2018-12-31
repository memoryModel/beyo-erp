package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/9/7
 * 表名:erp_procurement 字段名:type
 * 采购管理：采购单类型
 * 0、系统采购
 * 1、人工采购
 */
public enum ProcurementType {
    /**
     *系统采购
     */
    SYSTEM {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "系统采购";
        }
    },
    /**
     * 人工采购
     */
    PERSON {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "人工采购";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static ProcurementType[] procurementTypeList(){
        return ProcurementType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String ProcurementTypeName(Integer value){
        if (ProcurementType.SYSTEM.getValue() == value){
            return ProcurementType.SYSTEM.getName();
        }else if (ProcurementType.PERSON.getValue() == value){
            return ProcurementType.PERSON.getName();
        }else {
            return "";
        }
    }
}
