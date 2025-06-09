package com.ohot.home.groupProfile.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.api.controller.SpotifyApiCreateToken;
import com.ohot.home.groupProfile.service.GroupProfileService;
import com.ohot.home.groupProfile.service.impl.SpotiryApiServiceImpl;
import com.ohot.home.media.controller.MediaController;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.service.MemberService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/oho")
@Controller
public class GroupProfileController {
	
	
	@Autowired
	GroupProfileService groupProfileService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MediaController mediaController;
	
	@Autowired
	SpotifyApiCreateToken spotifyApiCreateToken;
	
	@Autowired
	SpotiryApiServiceImpl spotiryApiServiceImpl;
	
	@GetMapping("/groupProfile")
	public String groupProfile(ArtistGroupVO artistGroupVO
								, Model model
			) throws Exception {
		
		artistGroupVO = this.groupProfileService.getArtistGroup(artistGroupVO.getArtGroupNo());
		
		String artGroupNm = artistGroupVO.getArtGroupNmKo(); // 국문명
		if(artistGroupVO.getArtGroupNo()==7) {
			artGroupNm = artistGroupVO.getArtGroupNm();
		}
		String accessToken = spotifyApiCreateToken.accesstoken(); // 영문명
		log.info("accessToken : " + accessToken);
		log.info("artGroupNm : "+ artGroupNm);
		String result = spotiryApiServiceImpl.search(accessToken, artGroupNm);
		log.info("sptify Result : " + result);
		
		String albumId = null;
	    try {
	        JSONObject json = new JSONObject(result);
	        JSONArray items = json.getJSONObject("tracks").getJSONArray("items");
	        if (items.length() > 0) {
        		albumId = items.getJSONObject(1).getJSONObject("album").getString("id");
	        }
	    } catch (Exception e) {
	        log.error("Spotify JSON 파싱 에러", e);
	    }
	    
	    log.info("albumId : " + albumId);
		model.addAttribute("albumId", albumId);
		
		return "community/groupProfile";
	}
	
	@ResponseBody
	@GetMapping("/groupProfile/{artGroupNo}")
	public ArtistGroupVO getArtistList(@PathVariable int artGroupNo) throws Exception {
		log.info("getArtistList -> artGroupNo : " + artGroupNo);
		
		// 그룹 정보 가져오기
		ArtistGroupVO artistGroupVO = this.groupProfileService.getArtistGroup(artGroupNo);
		
		// 멤버 리스트 정보 가져오기
		List<ArtistVO> artistList = this.groupProfileService.getArtistList(artGroupNo);
		
		
		Map<String, Object> goodsMap = new HashMap<>();
		goodsMap.put("artGroupNo", artGroupNo);
		goodsMap.put("start", 1);
		goodsMap.put("end", 5);
		
		Map<String, Object> medialMap = new HashMap<>();
		medialMap.put("artGroupNo", artGroupNo);
		medialMap.put("mediaDelYn", "N");
		medialMap.put("mediaMebershipYn", "N");
		medialMap.put("start", 1);
		medialMap.put("end", 4);
		
		Map<String, Object> livelMap = new HashMap<>();
		livelMap.put("artGroupNo", artGroupNo);
		livelMap.put("mediaDelYn", "N");
		livelMap.put("mediaMebershipYn", "L");
		livelMap.put("start", 1);
		livelMap.put("end", 5);

		// 굿즈 정보 가져오기
		List<GoodsVO> goodsVOList = this.memberService.getGoodsVOList(goodsMap);
		
		// 미디어 정보 가져오기
		List<MediaPostVO> mediaList = this.groupProfileService.getMediaList(medialMap);
		
		// 라아브 정보 가져오기
		List<MediaPostVO> liveList = this.groupProfileService.getLiveList(livelMap);
		
		// MediaPostVO -> thumbNailPath 값 저장
		mediaController.setThumbNailPath(mediaList);
		mediaController.setThumbNailPath(liveList);
		
		artistGroupVO.setArtistVOList(artistList);
		artistGroupVO.setGoodsVOList(goodsVOList);
		artistGroupVO.setMediaList(mediaList);
		artistGroupVO.setLiveList(liveList);
		
		return artistGroupVO;
	}

	
}
