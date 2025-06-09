package com.ohot.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;


/*
인증 실패 시 페이지 이동.
우선 테스트에서는 인증 실패 시 login 페이지로 돌림 (스프링 시큐리티의 기본값이 login페이지로 돌리기에 굳이 만들지는 않아도 됨)
SecurityConfig.java 파일의 filterChain 메서드의 아래 부분에 연결됨.
.formLogin(form -> form.loginPage("/login")
                             .failureHandler(customLoginFailureHandler()))
*/
@Slf4j
@Component
public class CustomLoginFailureHandler implements AuthenticationFailureHandler{
	
	 @Override
	    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
	                                        AuthenticationException exception) throws IOException, ServletException {
	        String errorMessage;

	        if (exception instanceof UsernameNotFoundException) {
	            if ("EMAIL_NOT_FOUND".equals(exception.getMessage())) {
	                errorMessage = "존재하지 않은 계정입니다. 새 계정을 생성해주세요.";
	            } else if ("SNS_MEMBER".equals(exception.getMessage())) {
	            	errorMessage = "간편로그인 회원입니다. 간편 로그인으로 시도해 주세요.";
	            }else if (exception.getMessage().equals("DELETED_MEMBER")) {
	            	errorMessage = "탈퇴된 계정입니다.";
	            }else if(exception.getMessage().startsWith("STOP_MEMBER")) {
	            	String[] parts = exception.getMessage().split("=");
	            	String date = parts[1].trim();
	            	errorMessage = date + "까지 정지된 계정입니다.";
	            }else {
	                errorMessage = "비밀번호가 일치하지 않습니다. 다시 확인해주세요.";
	            }
	        } else if (exception instanceof BadCredentialsException) {
	            errorMessage = "비밀번호가 일치하지 않습니다. 다시 확인해주세요.";
	        } else {
	            errorMessage = "로그인에 실패했습니다.";
	        }
	        
	        // 리퍼러를 기준으로 실패 URL 설정
	        String referer = request.getHeader("Referer");
	        
	        String redirectPath = "/login"; // 기본 경로
	        
	        if (referer != null) {
	            if (referer.contains("/admin/login")) {
	                redirectPath = "/admin/login";
	            } else if (referer.contains("/emp/login")) {
	                redirectPath = "/emp/login";
	            }
	        }

	        response.sendRedirect(redirectPath + "?error=" + URLEncoder.encode(errorMessage, "UTF-8"));
	    }
	 
}
