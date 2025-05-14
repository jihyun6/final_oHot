package com.ohot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.MemberVO;
@Mapper
public interface MypageMapper {

	public List<MemberVO> NickName(MemberVO memberVO);

	public List<MemberVO> Email(MemberVO memberVO);

	//web에서 이메일 변경한 것을 DB Update
	public int updateEmail(MemberVO memberVO);

	public int updateNick(MemberVO memberVO);

	public List<MemberVO> name(MemberVO memberVO);

	public List<MemberVO> birth(MemberVO memberVO);

	
}
