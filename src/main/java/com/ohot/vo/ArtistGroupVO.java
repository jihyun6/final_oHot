package com.ohot.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.shop.vo.GoodsVO;

import lombok.Data;

@Data
public class ArtistGroupVO {

	private int rrnum;
	private int rnum;
	private int artGroupNo;
	private String artGroupDebutYmd;
	private String artGroupNm;
	private String artGroupNmKo;
	private String artGroupExpln;
	private String artGroupRegYmd;
	private String artGroupDelYn;
	private long fileGroupNo;
	
	private long logoFileGroupNo;
	private String fileLogoSaveLocate;
	
	private int totalCnt;
	
	// 데뷔 디데이
	private String debutDDay;
	
	// ARTIST_GROUP : FILEGROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	private MultipartFile[] uploadFile;
	
	//ARTIST_GROUP : GOODS = 1 : N
	private List<GoodsVO> goodsVOList; 
	
	// ARTISTGROUP : ARTIST = 1 : N
	private List<ArtistVO> artistVOList;
	
	// ARTISTGROUP : MediaPost = 1 : N (미디어, 라이브 따로 처리)
	private List<MediaPostVO> mediaList;
	private List<MediaPostVO> liveList;
	

	
}
