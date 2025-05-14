package com.ohot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.mapper.UsersMapper;
import com.ohot.service.UsersService;
import com.ohot.vo.MemberVO;
import com.ohot.vo.UsersVO;

@Service
public class UsersServiceImpl implements UsersService{

	@Autowired
	UsersMapper usersMapper;
	
	// 카카오 이메일로 사용자 정보 찾기
	@Override
	public UsersVO findByKakaoEmail(String userMail) {
		
		return this.usersMapper.findByEmail(userMail);
	}

	// 이메일로 memberVO 조회
	@Override
	public MemberVO findByEmailMember(String userMail) {
		return this.usersMapper.findByEmailMember(userMail);
	}

}
