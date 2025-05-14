package com.ohot.home.community.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.home.community.mapper.ArtistGroupNoticeMapper;
import com.ohot.home.community.service.ArtistGroupNoticeService;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ArtistGroupNoticeServiceImpl implements ArtistGroupNoticeService{
	@Autowired
	ArtistGroupNoticeMapper artistGroupNoticeMapper;


	@Override
	public ArtistGroupVO artGroupInfo(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.artistGroupNoticeMapper.artGroupInfo(artGroupNo);
	}

	@Override
	public List<ArtistGroupNoticeVO> artistGroupNoticeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.artistGroupNoticeMapper.artistGroupNoticeList(map);
	}

	@Override
	public int getTotal(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.artistGroupNoticeMapper.getTotal(artGroupNo);
	}

	@Override
	public List<ArtistGroupNoticeVO> newNoticeList(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.artistGroupNoticeMapper.newNoticeList(artGroupNo);
	}
}
