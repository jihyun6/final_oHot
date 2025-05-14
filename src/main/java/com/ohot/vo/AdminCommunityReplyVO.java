package com.ohot.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AdminCommunityReplyVO {
	private int comProfileNo;
	private int tkNo;
	private String urlCategory;
	private int replyNo;
	private String replyContent;
	private String replyDelyn;
	private Date replyCreateDt;
	private int boardNo;
	private int artNo;
	private int memNo;
	private int mediaPostNo;
	//달력처리
	private String replyCreateDt2;
	private String replyCreateDate;
	//댓글 카테고리
	private String category;
}
