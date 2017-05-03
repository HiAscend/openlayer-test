package com.zzia;

import java.math.BigDecimal;

/**
 * Created by ascend on 2017/5/3 10:03.
 */
public class Test {
    public static void main(String[] args) {
        BigDecimal longitude = new BigDecimal("12938743.773523552");
        BigDecimal base = new BigDecimal(256);
        BigDecimal result = longitude.divide(base);
        System.out.println("result = " + result);
    }
}
