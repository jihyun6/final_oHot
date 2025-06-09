package com.ohot.employee.vo;

import java.util.List;

import lombok.Data;

@Data
public class ApprovalLineVO {

	private List<ApprovalVO> approvals;
	private List<ApprovalVO> referrers;
	private ApprovalVO drafter;
}
