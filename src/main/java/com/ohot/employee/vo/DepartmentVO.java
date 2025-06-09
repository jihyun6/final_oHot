package com.ohot.employee.vo;

import java.util.List;

import com.ohot.vo.EmployeeVO;

import lombok.Data;

@Data
public class DepartmentVO {

	private int rnum;
	private int deptNo;
	private String deptNm;
	private int upDept;
	private int deptSn;
	private String crtYmd;
	
	// 1 : N = 부서 : 사원
	private List<EmployeeVO> employeeVOList;

	private int totalCnt;
}
