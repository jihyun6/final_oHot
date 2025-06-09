package com.ohot.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReportmanageVO {

	private int reportPostNo;
	private int reportBoardNo;//*
	private String reportTitle;
	private String reportCn;
	private String reportRegDt;
	private String reportChgDt;
	private String reportDelYn;
	private int memNo;//*
	private int reportCnt;//*
	private String reportTermination;
	//001 : 신고해지 / 002 : 활동정지(7일)
	private String reportResult;
	
	private MemberVO memberVO;
	
	private String memName;//신고자
	private String piMemName;//피신고자
	private String memLastName;
	private String memFirstName;
	private String memNicknm;
	private String memEmail;//신고자 이메일
	private String piMemEmail; //피신고자 이메일
	private String memTelno;
	private String memBirth;
	private String memPswd;
	private String joinYmd;
	private String secsnYmd;
	private String memAccessToken;
	private int enabled;
	private String memStatSecCodeNo;
	private String memSecCodeNo;
	private String memDelYn;
	private String reportlist;
	private String reportGubun;
	private int currentPage;
	private int size;
	private int rnum;
	private int totalCnt;
	
	private String pictureUrl;
	//MultipartFile는 Spring에서 제공해주는
	// 	파일관련 인터페이스
	private MultipartFile[] uploadFile;
	private long fileGroupNo;
	private Date fileRegdate;

	//REPORT_BOARD_POST : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;
	
	private Date reportEndDt;
	
}
