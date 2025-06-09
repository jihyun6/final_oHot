package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import com.ohot.home.inquiry.service.InquiryPostService;
import com.ohot.home.inquiry.vo.InquiryTypeVO;
import com.ohot.util.UploadController;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/admin/inquiryPost")
@Controller
public class AdminInquiryPostController {

	@Autowired
	InquiryPostService inquiryPostService;
	
	@Autowired
	UploadController uploadController;
	
	@GetMapping("")
	public String getMethodName(Model model) {
		List<InquiryTypeVO> inqTypeVOList = this.inquiryPostService.getInqTypeVO();
		log.info("inqTypeVOList : " + inqTypeVOList);
		model.addAttribute("inqTypeVOList", inqTypeVOList);
		
		return "admin/inquiryPost/adInquiryPost";
	}
	
	@ResponseBody
	@GetMapping("/getListAjax")
	public Map<String,Object> getListAjax(@RequestParam Map<String, Object> params
							, @AuthenticationPrincipal CustomUser customUser
			) {
		log.info("getListAjax -> params : " + params);
		//{inqType=1, inqWriter=, startDate=, endDate=, mode=, keyword=, page=1, blockSize=10, start=1, end=10}
		
		int currentPage = 1;
		try {
		    currentPage = Integer.parseInt(String.valueOf(params.get("page")));
		} catch (Exception e) {
		    log.info("페이지 파싱 실패, 기본값 1 사용");
		}
		
		params.put("isAdmin", true);
		List<BoardPostVO> InquiryPostList = this.inquiryPostService.getInquiryPostList(params);
		
		int size = 10;
		int total = this.inquiryPostService.getTotalCnt(params);
		log.info("getListAjax -> total : " + total);
		
		int totalPages = (int) Math.ceil((double) total / size);
	    int startPage = Math.max(1, currentPage - 10);
	    int endPage = Math.min(totalPages, currentPage + 9);
		
	    Map<String, Object> result = new HashMap<>();
	    result.put("content", InquiryPostList);
	    result.put("currentPage", currentPage);
	    result.put("totalPages", totalPages);
	    result.put("startPage", startPage);
	    result.put("endPage", endPage);
	    result.put("total", total);
	    
	    log.info("result : " + result);
		
		return result;
	}
	
	@GetMapping("/detail")
	public String getInquiryDetail(	@RequestParam int boardNo
									, @AuthenticationPrincipal CustomUser customUser
									, Model model
			) {
		log.info("getInquiryDetail -> boardNo : " + boardNo);
		
		BoardPostVO boardPostVO = this.inquiryPostService.getInquiryDetail(boardNo);
		model.addAttribute("boardPostVO", boardPostVO);
		return "admin/inquiryPost/adInquiryDetail";
	}
	
	@PostMapping("/createReplyPost")
	public String createReplyPost(BoardPostVO boardPostVO
							, String inqPswd
							,  MultipartFile[] uploadFile
			) {
		int parentNo = boardPostVO.getBbsPostNo();
		log.info("createReplyPost -> boardPostVO : " + boardPostVO);
		log.info("createReplyPost -> inqPswd : " + inqPswd);
		log.info("createReplyPost -> uploadFile : " + uploadFile);
		
		Map<String, Object> map = new HashMap<>();
		
		if(!uploadFile[0].isEmpty()) {
			long fileGroupNo = uploadController.multiImageUpload(uploadFile);
			map.put("fileGroupNo", fileGroupNo);
		}
		
		String bbsTitle = HtmlUtils.htmlEscape(boardPostVO.getBbsTitle());
		String bbsCn = HtmlUtils.htmlEscape(boardPostVO.getBbsCn());
		boardPostVO.setBbsTitle(bbsTitle);
		boardPostVO.setBbsCn(bbsCn);
		
		String bbsHtmlCn = "<pre>" + boardPostVO.getBbsCn() +"</pre>";
		int bbsPostNo = this.inquiryPostService.getMaxNo();
		
		map.put("bbsPostNo", bbsPostNo);
		map.put("parentPostNo", parentNo);
		map.put("bbsTypeCdNo", 4);
		map.put("bbsTitle", boardPostVO.getBbsTitle());
		map.put("bbsCn", boardPostVO.getBbsCn());
		map.put("bbsHtmlCn", bbsHtmlCn);
		map.put("artGroupNo", 0);
		map.put("inqPswd", inqPswd);
		
		this.inquiryPostService.createReplyPost(map);
		
		return "redirect:/admin/inquiryPost/detail?boardNo="+parentNo;
	}
	
	@PostMapping("/edit")
	public String edit(BoardPostVO boardPostVO
						, MultipartFile[] newUploadFile
			) {
		log.info("edit -> newUploadFile : " + newUploadFile);
		
		if(!newUploadFile[0].isEmpty()) { // 파일이 있을 경우에만 실행
			long fileGroupNo = uploadController.multiImageUpload(newUploadFile);
			boardPostVO.setFileGroupNo(fileGroupNo);
		}
		log.info("edit - > boardPostVO : " + boardPostVO);
		
		// HtmlUtils -> spring에서 기본으로 제공하는 메소드
		String bbsTitle = HtmlUtils.htmlEscape(boardPostVO.getBbsTitle());
		String bbsCn = HtmlUtils.htmlEscape(boardPostVO.getBbsCn());
		boardPostVO.setBbsTitle(bbsTitle);
		boardPostVO.setBbsCn(bbsCn);
		
		boardPostVO.setBbsHtmlCn("<pre>"+boardPostVO.getBbsCn()+"</pre>");
		
		this.inquiryPostService.editReply(boardPostVO);
		
		return "redirect:/admin/inquiryPost/detail?boardNo="+boardPostVO.getParentPostNo();
	}
	
	@GetMapping("/delete")
	public String delete(int parentPostNo, int bbsPostNo) {
		log.info("delete -> parentPostNo : " + parentPostNo);
		log.info("delete -> bbsPostNo : " + bbsPostNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentPostNo", parentPostNo);
		map.put("bbsPostNo", bbsPostNo);
		
		this.inquiryPostService.deleteReplyPost(map);
		
		return "redirect:/admin/inquiryPost/detail?boardNo="+parentPostNo;
	}
	
	@GetMapping("/pswdReset")
	public String pswdReset(@RequestParam Map<String, Object> params) {
		log.debug("pswdReset -> params : " + params);
		this.inquiryPostService.inqPswdReset(params);
		return "success";
	}
	
}
