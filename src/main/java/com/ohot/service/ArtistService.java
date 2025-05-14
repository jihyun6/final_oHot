package com.ohot.service;

import java.util.List;
import java.util.Map;

import com.ohot.vo.ArtistVO;



public interface ArtistService {
	
	public List<ArtistVO> artistList();
	
	public ArtistVO artistDetail(ArtistVO artistVO);
	
	public int artistInsert(ArtistVO artistVO);

	public int artistUpdate(ArtistVO artistVO);
	
	public int artistDelete(ArtistVO artistVO);

	public int getTotalArtist(Map<String, Object> map);

	public List<ArtistVO> artistSearchList(Map<String, Object> map);

	public List<ArtistVO> searchArtists(String keyword);

	//public int updateArtistGroup(int artNo, int artGroupNo);

	//public int removeArtistGroup(int artNo);

	public int updateArtistGroup(ArtistVO artistVO);

	public int removeArtistGroup(ArtistVO artistVO);

}
