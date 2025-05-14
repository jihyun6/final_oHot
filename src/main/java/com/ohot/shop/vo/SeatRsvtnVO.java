package com.ohot.shop.vo;

import java.util.List;

import lombok.Data;

@Data
public class SeatRsvtnVO {
	//좌석 구매 제한을 확인을 위한 VO
	private int gdsNo;
	private int artGroupNo;
	private long tkDetailNo;
	private int memNo;

	private int boughtCnt;
	private List<SeatVO> seatVOList;
}
