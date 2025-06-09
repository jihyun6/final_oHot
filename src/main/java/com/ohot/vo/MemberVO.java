package com.ohot.vo;

import java.util.List;

import com.ohot.shop.vo.MemberShopVO;

import lombok.Data;

@Data
public class MemberVO {
	
	private int rrnum;
	private int memNo;
	private String memLastName;
	private String memFirstName;
	private String memNicknm;
	private String memEmail;
	private String memTelno;
	private String memBirth;
	private String memPswd;
	private String joinYmd;
	private String secsnYmd;
	private String memAccessToken;
	private int enabled;
	private String memStatSecCodeNo;
	private String memSecCodeNo;
	private String memDelYn;
	
	// fullName
	private String fullName;
	
	// 간편로그인 회원 여부
	private String snsMemYn;
	
	// 권한 이름
	private String authNm;
	
	private List<AuthVO> authVOList;
	
	// 회원 : 아티스트 = 1 : 1
	private ArtistVO artistVO;
	
	private List<MemberShopVO> memberShipList;
}
