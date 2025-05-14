package com.ohot.home.community.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class ArtistGroupNoticeVO {
	private long fileGroupNo;
	private int parentPostNo;
	private int bbsPostNo;
	private int bbsTypeCdNo;
	private String bbsTitle;
	private String bbsCn;
	private Date bbsRegDt;
	private String bbsRegDt2;
	private String bbsRegDate;
	private Date bbsChgDt;
	private String bbsDelYn;
	private int bbsInqCnt;
	private int artGroupNo;
	
	private String artGroupNm;
	
	private MultipartFile[] uploadFile;
	
	private FileGroupVO fileGroupVO;
}
