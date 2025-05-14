package com.ohot.admin.service;

import java.util.List;
import java.util.Map;

import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.vo.ArtistGroupVO;

public interface AdminNoticeService {

	public List<ArtistGroupNoticeVO> artGroupNoticeList(Map<String, Object> data);

	public int getTotal(Map<String, Object> data);

	public List<ArtistGroupVO> artGroupList();

	public String getArtNm(int artGroupNo);

	public ArtistGroupNoticeVO detailNotice(int bbsPostNo);

	public int editNotice(ArtistGroupNoticeVO aritistGroupNoticeVO);

	public void deleteNotice(int bbsPostNo);

	public void unDeleteNotice(int bbsPostNo);

	public int addNotice(ArtistGroupNoticeVO artistGroupNoticeVO);

}
