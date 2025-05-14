package com.ohot.employee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.employee.vo.ApprovedConcertPlanVO;
import com.ohot.employee.vo.ApprovedConversionRequestVO;
import com.ohot.employee.vo.AtrzDocVO;
import com.ohot.employee.vo.AtrzLineVO;
import com.ohot.employee.vo.AtrzRefVO;
import com.ohot.employee.vo.DepartmentVO;
import com.ohot.employee.vo.EmployeeScheduleVO;

@Mapper
public interface EmployeeMapper {

	public List<DepartmentVO> treeList();

	public int atrzDocInsert(AtrzDocVO atrzDocVO);

	public int approvedConcertPlanInsert(ApprovedConcertPlanVO approvedConcertPlanVO);

	public String atrzDocSelectKey(AtrzDocVO atrzDocVO);

	public void atrzLineInsert(AtrzLineVO atrzLineVO);

	public void atrzRefInsert(AtrzRefVO atrzRefVO);

	public DepartmentVO atrzDocDetail(String atrzDocNo);

	public ApprovedConcertPlanVO aprrovedConcertPlanDetail(String atrzDocNo);

	public List<DepartmentVO> atrzRefDetail(String atrzDocNo);

	public List<DepartmentVO> atrzLineDetail(String atrzDocNo);

	public List<DepartmentVO> atrzAllList(Map<String, Object> data);

	public int atrzLineUpdate(AtrzLineVO atrzLineVO);

	public void atrzSttsCdUpdate(AtrzLineVO nextApproval);

	public void updateNextLinesToSkipped(AtrzLineVO atrzLineVO);

	public void updateAtrzDocToRejected(AtrzLineVO atrzLineVO);

	public int selectMaxAtrzSn(AtrzLineVO atrzLineVO);

	public void updateAtrzDocToApproved(AtrzLineVO atrzLineVO);

	public void updateConcertPlanRegYmd(AtrzLineVO atrzLineVO);

	public void updateLastAtrzYn(AtrzLineVO atrzLineVO);

	public int cntEmrgAtrz(long empNo);

	public int cntWaitAtrz(long empNo);

	public int cntReadyAtrz(long empNo);

	public int cntRefAtrz(long empNo);

	public List<DepartmentVO> atrzDocBoxList(Map<String, Object> data);

	public int updateRefIdntyYn(AtrzRefVO atrzRefVO);

	public ApprovedConversionRequestVO approvedConversionRequestDetail(String atrzDocNo);

	public void approvedConversionRequestInsert(ApprovedConversionRequestVO approvedConversionRequestVO);

	///// 스케줄 시작 /////
	// EMPLOYEE 스케쥴 불러오기
	public List<EmployeeScheduleVO> getEmployeeSchedule(long empNo);
	
	// EMPLOYEE 스케쥴 등록
	public void addEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO);
	
	// EMPLOYEE 스케쥴 수정
	public void editEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO);

	// EMPLOYEE 스케줄 삭제
	public int deleteEmployeeSchedule(int employeeScheduleNo);
	///// 스케줄 끝 /////

}
