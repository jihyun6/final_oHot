package com.ohot.vo;

import java.util.List;

import com.ohot.employee.vo.DepartmentVO;

import lombok.Data;

@Data
public class UsersVO {
	// security를 위해 만든 회원+사원 합한 가상의 사용자 테이블
	
	private long userNo;
	private String userMail;
	private String userPswd;
	private int enabled;
	
	// 간편로그인 회원 여부
	private String snsYn;
	
	private EmployeeVO employeeVO;
	
	private MemberVO memberVO;
	
	private DepartmentVO departmentVO;
	
	private List<UserAuthVO> userAuthList;
	
}
