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

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.mapper.MemberMapper;
import com.ohot.mapper.UsersMapper;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.EmployeeVO;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;
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
		// 시큐리티에서는 username인데 편의상 memEmail로 변경함
		log.info("UserDetailsServiceImpl -> userMail : {}", userMail);
		
		// 요청 URL
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String requestURL = request.getRequestURI();
		log.info("UserDetailsServiceImpl -> requestURL : " + requestURL);
		
		// 이메일로 회원검색
		UsersVO usersVO = usersMapper.findByEmail(userMail);
		log.info("UserDetailsServiceImpl -> usersVO : " + usersVO);
		
		if(usersVO == null) {
			throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
		}
		
		
		EmployeeVO empVO = usersMapper.findByEmailAdmin(userMail);
		if(empVO != null) {
			usersVO.setEmployeeVO(empVO);
			log.info("부서 VO 넣어졌을까?? : " + usersVO );
		}
		
		MemberVO memVO = usersMapper.findByEmailMember(userMail);
		if(memVO != null) {
			usersVO.setMemberVO(memVO);
			
			// 탈퇴한 회원 체크
			if(memVO.getMemDelYn().equals("Y")) {
				log.info("탈퇴한 회원인가요??");
				throw new UsernameNotFoundException("DELETED_MEMBER");
			}
			
			int memNo = (int)usersVO.getUserNo();
			
			// 활동정지된 회원 체크
			if(usersVO.getMemberVO().getMemStatSecCodeNo().equals("004")) { // 004 = 활동정지
				// 활동정지 종료일 여부 체크
				ReportmanageVO reportVO = this.usersMapper.getMemStopYN(memNo);
				if(reportVO != null) { // 종료일이 지나지 않았을 경우
					throw new UsernameNotFoundException("STOP_MEMBER, EndDate=" + reportVO.getReportEndDt());
				}else { // 종료일이 지났을 경우
					// 회원 상태 업데이트 (정지->활동)
					this.usersMapper.updateMemStatus(memNo);
				}
			}
			
			// 멤버십 유효기간이 지난 커뮤니티 체크
			List<CommunityProfileVO> communityProfileVOList = this.usersMapper.selectExpMemberShipList(memNo);
			
			if(!communityProfileVOList.isEmpty()) {
				// 유효기간이 지난 커뮤니티 리스트
				for(CommunityProfileVO communityProfileVO : communityProfileVOList) {
					int comProfileNo = communityProfileVO.getComProfileNo();
					// 커뮤니티 멤버십 해제
					this.usersMapper.expMemberShip(comProfileNo);
				}
			}
			
		}
		
		String snsYn = usersVO.getSnsYn();
		log.info("snsYn : " + snsYn);
		
		 // 1. 간편가입 회원이면 로그인 차단
	    if ("Y".equals(snsYn)) {
	        throw new UsernameNotFoundException("SNS_MEMBER");
	    }
	    
	    // 2. 로그인 경로별 Role 제한
	    List<UserAuthVO> roles = usersVO.getUserAuthList(); // ex) ROLE_MEM, ROLE_ART, ROLE_ADMIN, ROLE_EMP

		 // 관리자 로그인페이지일 경우
	    if (requestURL.startsWith("/admin") || requestURL.startsWith("/emp")) {
	        if (roles.stream().anyMatch(auth -> auth.getAuthNm().equals("ROLE_MEM") || auth.getAuthNm().equals("ROLE_ART"))) {
	            throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
	        }
	    }
	    
	    // 일반 로그인 페이지일 경우
	    if (requestURL.startsWith("/login")) {
	        if (roles.stream().anyMatch(auth -> auth.getAuthNm().equals("ROLE_ADMIN") || auth.getAuthNm().equals("ROLE_EMP"))) {
	            throw new UsernameNotFoundException("EMAIL_NOT_FOUND");
	        }
	    }
		
		// 서비스 회원가입자일 경우 -> 로그인 성공
		return new CustomUser(usersVO);
		
	}
	
}
