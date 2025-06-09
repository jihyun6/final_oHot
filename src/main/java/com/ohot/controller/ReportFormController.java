package com.ohot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.service.ReportFormService;
import com.ohot.util.UploadController;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.ReportmanageVO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho")
public class ReportFormController {

	@Autowired ReportFormService reportFormService;
	UploadController uploadController;

	
	@GetMapping("/reportForm/reportFormDetail")
	public String edit(ReportmanageVO reportmanageVO
			, Model model, HttpSession session ){
		
		log.info("edit-> reportmanageVO : " + reportmanageVO);
		
		//세션에서 로그인한 이메일을 가져온다
		String memEmail = (String) session.getAttribute("userEmail");
		log.info("현제 로그인한 이메일: " +memEmail);
		
		// 이메일 값을 reportmanageVO에 설정
		reportmanageVO.setMemEmail(memEmail);
		
		
		List<ReportmanageVO> reportList = this.reportFormService.reportList(reportmanageVO);
		log.info("reportList================= : " +reportList );
		
		
		model.addAttribute("reportList",reportList);
		log.info("reportList================= : " +reportList );

		/*
		 * ReportmanageVO reportFormVODetail =
		 * this.reportFormService.reportFormVODetail(reportmanageVO);
		 * 
		 * log.info("edit-> reportFormVODetail : " + reportFormVODetail);
		 * 
		 * model.addAttribute("reportFormVODetail", reportFormVODetail);
		 */
		return "reportForm/reportFormDetail";
	}
	
	//data{"reportBoardNo": "1","memNo": "2","reportCn": "asfd"}
	/*
	    reportPostNo : 0
	    reportGubun:  게시글
	    reportBoardNo:  43
	    memNo:  8
	    reportTitle : 운영규칙 위반
	    reportCn : 상세내용22
	    uploadFile : [object File]
	*/
	//신고 insert
	@ResponseBody
	@PostMapping("/reportForm/registerPost")
	public String editPost(ReportmanageVO reportmanageVO) {
	
		log.info("editPost->reportmanageVO: {}", reportmanageVO);
	    
		/*
		editPost->reportmanageVO: ReportmanageVO(reportPostNo=0, reportBoardNo=43, reportTitle=운영규칙 위반, reportCn=상세내용22,
		 reportRegDt=null, reportChgDt=null, reportDelYn=null, memNo=8, reportCnt=0, reportTermination=null, reportResult=null, 
		 memberVO=null, memName=null, piMemName=null, memLastName=null, memFirstName=null, memNicknm=null, memEmail=null, 
		 piMemEmail=null, memTelno=null, memBirth=null, memPswd=null, joinYmd=null, secsnYmd=null, memAccessToken=null, enabled=0, 
		 memStatSecCodeNo=null, memSecCodeNo=null, memDelYn=null, reportlist=null, reportGubun=게시글, pictureUrl=null, 
		 uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@53674ae0],
		  fileGroupNo=0, fileRegdate=null, fileGroupVO=null)
		 */
	    
	    // ReportmanageVO에 값을 설정하고 DB에 저장하는 로직
//	    reportmanageVO.setReportBoardNo(Integer.parseInt(reportBoardNo));
//	    reportmanageVO.setMemNo(Integer.parseInt(memNo));
//	    reportmanageVO.setReportCn(reportCn);
	    // 파일 관련 처리도 필요할 경우 추가
	    
		log.info("editPost->reportmanageVO(전) : " + reportmanageVO);
		
		int result = this.reportFormService.editPost(reportmanageVO);
		log.info("editPost->result : " + result);

		log.info("registerPost->reportmanageVO(후) : " + reportmanageVO);
		
		
		
		return "success";
	}
	

}
