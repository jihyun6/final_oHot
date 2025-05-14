package com.ohot.vo;

import com.ohot.home.inquiry.vo.InquiryPostVO;

import lombok.Data;

@Data
public class BoardPostVO {
	private long fileGroupNo;
	private int parentPostNo; // 자기참조 (문의게시글 필요)
	private int bbsPostNo;
	private int bbsTypeCdNo;
	private String bbsTitle;
	private String bbsCn; // 순수 텍스트
	private String bbsHtmlCn; // html 텍스트 (ckEditor)
	private String bbsRegDt;
	private String bbsChgDt;
	private String bbsDelYn;
	private int bbsInqCnt;
	private int artGroupNo;
	
	// 게시판명
	private String bbsNm;
	
	// 순서
	private int rnum;
	
	// 이미지 경로
	private String fileSaveLocate;
	
	// 게시판에 보여질 시간 또는 날짜
	private String displayDate;
	
	// YYYY-MM-DD 형식
	private String bbsRegYmd;	
	
	// BOARD_POST : INQUIRY_POST = 1 : 1
	private InquiryPostVO inquiryPostVO;
	// BOARD_POST : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	// 답글
	private BoardPostVO replyPostVO;
}
