package com.ohot.vo;

import lombok.Data;

@Data
public class RefreshTokenVO {
	private int refTokenNo;
	private long empNo;
	private String refreshToken;
}
