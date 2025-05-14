package com.ohot.shop.vo;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class GoodsVO {

	private int qty;
	private String gdsDelYn;
	private int gdsNo;
	private String gdsType;
	private String gdsNm;
	private int unitPrice;
	private String expln;
	private String pic;
	private String regDt;
	private String commCodeGrpNo;
	private int artGroupNo;
	private int artNo;
	private long fileGroupNo;
	
	//fileSavePath
	private String fileSavePath;
	
	//goodsDetail amount
	private int amount;
	
	//goodsDetail gramt()
	private int gramt;
	
	//artistGroupNm
	private String artGroupNm;
	private String artActNm;
	
	private String option2;
	
	private int rrnum;
	
	private int totalCnt;
	
	
	//파일업로드
	private MultipartFile[] uploadFile;
	
	//goods : ticket = 1:1
	private TicketVO ticketVO;
	
	//GoodsShop : FILE_GROUP = 1:1
	private FileGroupVO fileGroupVO;
}