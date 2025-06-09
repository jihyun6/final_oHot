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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohot.service.ArtistGroupService;
import com.ohot.service.ArtistService;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.FileDetailVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller("adminArtistController")
@RequestMapping("/admin/artistGroup")
public class ArtistGroupController {

	@Autowired
	ArtistGroupService artistGroupService;
	
	@Autowired
	ArtistService artistService;
	
	// /admin/artistGroup/artistGroupList?mode=artGroupNm&keyword=스테이씨
	@GetMapping("/artistGroupList")
	public String artistGroupList(Model model) {

		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
	
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		return "admin/artistGroup/artistGroupList"; 
	}
	
	@ResponseBody
	@PostMapping("/artistGroupListAjax")
	public Map<String, Object> artistGroupListAjax(
			@RequestBody Map<String, Object> param
			) {
		
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
	   
 
	    List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.artistGroupList(param);
	    int total = this.artistGroupService.getTotalArtistGroup(param);
		
	    int totalPages = (int) Math.ceil((double) total / rowSize); 
		int startPage = ((currentPage - 1) / blockSize) * blockSize + 1;
	    int endPage = Math.min(startPage + blockSize - 1, totalPages);
	
	    Map<String, Object> result = new HashMap<>();
	    result.put("content", artistGroupVOList);
	    result.put("currentPage", currentPage);
	    result.put("totalPages", totalPages);
	    result.put("startPage", startPage);
	    result.put("endPage", endPage);
	    result.put("total", total);
		
		return result; 
	}
	
	@GetMapping("/artistGroupDetail")
	public String artistGroupDetail(Model model, ArtistGroupVO artistGroupVO) {
		
		
		ArtistGroupVO artistGroupDetail = this.artistGroupService.artistGroupDetail(artistGroupVO);
		log.info("artistGroupDetail->artistGroupDetail(후) : " + artistGroupVO);
		
		model.addAttribute("artistGroupDetail", artistGroupDetail);
		
		List<ArtistVO> artistVOList = this.artistGroupService.getArtistsInGroup(artistGroupVO);
		log.info("artistGroupDetail->artistVOList : " + artistVOList);
		model.addAttribute("artistVOList", artistVOList);
		
		return "admin/artistGroup/artistGroupDetail";
	}
	
	@GetMapping("/artistGroupRegister")
	public String register(ArtistGroupVO artistGroupVO) {
		
		return "admin/artistGroup/artistGroupRegisterPost";
		
	}
	
	@PostMapping("/artistGroupRegisterPost")
	public String registerPost(ArtistGroupVO artistGroupVO
			, @RequestParam(value="uploadFile") MultipartFile[] uploadFile
			, RedirectAttributes redirectAtrrs) {
		
		artistGroupVO.setUploadFile(uploadFile);
		
		int result = this.artistGroupService.artistGroupInsert(artistGroupVO);
		log.info("artistGroupRegisterPost->artistGroupInsert : "+ result);
		
		redirectAtrrs.addFlashAttribute("registerSuccess", true);
		
		return "redirect:/admin/artistGroup/artistGroupDetail?artGroupNo="+artistGroupVO.getArtGroupNo();
		
	}
	
	@GetMapping("/artistGroupEdit")
	public String edit(Model model, ArtistGroupVO artistGroupVO) {
		
		ArtistGroupVO artistGroupDetail = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		model.addAttribute("artistGroupDetail", artistGroupDetail);
		
		List<ArtistVO> artistVOList = this.artistGroupService.getArtistsInGroup(artistGroupVO);
		log.info("artistGroupDetail->artistVOList : " + artistVOList);
		model.addAttribute("artistVOList", artistVOList);
		
		return "admin/artistGroup/artistGroupEdit";
	}
	
	@PostMapping("/artistGroupEditPost")
	public String editPost(Model model, ArtistGroupVO artistGroupVO,
			@RequestParam(value="uploadFile") MultipartFile[] uploadFile) {
		

		artistGroupVO.setUploadFile(uploadFile);
		
		int result = this.artistGroupService.artistGroupUpdate(artistGroupVO);
		log.info("artistGroupEditPost->editPost : "+ result);
	
		
		return "redirect:/admin/artistGroup/artistGroupDetail?artGroupNo="+artistGroupVO.getArtGroupNo();
	}
	
	@ResponseBody
	@GetMapping("/artistSearch")
	public List<ArtistVO> artistSearch(@RequestParam String keyword) {
		
		log.info("artistSearch : " + keyword);
		return this.artistService.searchArtists(keyword);
	}
	
