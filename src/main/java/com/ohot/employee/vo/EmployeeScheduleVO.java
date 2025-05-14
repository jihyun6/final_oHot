package com.ohot.employee.vo;

import lombok.Data;

@Data
public class EmployeeScheduleVO {
	private int employeeScheduleNo;
	private String startDate;
	private String endDate;
	private int deptNo;
	private String backgroundColor;
	private String textColor;
	private String borderColor;
	private String delYn;
	private String title;
	private String description;
	private long empNo;
	
	// fullcalendar 변수명과 매칭
	private String start;
	private String end;
	
	private String type;
}
