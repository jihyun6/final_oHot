package com.ohot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.BannerFileVO;

@Mapper
public interface BannerFileMapper {

	public List<BannerFileVO> bannerFileList(String taskSeNm);
	
}
