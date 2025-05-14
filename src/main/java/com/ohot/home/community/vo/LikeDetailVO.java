package com.ohot.home.community.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LikeDetailVO {
	private int likeNo;
	private int comProfileNo;
	private int boardNo;
	private int replyNo;
	private int mediaPostNo;
	private Date createDt;
	
	private int boardLikeCnt;
	private int replyLikeCnt;
	
	private int memNo;
	private int artGroupNo;
}
