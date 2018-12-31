package cn.com.beyo.erp.commons.persistence.interceptor;

import cn.com.beyo.erp.commons.utils.Utils;
import cn.com.beyo.security.ContentSecurity;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Component
public class APIParamsInterceptor extends HandlerInterceptorAdapter {

    private final Logger log = Logger.getLogger(this.getClass());
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
        response.setHeader("Content-Type", "application/json; charset=UTF-8");

//        if(!request.getMethod().equalsIgnoreCase("POST")){//只允许POST
//            response.getWriter().print(Utils.writeValueAsString(new UserResponse(500,"非法请求")));
//            return false;
//        }
//        if(Strings.isNullOrEmpty(request.getHeader("k"))){//http头时间
//            response.getWriter().print(Utils.writeValueAsString(new UserResponse(500,"非法来源")));
//            return false;
//        }
//
//        String k = GateSecurity.decrypt(request.getHeader("k"));//前后不超过10分钟的请求
//        if((System.currentTimeMillis()-Long.parseLong(k))>(1000*60*10)){
//            response.getWriter().print(Utils.writeValueAsString(new UserResponse(500,"请求已过期")));
//            return false;
//        }
//        if (Strings.isNullOrEmpty(request.getParameter("params"))){//没有加密参数
//            response.getWriter().print(Utils.writeValueAsString(new UserResponse(500,"非法参数")));
//            return false;
//        }

        try{
            String params = request.getParameter("params");//加密的参数
            params = ContentSecurity.decrypt(params);
            Map<String,Object> map = Utils.readValue(params,new HashMap<String,Object>().getClass());
            log.debug("params:"+map);
            request.setAttribute("userParams",new UserParams(map));
            return super.preHandle(request, response, handler);
        }catch(Exception e){
            log.error(e.getMessage(),e);
            response.getWriter().print(Utils.writeValueAsString(new UserResponse(500,"错误参数")));
            return false;
        }
    }

}
