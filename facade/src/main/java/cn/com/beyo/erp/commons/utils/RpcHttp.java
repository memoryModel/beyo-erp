package cn.com.beyo.erp.commons.utils;

import cn.com.beyo.erp.commons.persistence.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;

public class RpcHttp implements Serializable {

    private static final long serialVersionUID = 1L;

    private Page page;

    public RpcHttp(){}

    public RpcHttp(Page page) {
        this.page = page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public Page getPage() {
        return page;
    }
}
