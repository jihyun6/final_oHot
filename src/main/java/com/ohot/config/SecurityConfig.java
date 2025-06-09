package com.ohot.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.ohot.api.service.impl.CustomOAuth2FailureHandler;
import com.ohot.api.service.impl.CustomOAuth2UserServiceImpl;
import com.ohot.security.CustomAccessDeniedHandler;
import com.ohot.security.CustomAuthenticationEntryPoint;
import com.ohot.security.CustomLoginFailureHandler;
import com.ohot.security.CustomLoginSuccessHandler;
import com.ohot.security.CustomLogoutSuccessHandler;
import com.ohot.security.OAuth2SuccessHandler;
import com.ohot.service.impl.UserDetailsServiceImpl;

import jakarta.servlet.DispatcherType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Configuration
//골뱅이EnableWebSecurity는 클라이언트와 서버 요청 사이에 자동으로 스프링 시큐리티 필터를가 생성된다. 따라서 메모리를 등록해야 하기 때문에 configuration과 같이 다닌다.
@EnableWebSecurity(debug = false) // 스프링 시큐리티를 활성화하고 웹 보안 설정(폼 기반 인증, 로그인 페이지 구성, 권한 설정)을 구성하는 데 사용한다. configuration와 함께 사용한다!!!
@EnableMethodSecurity // @preAuthorize/@postAuthorize 사용
public class SecurityConfig {
//
	// autowired 보다 생성자 주입을 권장 (필드 주입은 테스트하기 어렵고 순환참조 문제가 생기기 쉽기 때문)
	private final DataSource dataSource; // application.properties에 설정한 spring.datasource D.I
    private final UserDetailsServiceImpl userDetailsServiceImpl;
    private final CustomLoginSuccessHandler customLoginSuccessHandler;
    private final CustomLogoutSuccessHandler customLogoutSuccessHandler;
//    private final CustomAccessDeniedHandler customAccessDeniedHandler;
    private final CustomLoginFailureHandler customLoginFailureHandler;
    private final CustomOAuth2UserServiceImpl customOAuth2UserService;
    private final OAuth2SuccessHandler auth2SuccessHandler;
    private final CustomOAuth2FailureHandler oAuth2FailureHandler;

