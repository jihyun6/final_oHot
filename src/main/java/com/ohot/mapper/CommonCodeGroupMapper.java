package com.ohot.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.CommonCodeGroupVO;

/*
 공통코드그룹 : 공통상세코드 = 1 : N
 쿼리 실행 전용 매퍼인터페이스
 */
@Mapper
public interface CommonCodeGroupMapper {
	
	//1) 굿즈의 크기 정보를 select
	public CommonCodeGroupVO commonCodeGroupList(CommonCodeGroupVO commonCodeGroupVO);
	
}
