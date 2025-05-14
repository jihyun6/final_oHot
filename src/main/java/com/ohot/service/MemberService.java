package com.ohot.service;

import java.util.List;
import java.util.Map;

import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.AuthVO;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.MemberVO;

public interface MemberService {
	
	// 회원가입
	public int signUp(MemberVO memberVO);

	public List<MemberVO> memberList();

	public MemberVO memberUpdate(MemberVO memberVO);

	// 검색 회원 목록
	public List<MemberVO> memberSearchList(Map<String, Object> map);

	public int getTotalMember(Map<String, Object> map);
	
	public MemberVO memberDetail(MemberVO memberVO);

	// 회원 삭제여부 업뎃
	public int memberDelete(int memNo);
	
	// 모달창 회원상세정보 조회
	public MemberVO modalDetailInfo(MemberVO memberVO);
	
	//////////// home에서 필요한 service 시작 /////////
	// 핸드폰 중복검사
	public MemberVO phoneDuplCheck(String memTelno);
	
	// 닉네임 중복검사
	public MemberVO nickDuplCheck(String memNicknm);
	
	// 디엠 리스트
	public List<ArtistGroupVO> getDmList(Map<String, Object> dmMap);

	// 새로운 아티스트를 만나보세요!
	public List<ArtistGroupVO> getNewArtistGroupList(Map<String, Object> unMemMap);

	// 커뮤니티에 가입한 아티스트 그룹
	public List<ArtistGroupVO> getJoinArtistGroupList(Map<String, Object> joinMap);

	// 가입한 아티스트의 굿즈 정보들
	public List<GoodsVO> getGoodsVOList(Map<String, Object> goodsMap);
	
	// 가입한 아티스트 그룹 중 굿즈가 있는 아티스트 그룹
	public List<ArtistGroupVO> getArtWithGoods(int memNo);

	// 정보 수정
	public int editInfo(Map<String, Object> map);
	
	////////////home에서 필요한 service 끝 /////////

}
