package com.ohot.employee.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AtrzLineVO {
	
	private int atrzLnNo;
	private String atrzDocNo;
	private long atrzEmpNo;
	private String atrzLnSttsCd;
	private String atrzOpnn;
	private String rjctRsn;
	private String atrzDt;
	private int atrzSn;
	private String aprvrJbgdCd;
	private String aprvrOffcsPhoto;
	private String lastAtrzYn;
	private long aprvrStampFileGroupNo;
	
	// 결재자 직인파일경로
	private String aprvrStampFileSaveLocate;

	// 결재 일자
	private String atrzYmd;
}
