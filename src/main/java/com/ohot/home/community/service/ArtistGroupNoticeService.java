package com.ohot.home.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;


public interface ArtistGroupNoticeService {

	public ArtistGroupVO artGroupInfo(int artGroupNo);

	public List<ArtistGroupNoticeVO> artistGroupNoticeList(Map<String, Object> map);

	public int getTotal(int artGroupNo);

	public List<ArtistGroupNoticeVO> newNoticeList(int artGroupNo);

}
