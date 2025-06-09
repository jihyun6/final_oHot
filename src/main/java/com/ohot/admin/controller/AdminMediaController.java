package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.config.BeanController;
import com.ohot.config.FileConfig;
import com.ohot.home.media.service.MediaLiveBoardService;
import com.ohot.home.media.vo.MediaPostVO;
import com.ohot.mapper.FileGroupMapper;
import com.ohot.service.ArtistGroupService;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.FileDetailVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/media")
public class AdminMediaController {

    private final BeanController beanController;

    private final FileConfig fileConfig;

	@Autowired
	MediaLiveBoardService mediaLiveBoardService;
	
	@Autowired
	ArtistGroupService artistGroupService;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	FileGroupMapper fileGroupMapper;

    AdminMediaController(FileConfig fileConfig, BeanController beanController) {
        this.fileConfig = fileConfig;
        this.beanController = beanController;
    }
	/*
	    GET /admin/media - 미디어 관리 페이지
		GET /admin/media/list - 미디어 목록 데이터 API
		GET /admin/media/{mediaId} - 특정 미디어 상세 정보
		POST /admin/media - 새 미디어 업로드
		PUT /admin/media/{mediaId} - 미디어 정보 수정
		DELETE /admin/media/{mediaId} - 미디어 삭제
		GET /admin/media/membership - 멤버십 미디어 관리
		GET /admin/media/banners - 배너 관리
	 */
	
	@GetMapping("")
	public String getMediaList(Model model) {
		
		log.info("getMediaList 호출");
		
		List<MediaPostVO> mediaPostListVO = mediaLiveBoardService.getMediaList();
		log.info("getMediaList->mediaPostListVO : {}", mediaPostListVO);
		
		List<ArtistGroupVO> artistGroupVOList = artistGroupService.homeArtistGroupList();
		log.info("ArtistGroupVOList:" + artistGroupVOList);
		
		model.addAttribute("mediaPostListVO", mediaPostListVO);
		model.addAttribute("artistGroupVOList", artistGroupVOList);

		return "/admin/media/mediaMain";
	}
	
	// 게시글 등록
	@GetMapping("/create")
	public String getMediaPost(Model model) {
			
		log.info("getMediaPost 진입");
		
		List<ArtistGroupVO> artistGroupVOList = artistGroupService.homeArtistGroupList();
		log.info("getMediaPost->ArtistGroupVOList:" + artistGroupVOList);
		
		model.addAttribute(artistGroupVOList);
		
		return "admin/media/mediaPostCreate";
	}
	
