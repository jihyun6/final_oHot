package com.ohot.shop.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TkRsvtnVO {
	
	private int tkRsvtn;
	private Date rsvtnDt;
	private int rsvtnEnum;
	private int memNo;
	private long tkDetailNo;
	private String seatNo;
	
	private List<SeatVO> seatVOList;

}
