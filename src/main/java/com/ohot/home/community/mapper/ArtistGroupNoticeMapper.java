package com.ohot.home.community.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;

@Mapper
public interface ArtistGroupNoticeMapper {


	public ArtistGroupVO artGroupInfo(int artGroupNo);

	public List<ArtistGroupNoticeVO> artistGroupNoticeList(Map<String, Object> map);

	public int getTotal(int artGroupNo);

	public List<ArtistGroupNoticeVO> newNoticeList(int artGroupNo);

}
