package com.ohot.api.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.mapper.UsersMapper;
import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomOAuth2UserServiceImpl implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{

	@Autowired
    private UsersMapper usersMapper;
	 
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
		
		Map<String, Object> attributes = oAuth2User.getAttributes();
		// 이렇게하면 형변환 경고가 뜸
		//Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
		// 따라서 밑에 방법으로 변경
		Object kakaoAccountObj = attributes.get("kakao_account");
		Map<String, Object> kakaoAccount = new HashMap<>();
		if (kakaoAccountObj instanceof Map) {
		    Map<?, ?> tempMap = (Map<?, ?>) kakaoAccountObj;
		    for (Map.Entry<?, ?> entry : tempMap.entrySet()) {
		        if (entry.getKey() instanceof String) {
		            kakaoAccount.put((String) entry.getKey(), entry.getValue());
		        }
		    }
		}
	    String email = (String) kakaoAccount.get("email");
		
		// 간편로그인/가입 사용자 정보 추출 방법
	    /*
        String provider = userRequest.getClientRegistration().getRegistrationId(); // "kakao"
        String providerId = oAuth2User.getAttribute("id").toString();
        String username = provider + "_" + providerId;
        */
        
        UsersVO usersVO = this.usersMapper.findByEmail(email);
        MemberVO memVO = usersMapper.findByEmailMember(email);
        
		if(memVO != null) {
			usersVO.setMemberVO(memVO);
			
			// 탈퇴한 회원 체크
			if(memVO.getMemDelYn().equals("Y")) {
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
        
        if(usersVO == null ) { // 신규회원
        	ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpServletRequest request = attr.getRequest();
            request.getSession().setAttribute("KAKAO_EMAIL", email);

            throw new OAuth2AuthenticationException("UNREGISTERED_USER");
        }
        
        return new CustomUser(usersVO);
		
	}

}
