package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.mapper.MypageMapper;
import com.ohot.service.MypageService;
import com.ohot.vo.MemberVO;

@Service
public class MypageServiiceImpl implements MypageService{

	@Autowired
	MypageMapper mypageMapper;

	@Override
	public List<MemberVO> NickName(MemberVO memberVO) {
		return this.mypageMapper.NickName(memberVO);
	}

	@Override
	public List<MemberVO> Email(MemberVO memberVO) {
		return this.mypageMapper.Email(memberVO);
	}

	//web에서 이메일 변경한 것을 DB Update
	@Override
	public int updateEmail(MemberVO memberVO) {
		return this.mypageMapper.updateEmail(memberVO);
	}

	@Override
	public int updateNick(MemberVO memberVO) {
		return this.mypageMapper.updateNick(memberVO);
	}

	@Override
	public List<MemberVO> name(MemberVO memberVO) {
		return this.mypageMapper.name(memberVO);
	}


	@Override
	public List<MemberVO> birth(MemberVO memberVO) {
		return this.mypageMapper.birth(memberVO);
	}

	
	
}
