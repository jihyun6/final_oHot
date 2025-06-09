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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.admin.service.AdminCommunityService;
import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.AdminCommunityReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/community")
public class AdminCommunityController {
	
	@Autowired
	AdminCommunityService adminCommunityService;
	
	@GetMapping("/postList")
	public String postList(
			) {
		
		return "/admin/community/postList";
	}
	
	@ResponseBody
	@PostMapping("/postListAjax")
	public Map<String, Object> postListAjax(
			@RequestBody Map<String,Object> data
			){
		
		String boardCreateDate =  (String)data.get("boardCreateDate");
		log.info("boardCreateDate ===="+boardCreateDate);
		log.info("boardCreateDate ===="+data);
		
		boardCreateDate = boardCreateDate.replaceAll("-", "/");
		data.put("boardCreateDate", boardCreateDate);
		
		log.info("boardCreateDate ===="+boardCreateDate);
		log.info("boardCreateDate ===="+data);
		int currentPage =1;
		int size = 10;
		
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
			
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
		
		List<AdminCommunityPostVO> adminCommunityPostVOList = this.adminCommunityService.adminPostList(data);
		
		for (AdminCommunityPostVO adminCommunityPostVO : adminCommunityPostVOList) {
			if(adminCommunityPostVO.getBoardContent().contains("script")) {
				adminCommunityPostVO.setBoardContent("보안에 위배되는 문구입니다");
			}else if(adminCommunityPostVO.getBoardTitle().contains("script")) {
				adminCommunityPostVO.setBoardTitle("보안에 위배되는 문구입니다");
			}
			if(adminCommunityPostVO.getUrlCategory()!=null && adminCommunityPostVO.getUrlCategory() != "") {
				if(adminCommunityPostVO.getUrlCategory().equals("ROLE_MEM")) {
					adminCommunityPostVO.setUrlCategory("멤버");
				}else {
					adminCommunityPostVO.setUrlCategory("아티스트");
				}
			}
			adminCommunityPostVO.getBoardContent().replaceAll(">","&gt");
			adminCommunityPostVO.getBoardContent().replaceAll("<", "&lt");
			adminCommunityPostVO.getBoardTitle().replaceAll(">","&gt");
			adminCommunityPostVO.getBoardTitle().replaceAll("<", "&lt");
		}
		
		log.info("postListAjax-> data"+data);
		
		int total = this.adminCommunityService.getTotalPost(data);
		
		int totalPages = (int) Math.ceil((double) total/size);		
		int startPage = Math.max(1, currentPage-10);
		int endPage = Math.min(totalPages, currentPage+9);
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("content", adminCommunityPostVOList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("total", total);
		
		return result;
	}
	
	
	@GetMapping("/replyList")
	public String getReplyList(
			) {
		
		return "/admin/community/replyList";
	}

	
	
	@ResponseBody
	@PostMapping("/replyListAjax")
	public Map<String, Object> replyListAjax(
			@RequestBody Map<String,Object> data
			){
		
		String replyCreateDate =  (String)data.get("replyCreateDate");
		log.info("replyCreateDate ===="+replyCreateDate);
		log.info("replyCreateDate ===="+data);
		
		replyCreateDate = replyCreateDate.replaceAll("-", "/");
		data.put("replyCreateDate", replyCreateDate);
		
		log.info("replyCreateDate ===="+replyCreateDate);
		log.info("replyCreateDate ===="+data);
		int currentPage =1;
		int size = 10;
		
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
			
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
		
		List<AdminCommunityReplyVO> adminCommunityReplyVOList = this.adminCommunityService.adminReplyList(data);
		
		for (AdminCommunityReplyVO adminCommunityReplyVO : adminCommunityReplyVOList) {
			if(adminCommunityReplyVO.getReplyContent().contains("script")) {
				adminCommunityReplyVO.setReplyContent("보안에 위배되는 문구입니다");
			}
			if(adminCommunityReplyVO.getUrlCategory()!=null && adminCommunityReplyVO.getUrlCategory() != "") {
				if(adminCommunityReplyVO.getUrlCategory().equals("ROLE_MEM")) {
					adminCommunityReplyVO.setUrlCategory("멤버");
				}else {
					adminCommunityReplyVO.setUrlCategory("아티스트");
				}
			}
			adminCommunityReplyVO.getReplyContent().replaceAll(">","&gt");
			adminCommunityReplyVO.getReplyContent().replaceAll("<", "&lt");
		}
		
		log.info("replyListAjax-> data"+data);
		
		int total = this.adminCommunityService.getTotalReply(data);
		
		int totalPages = (int) Math.ceil((double) total/size);		
		int startPage = Math.max(1, currentPage-10);
		int endPage = Math.min(totalPages, currentPage+9);
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("content", adminCommunityReplyVOList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("total", total);
		
		return result;
	}
	
	@GetMapping("/postDetail")
	public String postDetail(
			int boardNo,
			Model model
			) {
		
		AdminCommunityPostVO adminCommunityPostVO = this.adminCommunityService.postDetail(boardNo);
		
		log.info("postDetail -> fileGroupNo :::: "+adminCommunityPostVO.getFileGroupNo());
		
		model.addAttribute("postDetail", adminCommunityPostVO);
		
		return "/admin/community/postDetail";
	}
	@GetMapping("/postDelete")
	public String postDelete(
			int boardNo
			) {
	
		this.adminCommunityService.postDelete(boardNo);
		
		return "redirect:/admin/community/postList";
	}
	@GetMapping("/postUnDelete")
	public String postUnDelete(
			int boardNo
			) {
		
		this.adminCommunityService.postUnDelete(boardNo);
		
		return "redirect:/admin/community/postList";
	}
	@GetMapping("/replyDelete")
	public String replyDelete(
			int replyNo
			) {
		
		this.adminCommunityService.replyDelete(replyNo);
		
		return "redirect:/admin/community/replyList";
	}
	@GetMapping("/replyUnDelete")
	public String replyUnDelete(
			int replyNo
			) {
		
		this.adminCommunityService.replyUnDelete(replyNo);
		
		return "redirect:/admin/community/replyList";
	}
}
