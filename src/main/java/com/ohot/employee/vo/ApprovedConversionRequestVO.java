package com.ohot.employee.vo;

import lombok.Data;

@Data
public class ApprovedConversionRequestVO {

	private int planNo;
	private String atrzDocNo;
	private String memEmail;
	private String memFullName;
	private String reason;
	private String remarks;
	private String regYmd;
}
