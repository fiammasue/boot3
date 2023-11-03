package com.project.boot;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class AuthSucessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	@Override
    public void onAuthenticationSuccess(
    		HttpServletRequest request
    		, HttpServletResponse response 
    		, Authentication authentication //로그인한 사용자 정보가 있는 객체 
    		) throws IOException, ServletException {
		// 사용자 정보를 세션에 저장
        HttpSession session = request.getSession();
        session.setAttribute("loginMember", authentication.getPrincipal());
        
        String message = "로그인 되었습니다.";
        String encodeMessage = URLEncoder.encode(message,"UTF-8");
        
        // 다음으로 이동할 URL을 설정하고 리다이렉트
        setDefaultTargetUrl("/member/LoginMember.do?status=true&message="+encodeMessage); // 로그인 후 이동할 페이지
        super.onAuthenticationSuccess(request, response, authentication);
    }
}
