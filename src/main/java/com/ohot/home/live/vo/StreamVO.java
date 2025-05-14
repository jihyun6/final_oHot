package com.ohot.home.live.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StreamVO {
    private int streamNo;           // 방송 번호
    private int artGroupNo;         // 아티스트 그룹 번호
    private String streamTitle;     // 방송 제목
    private String streamExpln;     // 방송 설명
    private Date streamStartDt;     // 방송 시작 시간
    private Date streamEndDt;       // 방송 종료 시간
    private String streamStat;      // 방송 상태 (READY, START, END)
    private String streamThmimgUrl; // 썸네일 이미지 URL
    private int streamViewCnt;      // 총 조회수
    private int streamViewerCnt;    // 현재 시청자 수
    private String streamUrl;       // 방송 URL
    private String streamQty;       // 방송 품질
    private int fileGroupNo;        // 파일 그룹 번호 
    private String streamProtocol;  // 방송 프로토콜 
    private String streamKey;       // 방송 키 
    
    // 검색 정렬 조건
    private String sortBy;
}