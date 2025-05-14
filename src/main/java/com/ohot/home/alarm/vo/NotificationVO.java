package com.ohot.home.alarm.vo;


import java.util.Date;

import lombok.Data;

@Data
public class NotificationVO {

	private int notiNo;
	private String notiDt;
	private int notiSndrNo;
	private int notiRcvrNo;
	private String notiCn;
	private int notiOrgNo;
	private String notiOrgTb;
	
	//아티스트 그룹 이미지 경로 가져오기
	private String fileSaveLocate;
	
	private int boardNo;
	private String boardDelyn;
	private String replyDelyn;
	private String empDelyn;
	
	//사원용
	private long empNotiSndrNo;
	private long empNotiRcvrNo;
	private String empOrgNo;
	
}
