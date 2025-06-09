package com.ohot.home.media.vo;

import java.util.Date;

import com.ohot.vo.ArtistGroupVO;

import lombok.Data;

@Data
public class MediaPostVO {
	private int rnum;
	private String mediaMebershipYn;
	private String mediaVideoUrl;
	private int mediaPostNo;
	private String mediaPostTitle;
	private String mediaPostCn;
	private Date mediaRegDt;
	private String formatRegDt;
	private long fileGroupNo;
	private String mediaDelYn;
	private String isbannerYn;
	private int artGroupNo;
	
	//중첩 VO
	private ArtistGroupVO artistGroupVO;
	
	//썸네일 이미지 경로
	private String thumNailPath;
	// 아티스트 그룹 로고 이미지 경로
	private String fileLogoSaveLocate;
}
