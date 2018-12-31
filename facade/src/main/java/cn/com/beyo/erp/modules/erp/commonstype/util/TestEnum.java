package cn.com.beyo.erp.modules.erp.commonstype.util;

/**
 * Created by Thinkpad on 2017/6/2.
 */
public class TestEnum {
    public enum categorySelcet{
        connectype(),leavereason,droppedreason,typeleave,joborientation,studenttype,educationallevel;
        private  String name;

        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
    }
    public static void main(String[] args){
        String aa;
        aa= categorySelcet.connectype.name;
        System.out.print(aa);
    }
}
