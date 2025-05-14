package com.ohot.shop.vo;

import lombok.Data;

@Data
public class MemberShopVO {
	private int membershipNo;
	private int gdsNo;
	private int comProfileNo;
	private String startYmd;
	private String expYmd;
	
	//회원번호
	private long memNo;
	
	
	private int artGroupNo;
}
