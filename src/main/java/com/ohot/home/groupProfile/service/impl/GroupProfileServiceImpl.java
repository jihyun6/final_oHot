package com.ohot.home.groupProfile.service.impl;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.home.groupProfile.mapper.GroupProfileMapper;
import com.ohot.home.groupProfile.service.GroupProfileService;
import com.ohot.home.media.mapper.MediaLiveBoardMapper;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.mapper.MemberMapper;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GroupProfileServiceImpl implements GroupProfileService{

	@Autowired
	MediaLiveBoardMapper mediaLiveBoardMapper;
	
	@Autowired
	GroupProfileMapper groupProfileMapper;
	
	@Autowired
	MemberMapper memberMapper;
	
	// 아티스트 그룹 정보 가져오기
	@Override
	public ArtistGroupVO getArtistGroup(int artGroupNo) throws Exception {
		ArtistGroupVO artistGroupVO = this.groupProfileMapper.getArtistGroup(artGroupNo);
		
		DateTimeFormatter  formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		LocalDate debutYmd = LocalDate.parse(artistGroupVO.getArtGroupDebutYmd(), formatter); // String -> Date
		log.info("포맷한 debutYmd : " + debutYmd);
		
		LocalDate today = LocalDate.now();
		log.info("오늘 날짜 : " + today);
		
		long debutDDay = ChronoUnit.DAYS.between(debutYmd, today);
		log.info("debutDDay : " + debutDDay);
		
		artistGroupVO.setDebutDDay("D+"+debutDDay);
		
		return artistGroupVO;
	}
	
	// 아티스트 (멤버) 정보 가져오기
	@Override
	public List<ArtistVO> getArtistList(int artGroupNo) {
		// TODO Auto-generated method stub
		return this.groupProfileMapper.getArtistList(artGroupNo);
	}

	// 미디어 리스트 출력 (일반영상 + 멤버십 영상)
	@Override
	public List<MediaPostVO> getMediaList(Map<String, Object> medialMap) {
		return this.mediaLiveBoardMapper.getMediaSerchList2(medialMap);
	}

	// 라이브 리스트 출력
	@Override
	public List<MediaPostVO> getLiveList(Map<String, Object> livelMap) {
		return this.mediaLiveBoardMapper.getMediaSerchList2(livelMap);
	}

	// 굿즈 리스트 출력
	@Override
	public List<GoodsVO> getGoodsVOList(Map<String, Object> goodsMap) {
		return this.memberMapper.getGoodsList(goodsMap);
	}

}
