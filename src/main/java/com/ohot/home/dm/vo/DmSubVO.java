package com.ohot.home.dm.vo;

import lombok.Data;

@Data
public class DmSubVO {
	
	private long dmSubNo;
	private String dmStrYmd;
	private String dmFinYmd;
	private String dmFinYn;
	private int memNo;
	private int artNo;
	
	private String fileSaveLocate;
	private int notReadCnt;

}
