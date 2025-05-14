package com.ohot.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.vo.ArtistGroupVO;

@Mapper
public interface AdminNoticeMapper {


	public List<ArtistGroupNoticeVO> artGroupNoticeList(Map<String, Object> data);

	public int getTotal(Map<String, Object> data);

	public List<ArtistGroupVO> artGroupList();

	public String getArtNm(int artGroupNo);

	public ArtistGroupNoticeVO detailNotice(int bbsPostNo);

	public int editNotice(ArtistGroupNoticeVO aritistGroupNoticeVO);

	public void deleteNotice(int bbsPostNo);

	public void unDeleteNotice(int bbsPostNo);

	public int addNotice(ArtistGroupNoticeVO artistGroupNoticeVO);

	public int getNo();

}
