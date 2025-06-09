package com.ohot.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.ohot.vo.CustomUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		String role = customUser.getAuthorities().iterator().next().getAuthority();
		
		log.info("role -> role : " + role );
		
		 if ("ROLE_TEMP".equals(role)) {
			 	HttpSession session = request.getSession();
			 	session.setAttribute("snsMemYn", "Y");
	            response.sendRedirect("/signup"); // 신규 회원
	        } else {
	            response.sendRedirect("/oho"); // 기존 회원
	        }
		 
	}

}
