package com.ohot.home.media.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.vo.ArtistGroupVO;

@Mapper
public interface MediaLiveBoardMapper {
	// 미디어 전체
	public List<MediaPostVO> getMediaList();
	
	// 검색 옵션 적용 리스트, 커뮤니티 별 미디어 리스트
	public List<MediaPostVO> getMediaSerchList(Map<String, Object> params);
	// 페이징 추가
	public List<MediaPostVO> getMediaSerchList2(Map<String, Object> params);
	
	// 미디어Post 상세
	public MediaPostVO getMediaDetail(Map<String, Object> parmas);

	// 미디어post 등록
	public int createPost(MediaPostVO mediaPostVO);
	
	// 미디어 post 수정
	public int updateMediaPost(MediaPostVO mediaPostVO);

	// 미디어 Post 삭제
	public int deleteMediaPost(Integer mediaPostNo);

	// 단순 아티스트그룹 번호, 이름 조회
	public List<ArtistGroupVO> getArtistGroupList();

	public int getMediaListCount(Map<String, Object> params);
}
