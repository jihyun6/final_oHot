package com.ohot.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ohot.mapper.UsersMapper;
import com.ohot.vo.CustomUser;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomOAuth2UserServiceImpl implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{

	@Autowired
    private UsersMapper usersMapper;
	
	@Autowired
	UserStatusService userStatusService;
	 
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
		
		Map<String, Object> attributes = oAuth2User.getAttributes();
		
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
        UsersVO usersVO = this.usersMapper.findByEmail(email);
        
        if(usersVO != null) {
	    	// 회원 상태와 멤버십 만료 체크
	    	userStatusService.checkAndUpdateMemberStatus(usersVO);
        }else { // 신규회원
        	ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpServletRequest request = attr.getRequest();
            request.getSession().setAttribute("KAKAO_EMAIL", email);

            throw new OAuth2AuthenticationException("UNREGISTERED_USER");
        }
        
        return new CustomUser(usersVO);
		
	}

}
