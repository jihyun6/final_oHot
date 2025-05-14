package com.ohot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.inquiry.service.InquiryPostService;
import com.ohot.service.MemberService;
import com.ohot.service.UsersService;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho/mypage")
public class MyPageController {

	@Autowired
	UsersService usersService;

	@Autowired
	MemberService memberService;
	
	@Autowired
	InquiryPostService inquiryPostService;
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("")
	public String mypage(@AuthenticationPrincipal CustomUser customUser) {

		if (customUser != null) {
			return "mypage/mypage";
		} else {
			return "redirect:login?error";
		}

	}

	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@ResponseBody
	@PutMapping("/editInfo")
	public String editInfo(@RequestBody Map<String, Object> param, @AuthenticationPrincipal CustomUser customUser) {
		if (customUser != null) {
			int memNo = (int) customUser.getUsersVO().getUserNo();
			
			Map<String, Object> map = new HashMap<>();
			map.put("memNo", memNo);

			if (param.get("type").equals("memNicknm")) {
				String memNicknm = (String) param.get("info1");
				map.put("memNicknm", memNicknm);

				int result = this.memberService.editInfo(map);
				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			}

			if (param.get("type").equals("memTelno")) {
				String memTelno = (String) param.get("info1");
				map.put("memTelno", memTelno);
				int result = this.memberService.editInfo(map);
				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			}

			if (param.get("type").equals("memPswd")) {
				String memPswd = (String) param.get("info1");
				map.put("memPswd", memPswd);
				int result = this.memberService.editInfo(map);
				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			}

			if (param.get("type").equals("name")) {
				String memLastName = (String) param.get("info1");
				String memFirstName = (String) param.get("info2");
				map.put("memLastName", memLastName);
				map.put("memFirstName", memFirstName);

				int result = this.memberService.editInfo(map);
				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			}
		} 
		return "unMember";
	}
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@ResponseBody
	@GetMapping("/getMyInquiryPost")
	public Map<String, Object> getMyInquiryPost( @RequestParam Map<String, Object> params
											, @AuthenticationPrincipal CustomUser customUser
					) {
		int currentPage = 1;
		try {
		    currentPage = Integer.parseInt(String.valueOf(params.get("page")));
		} catch (Exception e) {
		    log.error("페이지 파싱 실패, 기본값 1 사용");
		}
		
		// 게스트이거나 회원일 경우
		params.put("isAdmin", false);
		params.put("memNo", customUser.getUsersVO().getUserNo());
		List<BoardPostVO> inquiryPostList = this.inquiryPostService.getInquiryPostList(params);
		
		int size = 5;
		int total = this.inquiryPostService.getTotalCnt(params);
		
		int totalPages = (int) Math.ceil((double) total / size);
	    int startPage = Math.max(1, currentPage - 10);
	    int endPage = Math.min(totalPages, currentPage + 9);
		
	    Map<String, Object> result = new HashMap<>();
	    result.put("content", inquiryPostList);
	    result.put("currentPage", currentPage);
	    result.put("totalPages", totalPages);
	    result.put("startPage", startPage);
	    result.put("endPage", endPage);
	    result.put("total", total);
	    
		return result;
	}
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@ResponseBody
	@GetMapping("/getMyInfo")
	public MemberVO getMyInfo(@AuthenticationPrincipal CustomUser customUser) {
		MemberVO memberVO = customUser.getUsersVO().getMemberVO();
		
		return memberVO;
	}

}
