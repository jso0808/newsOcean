package com.sp.app.security;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	@Autowired
	private MemberService service;
	
	private String defaultUrl;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		// 로그인 날짜 변경
		try {
			// authentication.getName() : 로그인 아이디. (이메일)
			service.updateLastLogin(authentication.getName());
		} catch (Exception e) {
		}
		
		// 세션에 로그인 유저 정보 저장
		HttpSession session = request.getSession();
		
		Member member = service.readMember(authentication.getName());
		
		SessionInfo info = new SessionInfo();
		info.setMemberNo(member.getMemberNo());
		info.setEmail(member.getEmail());
		info.setName(member.getName());
		info.setNickName(member.getNickName());
		info.setMemberShip(member.getMemberShip());
		info.setAuthority(member.getAuthority());
		
		session.setAttribute("member", info);
		
		// 패스워드 변경이 90일 이상인 경우 패스워드 변경 창으로 이동
		try {
			Date endDate = new Date();
			long gap;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date modifyDate = sdf.parse(member.getModifyDate());
			gap = (endDate.getTime() - modifyDate.getTime()) / (24*60*60*1000);
			
			if(gap >= 90) {
				String targetUrl = "/member/updatePwd";
				redirectStrategy.sendRedirect(request, response, targetUrl);
				return;
			}
		} catch (Exception e) {
		}
		
		// redirect 설정
		resultRedirectStrategy(request, response, authentication);
	}
	
	protected void resultRedirectStrategy(HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if(savedRequest != null) {
			// 권한이 필요한 페이지에 접근한 경우
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetUrl);
		} else {
			// 직접 로그인 주소를 클릭한 경우
			redirectStrategy.sendRedirect(request, response, defaultUrl);
		}
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

}
