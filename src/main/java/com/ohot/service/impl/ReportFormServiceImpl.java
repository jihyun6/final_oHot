package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.mapper.ReportFormMapper;
import com.ohot.service.ReportFormService;
import com.ohot.util.UploadController;
import com.ohot.vo.ReportmanageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReportFormServiceImpl implements ReportFormService{
	
	@Autowired
	ReportFormMapper reportFormMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Override
	public ReportmanageVO reportFormVODetail(ReportmanageVO reportmanageVO) {

		return this.reportFormMapper.reportFormVODetail(reportmanageVO);
	}

	
	//신고 insert
	@Override
	public int editPost(ReportmanageVO reportmanageVO) {
		
		/*
		editPost->reportmanageVO: ReportmanageVO(reportPostNo=0, reportBoardNo=43, reportTitle=운영규칙 위반, reportCn=상세내용22,
		 reportRegDt=null, reportChgDt=null, reportDelYn=null, memNo=8, reportCnt=0, reportTermination=null, reportResult=null, 
		 memberVO=null, memName=null, piMemName=null, memLastName=null, memFirstName=null, memNicknm=null, memEmail=null, 
		 piMemEmail=null, memTelno=null, memBirth=null, memPswd=null, joinYmd=null, secsnYmd=null, memAccessToken=null, enabled=0, 
		 memStatSecCodeNo=null, memSecCodeNo=null, memDelYn=null, reportlist=null, reportGubun=게시글, pictureUrl=null, 
		 uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@53674ae0],
		  fileGroupNo=0, fileRegdate=null, fileGroupVO=null)
		 */
		//파일업로드
		MultipartFile[] multipartFile = reportmanageVO.getUploadFile();
		
		// 널처리
		if (multipartFile != null && multipartFile.length > 0) {
	        long fileGroupNo = this.uploadController.multiImageUpload(multipartFile);
	        reportmanageVO.setFileGroupNo(fileGroupNo);
	        log.info("fileGroupNo : " + fileGroupNo);
	    }
		
		log.info("editPost->reportmanageVO(최종): {}", reportmanageVO);
		
		return this.reportFormMapper.editPost(reportmanageVO);
	}


	@Override
	public List<ReportmanageVO> reportList(ReportmanageVO reportmanageVO) {
		return this.reportFormMapper.reportList(reportmanageVO);
	}
	
}
