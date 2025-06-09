package com.ohot.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

/*
인증 성공 후 ROLE 별로 이동해야 하는 페이지가 다를 경우 만들면 됨
SecurityConfig.java 파일의 filterChain 메서드의 아래 부분에 연결됨.
.formLogin(form -> form.loginPage("/login")
                             .successHandler(customLoginSuccessHandler())
*/
@Slf4j
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
			log.info("CustomLoginSuccessHandler -> 인증완료 {} ", authentication);
			
			// 로그인한 사용자 정보 가져오기
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			log.info("CustomLoginSuccessHandler -> customUser : " + customUser);
			
			// 사용하던 페이지로 리다이렉트
			String redirectURL = request.getParameter("redirectURL");
			log.info("리다이렉트 확인 : "+redirectURL);
			
			switch (redirectURL) {
            case "/admin/login":
                redirectURL = "/admin/home";
                break;
            case "/emp/login":
                redirectURL = "/emp/home"; // 직원 전용 홈 경로로 분기
                break;
            case "/" : 
            case ""  :
            case "/login":
                redirectURL = "/oho"; // 일반 사용자용 홈으로 분기
                break;
        }
			
				response.sendRedirect(redirectURL);
	}

}
