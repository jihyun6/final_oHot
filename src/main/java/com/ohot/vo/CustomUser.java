package com.ohot.vo;

import java.util.Collection;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.oauth2.core.user.OAuth2User;

import lombok.Getter;

// select한 UsersVO를 User 객체에 연계하여 넣어 줌 (User -> 스프링 시큐리티에서 정의된 유저)
// CustomUser의 객체 **principal**
@Getter
public class CustomUser extends User implements OAuth2User{
	private static final long serialVersionUID = 1L;
	private UsersVO usersVO;
	private Map<String, Object> attributes; // OAuth2용
	
	// username = userMail / password = userPswd / authorities = userAuthList
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	// 기존 생성자
	// UserDetailServiceImpl에서 new CustomUser(UsersVO usersVO)를 리턴해 줌
	public CustomUser(UsersVO usersVO) {
		// select한 MemberVO 타입의 객체 memberVO를 스프링 시큐리티에서 제공해주고 있는 UsersDetails 타입으로 변환 -> 스프링 시큐리티가 관리해 줌
		super(usersVO.getUserMail(), usersVO.getUserPswd(),
				usersVO.getUserAuthList().stream().map(auth ->  new SimpleGrantedAuthority(auth.getAuthNm())).collect(Collectors.toList()));
		this.usersVO = usersVO;
	}
	
	// 간편회원/로그인 생성자
    public CustomUser(UsersVO usersVO, Map<String, Object> attributes) {
        this(usersVO);
        this.attributes = attributes;
    }
	
	public UsersVO getUsersVO() {
		 if (this.usersVO == null) {
		        throw new IllegalStateException("UsersVO가 없습니다!");
		    }
		 return this.usersVO;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public String getName() {
		return usersVO.getUserMail();
	}
	
}
