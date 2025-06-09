package com.ohot.vo;

import lombok.Data;

@Data
public class KakaoInfoVO {
	
	private String email;
	
	public KakaoInfoVO (String email) {
		this.email = email;
	}
}
