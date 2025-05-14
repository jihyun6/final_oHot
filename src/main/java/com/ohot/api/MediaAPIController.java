package com.ohot.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ohot.dto.MediaReplyDTO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.media.service.MediaCommentService;
import com.ohot.home.media.service.MediaLiveBoardService;
import com.ohot.home.media.vo.MediaPostVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("api")
public class MediaAPIController {
	
	@Autowired
	MediaLiveBoardService mediaLiveBoardService;
	
	@Autowired
	MediaCommentService mediaCommentService;

	@GetMapping("/media/getSearchList")
	public List<MediaPostVO> getSearchList(@RequestParam(value = "artGroupNm", required = false)  String artGroupNm,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(required = false) String endDate,
			@RequestParam(value = "mediaMebershipYn", required = false) String mediaMebershipYn,
			@RequestParam(value = "isbannerYn", required = false) String isbannerYn,
			@RequestParam(value = "mediaDelYn", required = false) String mediaDelYn,
			@RequestParam(value = "mediaPostTitle", required = false) String mediaPostTitle) {
		
		log.info("getSerchList 진입!!");
		
		//검색 옵션 map
		Map<String, Object> params = new HashMap<>();
		
		params.put("artGroupNm", artGroupNm);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		params.put("mediaMebershipYn", mediaMebershipYn);
		params.put("isbannerYn", isbannerYn);
		params.put("mediaDelYn", mediaDelYn);
		params.put("mediaPostTitle", mediaPostTitle);
		
		log.info("getSearchList" + params.toString());
		
		// 검색 조건 리스트 받기
		List<MediaPostVO> mediaPostVOList = mediaLiveBoardService.getMediaSerchList(params);
		
		return mediaPostVOList;
	}
	
	@GetMapping("/media/getPagedList")
	public Map<String, Object> getPagedList(
	        @RequestParam(value = "artGroupNm", required = false) String artGroupNm,
	        @RequestParam(value = "startDate", required = false) String startDate,
	        @RequestParam(value = "endDate", required = false) String endDate,
	        @RequestParam(value = "mediaMebershipYn", required = false) String mediaMebershipYn,
	        @RequestParam(value = "isbannerYn", required = false) String isbannerYn,
	        @RequestParam(value = "mediaDelYn", required = false) String mediaDelYn,
	        @RequestParam(value = "mediaPostTitle", required = false) String mediaPostTitle,
	        @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
	        @RequestParam(value = "size", defaultValue = "10") int size) {
	    
	    log.info("getPagedList 진입!!");
	    
	    // 검색 옵션 map
	    Map<String, Object> params = new HashMap<>();
	    params.put("artGroupNm", artGroupNm);
	    params.put("startDate", startDate);
	    params.put("endDate", endDate);
	    params.put("mediaMebershipYn", mediaMebershipYn);
	    params.put("isbannerYn", isbannerYn);
	    params.put("mediaDelYn", mediaDelYn);
	    params.put("mediaPostTitle", mediaPostTitle);
	    
	    // 페이징 처리 파라미터 추가
	    params.put("currentPage", currentPage);
	    params.put("size", size);
	    params.put("start", (currentPage - 1) * size + 1);
	    params.put("end", currentPage * size);
	    
	    log.info("getPagedList params: {}", params);
	    
	    // 페이징 처리된 리스트와 페이징 정보 가져오기
	    return mediaLiveBoardService.getMediaListWithPaging(params);
	}
	
	@PostMapping("/media/deletePost")
	public ResponseEntity<?> deleteMediaPost(@RequestParam(value = "mediaPostNo") Integer mediaPostNo) {
		
		log.info("deleteMeidaPost->mediaPostNo: {}", mediaPostNo);
		
		int result = mediaLiveBoardService.deleteMediaPost(mediaPostNo);
		// 성공 응답
		String msg = "삭제 성공";
		
		return ResponseEntity.ok().body(msg);
		
	}
	
	@GetMapping("/media/getReplyList")
	public List<MediaReplyDTO> getReplyList(
			@RequestParam(value = "mediaPostNo") Integer mediaPostNo
			, @RequestParam(value = "artGroupNo") Integer artGroupNo){
		
		List<MediaReplyDTO> mediaReplyDTOList;
		
		//댓글 검색 조건 => 리스트 전체조회
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mediaPostNo", mediaPostNo);
		params.put("artGroupNo", artGroupNo);
		params.put("replyDelYn", "N");		
		
		mediaReplyDTOList = mediaCommentService.getReplyList(params);
		
		log.debug("getReplyList->mediaReplyDTOList: {}", mediaReplyDTOList);
		
		return mediaReplyDTOList;
	}
	
	// 댓글 등록
	@PostMapping("/media/createReply")
	public ResponseEntity<?> createReply(//입력 매개변수는 따로 @RequestBody 어노테이션 사용해야함
			@RequestBody CommunityReplyVO communityReplyVO) {
		
		log.debug("createReply 진입,communityReplyVO: {}", communityReplyVO);
		
		int result = mediaCommentService.createReply(communityReplyVO);
		
		String msg = "댓글 등록 성공!" + result;
		
		return ResponseEntity.ok().body(msg) ;
	}
	
	// 댓글 수정
	@PostMapping("/media/updateReply")
	public ResponseEntity<?> updateReply(@RequestBody Map<String, Object> params) {
		// axios post요청은 일반적으로 http body의 객체를 받으므로 @RequestBody로 받는다.
		// @RequestBody 어노테이션은 HTTP 요청 본문(request body)의 JSON 데이터를 자바 객체로 변환
		// 프론트엔드에서 보낸 JavaScript 객체가 자동으로 자바 객체나 Map으로 변환
		// 근데 파라미터성이 아니라 정보성이면 DTO를 따로 만들어서 많이 받음
		log.debug("updateReply->parmas: {}", params);
		// 타입안정성!! VO생성해서 set으로 할당해서 보내면 타입안정성 보장되는데
		// Map으로 직접 파라미터 넘겨주면 타입불일치 가능성이 있다. -> db엔 들어가는데 vo에 선언된 필드의 타입과 맞지 않을 수 잇음
		// 그래서 타입변환을 명시적으로 하는게 좋다.
		// 댓글번호
		int replyNo = Integer.parseInt(params.get("replyNo").toString());
		String replyContent = params.get("replyContent").toString();
		
		// 서비스단으로 넘겨줄때 타입안정성 보장해서 넘겨주면 좋음 -> VO는 타입이 필드에 선언되어있으니까 VO로 넘기는건 괜찮음, 타입 안정성 보장
		int result = mediaCommentService.updateReply(replyNo, replyContent);
		
		if(result != 0) {
			// 댓글 수정 트랜잭션 성공
			return ResponseEntity.ok().build();
		}else {
			// 댓글 수정 트랜잭션 실패
			return ResponseEntity.badRequest().build();
		}
	}
	
	// 댓글 삭제
	@PostMapping("/media/deleteReply")
	public ResponseEntity<?> deleteReply(@RequestBody Map<String, Object> params) {
		log.debug("deleteReply->parmas: {}", params);
		
		int replyNo = Integer.parseInt(params.get("replyNo").toString()); // string -> int 바로 형변환 안됨
		
		int result = mediaCommentService.deleteReply(replyNo);
		
		return ResponseEntity.ok().body(result);
	}
	

}
