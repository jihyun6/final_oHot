package com.ohot.employee.vo;

import lombok.Data;

@Data
public class ApprovalVO {

	private String type;
    private String empNm;
    private String position;
    private String deptNm;
    private long empNo;
    
    private String jbgdCd;
    private long stampFileGroupNo;
    private String profileSaveLocate;
}
