package com.ohot.shop.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private int cartNo;
	private int gdsNo;
	private long memNo;
	private int qty;
	private int amount;
	private String prodOption;
	
	//Cart : goods = 1 : 1
	private GoodsVO goodsVO;
	
}
