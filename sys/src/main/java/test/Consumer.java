package test;

import cn.com.beyo.erp.modules.oneportal.entity.DepartmentInfo;
import cn.com.beyo.erp.modules.oneportal.entity.SignDetail;
import cn.com.beyo.erp.modules.oneportal.entity.UserInfo;
import cn.com.beyo.erp.modules.oneportal.facade.DepartmentInfoFacade;
import cn.com.beyo.erp.modules.oneportal.facade.SignDetailFacade;
import cn.com.beyo.erp.modules.oneportal.facade.UserInfoFacade;
import cn.com.beyo.erp.modules.school.areas.entity.Areas;
import cn.com.beyo.erp.modules.school.areas.facade.AreasFacade;
import cn.com.beyo.erp.modules.sys.entity.Area;
import cn.com.beyo.erp.modules.sys.facade.AreaFacade;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class Consumer {

    public static void main(String[] args) {

        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("spring-context.xml");
        context.start();
        /*AreasFacade areasFacade =  (AreasFacade) context.getBean("areasFacade");
        Areas areas = areasFacade.get(1L);
        System.out.println(areas);*/

        /*AreaFacade areaFacade = (AreaFacade)context.getBean("areaFacade");
        List<Area> list = areaFacade.findAll();
        for (Area area:list) {
            System.out.println(area);
        }*/

        /*DepartmentInfoFacade departmentInfoFacade = (DepartmentInfoFacade)context.getBean("departmentInfoFacade");
        DepartmentInfo departmentInfo = departmentInfoFacade.get(120L);
        System.out.println(departmentInfo);

        SignDetailFacade signDetailFacade = (SignDetailFacade)context.getBean("signDetailFacade");
        SignDetail signDetail = signDetailFacade.get(85324L);
        System.out.println(signDetail);*/

        /*UserInfoFacade userInfoFacade = (UserInfoFacade)context.getBean("userInfoFacade");
        *//*UserInfo userInfo = userInfoFacade.get(1464L);
        System.out.println(userInfo);*//*
       UserInfo userInfo = new UserInfo();
       userInfo.setEmployeNo("561516");

        UserInfo userInfo2 = userInfoFacade.findSignDetail(userInfo);
        System.out.println(userInfo2);*/
    }
}
