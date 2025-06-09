package com.ohot.shop.vo;

import lombok.Data;

@Data
public class OrdersDetailsVO {

	private int gdsNo;
	private int orderNo;
	private int seq;
	private int qty;
	private int amount;
	private String option1;
	private String option2;
	
	/* OrdersDetail VO : goodsVO = 1:1*/
	private GoodsVO goodsVO;
	
}