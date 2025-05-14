package com.ohot.home.groupProfile.service;

import java.util.List;
import java.util.Map;

import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;

public interface GroupProfileService {

	// 아티스트 그룹 정보 가져오기
	List<ArtistVO> getArtistList(int artGroupNo);
	
	// 아티스트 (멤버) 정보 가져오기
	ArtistGroupVO getArtistGroup(int artGroupNo) throws Exception;

	// 미디어 리스트 출력 (일반영상 + 멤버십 영상)
	List<MediaPostVO> getMediaList(Map<String, Object> medialMap);

	// 라이브 리스트 출력
	List<MediaPostVO> getLiveList(Map<String, Object> livelMap);
	
	// 굿즈 리스트 출력
	List<GoodsVO> getGoodsVOList(Map<String, Object> goodsMap);

}
