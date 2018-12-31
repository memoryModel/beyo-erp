package cn.com.beyo.erp.modules.oneportal.controller;


import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.modules.oneportal.entity.UserInfo;
import cn.com.beyo.erp.modules.oneportal.facade.UserInfoFacade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = "oneportal")
public class OneportalController {

    @Resource
    private UserInfoFacade userInfoFacade;

    @ModelAttribute
    public UserInfo get(@RequestParam(required=false) Long id) {
        UserInfo entity = null;

        entity = userInfoFacade.get(id);

        if (entity == null){
            return new UserInfo();
        }
        return entity;
    }


    @RequestMapping(value = "list")
    public String list(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response
                            , Model model) {
        Page<UserInfo> page = userInfoFacade.findPage(new Page<UserInfo>(request, response), userInfo);


        List<UserInfo> userInfoList = page.getList();
        if(userInfoList == null || userInfoList.size() ==0){
            model.addAttribute("page",page);
            return "modules/oneportal/onePortalList";
        }
        //将查询得到的list中employeNo放在数组
        String[] employeNoArray = new String[userInfoList.size()];
        for(int i = 0; i<userInfoList.size(); i++){
            employeNoArray[i] = userInfoList.get(i).getEmployeNo();
        }
        //通过数组的employeNo查询考勤情况
        userInfoList = userInfoFacade.findSignDetail(employeNoArray);
        page.setList(userInfoList);

        model.addAttribute("page",page);
        return "modules/oneportal/onePortalList";
    }
}
