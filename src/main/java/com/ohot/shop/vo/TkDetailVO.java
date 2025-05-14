package com.ohot.shop.vo;

import java.util.List;

import lombok.Data;

@Data
public class TkDetailVO {

	private long tkDetailNo;
	private String tkYmd;
	private int tkRound;
	private long tkNo;
	private String gdsNm;
	
	//tkDetail : seat = 1:N
	//private List<SeatVO> seatVOList;
}
