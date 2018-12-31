package cn.com.beyo.erp.commons.utils;

import java.math.BigDecimal;

public class Test {
    public static void main(String[] args){
        BigDecimal decimal = new BigDecimal(171/24).setScale(0,BigDecimal.ROUND_HALF_UP);

        String s =  decimal.toString();
        System.out.println(s);
    }
}
