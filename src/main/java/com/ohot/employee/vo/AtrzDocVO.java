package com.ohot.employee.vo;

import java.util.List;

import lombok.Data;

@Data
public class AtrzDocVO {

	private String atrzDocNo;
	private int docFmNo;
	private String drftTtl;
	private String drftCn;
	private String emrgYn;
	private String drftYmd;
	private String ddlnYmd;
	private long drftEmpNo;
	private String offcsPhoto;
	private String drftJbgdCd;
	private long fileGroupNo;
	private long drftStampFileGroupNo;
	private String atrzSttsCd;
	private String atrzLnSttsCd;

	// 기안자 직인 파일 경로
	private String drftStampFileSaveLocate;
	
	// 문서 번호 prefix 추가
	private String prefix;
	
	// 결재문서 : 결재참조 = 1 : N
	private List<AtrzRefVO> atrzRefVOList; 
	
	// 결재문서 : 결재선 = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 결재문서 : 공연기획_최종승인 = 1 : 1
	private ApprovedConcertPlanVO approvedConcertPlanVO;
	
	// 결재문서 : 아티스트전환요청_최종승인 = 1 : 1
	private ApprovedConversionRequestVO approvedConversionRequestVO;
	
	
	//기안일시
	private String drftDt;
	
	//문서양식이름
	private String docFrmNm;
}
