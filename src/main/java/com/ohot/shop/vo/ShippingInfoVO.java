package com.ohot.shop.vo;

import lombok.Data;

@Data
public class ShippingInfoVO {
	private int shippingInfoNo;
	private long memNo;
	private String farstNm;
	private String lastNm;
	private String telNo;
	private String country;
	private int countryCd;
	private String zipCd;
	private String addressNm;
	private String addressDetNm;
	private String isDefault;
}
