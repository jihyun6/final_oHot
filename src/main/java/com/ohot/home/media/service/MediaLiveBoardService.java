package com.ohot.home.media.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.vo.ArtistGroupVO;

public interface MediaLiveBoardService {

	public List<MediaPostVO> getMediaList();
	
	public List<MediaPostVO> getMediaSerchList(Map<String, Object> params);
	
	// 미디어Post 상세
	public MediaPostVO getMediaDetail(Map<String, Object> parmas);

	// 미디어 Post 등록
	public int createPost(MediaPostVO mediaPostVO);

	// 삭제
	public int deleteMediaPost(Integer mediaPostNo);

	public int updateMediaPost(MediaPostVO mediaPostVO);

	public List<ArtistGroupVO> getArtistGroupList();

	public Map<String, Object> getMediaListWithPaging(Map<String, Object> params);
}
