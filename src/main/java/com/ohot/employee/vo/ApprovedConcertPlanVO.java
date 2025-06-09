package com.ohot.employee.vo;


import lombok.Data;

@Data
public class ApprovedConcertPlanVO {

	private int conPlanNo;
	private String atrzDocNo;
	private String gdsNm;
	private String tkCtgr;
	private String tkLctn;
	private String playerNm;
	private String hostOrg;
	private int expectedAudience;
	private int expectedBudget;
	private String background;
	private String requests;
	private String remarks;
	private String regYmd;
}
