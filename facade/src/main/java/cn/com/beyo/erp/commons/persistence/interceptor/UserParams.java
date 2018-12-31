package cn.com.beyo.erp.commons.persistence.interceptor;

import java.math.BigDecimal;
import java.util.Map;

/**
 * Created by wanghw on 2016-07-01.
 * 自定义参数装箱对象
 * 如果直接使用HashMap会被Spring忽略,而自定义的WebArgumentResolver优先级太低,无法自动装箱到Controller的参数列表中
 */
public class UserParams{

    public UserParams(Map<String, Object> params) {
        this.requestParams = params;
    }

    private Map<String,Object> requestParams;

    public Map<String, Object> getRequestParams() {
        return requestParams;
    }

    public void setRequestParams(Map<String, Object> requestParams) {
        this.requestParams = requestParams;
    }

    public String getStringParams(String name) {
        return getStringParams(name,"");
    }
    public String getStringParams(String name,String defaultValue) {
        Object object = this.requestParams.get(name);
        if (null==object){
            return defaultValue;
        }else{
            return object.toString();
        }
    }
    public Integer getIntegerParams(String name){
        return getIntegerParams(name,0);
    }
    public Integer getIntegerParams(String name,Integer defaultValue) {
        Object object = this.requestParams.get(name);
        if (null==object){
            return defaultValue;
        }else if(object instanceof String){
            return Integer.parseInt(object.toString());
        }else{
            return (Integer)object;
        }
    }
    public Long getLongParams(String name){
        return getLongParams(name,0L);
    }

    public Long getLongParams(String name,Long defaultValue) {
        Object object = this.requestParams.get(name);
        if (null==object){
            return defaultValue;
        }else if(object instanceof Integer){
            return (Integer)object*1L;
        }else if(object instanceof BigDecimal){
            return ((BigDecimal) object).longValue();
        }else if(object instanceof String){
            return Long.parseLong(object.toString());
        }else{
            return (Long)object;
        }
    }
    public Double getDoubleParams(String name) {
        return getDoubleParams(name,0.0);
    }
    public Double getDoubleParams(String name,Double defaultValue) {
        Object object = this.requestParams.get(name);
        if (null==object){
            return defaultValue;
        }else if(object instanceof Float){
            return (Double)object;
        }else if(object instanceof BigDecimal){
            return ((BigDecimal) object).doubleValue();
        }else{
            return (Double)object;
        }
    }
}
