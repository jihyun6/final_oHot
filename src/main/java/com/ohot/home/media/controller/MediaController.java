package com.ohot.home.media.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.ohot.home.community.service.CommunityService;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.community.vo.MyCommuntiyVO;
import com.ohot.home.media.mapper.MediaCommentMapper;
import com.ohot.home.media.service.MediaLiveBoardService;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.service.ArtistGroupService;
import com.ohot.service.MemberService;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho/community")
public class MediaController {

	@Autowired
	MediaLiveBoardService mediaLiveBoardService;

	@Autowired
	FileGroupMapper fileGroupMapper;

	@Autowired
	MemberService memberService;
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	ArtistGroupService artistGroupService;

	/*
	 * 미디어 메인페이지
	 *
	 */
	
	  @PreAuthorize("hasAnyRole('MEM', 'ART', 'ADMIN')")
	  @ModelAttribute("communityProfileVO")
	  public CommunityProfileVO getCommunityProfile(
			  @RequestParam("artGroupNo") Integer artGroupNo
			  , @AuthenticationPrincipal CustomUser userVO
			  ) {
	
		  
		  // 미디어 페이지에서 들고다닐 커뮤니티 프로필 정보
		  
		  // userVO에서 getter로 유저 정보 접근 -> 보안
		  int memNo = (int)userVO.getUsersVO().getUserNo();
		  
		  log.info("getCommunityProfile-> memNo: {}", memNo);
		  
		  CommunityProfileVO communityProfileVO = new CommunityProfileVO();
		  // user넘버랑 아티그룹넘버를 파라미터로 넘김
		  // 근데 그럼 비회원일때는 어케 처리하냐...
		  communityProfileVO.setArtGroupNo(artGroupNo);
		  communityProfileVO.setMemNo(memNo);
		  
		  // 어차피 커뮤니티 가입한 멤버만 접근 가능하니까 이미 커뮤니티 프로필 정보를 가진 사용자임
		  communityProfileVO = communityService.profileDetail(communityProfileVO);
		  log.info("getCommunityProfile->communityProfileVO: {}", communityProfileVO);
		  	  
		  // 비회원이면 communityProfileVO의 profileNo가 null일거니까 이걸로 null체크해서 비회원 예외처리
		  return communityProfileVO; 
	 }
	 

	@PreAuthorize("hasAnyRole('MEM', 'ART', 'ADMIN')")
	@GetMapping("/media")
	public String mediaHome(@RequestParam(value = "artGroupNo", required = false) Integer artGroupNo, Model model, Principal principal
							,@AuthenticationPrincipal CustomUser customUser
			) {
		log.info("media page진입, artGroupNo: {}", artGroupNo);
		
		if(artGroupNo == null) {
			return "redirect:/oho";
		}
		
		// 시큐리티 회원 정보
		// 이걸로 멤버쉽인지 아닌지 판별해야 될거 같은데
		log.info("mediaHome->user정보 Principal: {}", principal);

		// 조회 조건 추가영역
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaDelYn", "N");

		List<MediaPostVO> mediaPostVOList = mediaLiveBoardService.getMediaSerchList(params);
		log.info("mediaHome->mediaPostVoList: {}", mediaPostVOList);

		// 배너 최대 갯수 5개로 제한
		// Stream을 사용해 보자
		// 깊은 복사 전에 잠깐 담을 리스트
		List<MediaPostVO> banerPostVOList = mediaPostVOList.stream()
				.filter(mediaPostVo -> "Y".equals(mediaPostVo.getIsbannerYn())).limit(5).collect(Collectors.toList()); // 왜
																														// 바로
		//마이 커뮤니티 리스트																												// toList가
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("Notice---myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(artGroupNo);
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);																											
		// 파일 썸네일 경로 처리
		setThumbNailPath(mediaPostVOList);
		setThumbNailPath(banerPostVOList);

		model.addAttribute("mediaPostVOList", mediaPostVOList);
		model.addAttribute("banerPostVOList", banerPostVOList);

		return "media/mediaMain";
	}

