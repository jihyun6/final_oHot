package com.ohot.home.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohot.admin.service.AdminNoticeService;
import com.ohot.home.community.service.ArtistGroupNoticeService;
import com.ohot.home.community.service.CommunityService;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.service.ArtistGroupService;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho/community")
public class ArtistGroupNoticeController {
	
	@Autowired
	ArtistGroupNoticeService artistGroupNoticeService;
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	ArtistGroupService artistGroupService;
	
	@Autowired
	AdminNoticeService adminNoticeService;
	
	@GetMapping("/notice")
	public String notice(
			int artGroupNo
			,@RequestParam(value = "currentPage", defaultValue = "1") int currentPage
			,@AuthenticationPrincipal CustomUser customUser
			,Model model
			) {
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("artGroupNo", artGroupNo);
		map.put("currentPage", currentPage);
		
		int total =this.artistGroupNoticeService.getTotal(artGroupNo);
		
		List<ArtistGroupNoticeVO> artistGroupNoticeList = this.artistGroupNoticeService.artistGroupNoticeList(map);
		ArtistGroupVO artistGroupInfo = this.artistGroupNoticeService.artGroupInfo(artGroupNo);
		
		log.info("artistGroupNoticeList:::::::::"+artistGroupNoticeList);
		log.info("artistGroupInfo:::::::::"+artistGroupInfo);
		
		
		BoardPage<ArtistGroupNoticeVO> noticeList = new BoardPage<ArtistGroupNoticeVO>(total, currentPage, 10, null, artistGroupNoticeList, null);
		
		//새로 올라온 공지사항리스트
		List<ArtistGroupNoticeVO> newNoticeList = this.artistGroupNoticeService.newNoticeList(artGroupNo);
		
		//마이 커뮤니티 리스트
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("Notice---myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);
		model.addAttribute("newNoticeList", newNoticeList);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("artistGroupInfo", artistGroupInfo);
		return "/community/artistGroupNotice";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(int bbsPostNo,Model model
			,@AuthenticationPrincipal CustomUser customUser
			) {
		
		ArtistGroupNoticeVO artistGroupNoticeVO = this.adminNoticeService.detailNotice(bbsPostNo);
		
		int artGroupNo = artistGroupNoticeVO.getArtGroupNo();
		
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);
		
		//마이 커뮤니티 리스트
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		
		model.addAttribute("noticeDetail", artistGroupNoticeVO);
		
		return "/community/noticeDetail";
	}
	
}
