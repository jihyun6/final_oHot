package com.ohot.api.service.impl;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomOAuth2FailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		 if (exception instanceof OAuth2AuthenticationException) {
	            String errorCode = ((OAuth2AuthenticationException) exception).getError().getErrorCode();

	            if ("UNREGISTERED_USER".equals(errorCode)) {
	                response.sendRedirect("/signup");
	                return;
	            }else if(exception.getMessage().startsWith("STOP_MEMBER")) {
	            	String[] parts = exception.getMessage().split("=");
	            	String date = parts[1].trim();
	            	String errorMessage = date + "까지 정지된 계정입니다.";
	            	response.sendRedirect("/login?error=" + URLEncoder.encode(errorMessage, "UTF-8"));
	                return;
	            }
	        }
	        response.sendRedirect("/login?error");
	    }

}
