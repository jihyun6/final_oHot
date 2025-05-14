package com.ohot.home.live.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ohot.home.live.service.LiveKitTokenService;
import com.ohot.home.live.service.MemberShipCheckService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(origins = "*")
@RequestMapping("/api/live/token")
@RestController
@RequiredArgsConstructor // 현대 스프링부트에선 Autowired말고 RequiredArgsConstructor를 권장
public class LiveTokenAPI {
	
    private final LiveKitTokenService liveKitTokenService;
    
    private final MemberShipCheckService memberShipCheckService;

	// 방송자 토큰 발급
	@GetMapping("/streamer")
	public ResponseEntity<?> createStreamerToken(
			@RequestParam(value = "streamNo") int streamNo,
			@RequestParam(value = "artGroupNo") int artGroupNo){
		log.info("방송자 파라미터-> streamNo: {}, artGroupNo: {}", streamNo, artGroupNo);
		
		try {
			String streamerToken = liveKitTokenService.createStreamerToken(streamNo, artGroupNo);
			
			Map<String, Object> response = new HashMap<>();
			response.put("streamerToken", streamerToken);
			response.put("streamNo", streamNo);
			response.put("success", true);

			//스프링은 java객체를 항상 json객체로 자동 변환하여 처리해준다.
			return ResponseEntity.ok().body(response);
			
		} catch (JsonProcessingException e) {
			log.debug("방송자 토큰 생성 실패: {}", e.getMessage());
			// 이럴 때 클라이언트에 오류정보 반환해야함
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", e.getMessage());
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}

	}
	
	// 시청자 토큰 발급
	@RequestMapping("/viewer")
	public ResponseEntity<?> createViewerToken(
			@RequestParam(value = "streamNo") int streamNo,
			@RequestParam(value = "comProfileNo") int comProfileNo){
		
		log.info("시청자 파라미터-> streamNo: {}, comProfileNo: {}", streamNo, comProfileNo);
		
		String isMemberShipStr = memberShipCheckService.memberShipCheck(comProfileNo);
		boolean isMemberShip = true;
		if(isMemberShipStr.equals("Y")) { isMemberShip = true; }
		else { isMemberShip = false; }
		
		// comProfileNo로 멤버십 체크
		try {
			String viewerToken = liveKitTokenService.createViewerToken(streamNo, comProfileNo, isMemberShip);
			
			Map<String, Object> response = new HashMap<>();
			response.put("viewerToken", viewerToken);
			response.put("success", true);
			response.put("streamNo", streamNo);
			
			return ResponseEntity.ok().body(response);
		} catch (JsonProcessingException e) {
			
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", e.getMessage());
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}
	
	// 일반 토큰
	@RequestMapping("/test")
	public ResponseEntity createToken(
			@RequestParam(value = "identity") String identity,
			@RequestParam(value = "roomName") String roomName){
		log.info("테스트 토큰 파라미터-> identity : {}, roomName: {}", identity, roomName);
		
		try {
			String token = liveKitTokenService.createToken(identity, roomName);
			
			Map<String, Object> response = new HashMap<>();
			response.put("token", token);
			response.put("success", true);
			response.put("roomName", roomName);
			
			return ResponseEntity.ok().body(response);
			
		} catch (JsonProcessingException e) {
			log.info("테스트 토큰 생성 실패");
			e.printStackTrace();
			
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", e.getMessage());
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}
	
	
}
