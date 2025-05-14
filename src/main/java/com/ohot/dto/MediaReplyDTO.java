package com.ohot.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MediaReplyDTO {
	
	private Integer replyNo;
    private String replyContent;
    private String replyDelyn;
    private String replyCreateDt;
    private Integer boardNo;
    private Integer artNo;
    private Integer memNo;
    private Integer mediaPostNo;
    private Integer comProfileNo;
    private Integer tkNo;
    private String urlCategory;
    
    // 프로필 정보s
    private Integer profileMemNo;
    private String comNm;
    private Integer comFileGroupNo;
    private String comJoinYmd;
    private String comDelyn;
    private String comAuth;
    private Integer artGroupNo;
    private String membershipYn;
    
    // 파일 정보
    private String fileSaveLocate;
    private String fileSaveName;
}
