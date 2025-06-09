package com.ohot.home.dm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.dm.service.DmService;
import com.ohot.home.dm.vo.DmMsgVO;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.service.ArtistGroupService;
import com.ohot.service.ArtistService;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho/dm")
public class DmController {

	@Autowired
	DmService dmService;
	
	@Autowired
	ArtistService artistService;
	
	@Autowired
	ArtistGroupService artistGroupService;

	
	@ResponseBody
	@PostMapping("/updateReadY")
	public int updateReadY (@RequestParam long dmSubNo) {
		log.info("updateReadY 실행: "+dmSubNo);
		int result = this.dmService.updateReadY(dmSubNo);
		
		return result;
	}

	//아티스트 그룹 검색 필터
	@ResponseBody
	@PostMapping("/dmsearchFilter")
	public List<ArtistGroupVO> dmsearchFilter(@RequestParam int artGroupNo , @RequestParam String dmSrhKeyword){
		log.debug("dmsearchFilter 실행");
		List<ArtistGroupVO> artistGroupVOList= this.dmService.dmsearchFilter(artGroupNo,dmSrhKeyword);
		log.info("dmsearchFilter->artistVOList : " + artistGroupVOList);
		
		return artistGroupVOList;
	}
	
	//구매이력확인 및 채팅방
	@PostMapping("/checkPurchaseDm")
	@ResponseBody
	public List<DmSubVO> checkPurchaseDm(@RequestParam int memNo, @RequestParam int artNo){
		log.debug("memNo: "+memNo+" artNo: "+artNo);
		DmSubVO dmSubVO= new DmSubVO();
		dmSubVO.setMemNo(memNo);
		dmSubVO.setArtNo(artNo);

		
		//dm 구독권있으면 채팅방+읽지 않은 메세지 갯수 불러오기
		if(artNo != 0) {
			List<DmSubVO> dmSubVOList  = this.dmService.checkPurchaseDm(dmSubVO);
			
			if(dmSubVOList.isEmpty()) { //구매이력없음 혹은 만료됨
				return null;
				
			}else { //구매이력 있음 사용가능
				
				log.info("checkPurchaseDm->구매한 dm 정보: "+dmSubVOList);
				return dmSubVOList;
			}

		//채팅방리스트
		}else {	
			List<DmSubVO> dmSubVOList  = this.dmService.checkPurchaseDm(dmSubVO);	
			log.info("checkPurchaseDm->dmSubVOList: "+dmSubVOList);
			
			return dmSubVOList;
		}
	}
	
	@PostMapping("/chatRoom")
	public List<DmMsgVO> chatRoom(@RequestParam int dmSubNo , @RequestParam int memNo){
		
		
		
		return null;
	}
	
	//커뮤니티 가입한 곳이 있을때
	@ResponseBody
	@PostMapping("/myArtist")
	public List<ArtistGroupVO> myArtist(@AuthenticationPrincipal CustomUser customUser) {
		
		if(customUser==null) {
			
			return null;
		}else {
		
			UsersVO usersVO =  customUser.getUsersVO();
			log.info("usersVO : " + usersVO);
			int memNo = (int) usersVO.getUserNo();
			
			List<ArtistGroupVO> myartistGroupVOList  = this.dmService.myArtistList(memNo);	
			log.info("myArtist->myartistGroupVOList: "+myartistGroupVOList);
			
			return myartistGroupVOList;
		}
	}
	
	//비회원 및 커뮤니티 가입한 곳이 없을때
	@ResponseBody
	@PostMapping("/artistList")
	public List<ArtistGroupVO>  artistList(@AuthenticationPrincipal CustomUser customUser) {
		int memNo=0;
		if(customUser!=null) {
			UsersVO usersVO =  customUser.getUsersVO();
			log.info("usersVO : " + usersVO);
			memNo = (int) usersVO.getUserNo();
		}			
			
		
		List<ArtistGroupVO> artistGroupVOList= this.dmService.artGroupList(memNo);
		log.info("myArtistList->artistVOList : " + artistGroupVOList);
		
		return artistGroupVOList;
	}
	
}
