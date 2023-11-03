package com.project.boot.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.project.boot.dto.Member;

public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request,
							HttpServletResponse response, Object handler) throws IOException {
		
		HttpSession session = request.getSession();
		
		Member member =(Member) session.getAttribute("loginMember");
		if(member!=null && member.isAdmin()) {
			return true;
		}
		response.sendRedirect(request.getContextPath()+"/main/Index.do");
		return false;
	}
	
	
	
}
