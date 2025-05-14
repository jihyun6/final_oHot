package com.ohot.employee.vo;

import lombok.Data;

@Data
public class ApprovedGoodsPlanVO {

	private int goodsPlanNo;
	private String atrzDocNo;
	private String gdsNm;
	private String gdsType;
	private String artActNm;
	private String artGroupNm;
	private String salesChannel;
	private int expectedProduction;
	private int expectedRevenue;
	private String planDetail;
	private String requests;
	private String remarks;
	private String regYmd;
}
