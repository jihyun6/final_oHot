package com.ohot.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler{

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		// 요청 URI
		String requestURI = request.getRequestURI();
		log.info("CustomLogoutSuccessHandler -> requestURI : " + requestURI);

		String redirectPath = "";
		
		if (requestURI.startsWith("/oho")) {
            redirectPath = "/oho";
        } else if (requestURI.startsWith("/shop")) {
            redirectPath = "/shop/home";
        } else if (requestURI.startsWith("/admin")) {
            redirectPath = "/admin/login";
        } else if (requestURI.startsWith("/emp")) {
        	redirectPath = "/emp/login";
        } else {
            redirectPath = "/oho"; // 기본 리다이렉트
        }
		
		 // 세션 무효화
        HttpSession session = request.getSession(false); // false -> 새 세션을 만들지 않고 이미 있는 세션만 가져 옴
        if (session != null) session.invalidate();
        
        response.sendRedirect(redirectPath);
		
	}

}