	@PostMapping("/create")
	public String createMediaPost(MediaPostVO mediaPostVO
			, @RequestParam("thumbnailFile") MultipartFile[] thumbnailFile
			, @RequestParam("videoFile") MultipartFile[] videoFile) {
		
		// 일반미디어 일때 썸네일 경로는 youtube아이디가 돼야함
		if(mediaPostVO.getMediaMebershipYn().equals("N")) {
			String youtubeId = getYoutubeId(mediaPostVO.getMediaVideoUrl());
			
			mediaPostVO.setMediaVideoUrl(youtubeId);
		}
		else {
			
			
			// 썸네일 이미지 파일
			if(thumbnailFile.length != 0) { // null체크
				// 썸네일 처리 메소드 들고 와서 쓰면 되지않나 => 이미 등록된 게시글에대해 처리하는거라 관련 없음 오키
				// 파일 업로드 처리를 먼저해야한다는 뜻
				long fileGroupNo = uploadController.multiImageUpload(thumbnailFile); // FileGroupNo 반환
				
				// mediaPostVO 받아온거에 파일그룹넘버 아직 없으니까 담아줌
				mediaPostVO.setFileGroupNo(fileGroupNo);
				
				// 어차피 조회메소드에서 saveLocate를 thumbnailPath에 대입
			}
			// 비디오 파일
			if(videoFile.length != 0) { // null체크
				long videoFileGroupNo = uploadController.multiImageUpload(videoFile);
				
				// 근데 이미지랑 비디오 파일이랑 그룹넘버는 달라지는데 같은 post인데 비디오를 받는다
				// 어차피 같은 파일넘버로 받아도 삭제할때 문제 생긴다
				// 다른 넘버로 하고 삭제할때 mediaPostVo 삭제 시 뭘 삭제해야하나
				// media Post 하나에 그룹넘버 하나인데
				
				// 비디오는 어쩔 수 없다
				FileDetailVO videoFileDetailVO = new FileDetailVO();
				
				// 먼저 파일 그룹넘버 넣고
				videoFileDetailVO.setFileGroupNo(videoFileGroupNo);
				// 시리얼 번호 1번 고정이고
				videoFileDetailVO.setFileSn(1);
				
				// 위 두 조건에 해당하는 파일 정보 불러옴
				videoFileDetailVO = fileGroupMapper.selectFileDetail(videoFileDetailVO);
				
				// 새로 불러온 파일 정보에서 동영상 savaloate를 mediaPostVo의 mediaVideoUrl에 대입 홀리몰리
				
				mediaPostVO.setMediaVideoUrl(videoFileDetailVO.getFileSaveLocate());
			}
		}
		// 셋팅된 mediaPostVO 저장
		mediaLiveBoardService.createPost(mediaPostVO);
		
		return "redirect:/admin/media";
	}

	
	@GetMapping("/detail")
	public String getMediaDetail(@RequestParam(value = "postNo") Integer mediaPostNo
			, @RequestParam(value = "artGroupNo") String artGroupNo
			, Model model) {
		
		// getDetail 파라미터, 포스트 번호랑 아티스트그룹 넘버 설정
		Map<String, Object> params = new HashMap<>();
		params.put("mediaPostNo", mediaPostNo);
		params.put("artGroupNo", artGroupNo);
		
		log.info("getMediaDetail->params: " + params);

		// Psot 정보 불러오기
		MediaPostVO mediaPostVO = mediaLiveBoardService.getMediaDetail(params);
		
		// 썸네일 경로 새로 붙여줘야 됨
		mediaPostVO.setThumNailPath(setThumbNailPath(mediaPostVO));
		log.info("getMediaDetail->mediaPostVO: " + mediaPostVO);
		
		model.addAttribute("mediaPostVO",mediaPostVO);
		
		return "admin/media/mediaPostDetail";
	}
	
	// 게시글 수정 폼 포워딩 
	@GetMapping("/update")
	public String showUpdateMediaPost(@RequestParam(value = "postNo") Integer mediaPostNo
			, @RequestParam(value = "artGroupNo") String artGroupNo
			, Model model) {
		
		// 검색조건 파라미터 구성
		Map<String, Object> params = new HashMap<>();
		params.put("artGroupNo", artGroupNo);
		params.put("mediaPostNo", mediaPostNo);
		
		// 선택된 게시글 정보 담아서 수정폼에 넘겨주기
		MediaPostVO mediaPostVO = mediaLiveBoardService.getMediaDetail(params);
		// 아티스트 그룹정보도 필요함
		List<ArtistGroupVO> artistGroupVOList = mediaLiveBoardService.getArtistGroupList();
		
		// 썸네일 경로 새로 붙여줘야 됨
		mediaPostVO.setThumNailPath(setThumbNailPath(mediaPostVO));
		log.info("showUpdateMediaPost->mediaPostVO: " + mediaPostVO);
		
		// 게시글 정보
		model.addAttribute("mediaPostVO",mediaPostVO);
		// 아티스트 그룹 종류 정보
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		return "admin/media/mediaPostUpdate";
	}
	
