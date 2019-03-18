package cn.com.beyo.erp.commons.service;

import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.modules.erp.commonstype.entity.CommonsType;
import cn.com.beyo.erp.modules.erp.commonstype.facade.CommonsTypeFacade;
import cn.com.beyo.erp.modules.erp.employee.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by wanghw on 2017/6/5.
 */
@Service
public class InitService {

    @Autowired
    private Redis redis;
    @Resource
    private CommonsTypeFacade commonsTypeFacade;



    @PostConstruct
    private void initCommonsTypeList(){



        CommonsType commonsType = new CommonsType();
        commonsType.setStatus(0);
        List<CommonsType> list = commonsTypeFacade.findList(commonsType);

        Set<Integer> categorySet = new HashSet<>();
        for(CommonsType row : list){
            categorySet.add(row.getCategory());

            redis.set(RedisKey.COMMONS_TYPE_INFO+row.getId(),row.getCommonsName());
        }

        List<CommonsType> categoryList;
        for(Integer category:categorySet){

            categoryList = new ArrayList<>();

            for(CommonsType row : list){
                if (category.intValue() == row.getCategory().intValue()){

                    categoryList.add(row);
                }
            }

            redis.set(RedisKey.COMMONS_TYPE_LIST+category,categoryList);

        }

        //删除

        commonsType.setStatus(1);
        list = commonsTypeFacade.findList(commonsType);
        for(CommonsType row : list){
            redis.del(RedisKey.COMMONS_TYPE_INFO+row.getId());
        }
    }
    /**
     * 更新了CommonsType时调用
     * */
    public void updateCommonsTypeList(){

        initCommonsTypeList();
    }


    public void updateEmployee(Employee employee){
        redis.set(RedisKey.EMPLOYEE_INFO+ employee.getId(), employee);
    }

}
