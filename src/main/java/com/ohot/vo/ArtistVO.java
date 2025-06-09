package com.ohot.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ArtistVO {

	private int rnum;
	private int artNo;
	private int artGroupNo;
	private String artActNm;
	private String artExpln;
	private String artRegYmd;
	private long fileGroupNo;
	private int memNo;
	private String artDelYn;
	
	//픽 횟수
	int cnt;
	
	// 생일
	private String artBirth;
	
	// ARTIST : MEMBER =  1:1
	private MemberVO memVO;
	
	// ARTIST : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	private MultipartFile[] uploadFile;
	
	private String fileSaveLocate;
	
	private String comNm;
}
