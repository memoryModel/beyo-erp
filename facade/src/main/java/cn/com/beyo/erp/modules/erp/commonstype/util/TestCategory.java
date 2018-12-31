package cn.com.beyo.erp.modules.erp.commonstype.util;

/**
 * Created by Thinkpad on 2017/6/2.
 */
public class TestCategory {
    public static void main(String[] args){
        //输出每一个枚举
        System.out.print(Category.connectype.getName());
        System.out.print(Category.connectype.getIndex());

        //遍历所有枚举
        for (Category TestCategory : Category.values()){
            System.out.println(TestCategory + "name:"+TestCategory.getName()+ "  index: " + TestCategory.getIndex() );
        }
    }
}
