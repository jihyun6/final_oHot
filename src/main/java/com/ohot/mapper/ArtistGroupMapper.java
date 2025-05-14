package com.ohot.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.FileDetailVO;

@Mapper
public interface ArtistGroupMapper {

	public List<ArtistGroupVO> artistGroupList(Map<String, Object> map);
	
	// home에서 검색어 없이 아티스트 전체 검색
	public List<ArtistGroupVO> homeArtistGroupList();
	
	public ArtistGroupVO artistGroupDetail(ArtistGroupVO artistGroupVO);

	public int artistGroupInsert(ArtistGroupVO artistGroupVO);

	public int artistGroupUpdate(ArtistGroupVO artistGroupVO);
	
	public int getTotalArtistGroup(Map<String, Object> map);

	public FileDetailVO logoFilePost(long fileGroupNo);

	public List<ArtistVO> getArtistsInGroup(ArtistGroupVO artistGroupVO);

	public int artistGroupDelete(int artGroupNo);

	public int artistGroupActive(int artGroupNo);

}
