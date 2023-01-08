package com.sp.app.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.sp.app.member.MemberService;

public class LoginFailureHandler implements AuthenticationFailureHandler{
	@Autowired
	private MemberService service;
	
	private String defaultFailureUrl;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String email = request.getParameter("userId");
		
		String s = "아이디 또는 패스워드가 일치하지 않습니다.";
		
		try {
			if(exception instanceof BadCredentialsException) {
				// 패스워드가 일치하지 않는 경우
				
				// 실패 회수 누적
				service.updateFailureCount(email);
				int count = service.checkFailureCount(email);
				
				if(count >= 5) {
					// 계정 비활성화
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("enabled", 0);
					map.put("email", email);
					service.updateMemberEnabled(map);
					
				}
			} else if(exception instanceof InternalAuthenticationServiceException) {
				// 존재하지 않는 아이디
			} else if(exception instanceof DisabledException) {
				s = "계정이 비활성화 되었습니다. 관리자에게 문의하세요.";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("message", s);
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}
	
	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
	
}
