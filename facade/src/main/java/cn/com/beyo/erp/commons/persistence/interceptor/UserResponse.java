package cn.com.beyo.erp.commons.persistence.interceptor;

import cn.com.beyo.erp.commons.config.Global;
import cn.com.beyo.erp.commons.utils.Utils;
import cn.com.beyo.security.ContentSecurity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wanghw on 2016-07-01.
 */

public class UserResponse {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    private boolean isDebug = Global.getAPIDebug();//开关


    private Integer status;
    private String message;
    private String response;

    private String debug;

    private Map<String,Object> params;

    public UserResponse(){
        this.status = 200;
        this.message = "success";
        this.params = new HashMap<String, Object>();
    }
    public UserResponse(Integer status, String message){
        this.status = status;
        this.message = message;
        this.params = new HashMap<String, Object>();
    }

    public UserResponse(Integer status, String message, Map<String,Object> params){
        this.status = status;
        this.message = message;
        this.params = params;
    }
    public UserResponse(Map<String,Object> params){
        this.status = 200;
        this.message = "success";
        this.params = params;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


    public String getResponse() {
        try{
            this.response = ContentSecurity.encrypt(Utils.writeValueAsString(this.params));
        }catch(Exception e){
            this.response = "{}";
            this.status = 500;
            this.message = "encrypt fail";
        }
        return this.response;
    }

    public String getDebug() {
        if (!isDebug)return "false";
        try{
            return Utils.writeValueAsString(this.params);
        }catch(Exception e){
            log.error(e.getMessage(),e);
        }
        return "json error";
    }
}
