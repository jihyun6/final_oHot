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

import com.ohot.admin.service.AdminNoticeService;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.vo.AdminCommunityPostVO;
import com.ohot.vo.ArtistGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	
	@Autowired
	AdminNoticeService adminNoticeService;
	
	@GetMapping("/noticeList")
	public String noticeList(Model model) {
		
		//아티스트 그룹명 받아오기
		List<ArtistGroupVO> artGroupList = this.adminNoticeService.artGroupList();
		model.addAttribute("artGroupList", artGroupList);
		
		return "/admin/notice/noticeList";
	}
	
	@ResponseBody
	@PostMapping("/noticeListAjax")
	public Map<String, Object> noticeListAjax(
			@RequestBody Map<String,Object> data
			){
		String bbsRegDate =  (String)data.get("bbsRegDt");
	
		bbsRegDate = bbsRegDate.replaceAll("-", "/");
		data.put("bbsRegDate", bbsRegDate);

		log.info("bbsRegDate ===="+data);
		
		int currentPage =1;
		int size = 10;
		
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
			
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
		List<ArtistGroupNoticeVO> artGroupNoticeList = this.adminNoticeService.artGroupNoticeList(data);
		
		for (ArtistGroupNoticeVO artistGroupNoticeVO : artGroupNoticeList) {
			int artGroupNo =  artistGroupNoticeVO.getArtGroupNo();
			String artGroupNm = this.adminNoticeService.getArtNm(artGroupNo);
			artistGroupNoticeVO.setArtGroupNm(artGroupNm);
		}
		
		int total = this.adminNoticeService.getTotal(data);
		
		int totalPages = (int) Math.ceil((double) total/size);		
		int startPage = Math.max(1, currentPage-10);
		int endPage = Math.min(totalPages, currentPage+9);
		
		Map<String, Object> result = new HashMap<String,Object>();
		
		result.put("content", artGroupNoticeList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("total", total);
		
		return result;
	}
	
	@GetMapping("/detailNotice")
	public String detailNotice(int bbsPostNo,Model model) {
		
		ArtistGroupNoticeVO artGroupNotice = this.adminNoticeService.detailNotice(bbsPostNo);
		
		model.addAttribute("artGroupNotice", artGroupNotice);
		
		return "/admin/notice/detailNotice";
	}
	
	@GetMapping("/editNotice")
	public String editNotice(
			int bbsPostNo,Model model
			) {
		ArtistGroupNoticeVO artistGroupNotice = this.adminNoticeService.detailNotice(bbsPostNo);
		
		model.addAttribute("artGroupNotice", artistGroupNotice);
		
		return "/admin/notice/editNotice";
	}
	
	@PostMapping("/editNoticePost")
	public String editNoticePost(
			ArtistGroupNoticeVO aritistGroupNoticeVO
			) {
		int bbsPostNo = aritistGroupNoticeVO.getBbsPostNo();
		
		int result = this.adminNoticeService.editNotice(aritistGroupNoticeVO);
		
		log.info("editNoticePost::::::"+result);
		
		return "redirect:/admin/notice/detailNotice?bbsPostNo="+bbsPostNo;
	}
	
	@GetMapping("/deleteNotice")
	public String deleteNotice(int bbsPostNo) {
		
		this.adminNoticeService.deleteNotice(bbsPostNo);
		
		return "redirect:/admin/notice/noticeList";
	}
	@GetMapping("/unDeleteNotice")
	public String unDeleteNotice(int bbsPostNo) {
		
		this.adminNoticeService.unDeleteNotice(bbsPostNo);
		
		return "redirect:/admin/notice/noticeList";
	}
	@GetMapping("/addNotice")
	public String addNotice(Model model) {
		
		List<ArtistGroupVO> artGroupList = this.adminNoticeService.artGroupList();
		model.addAttribute("artGroupList", artGroupList);
		
		return "/admin/notice/addNotice";
	}
	@PostMapping("/addNoticePost")
	public String addNoticePost(ArtistGroupNoticeVO artistGroupNoticeVO) {
		
		int bbsPostNo = this.adminNoticeService.addNotice(artistGroupNoticeVO);
		
		
		return "redirect:/admin/notice/detailNotice?bbsPostNo="+bbsPostNo;
	}
}
