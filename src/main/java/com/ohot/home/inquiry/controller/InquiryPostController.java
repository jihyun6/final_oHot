package com.ohot.home.inquiry.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.config.BeanController;
import com.ohot.home.inquiry.service.InquiryPostService;
import com.ohot.home.inquiry.vo.InquiryTypeVO;
import com.ohot.util.UploadController;
import com.ohot.vo.BoardPostVO;
import com.ohot.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/oho/inquiryPost")
@Controller
public class InquiryPostController {
	
	@Autowired
	InquiryPostService inquiryPostService;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	BeanController beanController;
	
	@GetMapping("")
	public String getInquiryPostList(Model model) {
		List<InquiryTypeVO> inqTypeVOList = this.inquiryPostService.getInqTypeVO();
		model.addAttribute("inqTypeVOList", inqTypeVOList);
		return "inquiryPost/inquiryPost";
	}
	
	@ResponseBody
	@GetMapping("/getListAjax")
	public Map<String,Object> getListAjax(@RequestParam Map<String, Object> params
							, @AuthenticationPrincipal CustomUser customUser
			) {
		int currentPage = 1;
		try {
		    currentPage = Integer.parseInt(String.valueOf(params.get("page")));
		} catch (Exception e) {
		    log.error("페이지 파싱 실패, 기본값 1 사용");
		}
		
		params.put("isAdmin", false);
		List<BoardPostVO> inquiryPostList = this.inquiryPostService.getInquiryPostList(params);
		
		int size = 10;
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
	
	@GetMapping("/detail")
	public String getInquiryDetail(int boardNo
								   , Model model
				) {
		BoardPostVO boardPostVO = this.inquiryPostService.getInquiryDetail(boardNo);
		model.addAttribute("boardPostVO", boardPostVO);
		return "inquiryPost/detail";
	}
	
	@ResponseBody
	@PostMapping("/pswdCheck")
	public String pswdCheck(@RequestBody Map<String, Object> data) {
		BoardPostVO boardPostVO = this.inquiryPostService.getInquiryDetail((int)data.get("boardNo"));
		if(boardPostVO.getInquiryPostVO().getInqPswd().equals(data.get("pswd"))) { 
			return "success";
		}else {
			return "fail";
		}
	}
	
	@GetMapping("/createPost")
	public String createPost(@RequestParam(required = false, defaultValue = "0") int bbsPostNo
							, @AuthenticationPrincipal CustomUser customUser
							, @RequestParam(required = false) Integer memNo
							, Model model) {
		if(customUser==null && bbsPostNo != 0) { // 비회원이 수정하려 할 경우
			return "error/403";
		}
		
		if(memNo != null) {
			if(customUser!=null && customUser.getUsersVO().getUserNo() != memNo) { // 회원이지만 작성자가 아닐 경우
				return "error/403";
			}
		}
		
		if(bbsPostNo != 0) { // 수정일 경우
			BoardPostVO boardPostVO = this.inquiryPostService.getInquiryDetail(bbsPostNo);
			model.addAttribute("boardPostVO", boardPostVO);
		}
				
		int boardNo = this.inquiryPostService.getMaxNo();
		List<InquiryTypeVO> inqTypeVOList = this.inquiryPostService.getInqTypeVO();
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("inqTypeVOList", inqTypeVOList);
		return "inquiryPost/create";
			

	}
	
	@PostMapping("/createPostAcess")
	public String createPostAcess(BoardPostVO boardPostVO
									, String inqTypeNo
									, String writer
									, String inqPswd
									, @AuthenticationPrincipal CustomUser customUser
			) throws IOException {
		List<MultipartFile> multipartFileList = ckEditorUpload(boardPostVO);
		
		Map<String, Object> map = new HashMap<>();

		if (!multipartFileList.isEmpty()) {
	        MultipartFile[] multipartFiles = multipartFileList.toArray(new MultipartFile[0]);
	        long fileGroupNo = uploadController.multiImageUpload(multipartFiles);
	        map.put("fileGroupNo", fileGroupNo);
	    }
		
		map.put("bbsPostNo", boardPostVO.getBbsPostNo());
		map.put("bbsTypeCdNo", 4);
		map.put("bbsTitle", boardPostVO.getBbsTitle());
		map.put("bbsCn", boardPostVO.getBbsCn());
		map.put("bbsHtmlCn", boardPostVO.getBbsHtmlCn());
		map.put("artGroupNo", 0);
		map.put("bbsCn", boardPostVO.getBbsCn());
		map.put("ansYn", "N");
		map.put("inqTypeNo", inqTypeNo);
		map.put("inqPswd", inqPswd);
		
		if(customUser != null) { // 회원일 경우
			writer = customUser.getUsersVO().getUserMail();
			
			map.put("inqWriter", writer);
			map.put("memNo", customUser.getUsersVO().getUserNo());
			this.inquiryPostService.insertBoardPost(map);
		
		}else { // 비회원일 경우
			map.put("memNo", null);
			map.put("inqWriter", writer);
			
			this.inquiryPostService.insertBoardPost(map);
		}
		
		return "redirect:/oho/inquiryPost/detail?boardNo=" + boardPostVO.getBbsPostNo();
		
	}
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@PostMapping("/editPost")
	public String editPost(BoardPostVO boardPostVO
							, String inqTypeNo
							, String inqPswd
							, String replyPostNo
							, String pswdStatus
			) throws IOException {
		
		List<MultipartFile> multipartFileList = ckEditorUpload(boardPostVO);
		
		Map<String, Object> map = new HashMap<>();

		if (!multipartFileList.isEmpty()) {
	        MultipartFile[] multipartFiles = multipartFileList.toArray(new MultipartFile[0]);
	        long fileGroupNo = uploadController.multiImageUpload(multipartFiles);
	        map.put("fileGroupNo", fileGroupNo);
	    }
		
		map.put("bbsPostNo", boardPostVO.getBbsPostNo());
		map.put("inqTypeNo", inqTypeNo);
		map.put("bbsTitle", boardPostVO.getBbsTitle());
		map.put("bbsCn", boardPostVO.getBbsCn());
		map.put("bbsHtmlCn", boardPostVO.getBbsHtmlCn());
		map.put("inqPswd", inqPswd);
		map.put("replyPostNo", replyPostNo);
		map.put("pswdStatus", pswdStatus);
		
		this.inquiryPostService.editBoardPost(map);
		
		return "redirect:/oho/inquiryPost/detail?boardNo=" + boardPostVO.getBbsPostNo();
	}
	
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/deletePost")
	public String deletePost(int bbsPostNo) {
		this.inquiryPostService.deletePost(bbsPostNo);
		return "redirect:/oho/inquiryPost";
	}
	
	// HTML에서 이미지 URL 뽑는 유틸
	public List<String> extractImageUrls(String html) {
	    List<String> urls = new ArrayList<>();
	    Pattern pattern = Pattern.compile("<img[^>]+src=[\"']?([^\"'>]+)[\"']?");
	    Matcher matcher = pattern.matcher(html);
	    while (matcher.find()) {
	        urls.add(matcher.group(1));
	    }
	    return urls;
	}
	
	
	// ckEditor의 이미지를 파일 객체로 변환하는 유틸
	public List<MultipartFile> ckEditorUpload(BoardPostVO boardPostVO) throws IOException {
		
		String html = boardPostVO.getBbsHtmlCn();
		List<String> imageUrls = extractImageUrls(html);
		
		 List<MultipartFile> multipartFileList = new ArrayList<>();
		
		for(String imageUrl : imageUrls) {
			if(imageUrl.contains("/images/temp/")) { // 웹 경로
				
				String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
		        File tempFile = new File("C:/workspace/tempUpload/" + fileName);
		        
		        if (tempFile.exists()) {
	                byte[] content = FileUtils.readFileToByteArray(tempFile);

	                MultipartFile multipartFile = new MockMultipartFile(
	                        "upload",
	                        fileName,
	                        Files.probeContentType(tempFile.toPath()),
	                        content
	                );

	                multipartFileList.add(multipartFile);
	            } else {
	                log.warn("파일이 없음 : " + tempFile.getAbsolutePath());
	            }
			}
		}
		
		return multipartFileList;
	}
	
}
