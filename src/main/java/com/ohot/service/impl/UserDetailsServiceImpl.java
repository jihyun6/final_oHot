package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ohot.mapper.MemberMapper;
import com.ohot.mapper.UsersMapper;
import com.ohot.vo.CustomUser;
import com.ohot.vo.EmployeeVO;
import com.ohot.vo.MemberVO;
import com.ohot.vo.UserAuthVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
// UserDetailService가 스프링 시큐리티에서 제공하는 interface
@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	UsersMapper usersMapper;
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	UserStatusService userStatusService;
	
	
	//MVC에서는 Controller로 리턴하지 않고, "CustomUser"로 리턴함
	//CustomUser : 사용자 정의 유저 정보. extends User를 상속받고 있음
	//2) 스프링 시큐리티의 User 객체의 정보로 넣어줌 => 프링이가 이제부터 해당 유저를 관리
	//User : 스프링 시큐리에서 제공해주는 사용자 정보 클래스
	/*
	 usersVO(우리) -> user(시큐리티)
	 -----------------
	 userMail  -> username
	 userPwsd  -> password
	 enabled   -> enabled
	 auth      -> authorities
	 */
	@Transactional
	@Override
	public UserDetails loadUserByUsername(String userMail) throws UsernameNotFoundException {
		// 요청 URL
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String requestURL = request.getRequestURI();
		
		UsersVO usersVO = usersMapper.findByEmail(userMail);
		
		if(usersVO == null) {
			throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
		}
		
	    // 로그인 경로별 Role 제한
	    List<UserAuthVO> roles = usersVO.getUserAuthList(); // ex) ROLE_MEM, ROLE_ART, ROLE_ADMIN, ROLE_EMP

		 // 관리자 로그인페이지일 경우
	    if (requestURL.startsWith("/admin") || requestURL.startsWith("/emp")) {
	        if (roles.stream().anyMatch(auth -> auth.getAuthNm().equals("ROLE_MEM") || auth.getAuthNm().equals("ROLE_ART"))) {
	            throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
	        }
	        
	        EmployeeVO empVO = usersMapper.findByEmailAdmin(userMail);
	        if(empVO != null) {
	        	usersVO.setEmployeeVO(empVO);
	        }
	    }
	    
	    // 일반 로그인 페이지일 경우
	    if (requestURL.startsWith("/login")) {
	    	// 회원 상태와 멤버십 만료 체크
			userStatusService.checkAndUpdateMemberStatus(usersVO);
			
			String snsYn = usersVO.getSnsYn();
			// 간편가입 회원이면 로그인 차단
		    if ("Y".equals(snsYn)) {
		        throw new UsernameNotFoundException("SNS_MEMBER");
		    }
	    	
	        if (roles.stream().anyMatch(auth -> auth.getAuthNm().equals("ROLE_ADMIN") || auth.getAuthNm().equals("ROLE_EMP"))) {
	            throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
	        }
	    }
		
		// 서비스 회원가입자일 경우 -> 로그인 성공
		return new CustomUser(usersVO);
		
	}
	
}
