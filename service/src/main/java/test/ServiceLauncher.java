package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class ServiceLauncher {

    public static void main(String[] args) throws IOException {

        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("spring-context.xml");

        context.start();
        System.out.println("--------------Provider Server Started!-------------");
        System.in.read();

    }
}
