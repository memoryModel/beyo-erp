package cn.com.beyo.erp.commons.status;

/**
 * 通用类型分类
 * Created by wanghw on 2017/6/1.
 */
public enum CommonsType {
    /**
     * 沟通类型
     */
    COMMUNICATION {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "沟通类型";
        }
    },

    /**
     * 离职原因
     */
    LEAVINGREASON {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "离职原因";
        }
    },

    /**
     * 退班原因
     */
    DROPOUTREASON {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "退班原因";
        }
    },

    /**
     * 休假原因
     */
    VACATIONREASON {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "休假原因";
        }
    },

    /**
     * 就业方向
     */
    JOBPATH {
        public Integer getValue() {
            return 5;
        }

        public String getName() {
            return "就业方向";
        }
    },


    /**
     * 学历
     */
    EDUCATIONLEVEL {
        public Integer getValue() {
            return 7;
        }

        public String getName() {
            return "学历";
        }
    },

    /**
     * 跟进形式
     */
    SALEFOLLOW {
        public Integer getValue() {
            return 8;
        }

        public String getName() {
            return "跟进形式";
        }
    },
    /**
     * 跟进阶段
     */
    SALESTAGE {
        public Integer getValue() {
            return 9;
        }

        public String getName() {
            return "跟进阶段";
        }
    },

    /**
     * 商品管理
     */
    PRODUCT{
        public Integer getValue() {
            return 10;
        }

        public String getName() {
            return "商品类型";
        }
    },
    /**
     * 特长
     */
    SPECIALITY{
        public Integer getValue() {
            return 11;
        }

        public String getName() {
            return "特长";
        }
    },
    /**
     *职业方向
     */
    DIRECYION{
        public Integer getValue() {
            return 12;
        }

        public String getName() {
            return "职业方向";
        }
    },
    /**
     *财务科目
     */
    FINCETYPE{
        public Integer getValue() {
            return 13;
        }

        public String getName() {
            return "财务科目设置";
        }
    },

    /**
     *宿舍成本类型
     */
    DORMCOSTTYPE{
        public Integer getValue() {
            return 14;
        }

        public String getName() {
            return "宿舍成本类型";
        }
    },

    /**
     *退费类型
     */
    REFUNDTYPE{
        public Integer getValue() {
            return 15;
        }

        public String getName() {
            return "退费类型";
        }
    },

    /**
     *支出付款方式
     */
    SPENDINGPAYTYPE{
        public Integer getValue() {
            return 16;
        }

        public String getName() {
            return "支付方式";
        }
    },
    /**
     *居住类型
     */
    LIVETYPE {
        public Integer getValue() {
            return 17;
        }

        public String getName() {
            return "居住类型";
        }
    },
    /**
     *收款方式
     */
    PAYMETHODS {
        public Integer getValue() {
            return 18;
        }

        public String getName() {
            return "收款方式";
        }
    },
    /**
     *收款类型
     */
    PAYTYPE {
            public Integer getValue() {
                return 19;
            }

        public String getName() {
            return "收款类型";
        }
    },

    /**
     *(考试)发放试卷规则
     */
    REGULATION {
        public Integer getValue() {
            return 20;
        }

        public String getName() {
            return "发放试卷规则";
        }
    },
    /**
     * 专业
     */
    PROFESSIONAL {
        public Integer getValue() {
            return 21;
        }

    public String getName() {
        return "专业";
    }
    },
    /**
     * 付款类型
     */
    PAYMENTTYPE{
        public Integer getValue() {
            return 22;
        }

        public String getName() {
            return "付款类型";
        }
    },
    /**
     * 付款类型
     */
    AREANAME{
        public Integer getValue() {
            return 23;
        }

        public String getName() {
            return "付款类型";
        }
    },
    /**
     * 成单几率
     */
    ORDERFORMPERCENTAGE{
        public Integer getValue() {
                    return 24;
                }

        public String getName() {
                    return "成单几率";
                }
    },
    /**
     * 考试类型
     */
    INFOTYPE{
        public Integer getValue() {
            return 25;
        }

        public String getName() {
            return "考试类型";
        }
    },
    /**
     * 考试方式
     */
    INFOMETHOD{
        public Integer getValue() {
            return 26;
        }

        public String getName() {
            return "考试方式";
        }
    },
    /**
     * 及格标记
     */
    PASSTHETAG{
        public Integer getValue() {
            return 27;
        }

        public String getName() {
            return "及格标记";
        }
    },
    /**
     * 请假类型
     */
    LEAVETYPE{
        public Integer getValue() {return 28;}

        public String getName() {return "请假类型";}

    },
    /**
     * 供应商
     */
    SUPPLIER{
    public Integer getValue() {return 29;}

    public String getName() {return "供应商";}
    },
    /**
     * 试题类型
     */
    QUESTIONTYPE{
        public Integer getValue() {return 30;}

        public String getName() {return "试题类型";}
    }

    ,
    /**
     * 图片状态
     */
   UPLOADFILES{
        public Integer getValue() {return 31;}

        public String getName() {return "图片状态";}

    },
    /**
     * 生源下次跟进类型
     */
    XIACIGENJIN{
        public Integer getValue() {return 32;}

        public String getName() {return "下次跟进类型";}
    },

    /**
     * 订单类型
     */
    ORDERTYPE{
        public Integer getValue() {return 35;}

        public String getName() {return "订单类型";}

    },
    /**
     * 补课状态
     */
    MAKELESSON{
        public Integer getValue() {return 36;}

        public String getName() {return "补课状态";}

    },
    /**
     * 审批类型
     */
    APPROVETYPE{
        public Integer getValue() {return 37;}

        public String getName() {return "审批类型";}
    },
    /**
     * 发票类型
     */
    INVOICETYPE{
        public Integer getValue() {return 38;}

        public String getName() {return "发票类型";}
    },
    /**
     * 发票类型
     */
    INVOICECONTENT{
        public Integer getValue() {return 39;}

        public String getName() {return "发票内容";}
    },
    /**
     * 发票收款单位
     */
    INVOICESKDW{
        public Integer getValue() {return 40;}

        public String getName() {return "收款单位";}
    },
    /**
     * 员工职位
     */
    POSITION{
        public Integer getValue() {return 41;}

        public String getName() {return "员工职位";}
    },
    /**
     * 员工级别
     */
    EMPLOYEERANK{
        public Integer getValue() {return 42;}

        public String getName() {return "员工级别";}

    },
    /**
     * 民族
     */
    NATION{
        public Integer getValue() {return 43;}

        public String getName() {return "民族";}

    },
    /**
     * 发票内容
     */
    INVOICE_SUBJECT{
        public Integer getValue() {return 44;}

        public String getName() {return "发票内容";}

    },
    /**
     * 发票单位
     */
    INVOICE_PAYEE{
        public Integer getValue() {return 45;}

        public String getName() {return "开票单位";}

    },

    /**
     * 外语等级
     */
    lENGLISHVEVEL{
        public Integer getValue() {return 46;}

    public String getName() {return "外语等级";}

},

    /**
     * 政治面貌
     */
    POLITICALOUTLOOK{
        public Integer getValue() {return 47;}

        public String getName() {return "政治面貌";}

    },

    /**
     * 户口性质
     */
    FAMILYNATURE{
        public Integer getValue() {return 48;}

        public String getName() {return "户口性质";}

    },

    /**
     * 客户意向
     */
    CUSTOMERINTENTION{
        public Integer getValue() {return 49;}

        public String getName() {return "客户意向";}

    },
    /**
     * 班级类型
     */
    CLASSTYPE{
        public Integer getValue() {return 50;}

    public String getName() {return "班型";}

    },
    /**
     * 升级原因
     */
    UPGRADEREASON{
        public Integer getValue() {return 51;}

        public String getName() {return "升级原因";}

    },
    /**
     * 降级原因
     */
    DOWNGRADEREASON{
        public Integer getValue() {return 52;}

        public String getName() {return "降级原因";}

    },
    /**
     *可服务时间
     */
    SERVICETIME{
        public Integer getValue() {return 53;}

        public String getName() {return "可服务时间";}
    }
    ,
    /**
     *重要程度
     */
    IMPORTANTDEGREE{
        public Integer getValue() {return 54;}

        public String getName() {return "重要程度";}

    },
    /**
     *客户跟进形式
     */
    FOLLOWTYPE{
        public Integer getValue() {return 55;}

        public String getName() {return "跟进形式";}
    },
    /**
     *星座
     */
    CONSTELLATION{
        public Integer getValue() {return 56;}

        public String getName() {return "星座";}
    },
    /**
     *血型
     */
    BLOODTYPE{
        public Integer getValue() {return 57;}

        public String getName() {return "血型";}
    },
    /**
     *证件类型
     */
    CREDENTIAL{
        public Integer getValue() {return 58;}

        public String getName() {return "证件类型";}
    },
    /**
     *意向业务
     */
    SERVICETYPE{
        public Integer getValue() {return 59;}

        public String getName() {return "意向业务";}
    },
    /**
     *客户与宝宝的关系
     */
    RELATION{
        public Integer getValue() {return 60;}

        public String getName() {return "客户与宝宝的关系";}
    };

    public abstract Integer getValue();

    public abstract String getName();


    /**
     * 返回状态列表
     * */
    public static CommonsType[] all(){
        return CommonsType.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){


        switch (value){
            case 1:
                return CommonsType.COMMUNICATION.getName();
            case 2:
                return CommonsType.LEAVINGREASON.getName();

            case 4:
                return CommonsType.VACATIONREASON.getName();
            case 5:
                return CommonsType.JOBPATH.getName();

            case 7:
                return CommonsType.EDUCATIONLEVEL.getName();
            case 8:
                return CommonsType.SALEFOLLOW.getName();
            case 9:
                return CommonsType.SALESTAGE.getName();
            case 10:
                return CommonsType.PRODUCT.getName();
            case 11:
                return CommonsType.SPECIALITY.getName();
            case 12:
                return CommonsType.DIRECYION.getName();
            case 13:
                return CommonsType.FINCETYPE.getName();
            case 14:
                return CommonsType.DORMCOSTTYPE.getName();
            case 15:
                return CommonsType.REFUNDTYPE.getName();
            case 16:
                return CommonsType.SPENDINGPAYTYPE.getName();
            case 17:
                return CommonsType.LIVETYPE.getName();
            case 18:
                return CommonsType.PAYMETHODS.getName();
            case 19:
                return CommonsType.PAYTYPE.getName();
            case 20:
                return CommonsType.REGULATION.getName();
            case 22:
                return CommonsType.PAYMENTTYPE.getName();
            case 25:
                return CommonsType.INFOTYPE.getName();
            case 26:
                return CommonsType.INFOMETHOD.getName();
            case 27:
                return CommonsType.PASSTHETAG.getName();
            case 29:
                return CommonsType.SUPPLIER.getName();
            case 30:
                return CommonsType.QUESTIONTYPE.getName();
            case 32:
                return CommonsType.XIACIGENJIN.getName();
            case 35:
                return CommonsType.ORDERTYPE.getName();
            case 36:
                return CommonsType.MAKELESSON.getName();
            case 37:
                return CommonsType.APPROVETYPE.getName();
            case 38:
                return CommonsType.INVOICETYPE.getName();
            case 39:
                return CommonsType.INVOICECONTENT.getName();
            case 40:
            return CommonsType.INVOICESKDW.getName();
            case 41:
            return CommonsType.POSITION.getName();
            case 42:
            return CommonsType.EMPLOYEERANK.getName();
            case 43:
            return CommonsType.NATION.getName();
            case 44:
                return CommonsType.lENGLISHVEVEL.getName();
            case 47:
                return CommonsType.POLITICALOUTLOOK.getName();
            case 48:
                return CommonsType.POLITICALOUTLOOK.getName();
            case 49:
                return CommonsType.CUSTOMERINTENTION.getName();
            case 50:
                return CommonsType.CLASSTYPE.getName();
            case 51:
                return CommonsType.UPGRADEREASON.getName();
            case 52:
                return CommonsType.DOWNGRADEREASON.getName();
            case 53:
                return CommonsType.SERVICETIME.getName();
            case 54:
                return CommonsType.IMPORTANTDEGREE.getName();
            case 55:
                return CommonsType.FOLLOWTYPE.getName();
            case 56:
                return CommonsType.CONSTELLATION.getName();
            case 57:
                return CommonsType.BLOODTYPE.getName();
            case 58:
                return CommonsType.CREDENTIAL.getName();
            case 59:
                return CommonsType.SERVICETYPE.getName();
            case 60:
                return CommonsType.RELATION.getName();
            default:
                return "";
        }
    }
}
