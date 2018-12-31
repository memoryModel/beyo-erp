package cn.com.beyo.erp.commons.status;

/**
 * Created by mac on 2017/12/20
 * 表名:crm_interview 字段名:interview_status
 * 面试管理：面试确认状态
 * 0、未提交
 * 1、已提交
 * 2、解约已退回
 * 3、续约已退回
 * 4、解约已提交
 * 5、续约成功
 */
public enum EmployeeRenewStatus {

    /**
     * 未提交
     */

    UNSUBMITTED {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "未提交";
        }
    },
    /**
     * 已提交
     */
    REBEWSUBMITTE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "续约申请已提交";
        }

    },
    /**
     * 解约已退回
     */
    CANCELLATIONRETURN {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "解约已退回";
        }
    },
    /**
     * 续约已退回
     */
    RENEWRETURN {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "续约已退回";
        }
    },
    /**
     * 解约已提交
     */
    CANCELLATIONSUBMITTE {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "解约申请已提交";
        }
    },
    /**
     * 续约成功
     */
    RENEWALSUCCESS {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "续约成功";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static EmployeeRenewStatus[] employeeRenewList(){
        return EmployeeRenewStatus.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String employeeRenewName(Integer value){
        if (EmployeeRenewStatus.UNSUBMITTED.getValue() == value){
            return EmployeeRenewStatus.UNSUBMITTED.getName();
        }else if (EmployeeRenewStatus.REBEWSUBMITTE.getValue() == value){
            return EmployeeRenewStatus.REBEWSUBMITTE.getName();
        }else if (EmployeeRenewStatus.CANCELLATIONRETURN.getValue() == value){
            return EmployeeRenewStatus.CANCELLATIONRETURN.getName();
        }else if (EmployeeRenewStatus.RENEWRETURN.getValue() == value){
            return EmployeeRenewStatus.RENEWRETURN.getName();
        }else if (EmployeeRenewStatus.CANCELLATIONSUBMITTE.getValue() == value){
            return EmployeeRenewStatus.CANCELLATIONSUBMITTE.getName();
        }else if (EmployeeRenewStatus.RENEWALSUCCESS.getValue() == value){
            return EmployeeRenewStatus.RENEWALSUCCESS.getName();
        }else {
            return "";
        }
    }
}
