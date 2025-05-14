package com.ohot.admin.service;

import java.util.List;
import java.util.Map;

import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;

public interface AdminReportService {

	//신고 리스트 상세검색
	public List<ReportmanageVO> reportListSearchPost(Map<String, Object> data);

	//신고 목록 총 개수
	public int getTotalCount(Map<String, Object> data);

	//신고 리스트 상세검색
	public ReportmanageVO reportmanageDetail(ReportmanageVO reportmanageVO);

	//REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 UPDATE함
	public int reportBoardPostUpdate(ReportmanageVO reportmanageVO);

	


}
