package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class SysServiceLauncher {

    public static void main(String[] args) throws IOException {
        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("spring-context.xml");

        context.start();
        System.out.println("--------------Provider SysService Started!-------------");
        System.in.read();
    }
}
