package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.admin.service.AdminReportService;
import com.ohot.util.BoardPage;
import com.ohot.util.Pazing;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.MemberVO;
import com.ohot.vo.ReportmanageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller("AdminReportmanageController")
@RequestMapping("/admin/reportmanage")
public class AdminReportmanageController {

	@Autowired
	AdminReportService adminReportService;
	
	//신고 리스트
	@GetMapping("/reportList")
	public String reportmanage(Model model) {
		log.info("adGoodsList Start!");
		return "admin/reportmanage/reportList";
	}
	// 상세검색
		@ResponseBody
		@PostMapping("/reportListPost")
		public Map<String, Object> reportListSearchPost(@RequestBody Map<String, Object> data) {
			log.info("reportListSearchPost: " + data);
			
			int currentPage = 1;
			try {
				currentPage = Integer.parseInt(String.valueOf(data.get("page")));
			} catch (Exception e) {
				log.warn("페이지 파싱 실패, 기본값 1 사용");
			}

			log.info("안담기니? 담기렴" + data);
			int size = 10;

			List<ReportmanageVO> reportList = this.adminReportService.reportListSearchPost(data);
			log.info("search->reportListSearchPost: " + reportList);
			
			//신고 목록 총 개수
			int total = this.adminReportService.getTotalCount(data); 
			log.info("reportListSearchPost->total 행 : " + total);
			
			int totalPages = (int) Math.ceil((double) total / size);
			int startPage = Math.max(1, currentPage - 5);
			int endPage = Math.min(totalPages, currentPage + 4);
			
			log.info("이게 필요핸가?: " + totalPages + "start: " + startPage + "end: " + endPage);

			Map<String, Object> result = new HashMap<>();
			result.put("content", reportList);
			result.put("currentPage", currentPage);
			result.put("totalPages", totalPages);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("total", total);

			return result;
			
		}
		@ResponseBody
		@GetMapping("/reportmanageDetail")
		public ReportmanageVO reportmanageDetail(ReportmanageVO reportmanageVO) {
			log.info("reportmanageDetailPost: " + reportmanageVO);
			
			ReportmanageVO reportVODetail = this.adminReportService.reportmanageDetail(reportmanageVO);
			
			log.info("reportmanageDetailPost->reportmanageDetail" + reportVODetail);
			
			return reportVODetail;
		}
		
		//REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 UPDATE함
		@ResponseBody
		@PostMapping("/reportBoardPostUpdate")
		public ReportmanageVO reportBoardPostUpdate(ReportmanageVO reportmanageVO) {
			/*
			ReportmanageVO(reportPostNo=1, reportBoardNo=0, reportTitle=null, reportCn=null, reportRegDt=null, reportChgDt=null
			, reportDelYn=null, memNo=0, reportCnt=0, reportTermination=null, reportResult=004
			, memberVO=null..,piMemEmail=o@naver.com
			 */
			log.info("reportBoardPostUpdate->reportmanageVO : " + reportmanageVO);
			
			int result = this.adminReportService.reportBoardPostUpdate(reportmanageVO);
			
			log.info("reportBoardPostUpdate->result" + result);
			
			return reportmanageVO;
		}
}









