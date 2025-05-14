package com.ohot.service;

import java.util.List;

import com.ohot.vo.ReportmanageVO;

public interface ReportFormService {

	ReportmanageVO reportFormVODetail(ReportmanageVO reportmanageVO);

	//신고 insert
	public int editPost(ReportmanageVO reportmanageVO);

	public List<ReportmanageVO> reportList(ReportmanageVO reportmanageVO);

}
