package cn.com.beyo.erp.modules.sys.listener;

import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;

public class WebContextListener extends org.springframework.web.context.ContextLoaderListener {
	
	@Override
	public WebApplicationContext initWebApplicationContext(ServletContext servletContext) {
		return super.initWebApplicationContext(servletContext);
	}
}
