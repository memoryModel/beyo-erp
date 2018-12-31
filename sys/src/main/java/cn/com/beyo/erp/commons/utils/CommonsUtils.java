package cn.com.beyo.erp.commons.utils;

import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * Created by wanghw on 2017/6/1.
 */
@Component
public class CommonsUtils{

    @Autowired
    private Redis redis;

    private static CommonsUtils commonsUtils;

    @PostConstruct
    private void init(){
        commonsUtils = this;
        commonsUtils.redis = this.redis;
    }




    public static List<CommonsType> getCommonsTypeList(Integer category){
        return   (List<CommonsType>)commonsUtils.redis.get(RedisKey.COMMONS_TYPE_LIST+category);
    }

    public static String getCommonsTypeName(Long id){
        String name =  (String)commonsUtils.redis.get(RedisKey.COMMONS_TYPE_INFO+id);
        if (null==name){
            return "";
        }
        return name;
    }

    public static Employee getEmployeeInfo(Long id){
        return (Employee)commonsUtils.redis.get(RedisKey.EMPLOYEE_INFO+id);
    }
}
