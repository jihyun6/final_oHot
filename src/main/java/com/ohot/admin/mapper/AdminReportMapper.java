package com.ohot.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;

@Mapper
public interface AdminReportMapper {

	//신고 리스트 상세검색
	public List<ReportmanageVO> reportListSearchPost(Map<String, Object> data);

	//신고 목록 총 개수
	public int getTotalCount(Map<String, Object> data);

	//신고 리스트 상세검색
	public ReportmanageVO reportmanageDetail(ReportmanageVO reportmanageVO);

	//1) REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 '001','004','N'          UPDATE함
	public int reportBoardPostUpdate(ReportmanageVO reportmanageVO);

	//2) MEMBER 테이블의 MEM_STAT_SEC_CODE_NO 컬럼의 값을    '001','004','001' 또는 로 UPDATE
	public int memberCodeNoUpdate(ReportmanageVO reportmanageVO);
	
	
	

}
