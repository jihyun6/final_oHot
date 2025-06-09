package com.ohot.home.dm.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DmMsgVO {

	private int msgNo;
	private String msgContent;
	private Date msgDt;
	private String msgReadYn;
	private int fileGroupNo;
	private int msgSndrNo;
	private long dmSubNo;
	private int artNo;
	
	private String msgDtStr;
	
	private int start;
	private int end;
	private String sndrActNm;
	private String sndrProfileImg;
	private String memFirstName;
}
