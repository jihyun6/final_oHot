package com.ohot.shop.vo;
import java.util.List;
import java.util.UUID;

import lombok.Data;

@Data
public class OrdersVO {

	private int orderNo;
	private long memNo;
	private int gramt;
	private String stlmYn;
	private String stlmDt;
	private int shippingInfoNo;
	private String orderPayNo;
	private String paymentKey;
	
	//Orders : OrdersDetails = 1:N
	List<OrdersDetailsVO> ordersDetailsVOList;
	
	//공연포스터
	private String tkFileSaveLocate;
	
	private int artNo;
}