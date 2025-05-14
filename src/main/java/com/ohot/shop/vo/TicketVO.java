package com.ohot.shop.vo;

import java.util.List;

import com.ohot.vo.FileGroupVO;

import lombok.Data;

@Data
public class TicketVO {
	
	
	private int tkVprice;
	private int tkRprice;
	private int tkSprice;
	private long tkNo;
	private String tkCtgr;
	private String tkLctn;
	private int gdsNo;
	private String tkStartYmd;
	private String tkFinishYmd;
	private int tkRuntime;
	private String tkLctnAddress;
	
	private long posterFile;
	private String tkFileSaveLocate;
	private FileGroupVO fileGroupVO;
		
	//ticket : tkDetail 1:N
	private List<TkDetailVO> tkDetailVOList;
	
	private int totalSeatCnt;
	private int rsvtCnt;

}