	// 게시글 수정
	@PostMapping("/update")
	public String updateMediaPost(@ModelAttribute MediaPostVO mediaPostVO
			, @RequestParam(value = "thumbnailFile", required = false) MultipartFile[] thumbnailFile
			, @RequestParam(value = "videoFile", required = false) MultipartFile[] videoFile) {
		
		// 게시글 유형에 따라 다른 로직
		// 일반미디어 일때 썸네일 경로는 youtube아이디가 돼야함
				if(mediaPostVO.getMediaMebershipYn().equals("N")) {
					String youtubeId = getYoutubeId(mediaPostVO.getMediaVideoUrl());
					
					mediaPostVO.setMediaVideoUrl(youtubeId);
				}
				else {
					
					
					// 썸네일 이미지 파일
					if(thumbnailFile.length != 0) { // null체크
						// 썸네일 처리 메소드 들고 와서 쓰면 되지않나 => 이미 등록된 게시글에대해 처리하는거라 관련 없음 오키
						// 파일 업로드 처리를 먼저해야한다는 뜻
						long fileGroupNo = uploadController.multiImageUpload(thumbnailFile); // FileGroupNo 반환
						
						// mediaPostVO 받아온거에 파일그룹넘버 아직 없으니까 담아줌
						mediaPostVO.setFileGroupNo(fileGroupNo);
						
						// 어차피 조회메소드에서 saveLocate를 thumbnailPath에 대입
					}
					// 비디오 파일
					if(videoFile.length != 0) { // null체크
						long videoFileGroupNo = uploadController.multiImageUpload(videoFile);
						
						// 근데 이미지랑 비디오 파일이랑 그룹넘버는 달라지는데 같은 post인데 비디오를 받는다
						// 어차피 같은 파일넘버로 받아도 삭제할때 문제 생긴다
						// 다른 넘버로 하고 삭제할때 mediaPostVo 삭제 시 뭘 삭제해야하나
						// media Post 하나에 그룹넘버 하나인데
						
						// 비디오는 어쩔 수 없다
						FileDetailVO videoFileDetailVO = new FileDetailVO();
						
						// 먼저 파일 그룹넘버 넣고
						videoFileDetailVO.setFileGroupNo(videoFileGroupNo);
						// 시리얼 번호 1번 고정이고
						videoFileDetailVO.setFileSn(1);
						
						// 위 두 조건에 해당하는 파일 정보 불러옴
						videoFileDetailVO = fileGroupMapper.selectFileDetail(videoFileDetailVO);
						
						// 새로 불러온 파일 정보에서 동영상 savaloate를 mediaPostVo의 mediaVideoUrl에 대입 홀리몰리
						
						mediaPostVO.setMediaVideoUrl(videoFileDetailVO.getFileSaveLocate());
					}
				}
		log.info("updateMediaPost->mediaPostVO : {}", mediaPostVO);
				
		//업데이트 실행
		mediaLiveBoardService.updateMediaPost(mediaPostVO);
		
		return "redirect:/admin/media/detail?postNo=" + mediaPostVO.getMediaPostNo() + "&artGroupNo=" + mediaPostVO.getArtGroupNo();
	}
	
	// 유튜브 동영상 id 추출 메소드
		public static String getYoutubeId(String mediaVideoUrl) {
		    if (mediaVideoUrl == null || mediaVideoUrl.trim().isEmpty()) {
		        return null;
		    }
		    
		    // 표준 유튜브 URL 패턴에서 ID 추출
		    Pattern pattern = Pattern.compile(
		        "(?<=watch\\?v=|/videos/|embed\\/|youtu.be\\/|\\/v\\/|\\/e\\/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%\u200C\u200B2F|youtu.be%2F|%2Fv%2F)[^#\\&\\?\\n]*");
		    Matcher matcher = pattern.matcher(mediaVideoUrl);
		    
		    return matcher.find() ? matcher.group() : null;
		}
		
		// 썸네일 경로 처리
		private String setThumbNailPath(MediaPostVO mediaPostVO) {
			//파일 디테일 경로 가져오기
			
			// 일단 포스트에 저장된 파일 그룹넘버를 가져와야함
			// 
			FileDetailVO fileDetailVO = new FileDetailVO();

			// 멤버쉽일땐 경로 다르게 처리
			if (mediaPostVO.getMediaMebershipYn().equals("N")) {

				mediaPostVO.setThumNailPath(mediaPostVO.getMediaVideoUrl());
			} else {
				// 멤버쉽 아닌 미디어
				// 하나씩 파일그룹 넘버 꺼내기
				fileDetailVO.setFileGroupNo(mediaPostVO.getFileGroupNo());
				// 썸네일은 1개만 있으니까 무조건 1
				fileDetailVO.setFileSn(1);

				// 새로 디테일 담을 fileVO
				FileDetailVO fileDetailVO2 = fileGroupMapper.selectFileDetail(fileDetailVO);

				// mediaPostVO에 썸네일 경로 대입
				mediaPostVO.setThumNailPath(fileDetailVO2.getFileSaveLocate());
				log.info("썸네일경로 대입=> 게시글번호{} + 설정썸네일경로{}", mediaPostVO.getMediaPostNo(), mediaPostVO.getThumNailPath());
			}

			return mediaPostVO.getThumNailPath();
		}
		
	
}
