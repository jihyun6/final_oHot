package com.ohot.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

/*
[접근거부 처리 핸들러]
접근 권한이 없는 페이지를 접근하려 하면 실행 된다.
예를 들면 MEM_ROLE을 가진 자가 ROLE_ADMIN 권한이 필요한 페이지로 이동하려 하면 발생한다.
추가로 접근 권한이 없는 이유를 로그로 찍어볼 수 있어서 개발에 유용하다. 또 에러페이지를 하나 만들어서 그쪽으로 이동시킨다.

SecurityConfig.java 파일의 filterChain 메서드의 아래 부분에 연결됨.(예외처리)
.exceptionHandling(ex -> ex.accessDeniedHandler(customAccessDeniedHandler()))
*/
@Slf4j
@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("CustomAccessDeniedHandler -> 체크 : {}", accessDeniedException.getMessage());		
		
		response.sendRedirect("/err/403");
	}

}
