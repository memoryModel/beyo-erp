package cn.com.beyo.erp.modules.erp.commonstype.util;

/**
 * Created by Thinkpad on 2017/6/2.
 */
public enum Category {
    connectype("connectype",1),
    leavereason("leavereason",2),
    droppedreason("droppedreason",3),
    typeleave("typeleave",4),
    joborientation("joborientation",5),
    studenttype("studenttype",6),
    educationallevel("educationallevel",7);

    private String name ;
    private int index ;

    //有参构造
    private Category(String name, int index){
        this.name = name;
        this.index = index;
    }

    //get，set方法
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

}
