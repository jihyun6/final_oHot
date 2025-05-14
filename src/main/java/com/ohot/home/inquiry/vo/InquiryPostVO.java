package com.ohot.home.inquiry.vo;

import com.ohot.vo.MemberVO;

import lombok.Data;

@Data
public class InquiryPostVO {
	private int bbsPostNo;
	private int memNo;
	private String ansYn;
	private int inqTypeNo;
	private String inqPswd;
	private String inqWriter;
	
	private String pswdYn;
	private String inqTypeNm;
	private MemberVO MemberVO;
}
