package com.ohot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.ReportmanageVO;

@Mapper
public interface ReportFormMapper {

	ReportmanageVO reportFormVODetail(ReportmanageVO reportmanageVO);

	//신고 insert
	public int editPost(ReportmanageVO reportmanageVO);

	public List<ReportmanageVO> reportList(ReportmanageVO reportmanageVO);

}