	/*
	 * 최신 미디어 페이지
	 * 
	 */

//	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/media/new")
	public String newMediaHome(@RequestParam(value = "artGroupNo") String artGroupNo, Model model,
			Principal principal, @AuthenticationPrincipal CustomUser customUser) {

		log.info("newMediaList  진입");

		
		
		//마이 커뮤니티 리스트																												// toList가
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("Notice---myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(Integer.parseInt(artGroupNo));
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);		
		
		
		
		// 조회 조건 추가영역
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaMebershipYn", "N");
		params.put("mediaDelYn", "N");

		// 아티스트그룹 별 미디어포스트 리스트
		List<MediaPostVO> mediaPostVOList = mediaLiveBoardService.getMediaSerchList(params);

		// 파일 썸네일 경로 처리
		setThumbNailPath(mediaPostVOList);

		model.addAttribute("mediaPostVOList", mediaPostVOList);

		log.info("newMediaHome->mediaPostVOList: {}", mediaPostVOList);

		return "media/newMediaList";
	}

//	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/media/membership")
	public String membershipMediaHome(@RequestParam(value = "artGroupNo") String artGroupNo, Model model,
			Principal principal,@AuthenticationPrincipal CustomUser customUser) {
		// 멤버쉽 회원만 접근해야함

		log.info("newMediaList  진입");
		
		//마이 커뮤니티 리스트																												// toList가
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("Notice---myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(Integer.parseInt(artGroupNo));
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);		
		

		// 조회 조건 추가영역
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaMebershipYn", "Y");
		params.put("mediaDelYn", "N");

		// 아티스트그룹 별 미디어포스트 리스트
		List<MediaPostVO> mediaPostVOList = mediaLiveBoardService.getMediaSerchList(params);

		// 파일 썸네일 경로 처리
		setThumbNailPath(mediaPostVOList);

		model.addAttribute("mediaPostVOList", mediaPostVOList);

		log.info("membershipMediaHome->mediaPostVOList: {}", mediaPostVOList);

		return "media/membershipMediaList";
	}

//	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/media/all")
	public String allMediaHome(@RequestParam(value = "artGroupNo") String artGroupNo, Model model,
			Principal principal,@AuthenticationPrincipal CustomUser customUser) {
		log.info("newMediaList  진입");

		//마이 커뮤니티 리스트																												// toList가
		int memNo = (int)customUser.getUsersVO().getUserNo();
		
		List<MyCommuntiyVO> myCommunityList = this.communityService.myCommunity(memNo);
		log.info("Notice---myCommunityList::::"+myCommunityList);
		
		model.addAttribute("myCommunityList", myCommunityList);
		//끝
		ArtistGroupVO artistGroupVO = new ArtistGroupVO();
		artistGroupVO.setArtGroupNo(Integer.parseInt(artGroupNo));
		
		artistGroupVO = this.artistGroupService.artistGroupDetail(artistGroupVO);
		
		
		model.addAttribute("artistGroupVO",artistGroupVO);		
		
		
		// 조회 조건 추가영역
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaDelYn", "N");

		// 아티스트그룹 별 미디어포스트 리스트
		List<MediaPostVO> mediaPostVOList = mediaLiveBoardService.getMediaSerchList(params);

		// 파일 썸네일 경로 처리, 멤버쉽 N일때 썸네일 처리
		// 멤버쉽 Y일때 썸네일 변경

		setThumbNailPath(mediaPostVOList);

		model.addAttribute("mediaPostVOList", mediaPostVOList);

		log.info("allMediaHome->mediaPostVOList: {}", mediaPostVOList);

		return "media/allMediaList";
	}

// 미디어 게시글 상세
//	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/media/post")
	public String mediaPostDetail(@RequestParam(value = "artGroupNo") String artGroupNo,
			@RequestParam(value = "postNo") Integer mediaPostNo, Model model) {
		log.info("mediaPostDetail  진입");

		// 조회 조건 추가영역
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaPostNo", mediaPostNo);

		// 아티스트그룹 별 미디어포스트 1개
		MediaPostVO mediaPostVO = mediaLiveBoardService.getMediaDetail(params);

		// 상세인 썸네일 필요없음
		model.addAttribute("mediaPostVO", mediaPostVO);

		log.info("newMediaHome->mediaPostVO: {}", mediaPostVO);

		return "media/mediaPostDetail";
	}

	// 썸네일 경로 처리
	public void setThumbNailPath(List<MediaPostVO> mediaPostVOList) {
		// 파일 디테일 경로 가져오기

		// 일단 포스트에 저장된 파일 그룹넘버를 가져와야함
		//
		FileDetailVO fileDetailVO = new FileDetailVO();

		for (MediaPostVO postVO : mediaPostVOList) {

			// 멤버쉽일땐 경로 다르게 처리
			if (postVO.getMediaMebershipYn().equals("N")) {

				postVO.setThumNailPath(postVO.getMediaVideoUrl());
			} else {
				// 멤버쉽 아닌 미디어
				// 하나씩 파일그룹 넘버 꺼내기
				fileDetailVO.setFileGroupNo(postVO.getFileGroupNo());
				// 썸네일은 1개만 있으니까 무조건 1
				fileDetailVO.setFileSn(1);

				// 새로 디테일 담을 fileVO
				FileDetailVO fileDetailVO2 = fileGroupMapper.selectFileDetail(fileDetailVO);

				// mediaPostVO에 썸네일 경로 대입
				postVO.setThumNailPath(fileDetailVO2.getFileSaveLocate());
//			log.info("썸네일경로 대입=> 게시글번호{} + 설정썸네일경로{}", postVO.getMediaPostNo(),postVO.getThumNailPath());
			}
		}
	}

}
