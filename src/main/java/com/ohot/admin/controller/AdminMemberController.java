package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.service.ArtistService;
import com.ohot.service.MemberService;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller("adminMemberController")
@RequestMapping("/admin/member")
public class AdminMemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	ArtistService artistService;
	
	@GetMapping("/memberList")
	public String memberList(
			Model model,
			@RequestParam(value="memberType", defaultValue = "", required = false) String memberType,
			@RequestParam(value="currentPage", defaultValue = "1", required = false) int currentPage,
			@RequestParam(value="mode", defaultValue = "", required = false) String mode,
			@RequestParam(value="keyword", defaultValue = "", required = false) String keyword) {
		
		
		int size = 10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberType", memberType);
		map.put("currentPage", currentPage);
		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("size", size);
		
		int total = this.memberService.getTotalMember(map);
		
		List<MemberVO> memberVOList = this.memberService.memberSearchList(map);
	
		BoardPage<MemberVO> boardPage = new BoardPage<>(total, currentPage, size, keyword, memberVOList, mode);
		model.addAttribute("boardPage", boardPage);
		
		return "admin/member/memberList";
	}
	
	@ResponseBody
	@GetMapping("/memberEdit")
	public MemberVO edit(MemberVO memberVO){
		
		log.info("edit->memberVO : " + memberVO);
		
		MemberVO memberVODetail = this.memberService.modalDetailInfo(memberVO);
		//MemberVO memberVODetail = this.memberService.memberDetail(memberVO);
		/*1. 일반회원
		 edit->memberVODetail : MemberVO(rnum=0, memNo=13, memLastName=김, memFirstName=영신, memNicknm=김영신, memEmail=dudtls3467@naver.com
		 , memTelno=01022223333, memBirth=1997-01-13, memPswd=null, joinYmd=2025-04-03, secsnYmd=null, memAccessToken=null, enabled=0
		 , memStatSecCodeNo=001, memSecCodeNo=M01, memDelYn=N, authNm=null, authVOList=[AuthVO(memNo=13, authNm=null)]
			 , artistVO=ArtistVO(rnum=0, artNo=0, artGroupNo=0, artActNm=null, artExpln=null, artRegYmd=null, fileGroupNo=0, memNo=13, artDelYn=null, fileGroupVO=null
			 , uploadFile=null)
		 )
		 */
		/*2. 아티스트 회원
		 MemberVO(rnum=0, memNo=2, memLastName=김, memFirstName=민정, memNicknm=null, memEmail=aespawinter@naver.com, memTelno=01011112222, memBirth=2000-01-01
		 , memPswd=null, joinYmd=2025-03-20, secsnYmd=null, memAccessToken=null, enabled=0, memStatSecCodeNo=001, memSecCodeNo=M02, memDelYn=N, authNm=null
		 		, authVOList=[AuthVO(memNo=2, authNm=null)], 
				 artistVO=ArtistVO(rnum=0, artNo=2, artGroupNo=1, artActNm=Winter, artExpln=윈터, artRegYmd=2025-03-25, fileGroupNo=0, memNo=2
				 , artDelYn=N, fileGroupVO=null, uploadFile=null)
		 )
		 */
		log.info("edit->memberVODetail : " + memberVODetail);
		
		return memberVODetail;
	}
	
	@ResponseBody
	@PostMapping("/memberEditPost")
	public MemberVO editPost(MemberVO memberVO) {
		/*
		MemberVO(rnum=0, memNo=13, memLastName=김, memFirstName=영신, memNicknm=null, memEmail=dudtls3467@naver.com, memTelno=010-1234-5678, memBirth=1997-01-18
		, memPswd=null, joinYmd=2025-04-03, secsnYmd=, memAccessToken=null, enabled=0, memStatSecCodeNo=001, memSecCodeNo=M02, memDelYn=null, authNm=null
		, authVOList=null, 
			artistVO=ArtistVO(rnum=0, artNo=0, artGroupNo=0, artActNm=영신, artExpln=테스트입니다, artRegYmd=null, fileGroupNo=0, memNo=0, artDelYn=null, memVO=null, 
			fileGroupVO=null, uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@64bd922a])
		)
		 */
		log.info("memberEditPost->memberVO : " + memberVO);
		
		MemberVO memberVODetail = this.memberService.memberUpdate(memberVO);
		
		log.info("memberEditPost->memberVODetail" + memberVODetail);
		
		return memberVODetail;
	}
	
	@ResponseBody
	@PostMapping("/memberDelete")
	public String memberDelete(@RequestParam(value="memNo") int memNo) {
		
		int cnt = this.memberService.memberDelete(memNo);
		
		String result = "";
		if(cnt == 1) {
			result = "success";
		}else result = "fail";
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/memberListAjax")
	public Map<String, Object> memberListAjax(@RequestBody Map<String, Object> param){
		
		int currentPage = 1;
		int rowSize=10;
	    int blockSize=10;
	    
		try {
		    currentPage = Integer.parseInt(String.valueOf(param.get("page")));
		    rowSize = Integer.parseInt(String.valueOf(param.get("rowSize")));
		    blockSize = Integer.parseInt(String.valueOf(param.get("blockSize")));
		} catch (Exception e) {
		    log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
	    int size = 10;
	    
	    
	    List<MemberVO> memberVOList = this.memberService.memberSearchList(param);
	    int total = this.memberService.getTotalMember(param);
		
	    int totalPages = (int) Math.ceil((double) total / rowSize); 
		int startPage = ((currentPage - 1) / blockSize) * blockSize + 1;
	    int endPage = Math.min(startPage + blockSize - 1, totalPages);
	
	    Map<String, Object> result = new HashMap<>();
	    result.put("content", memberVOList);
	    result.put("currentPage", currentPage);
	    result.put("totalPages", totalPages);
	    result.put("startPage", startPage);
	    result.put("endPage", endPage);
	    result.put("total", total);
		
		return result; 
	}
	
}
