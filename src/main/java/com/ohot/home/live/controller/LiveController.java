package com.ohot.home.live.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ohot.home.community.service.CommunityService;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.groupProfile.service.GroupProfileService;
import com.ohot.home.live.service.MemberShipCheckService;
import com.ohot.home.live.service.StreamService;
import com.ohot.home.live.vo.StreamVO;
import com.ohot.home.media.service.MediaLiveBoardService;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.FileDetailVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(origins = "*")
@Controller
@RequestMapping("/oho/community")
@RequiredArgsConstructor
public class LiveController {
	
	  private final StreamService streamService;
      private final CommunityService communityService;
      private final MediaLiveBoardService mediaLiveBoardService;
      private final MemberShipCheckService memberShipCheckService;
      private final GroupProfileService groupProfileService; 
      private final FileGroupMapper fileGroupMapper;
      
      @Value("${livekit.ws.url}")
  	  private String serverUrl;
      
	  @PreAuthorize("hasAnyRole('MEM', 'ART')")
	  @ModelAttribute("communityProfileVO")
	  public CommunityProfileVO getCommunityProfile(
			  @RequestParam("artGroupNo") int artGroupNo
			  , @AuthenticationPrincipal CustomUser userVO
			  ) {
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
	 
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/live")
	public String liveHome(
			@RequestParam(value = "artGroupNo") int artGroupNo,
			@ModelAttribute(value = "communityProfileVO") CommunityProfileVO communityProfileVO,
			RedirectAttributes redirectAttributes,
			Model model) {
		log.info("라이브 홈 진입 artGroupNo: {}, comPrfileVO: {}", artGroupNo, communityProfileVO);
		
		// 해당 커뮤니티 가입 여부 체크
	    int comProfileNo = communityProfileVO.getComProfileNo();
	    if(comProfileNo == 0) {
	        // 커뮤니티 가입 페이지로 리다이렉트
	        return "redirect:/oho/community/join?artGroupNo=" + artGroupNo;
	    }
		
		//방송 정보 반환
		StreamVO liveStreamVO = streamService.getStreamByArtGroupNo(artGroupNo); // 상태코드 start인 방송정보 반환

		if(liveStreamVO != null) {
			log.info("liveHome->liveStreamVO: {}", liveStreamVO);
			model.addAttribute("liveStreamVO", liveStreamVO);
		}
		
		/*
		 * StreamVO streamVOParams = new StreamVO();
		 * streamVOParams.setStreamStat("end"); // 지난 방송 리스트 반환 List<StreamVO>
		 * streamVOList = streamService.getStreamList(streamVOParams);
		 * log.debug("liveHome-> streamVOList: {}", streamVOList);
		 */
		
		// 미디어 포스트 중 라이브 미디어인 포스트
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaDelYn", "N");
		params.put("mdiaMembershipYn", "L");
		
		List<MediaPostVO> livePostVOList = mediaLiveBoardService.getMediaSerchList(params);
		
		setThumbNailPath(livePostVOList);
		
		log.info("liveHome->livePostVOList {}", livePostVOList);
		
		model.addAttribute("livePostVOList", livePostVOList);
		
		return "live/liveMain";
	}
	
	// 방송 시작 페이지
	@PreAuthorize("hasRole('ART')")
	@GetMapping("/live/studio")
	public String getStudioPage(
			@RequestParam(value = "artGroupNo") int artGroupNo,
			@ModelAttribute(value = "communityProfileVO") CommunityProfileVO communityProfileVO,
			Model model,
			RedirectAttributes redirectAttributes) {
		log.info("getStudioPage->artGroupNo: {}, communityProfileVO: {}", artGroupNo, communityProfileVO);
		
		//방송 권한 체크
		if(!communityProfileVO.getComAuth().equals("ROLE_ART")
				|| communityProfileVO.getArtGroupNo() != artGroupNo) {
			redirectAttributes.addFlashAttribute("errorMassage", "방송 권한이 없습니다.");
			// 쿼리스트링 붙여서 해당 아티스트그룹 라이브페이지로 이
			
			return "redirect:/oho/community/live?artGroupNo=" + artGroupNo;
		}else {
			model.addAttribute("serverUrl", serverUrl);
			return "live/liveStudio";
		}
		
		
	}
	
	// 방송 시청 페이지
	@GetMapping("/live/stream")
	public String getViewerPage(
	        @RequestParam(value = "artGroupNo") int artGroupNo,
	        @RequestParam(value = "streamNo") int streamNo,
	        @ModelAttribute(value = "communityProfileVO") CommunityProfileVO communityProfileVO,
	        Model model) {
	    
	    log.info("방송 시청 페이지 진입 -> artGroupNo: {}, streamNo: {}, communityProfileVO: {}", 
	             artGroupNo, streamNo, communityProfileVO);
	    
	    // 해당 커뮤니티 가입 여부 체크
	    int comProfileNo = communityProfileVO.getComProfileNo();
	    if(comProfileNo == 0) {
	        // 커뮤니티 가입 페이지로 리다이렉트
	        return "redirect:/oho/community/join?artGroupNo=" + artGroupNo;
	    }
	    
	    // 방송 정보 조회
	    StreamVO liveStreamVO = streamService.getStream(streamNo);
	    
	    if(liveStreamVO == null || !"start".equals(liveStreamVO.getStreamStat())) {
	        // 방송이 없거나 방송 중이 아닌 경우
	        return "redirect:/oho/community/live?artGroupNo=" + artGroupNo;
	    }
	    
	    // 아티스트 정보
	    ArtistGroupVO artistGroupVO;
		try {
			artistGroupVO = groupProfileService.getArtistGroup(artGroupNo);
			 log.debug("getViewerPage->artProfVO :{}", artistGroupVO);
			 model.addAttribute("artistGroupVO", artistGroupVO);
			    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   
	    // 모델에 방송 정보 추가
	    model.addAttribute("liveStreamVO", liveStreamVO);
	    model.addAttribute("serverUrl", serverUrl);
	    
	    return "live/liveViewer";
	}
	
	@GetMapping()
	public String getLivePostDetailPage(
			@RequestParam(value = "artGroupNo") String artGroupNo,
			@RequestParam(value = "postNo") Integer mediaPostNo,
			Model model) {
		
		
		return "live/livePostDetail";
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
//				log.info("썸네일경로 대입=> 게시글번호{} + 설정썸네일경로{}", postVO.getMediaPostNo(),postVO.getThumNailPath());
				}
			}
		}
}
