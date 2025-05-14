package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.mapper.BannerFileMapper;
import com.ohot.service.BannerFileService;
import com.ohot.vo.BannerFileVO;

@Service
public class BannerFileServiceImpl implements BannerFileService {
	
	@Autowired
	BannerFileMapper bannerFileMapper;

	@Override
	public List<BannerFileVO> bannerFileList(String taskSeNm) {
		return bannerFileMapper.bannerFileList(taskSeNm);
	} 
	
}
