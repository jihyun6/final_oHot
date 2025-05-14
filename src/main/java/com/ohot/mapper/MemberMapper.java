package com.ohot.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.MemberVO;

@Mapper
public interface MemberMapper {
	
	// 회원가입
	public int signUp(MemberVO memberVO);
	
	// 회원가입한 회원의 권한 insert
	public int insertAuth(MemberVO memberVO);
	
	// email로 회원의 정보 조회
	public MemberVO findByEmail(String MemEmail);

	public List<MemberVO> memberList();

	public int memberUpdate(MemberVO memberVO);

	public List<MemberVO> memberSearchList(Map<String, Object> map);

	public int getTotalMember(Map<String, Object> map);
	
	public MemberVO memberDetail(MemberVO memberVO);

	public int memberDelete(int memNo);
	
	public int authUpdate(MemberVO memberVO);
	
	// 모달창 회원상세정보 조회
	public MemberVO modalDetailInfo(MemberVO memberVO);
	
	///// 홈에서 필요한 메소드 시작 /////
	// 동적으로 처리한 아티스트그룹 리스트 (비회원, 회원 디엠리스트)
	List<ArtistGroupVO> getArtistGroupList(Map<String, Object> map);
	
	// 굿즈 리스트
	List<GoodsVO> getGoodsList(Map<String, Object> map);
	
	// 핸드폰 중복검사
	public MemberVO phoneDuplCheck(String memTelno);
	
	// 닉네임 중복검사
	public MemberVO nickDuplCheck(String memNicknm);

	// 가입한 아티스트 그룹 중 굿즈가 있는 아티스트 그룹
	public List<ArtistGroupVO> getArtWithGoods(int memNo);

	// 회원 상태 탈퇴로 업데이트
	public void memberCancle(MemberVO memberVO);

	public void authDelete(MemberVO memberVO);

	// 사용자 정보 수정
	public int editInfo(Map<String, Object> map);

	///// 홈에서 필요한 메소드 끝 /////
}
