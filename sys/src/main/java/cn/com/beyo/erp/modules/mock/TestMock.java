package cn.com.beyo.erp.modules.mock;

public class TestMock implements IGpHello {
    @Override
    public String sayHello(String s) {

        return "系统繁忙" + s;
    }
}
