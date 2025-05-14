package com.ohot.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint{

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		
		// 현재 요청 URI 가져오기
		String requestURI = request.getRequestURI();
		String redirectUrl = "/loginRequired?from=" + URLEncoder.encode(requestURI, "UTF-8"); // 요청 uri 인코딩해서 쿼리스트링으로 보냄 -> 그 후 분기처리
		log.info("CustomAuthenticationEntryPoint -> redirectUrl : " + redirectUrl);
		
		response.sendRedirect(redirectUrl);
	}

}