	@Bean
	@Order(1)
	protected SecurityFilterChain adminSecurity(HttpSecurity http) throws Exception {
		return http
				.securityMatcher("/admin/**")
				.csrf(csrf -> csrf.disable()).httpBasic(hbasic -> hbasic.disable()) // csrf.disable() : form 태그 안에 <sec:csrfInput> 를 작성하지 않아도 됨.
																					   // httpBasic(hbasic -> hbasic.disable() : 아이디, 비밀번호, 로그인버튼만 있는 구식 form을 사용하지 않겠다
				.headers(config -> config.frameOptions(customizer -> customizer.sameOrigin())) // iframe 설정 / iframe을 사용하겠다는 뜻 (원래는 막히는데 이를 사용하므로써 다른 url을 끌어 올 수 있음)
				.authorizeHttpRequests(authz -> authz
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward 허가
						.requestMatchers("/admin/login").anonymous()
						.requestMatchers("/emp/**").hasAnyRole("EMP", "ADMIN") // "EMP, ADMIN" 권한자만 접근 가능
						.requestMatchers("/admin/**").hasRole("ADMIN") // "ADMIN" 권한자만 접근 가능
						.anyRequest().authenticated())
				.formLogin(formLogin -> formLogin.loginPage("/admin/login") // 로그인 페이지 지정
						.successHandler(customLoginSuccessHandler)
						.failureHandler(customLoginFailureHandler))
				.logout(logout -> logout
					    .logoutUrl("/admin/logout") // 로그아웃 요청 URL (form action="/logout")
					    .logoutSuccessHandler(customLogoutSuccessHandler) // 성공 시 사용자 정의 처리
					    .invalidateHttpSession(true) // 세션 무효화
					    .deleteCookies("JSESSIONID") // 쿠키 삭제
					)
				.sessionManagement(session -> session.maximumSessions(1))
				.exceptionHandling(ex ->
//						ex.accessDeniedHandler(customAccessDeniedHandler) // 권한 없음(403) -> security가 알아서 error/403.jsp를 찾아줌
						ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint())) // 인증 안 됨 -> 로그인 요청
				.build();
	}
	
	@Bean
	@Order(2)
	protected SecurityFilterChain empSecurity(HttpSecurity http) throws Exception {
		return http
				.securityMatcher("/emp/**")
				.csrf(csrf -> csrf.disable()).httpBasic(hbasic -> hbasic.disable()) // csrf.disable() : form 태그 안에 <sec:csrfInput> 를 작성하지 않아도 됨.
				.headers(config -> config.frameOptions(customizer -> customizer.sameOrigin())) // iframe 설정 / iframe을 사용하겠다는 뜻 (원래는 막히는데 이를 사용하므로써 다른 url을 끌어 올 수 있음)
				.authorizeHttpRequests(authz -> authz
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward 허가
						.requestMatchers("/emp/login").anonymous()
						.requestMatchers("/emp/**").hasAnyRole("EMP", "ADMIN") // "EMP, ADMIN" 권한자만 접근 가능
						.anyRequest().authenticated())
				.formLogin(formLogin -> formLogin.loginPage("/emp/login") // 로그인 페이지 지정
						.successHandler(customLoginSuccessHandler)
						.failureHandler(customLoginFailureHandler))
				.logout(logout -> logout
						.logoutUrl("/emp/logout") // 로그아웃 요청 URL (form action="/logout")
						.logoutSuccessHandler(customLogoutSuccessHandler) // 성공 시 사용자 정의 처리
						.invalidateHttpSession(true) // 세션 무효화
						.deleteCookies("JSESSIONID") // 쿠키 삭제
						)
				.sessionManagement(session -> session.maximumSessions(1))
				.exceptionHandling(ex ->
//						ex.accessDeniedHandler(customAccessDeniedHandler) // 권한 없음(403) -> security가 알아서 error/403.jsp를 찾아줌
						ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint())) // 인증 안 됨 -> 로그인 요청
				.build();
	}
	
	@Bean
	@Order(3)
	protected SecurityFilterChain memberSecurity(HttpSecurity http) throws Exception {
		return http.csrf(csrf -> csrf.disable()).httpBasic(hbasic -> hbasic.disable()) // csrf.disable() : form 태그 안에 <sec:csrfInput> 를 작성하지 않아도 됨.
																					   // httpBasic(hbasic -> hbasic.disable() : 아이디, 비밀번호, 로그인버튼만 있는 구식 form을 사용하지 않겠다
				.headers(config -> config.frameOptions(customizer -> customizer.sameOrigin())) // iframe 설정 / iframe을 사용하겠다는 뜻 (원래는 막히는데 이를 사용하므로써 다른 url을 끌어 올 수 있음)
				.authorizeHttpRequests(authz -> authz
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward 허가
						.requestMatchers("/**", "/oho/inquiryPost/**", "/ckEditor/**").permitAll() // 누구나 접근 가능
						.requestMatchers("/oho/community/**").hasAnyRole("MEM", "ART", "ADMIN") // ROLE 접두어 자동 생성
						.requestMatchers("/oho/mypage/**").hasAnyRole("MEM", "ART", "ADMIN")
						.anyRequest().authenticated()
						)
				.formLogin(formLogin -> formLogin.loginPage("/login") // 로그인 페이지 지정
						.successHandler(customLoginSuccessHandler)
						.failureHandler(customLoginFailureHandler)
						)
					.oauth2Login(oauth2 -> oauth2
						    .loginPage("/login")
						    .userInfoEndpoint(userInfo -> userInfo
						        .userService(customOAuth2UserService)
						    )
						    .successHandler(auth2SuccessHandler)
						    .failureHandler(oAuth2FailureHandler)
						)
				.logout(logout -> logout
					    .logoutUrl("/logout") // 로그아웃 요청 URL (form action="/logout")
					    .logoutSuccessHandler(customLogoutSuccessHandler) // 성공 시 사용자 정의 처리
					    .invalidateHttpSession(true) // 세션 무효화
					    .deleteCookies("JSESSIONID") // 쿠키 삭제
					)
				.sessionManagement(session -> session.maximumSessions(1))
				.exceptionHandling(ex -> 
//						ex.accessDeniedHandler(customAccessDeniedHandler) // 권한 없음(403) -> security가 알아서 error/403.jsp를 찾아줌
						ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint())) // 인증 안 됨 -> 로그인 요청
				.build();
	}

	@Bean // remember-me db 연결
	protected PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		return tokenRepository;
	}

	  @Bean // 암호 인코더 기본필요
	  protected BCryptPasswordEncoder passwordEncoder() {
	     return new BCryptPasswordEncoder();
	  }

	@Bean // 인증매니저 스프링 문서 참조, global 설정 복사해옴
	protected AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
			throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}

	@Bean // 인증제공자 인증처리
	protected AuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
		authenticationProvider.setUserDetailsService(userDetailsServiceImpl);
		authenticationProvider.setPasswordEncoder(passwordEncoder());
		authenticationProvider.setHideUserNotFoundExceptions(false);
		return authenticationProvider;

	}

	@Bean // 동시 로그인수 제어을 위해 필요
	protected HttpSessionEventPublisher httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}


	/*
	 * "malicious String "//" - RequestRejectedException" 오류는 Spring Security의 HTTP
	 * 요청 방화벽이 발견한 악성 문자열 "//"에 대한 예외입니다. 이 예외는 일반적으로 웹 요청에서 발생하며, Spring Security가
	 * 보안 상의 이유로 해당 요청을 거부했음을 나타냅니다.
	 */
	@Bean
	protected HttpFirewall allowUrlEncodedDoubleSlashHttpFirewall() {
		StrictHttpFirewall firewall = new StrictHttpFirewall();
		firewall.setAllowUrlEncodedDoubleSlash(true);
		return firewall;
	}

	// 1. 스프링 시큐리티 기능 비활성화
	/*
	 * 스프링 시큐리티의 모든 기능을 사용하지 않게 설정하는 코드. 즉, 인증, 인가 서비스를 모든 곳에 적용하지는 않음 일반적으로 정적
	 * 리소스(이미지, HTML 파일)에 설정함. 정적 리소스만 스프링 시큐리티 사용을 비활성화 하는 데 static 하위 경로에 있는 리소스를
	 * 대상으로 ignoring() 메서드를 사용함
	 */
	public WebSecurityCustomizer configure() {
		return (web) -> web.ignoring().requestMatchers(new AntPathRequestMatcher("/static/**"));
	}

}
