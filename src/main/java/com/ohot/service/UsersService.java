package com.ohot.service;

import com.ohot.vo.MemberVO;
import com.ohot.vo.UsersVO;

public interface UsersService {
	
	// kakao email로 사용자의 정보 조회
	public UsersVO findByKakaoEmail(String userMail);
	
	// 이메일로 memberVO 조회
	public MemberVO findByEmailMember(String userMail);
	
}
