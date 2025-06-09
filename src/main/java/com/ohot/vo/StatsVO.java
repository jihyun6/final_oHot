package com.ohot.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StatsVO {
//	
	private int dmSubNo;
	private String dmStrYmd;
	private String dmFinYmd;
	private String dmFinYn;
	private int memNo;
	private int artNo;
	private int cnt;
	
//	댓글통계
	private int replyNo;
	private String replyContent;
	private String replyDelyn;
	private String replyCreateDt;
	private String boardNo;
	private int mediaPostNo;
	private int cnt2;
	
	private int tkNo;
	private String tkCtgr;
	private String tkLctn;
	private String tkYmd;
	private int tkRound;
	private int gdsNo;
	private String tkStartYmd;
	private String tkFinishYmd;
	private int cnt3;
	
	private int totalCnt;
	private int totalCnt2;
	private int totalCnt3;
	private int totalCnt4;
	private int revenue;
	private int availableSeats;
	
	
	
	private String gdsType;
	private String gdsNm;
	private int unitPrice;
	private String expln;
	private String pic;
	private String regDt;
	private String commCodeGrpNo;
	private int artGroupNo;
	private int rnum;
	
	
	private String memLastName;
	private String memFirstName;
	private String memNicknm;
	private String memEmail;
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
	
	private int MemberCnt;
	
	
	private int comProfileNo;
	private String comNm;
	private String comFileGroupNo;
	private String comJoinYmd;
	private String comDelyn;
	private String comAuth;
	private String goodCnt2;
	private String goodNM2;

	private int comProfileCnt;
	private int totalSale;
	private int totalSale2;
	

	private int reportPostNo;
	private int reportBoardNo;
	private String reportTitle;
	private String reportCn;
	private String reportRegDt;
	private String reportChgDt;
	private String reportDelYn;
	private int reportCnt;
	private String reportTermination;
	private String callerEmail;
	private String reportResult;
	private String reportGubun;
	
	
	private String pictureUrl;
	//MultipartFile는 Spring에서 제공해주는
	// 	파일관련 인터페이스
	private MultipartFile[] uploadFile;
	private long fileGroupNo;
	private Date fileRegdate;

	//REPORT_BOARD_POST : FILE_GROUP = 1 : 1
	private FileGroupVO fileGroupVO;

	
	
	private String artistName;
    private String fileSaveName;
    private String fileSaveLocate;
    private String fileNo;

    private String totalCnts1;
    private String totalCnts2;
    private String totalCnts3;
    private String totalCnts4;
    private String saleDate;
    
    private String artGroupDebutYmd;
    private String artGroupNm;
    private String artGroupNmKo;
    private String artGroupExpln;
    private String artGroupRegYmd;
    private String artGroupDelYn;
    private int logoFileGroupNo;
    
    private String gdsDelYn;

    private int orderNo;
    private int seq;
    private int qty;
    private int amount;
    private String option1;
    private String option2;
    private String productPurchases; //상품구매건수
    private String goodsNum;	//상품수
    private String competition ;	//경쟁률
    
    private String keyword;
    private String currentPage;
    private String total;
    
    private String startDate;
    private String endDate;
    private String purchaseCount;
    private String CNT9;
    private String totalQty;
    private String totalAmount;
    private String totalRevenue;
    private String reservationTotalSales;
    private String reservationTotalSales1;
    private String concertTotalSales;
    private String fanmeetingTotalSales;
    private String etcTotalSales;
    private String reportTotalCnt;
    private String etcTicketSales;
    private String ageGroup;
    private String purchaseCount2;
    
    private String startRow;
    private String endRow;

    //GD01 : 굿즈, GD02 : 티켓
    private String gubun;
}
