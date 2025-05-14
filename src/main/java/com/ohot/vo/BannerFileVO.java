package com.ohot.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BannerFileVO {
	private int bannerNo;
	private String taskSeNm;
	private long fileGroupNo;
	private String bannerLink;
	private String useYn;
	private String displayOrder;
	
	//파일업로드
	private MultipartFile[] uploadFile;
	
	//GoodsShop : FILE_GROUP = 1:1
	private FileGroupVO fileGroupVO;
}