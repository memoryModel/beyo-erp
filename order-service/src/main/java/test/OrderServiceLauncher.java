package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class OrderServiceLauncher {
    public static void main(String[] args) throws IOException {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("spring-context.xml");
        context.start();
        System.out.println("--------------Provider OrderServer Started!-------------");
        System.in.read();
    }
}
