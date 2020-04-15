package com.jeefw.security;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jeefw.model.sys.SysUser;
import com.jeefw.service.sys.SysUserService;

/**
 * A Spring MVC interceptor that adds the currentUser into the request as a request attribute before the JSP is rendered. This operation is assumed to be fast because the User should be cached in the Hibernate
 * second-level cache.
 */
@Component
public class CurrentUserInterceptor extends HandlerInterceptorAdapter {

	@Resource
	private SysUserService sysUserService;

	
	//后处理（调用了Service并返回ModelAndView，但未进行页面渲染）
	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
		// Add the current user into the request
		//SecurityUtils.getSubject()得到当前用户
		String url = httpServletRequest.getScheme()+"://";
		url += httpServletRequest.getHeader("host");//请求服务器
		url += httpServletRequest.getRequestURI();//工厂名
		if(httpServletRequest.getQueryString()!=null) //判断请求参数是否为空  
			url+="?"+httpServletRequest.getQueryString();   // 参数   
		if(!url.contains("/static"))
		System. out.println("请求的地址是：" + url);    
			
		
		/*final Long currentUserId = (Long) SecurityUtils.getSubject().getPrincipal();
		SysUser currentUser = sysUserService.get(currentUserId);
		if (currentUser != null) {
			httpServletRequest.setAttribute("currentUser", currentUser);
		}*/
	}

}
