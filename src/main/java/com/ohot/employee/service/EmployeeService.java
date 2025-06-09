package com.ohot.employee.service;

import java.util.List;
import java.util.Map;

import com.ohot.employee.vo.ApprovedConcertPlanVO;
import com.ohot.employee.vo.ApprovedConversionRequestVO;
import com.ohot.employee.vo.AtrzDocVO;
import com.ohot.employee.vo.AtrzLineVO;
import com.ohot.employee.vo.AtrzRefVO;
import com.ohot.employee.vo.DepartmentVO;
import com.ohot.employee.vo.EmployeeScheduleVO;

public interface EmployeeService {

	public List<DepartmentVO> treeList();

	public String atrzDocInsert(AtrzDocVO atrzDocVO);

	public DepartmentVO atrzDocDetail(String atrzDocNo);

	public List<DepartmentVO> atrzRefDetail(String atrzDocNo);

	public List<DepartmentVO> atrzLineDetail(String atrzDocNo);

	public ApprovedConcertPlanVO aprrovedConcertPlanDetail(String atrzDocNo);

	public List<DepartmentVO> atrzAllList(Map<String, Object> data);

	public int atrzLineUpdate(AtrzLineVO atrzLineVO);

	public boolean checkCanApprove(List<DepartmentVO> atrzLineVOList, long empNo);

	public int cntEmrgAtrz(long empNo);

	public int cntWaitAtrz(long empNo);

	public int cntReadyAtrz(long empNo);

	public int cntRefAtrz(long empNo);

	public List<DepartmentVO> atrzDocBoxList(Map<String, Object> data);

	public int updateRefIdntyYn(AtrzRefVO atrzRefVO);

	public ApprovedConversionRequestVO approvedConversionRequestDetail(String atrzDocNo);
	
	///// 스케줄 시작 /////
	// EMPLOYEE 스케줄 불러오기
	public List<EmployeeScheduleVO> getEmployeeSchedule(long empNo) throws Exception;
	
	// EMPLOYEE 개인 스케쥴 등록
	public void addEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO);
	
	// EMPLOYEE 스케쥴 수정
	public void editEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO);
	
	// EMPLOYEE 개인 스케줄 삭제
	public int deleteEmployeeSchedule(int employeeScheduleNo); 
	///// 스케줄 끝 /////

}
