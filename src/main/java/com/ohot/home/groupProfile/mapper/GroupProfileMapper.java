package com.ohot.home.groupProfile.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;

@Mapper
public interface GroupProfileMapper {
	
	// 아티스트 그룹 정보 가져오기
	ArtistGroupVO getArtistGroup(int artGroupNo);

	// 아티스트 (멤버) 정보 가져오기
	List<ArtistVO> getArtistList(int artGroupNo);

	// 굿즈 리스트 출력
	List<GoodsVO> getGoodsList(int artGroupNo);

}
