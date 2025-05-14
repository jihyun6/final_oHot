package com.ohot.employee.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.employee.mapper.EmployeeMapper;
import com.ohot.employee.service.EmployeeService;
import com.ohot.employee.vo.ApprovedConcertPlanVO;
import com.ohot.employee.vo.ApprovedConversionRequestVO;
import com.ohot.employee.vo.AtrzDocVO;
import com.ohot.employee.vo.AtrzLineVO;
import com.ohot.employee.vo.AtrzRefVO;
import com.ohot.employee.vo.DepartmentVO;
import com.ohot.employee.vo.EmployeeScheduleVO;
import com.ohot.home.alarm.mapper.AlarmMapper;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.vo.EmployeeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	@Override
	public List<DepartmentVO> treeList() {
		return this.employeeMapper.treeList();
	}

	@Transactional(rollbackFor = {IOException.class, SQLException.class, IllegalStateException.class})
	@Override
	public String atrzDocInsert(AtrzDocVO atrzDocVO) {
		log.info("aaaaaaaaaaaaaaaaaaaaaaaaa: "+atrzDocVO);
		/*
		 * atrzDocPost : AtrzDocVO(atrzDocNo=null, docFmNo=2, drftTtl=, drftCn=테스트입니다,
		 * emrgYn=N, drftYmd=null, ddlnYmd=null, drftEmpNo=202503240016,
		 * offcsPhoto=null, drftJbgdCd=P01, fileGroupNo=0, drftStampFileGroupNo=0,
		 * prefix=null, atrzRefVOList=[AtrzRefVO(atrzRefNo=0, refEmpNo=202301010005,
		 * atrzDocNo=null, atrzIdntyYn=null, refJbgdCd=P05), AtrzRefVO(atrzRefNo=0,
		 * refEmpNo=202301010010, atrzDocNo=null, atrzIdntyYn=null, refJbgdCd=P04),
		 * AtrzRefVO(atrzRefNo=0, refEmpNo=202301010025, atrzDocNo=null,
		 * atrzIdntyYn=null, refJbgdCd=P03)], atrzLineVOList=[AtrzLineVO(atrzLnNo=0,
		 * atrzDocNo=null, atrzEmpNo=202301010004, atrzStts=null, atrzOpnn=null,
		 * rjctRsn=null, atrzDt=null, atrzSn=0, aprvrJbgdCd=P05, aprvrOffcsPhoto=null,
		 * lastAtrzYn=null, aprvrStampFileGroupNo=0), AtrzLineVO(atrzLnNo=0,
		 * atrzDocNo=null, atrzEmpNo=202301010009, atrzStts=null, atrzOpnn=null,
		 * rjctRsn=null, atrzDt=null, atrzSn=0, aprvrJbgdCd=P04, aprvrOffcsPhoto=null,
		 * lastAtrzYn=null, aprvrStampFileGroupNo=0)],
		 * approvedConcertPlanVO=ApprovedConcertPlanVO(conPlanNo=0, atrzDocNo=null,
		 * gdsNm=에스파, tkCtgr=콘서트, tkLctn=아카데미홀, playerNm=에스파, hostOrg=오호엔터,
		 * expectedAudience=10000, expectedBudget=40000000, background=테스트입니다,
		 * requests=테스트를할거에요, remarks=하하하ㅏ, regYmd=null))
		 */
		
		String atrzDocNo = this.employeeMapper.atrzDocSelectKey(atrzDocVO);
		log.info("atrzDocNO : " +  atrzDocNo);
		
		atrzDocVO.setAtrzDocNo(atrzDocNo);
		
		// 결재문서 테이블 insert
		int result = this.employeeMapper.atrzDocInsert(atrzDocVO);
		
		// 결재선 테이블 insert
		if(atrzDocVO.getAtrzLineVOList()!=null) {
			int sn = 0;
			for(AtrzLineVO atrzLineVO : atrzDocVO.getAtrzLineVOList()) {
				atrzLineVO.setAtrzDocNo(atrzDocNo);
				
				// sn 부여
				sn++;
				atrzLineVO.setAtrzSn(sn);
				
				if(sn==1) {
					atrzLineVO.setAtrzLnSttsCd("WAIT");
				}else {
					atrzLineVO.setAtrzLnSttsCd("READY");
				}
				
				this.employeeMapper.atrzLineInsert(atrzLineVO);
				
			}
		}
		
		// 결재 참조 테이블 insert
		if(atrzDocVO.getAtrzRefVOList() != null) {
			for(AtrzRefVO atrzRefVO : atrzDocVO.getAtrzRefVOList()) {
				atrzRefVO.setAtrzDocNo(atrzDocNo);
				
				this.employeeMapper.atrzRefInsert(atrzRefVO);
			}
		}
		  
		// 공연기획 최종승인 테이블 insert
		if(atrzDocVO.getApprovedConcertPlanVO()!=null) {
			
			atrzDocVO.getApprovedConcertPlanVO().setAtrzDocNo(atrzDocNo);
			
			this.employeeMapper.approvedConcertPlanInsert(atrzDocVO.getApprovedConcertPlanVO());
		}
		
		// 아티스트전환 최종승인 테이블 insert
		if(atrzDocVO.getApprovedConversionRequestVO()!=null) {
			
			atrzDocVO.getApprovedConversionRequestVO().setAtrzDocNo(atrzDocNo);
			
			this.employeeMapper.approvedConversionRequestInsert(atrzDocVO.getApprovedConversionRequestVO());
		}
		
		log.info("atrzDocInsert->result : "+ result);
		
		if(result==0) {
			throw new IllegalStateException("기안서등록 실패로 롤백 처리");
		}else {	
			
			log.info("전체 insert 성공");
			int lineResult=0;
			int refResult=0;
						
			// 결재선 리스트를 순회하며 각 결재자에게 알림 전송
		    for (AtrzLineVO line : atrzDocVO.getAtrzLineVOList()) {
		        NotificationVO notificationVO = new NotificationVO();
		        notificationVO.setEmpNotiSndrNo(atrzDocVO.getDrftEmpNo()); // 발신자: 기안자
		        notificationVO.setEmpNotiRcvrNo(line.getAtrzEmpNo());       // 수신자: 결재선 개별 사원
		        notificationVO.setNotiCn("[결재도착] "+atrzDocVO.getDrftTtl());  // 알림 내용: 기안 제목 등
		        notificationVO.setEmpOrgNo(atrzDocNo);
		        lineResult = this.alarmMapper.empAlarmInsert(notificationVO);
		        
		    }
		    //참조인
		    for (AtrzRefVO ref : atrzDocVO.getAtrzRefVOList()) {
		        NotificationVO notificationVO = new NotificationVO();
		        notificationVO.setEmpNotiSndrNo(atrzDocVO.getDrftEmpNo()); // 기안자
		        notificationVO.setEmpNotiRcvrNo(ref.getRefEmpNo());        // 참조자
		        notificationVO.setNotiCn("[참조] " + atrzDocVO.getDrftTtl()); // 알림 내용에 [참조] 표시
		        notificationVO.setEmpOrgNo(atrzDocNo);
		        refResult =this.alarmMapper.empAlarmInsert(notificationVO);
		    }
		    if(lineResult>0) {
		    	log.info("결재선 알림성공 몇개 : "+lineResult+"참조선 알림성공 몇개: "+refResult);
		    	return atrzDocNo;
		    }else {
		    	throw new IllegalStateException("알림등록 실패로 롤백 처리");
		    }

		}
		
		
	}

	@Override
	public DepartmentVO atrzDocDetail(String atrzDocNo) {
		
		return this.employeeMapper.atrzDocDetail(atrzDocNo);
	}

	@Override
	public List<DepartmentVO> atrzRefDetail(String atrzDocNo) {
		return this.employeeMapper.atrzRefDetail(atrzDocNo);
	}

	@Override
	public List<DepartmentVO> atrzLineDetail(String atrzDocNo) {
		return this.employeeMapper.atrzLineDetail(atrzDocNo);
	}

	@Override
	public ApprovedConcertPlanVO aprrovedConcertPlanDetail(String atrzDocNo) {
		return this.employeeMapper.aprrovedConcertPlanDetail(atrzDocNo);
	}

	@Override
	public List<DepartmentVO> atrzAllList(Map<String, Object> data) {
		return this.employeeMapper.atrzAllList(data);
	}

	@Transactional
	@Override
	public int atrzLineUpdate(AtrzLineVO atrzLineVO) {
		
		log.info("atrzLineUpdate=>atrzLineVO : "+ atrzLineVO);
		log.info("atrzLineUpdate 체크 sn : " + atrzLineVO.getAtrzSn());
		
		// 현재결재자 결재순번값
		int currentSn = atrzLineVO.getAtrzSn();
		
		int result = this.employeeMapper.atrzLineUpdate(atrzLineVO);
		
		if(result!=0) {
			
			// 현재 결재자가 최종결재자인지 체크
			int maxAtrzSn = this.employeeMapper.selectMaxAtrzSn(atrzLineVO);
			
			// 결재 승인시 
			if("APPROVED".equals(atrzLineVO.getAtrzLnSttsCd())){
				
				// 현재 결재자가 최종결재자면 결재문서 APR03(완료)로 업뎃, 최종공연승인테이블 등록일 update
				// 결재선테이블 최종 결재자여부 업데이트
				if(maxAtrzSn == currentSn) {
					this.employeeMapper.updateAtrzDocToApproved(atrzLineVO);
					this.employeeMapper.updateConcertPlanRegYmd(atrzLineVO);
					
					atrzLineVO.setLastAtrzYn("Y");
					this.employeeMapper.updateLastAtrzYn(atrzLineVO);
					
				}else {
					// 다음 결재자 상태 WAIT 결재대기로 업데이트
					AtrzLineVO nextApproval = new AtrzLineVO();
					
					int nextSn = currentSn+1;
					nextApproval.setAtrzSn(nextSn);
					nextApproval.setAtrzDocNo(atrzLineVO.getAtrzDocNo());
					nextApproval.setAtrzLnSttsCd("WAIT");
					
					this.employeeMapper.atrzSttsCdUpdate(nextApproval);
					
				}
				
			}// 결재 반려시
			else if("REJECTED".equals(atrzLineVO.getAtrzLnSttsCd())){ 
				
				if(maxAtrzSn != currentSn) {
					//다음 결재자 상태 skipped로 업뎃
					this.employeeMapper.updateNextLinesToSkipped(atrzLineVO);
				}
				
				// 결재문서 반려면 APR02로 업뎃
				this.employeeMapper.updateAtrzDocToRejected(atrzLineVO);
			}
			
		}
		
		return result;
	}

	@Override
	public boolean checkCanApprove(List<DepartmentVO> atrzLineVOList, long empNo) {
		
		
		// 결재선 depth가 깊어서 펼치기
		List<AtrzLineVO> atrzLineList = new ArrayList<>();
		
		for(DepartmentVO departmentVO : atrzLineVOList) {
			for(EmployeeVO employeeVO : departmentVO.getEmployeeVOList()) {
				atrzLineList.addAll(employeeVO.getAtrzLineVOList());
			}
		}
		
		// 로그인한 사원 결재선 찾기
		for(int i = 0; i<atrzLineList.size(); i++) {
			AtrzLineVO atrzLineVO = atrzLineList.get(i);
			
			System.out.println("Check empNo: " + atrzLineVO.getAtrzEmpNo() + " vs " + empNo);
			System.out.println("Check status: " + atrzLineVO.getAtrzLnSttsCd());
			
			if(atrzLineVO.getAtrzEmpNo() == empNo) {
				// 로그인한 사원 앞사람 결재 완료 체크
				for(int j = 0; j<i; j++) {
					AtrzLineVO beforeLine = atrzLineList.get(j);
					if(!"결재 승인".equals(beforeLine.getAtrzLnSttsCd())) {
						
						return false; // 앞사람 결재 안했으면 결재 불가
					}
				}
				
				// 앞사람들 결재완료 했고 
				return "결재 대기".equals(atrzLineVO.getAtrzLnSttsCd()); // 내 결재상태 WAIT이면 결재가능
			}
		}
		
		return false; // 로그인한 사원 결재선 없으면 결재 불가
	}

	@Override
	public int cntEmrgAtrz(long empNo) {
		return this.employeeMapper.cntEmrgAtrz(empNo);
	}

	@Override
	public int cntWaitAtrz(long empNo) {
		return this.employeeMapper.cntWaitAtrz(empNo);
	}

	@Override
	public int cntReadyAtrz(long empNo) {
		return this.employeeMapper.cntReadyAtrz(empNo);
	}

	@Override
	public int cntRefAtrz(long empNo) {
		return this.employeeMapper.cntRefAtrz(empNo);
	}


	@Override
	public List<DepartmentVO> atrzDocBoxList(Map<String, Object> data) {
		return this.employeeMapper.atrzDocBoxList(data);
	}

	@Override
	public int updateRefIdntyYn(AtrzRefVO atrzRefVO) {
		return this.employeeMapper.updateRefIdntyYn(atrzRefVO);
	}

	@Override
	public ApprovedConversionRequestVO approvedConversionRequestDetail(String atrzDocNo) {
		return this.employeeMapper.approvedConversionRequestDetail(atrzDocNo);
	}
	
	///// 스케줄 시작 /////
	// EMPLOYEE 개인 스케줄 불러오기
	@Override
	public List<EmployeeScheduleVO> getEmployeeSchedule(long empNo) throws Exception {
		
		List<EmployeeScheduleVO> employeeScheduleVOList = this.employeeMapper.getEmployeeSchedule(empNo);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(!employeeScheduleVOList.isEmpty()) {
			
		   for(EmployeeScheduleVO employeeScheduleVO: employeeScheduleVOList) {
		      
		      Date date = sdf.parse(employeeScheduleVO.getEndDate());
		      Calendar cal = Calendar.getInstance();
		      cal.setTime(date);
		      cal.add(Calendar.DATE, 1);       // 날짜 +1일

		      String end = sdf.format(cal.getTime());
		      employeeScheduleVO.setEnd(end);
		      employeeScheduleVO.setStart(employeeScheduleVO.getStartDate());
		      
		      if(employeeScheduleVO.getDeptNo() != 0) { // 부서 번호가 있으면
		    	  employeeScheduleVO.setType("department");
		      }else {
		    	  employeeScheduleVO.setType("persnal");
		      }
		      
		   }
		}
		
		return employeeScheduleVOList;
	}
	
	// EMPLOYEE 개인 스케줄 등록
	@Override
	public void addEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO) {
		this.employeeMapper.addEmployeeSchedule(employeeScheduleVO);
	}

	// EMPLOYEE 개인 스케줄 수정
	@Override
	public void editEmployeeSchedule(EmployeeScheduleVO employeeScheduleVO) {
		this.employeeMapper.editEmployeeSchedule(employeeScheduleVO);
	}

	// EMPLOYEE 개인 스케줄 삭제
	@Override
	public int deleteEmployeeSchedule(int employeeScheduleNo) {
		return this.employeeMapper.deleteEmployeeSchedule(employeeScheduleNo);
	}
	///// 스케줄 끝 /////

}
