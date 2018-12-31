package cn.com.beyo.erp.commons.status;

/**
 * Created by Thinkpad on 2017/7/5.
 */
public enum ClassStudentsStatus {
    /**
     * 在读
     */
    STUDY {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "在读";
        }
    },
    /**
     * 退班
     */
    QUIT {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "退班";
        }
    },
    /**
     * 毕业
     */
    GRADUATE {
        public Integer getValue() {
            return 2;
        }

        public String getName() {
            return "毕业";
        }
    },
    /**
     * 毕业已办证书
     */
    CERTIFICATE {
        public Integer getValue() {
            return 3;
        }

        public String getName() {
            return "已办证书";
        }
    },
    /**
     * 报名未开班
     */
    READY {
        public Integer getValue() {
            return 4;
        }

        public String getName() {
            return "报名未开班";
        }


    },
    /**
     * 作用查询用
     * */
    FILTER {
        public Integer getValue() {
            return 9;
        }

        public String getName() {
            return "查询作用";
        }
    };



    public abstract Integer getValue();

    public abstract String getName();





    public static ClassStudentsStatus[] ClassStudentsList(){
        return ClassStudentsStatus.values();
    }

    public static String ClassStudentsName(Integer value){
        if (ClassStudentsStatus.STUDY.getValue() == value){
            return ClassStudentsStatus.STUDY.getName();
        }else if (ClassStudentsStatus.QUIT.getValue() == value){
            return ClassStudentsStatus.QUIT.getName();
        }else if (ClassStudentsStatus.GRADUATE.getValue() == value){
            return ClassStudentsStatus.GRADUATE.getName();
        }else if (ClassStudentsStatus.CERTIFICATE.getValue() == value){
            return ClassStudentsStatus.CERTIFICATE.getName();
        }else if (ClassStudentsStatus.READY.getValue() == value){
            return ClassStudentsStatus.READY.getName();
        }else {
            return "";
        }
    }
}
