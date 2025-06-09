package com.ohot.vo;

import lombok.Data;

@Data
public class UserAuthVO {
	// security를 위해 만든 회원+사원 합한 가상의 사용자 권한 테이블
	
	private String authNm;
	private long userNo;
}
