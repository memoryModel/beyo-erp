package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class OneportalServiceLauncher {

    public static void main(String[] args) throws IOException {
        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("spring-context.xml");

        context.start();
        System.out.println("--------------Provider OneportalService Started!-------------");
        System.in.read();
    }
}
