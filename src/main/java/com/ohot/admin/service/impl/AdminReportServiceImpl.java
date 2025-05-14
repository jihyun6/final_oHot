package com.ohot.admin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.admin.mapper.AdminReportMapper;
import com.ohot.admin.service.AdminReportService;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminReportServiceImpl implements AdminReportService {
	
	
	@Autowired
	AdminReportMapper adminReportMapper;
	
	//신고 리스트 상세검색
	@Override
	public List<ReportmanageVO> reportListSearchPost(Map<String, Object> data) {
		return this.adminReportMapper.reportListSearchPost(data);
	}

	//신고 목록 총 개수
	@Override
	public int getTotalCount(Map<String, Object> data) {
		return this.adminReportMapper.getTotalCount(data);
	}

	//신고 리스트 상세검색
	@Override
	public ReportmanageVO reportmanageDetail(ReportmanageVO reportmanageVO) {
		return this.adminReportMapper.reportmanageDetail(reportmanageVO);
	}

	//REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 '001','004','N'          UPDATE함
	// + MEMBER 테이블의 MEM_STAT_SEC_CODE_NO 컬럼의 값을 '001','004','001' 또는 로 UPDATE
	@Transactional
	@Override
	public int reportBoardPostUpdate(ReportmanageVO reportmanageVO) {
		//1) REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 '001','004','N'          UPDATE함
		int result = this.adminReportMapper.reportBoardPostUpdate(reportmanageVO);
		
		/*
		ReportmanageVO(reportPostNo=1, reportBoardNo=0, reportTitle=null, reportCn=null, reportRegDt=null, reportChgDt=null
		, reportDelYn=null, memNo=0, reportCnt=0, reportTermination=null, reportResult=004
		, memberVO=null..,piMemEmail=o@naver.com
		 */
		//2) MEMBER 테이블의 MEM_STAT_SEC_CODE_NO 컬럼의 값을 '001','004','001' 또는 로 UPDATE
		result += this.adminReportMapper.memberCodeNoUpdate(reportmanageVO);
		
		return result;
	}
	
	
}
