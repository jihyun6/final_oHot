package com.ohot.home.media.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.ohot.home.media.mapper.MediaLiveBoardMapper;
import com.ohot.home.media.service.MediaLiveBoardService;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.util.Pazing;
import com.ohot.vo.ArtistGroupVO;

@Service
public class MediaLiveBoardServiceImpl implements MediaLiveBoardService{

	@Autowired
	MediaLiveBoardMapper mediaLiveBoardMapper; 
	
	@Override
	public List<MediaPostVO> getMediaList() {
		
		return mediaLiveBoardMapper.getMediaList();
	}

	@Override
	public List<MediaPostVO> getMediaSerchList(Map<String, Object> params) {
		
		return mediaLiveBoardMapper.getMediaSerchList(params);
	}

	@Override
	public MediaPostVO getMediaDetail(Map<String, Object> parmas) {
		
		return mediaLiveBoardMapper.getMediaDetail(parmas);
	}

	@Override
	public int createPost(MediaPostVO mediaPostVO) {
		return mediaLiveBoardMapper.createPost(mediaPostVO);
	}

	@Override
	public int deleteMediaPost(Integer mediaPostNo) {
		
		return mediaLiveBoardMapper.deleteMediaPost(mediaPostNo);
	}

	@Override
	public int updateMediaPost(MediaPostVO mediaPostVO) {
		
		return mediaLiveBoardMapper.updateMediaPost(mediaPostVO);
	}

	@Override
	public List<ArtistGroupVO> getArtistGroupList() {
		
		return mediaLiveBoardMapper.getArtistGroupList();
	}

	@Override
	public Map<String, Object> getMediaListWithPaging(Map<String, Object> params) {
		// 총 데이터 개수 조회
        int total = mediaLiveBoardMapper.getMediaListCount(params);
        
        // 현재 페이지와 사이즈 가져오기
        int currentPage = Integer.parseInt(params.get("currentPage").toString());
        int size = Integer.parseInt(params.get("size").toString());
        
        // 데이터 조회
        List<MediaPostVO> content = mediaLiveBoardMapper.getMediaSerchList2(params);

        String keyword = params.get("mediaPostTitle") != null ? params.get("mediaPostTitle").toString() : "";
        Pazing<MediaPostVO> pazing = new Pazing<>(total, currentPage, size, content, keyword);

        pazing.setUrl("");
        
        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("content", pazing.getContent());
        result.put("pagingArea", pazing.getPagingArea());
        result.put("total", pazing.getTotal());
        result.put("currentPage", pazing.getCurrentPage());
        result.put("totalPages", pazing.getTotalPages());
        result.put("startPage", pazing.getStartPage());
        result.put("endPage", pazing.getEndPage());
        
        return result;
	}
	
	

}
