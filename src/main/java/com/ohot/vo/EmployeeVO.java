package com.ohot.vo;

import java.util.List;

import com.ohot.employee.vo.AtrzDocVO;
import com.ohot.employee.vo.AtrzLineVO;
import com.ohot.employee.vo.AtrzRefVO;
import com.ohot.employee.vo.DepartmentVO;

import lombok.Data;

@Data
public class EmployeeVO {
	private long empNo;
	private String empPswd;
	private String empNm;
	private String empRrno;
	private String empBrdt;
	private String empTelno;
	private String empEmlAddr;
	private String jncmpYmd;
	private String rsgntnYmd;
	private String empZip;
	private String empAddr;
	private String empDaddr;
	private String offcsPhoto;
	private String jbgdCd;
	private String sexdtnCd;
	private int deptNo;
	private String empStngYn;
	private long fileGroupNo;
	private int enabled;
	private String snsEmpYn; // SNS간편가입여부 / default = 'N'
	private long stampFileGroupNo;
	
	// 직급코드 한글로 노출
	private String position;
	
	// 프로필 파일 경로
	private String profileSaveLocate;
	
	// Employee : FILEGROUP = 1 : 1
    private FileGroupVO fileGroupVO;
	
	private DepartmentVO departmentVO;
	
	// 권한 목록
	private List<AuthVO> auth2VOList;
	
	// 사원 : 결재문서 = 1 : N
	private List<AtrzDocVO> atrzDocVOList;
	
	// 사원 : 결재선 = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 사원 : 결재참조 = 1 : N
	private List<AtrzRefVO> atrzRefVOList;
}
