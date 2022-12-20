package com.sp.app.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

public class AjaxSessionTimeoutFilter implements Filter{

	private String ajaxHeader;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		if(isAjaxRequest(req)) {
			try {
				chain.doFilter(req, resp);
			} catch (AccessDeniedException e) {
				// 권한이 없거나 로그인되지 않은 경우 AccessDeniedException 예외가 발생
				resp.sendError(HttpServletResponse.SC_FORBIDDEN); // 403
			} catch (AuthenticationException e) {
				resp.sendError(HttpServletResponse.SC_UNAUTHORIZED); // 401
			}
		} else {
			chain.doFilter(req, resp);
		}
		
	}

	public void setAjaxHeader(String ajaxHeader) {
		this.ajaxHeader = ajaxHeader;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
		return req.getHeader(ajaxHeader) != null && 
				req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
 	}
	
}
