package com.ohot.shop.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SeatVO {
	
	private int seatGrade;
	private String seatNo;
	private String tkLctn;
	private int seatFloor;
	private String seatSection;
	private int seatRow;
	private int seatDetailNo;
	
	private int rsvtnEnum;
	private int memNo;

}
