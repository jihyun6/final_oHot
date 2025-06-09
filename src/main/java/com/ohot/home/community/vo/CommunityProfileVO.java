package com.ohot.home.community.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.shop.vo.MemberShopVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class CommunityProfileVO {
	private int comProfileNo;
	private int memNo;
	private String comNm;
	private Long comFileGroupNo;
	private String comJoinYmd;
	private String comDelyn;
	private String comAuth;
	private int artGroupNo;
	private String membershipYn;
	
	//프로필 파일넘버
	private int profileFileNo;
	
	//파일 그룹 번호
	private Long fileGroupNo;
	
	// 유효기간이 지난 멤버십 리스트
	private List<MemberShopVO> memberShipList;
	
	private FileGroupVO fileGroupVO;
	
	//CommunityProfileVO : ArtistGroupVO : 1 : 1
	private ArtistGroupVO artistGroupVO;
	
	private MultipartFile[] uploadFile;
	
	private int currentPage;
	private String keyword;
	private int currentReplyPage;
}
