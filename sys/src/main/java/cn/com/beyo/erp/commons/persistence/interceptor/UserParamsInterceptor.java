package cn.com.beyo.erp.commons.persistence.interceptor;

import cn.com.beyo.erp.commons.config.Global;
import cn.com.beyo.erp.commons.status.CommonsType;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by wanghw on 2017/6/1.
 */
@Component
public class UserParamsInterceptor extends HandlerInterceptorAdapter {
    //private final Logger log = LoggerFactory.getLogger(getClass());
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
        request.setAttribute("commonsTypeEnum", CommonsType.values());
        request.setAttribute("cloudPublicSpace", Global.getCloudPublicSpace());
        request.setAttribute("cloudPrivateSpace", Global.getCloudPrivateSpace());
        return super.preHandle(request, response, handler);
    }

}