	@ResponseBody
	@PostMapping("/updateGroup")
	public String updateGroup(@RequestBody ArtistVO artistVO) {
		log.info("updateGroup : "+  artistVO);
		/*
		 * ArtistVO(rnum=0, artNo=8, artGroupNo=16, artActNm=영신2, artExpln=테스트입니다2,
		 * artRegYmd=null, fileGroupNo=20250403016, memNo=13, artDelYn=null,
		 * memVO=MemberVO(rnum=0, memNo=13, memLastName=김, memFirstName=영신,
		 * memNicknm=null, memEmail=null, memTelno=null, memBirth=null, memPswd=null,
		 * joinYmd=null, secsnYmd=null, memAccessToken=null, enabled=0,
		 * memStatSecCodeNo=null, memSecCodeNo=null, memDelYn=null, fullName=null,
		 * snsMemYn=null, authNm=null, authVOList=null, artistVO=null),
		 * fileGroupVO=FileGroupVO(fileGroupNo=20250403016, fileRegdate=Thu Apr 03
		 * 17:39:25 KST 2025, fileDetailVOList=[FileDetailVO(fileSn=2,
		 * fileGroupNo=20250403016 , fileOriginalName=쇼타로.jpeg,
		 * fileSaveName=e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg ,
		 * fileSaveLocate=/2025/04/03/e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg,
		 * fileSize=7795 , fileExt=jpeg, fileMime=image/jpeg, fileFancysize=null,
		 * fileSaveDate=Thu Apr 03 20:59:45 KST 2025 , fileDowncount=0)]),
		 * uploadFile=null)
		 */
		int cnt = artistService.updateArtistGroup(artistVO);
		
		if(cnt==1) {
			return "success";
		}
		
		return "fail";
	}
	
	@ResponseBody
	@PostMapping("/removeGroup")
	public String removeGroup(@RequestBody ArtistVO artistVO) {
		
		log.info("removeGroup : " + artistVO);
		/*
		 * ArtistVO(rnum=0, artNo=8, artGroupNo=16, artActNm=영신2, artExpln=테스트입니다2,
		 * artRegYmd=null, fileGroupNo=20250403016, memNo=13, artDelYn=null,
		 * memVO=MemberVO(rnum=0, memNo=13, memLastName=김, memFirstName=영신,
		 * memNicknm=null, memEmail=null, memTelno=null, memBirth=null, memPswd=null,
		 * joinYmd=null, secsnYmd=null, memAccessToken=null, enabled=0,
		 * memStatSecCodeNo=null, memSecCodeNo=null, memDelYn=null, fullName=null,
		 * snsMemYn=null, authNm=null, authVOList=null, artistVO=null),
		 * fileGroupVO=FileGroupVO(fileGroupNo=20250403016, fileRegdate=Thu Apr 03
		 * 17:39:25 KST 2025, fileDetailVOList=[FileDetailVO(fileSn=2,
		 * fileGroupNo=20250403016, fileOriginalName=쇼타로.jpeg,
		 * fileSaveName=e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg,
		 * fileSaveLocate=/2025/04/03/e8272b26-f056-419a-ad8a-e9f898e29696_쇼타로.jpeg,
		 * fileSize=7795, fileExt=jpeg, fileMime=image/jpeg, fileFancysize=null,
		 * fileSaveDate=Thu Apr 03 20:59:45 KST 2025, fileDowncount=0)]),
		 * uploadFile=null)
		 */
		
		int cnt = artistService.removeArtistGroup(artistVO);
		
		if(cnt==1) {
			return "success";
		}
		
		return "fail";
	}
	
	@ResponseBody
	@PostMapping("/logoFilePost")
	public FileDetailVO logoFilePost(@RequestPart MultipartFile[] uploadFileLogo) {
		
		FileDetailVO result = this.artistGroupService.logoFilePost(uploadFileLogo);
		log.info("파일등록 후 : " + result);
		
		return result;
	}
	
	@GetMapping("/artistGroupDelete")
	public String artistGroupDelete(@RequestParam(value="artGroupNo") int artGroupNo) {
		log.info("artGroupNo->artistGroupDelete" + artGroupNo);
		
		int result = this.artistGroupService.artistGroupDelete(artGroupNo);
		log.info("artGroupNo->artistGroupDelete" + result);
		
		
		return "redirect:/admin/artistGroup/artistGroupDetail?artGroupNo="+artGroupNo;
	}
	
	@GetMapping("/artistGroupActive")
	public String artistGroupActive(@RequestParam(value="artGroupNo") int artGroupNo) {
		
		int result = this.artistGroupService.artistGroupActive(artGroupNo);
		
		
		return "redirect:/admin/artistGroup/artistGroupDetail?artGroupNo="+artGroupNo;
	}
}
