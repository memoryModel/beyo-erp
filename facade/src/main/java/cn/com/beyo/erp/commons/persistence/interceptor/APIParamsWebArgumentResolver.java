package cn.com.beyo.erp.commons.persistence.interceptor;

import org.apache.log4j.Logger;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.context.request.NativeWebRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by wanghw on 2016-07-01.
 */
@Component
public class APIParamsWebArgumentResolver implements WebArgumentResolver {
    private final Logger log = Logger.getLogger(this.getClass());

    @Override
    public Object resolveArgument(MethodParameter methodParameter, NativeWebRequest nativeWebRequest) throws Exception {
        if(methodParameter.getParameterType().equals(UserParams.class)) {
            HttpServletRequest nativeRequest = (HttpServletRequest) nativeWebRequest.getNativeRequest();
            UserParams userParams = (UserParams) nativeRequest.getAttribute("userParams");
            return userParams;
        }
        return UNRESOLVED;
    }
}
