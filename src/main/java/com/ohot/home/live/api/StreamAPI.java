package com.ohot.home.live.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ohot.home.live.service.StreamService;
import com.ohot.home.live.vo.StreamVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/live/stream")
@RequiredArgsConstructor
public class StreamAPI {

	private final StreamService streamService;

	// 방송시작
	@PostMapping("/create")
	public ResponseEntity<?> createStream(@RequestBody StreamVO streamVO) {

		log.info("방송 생성 진입: streamVO: {}", streamVO);

		// StartDt 디폴트값이 SYSDATE긴 한데 동기화율 높이기 위해 재할당
		streamVO.setStreamStartDt(new Date());
		// 방송 상태 설정
		streamVO.setStreamStat("start");

		// 방송 정보 저장
		int result = streamService.createStream(streamVO);

		if (result > 0) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("streamNo", streamVO.getStreamNo());
			response.put("message", "방송 생성 성공");

			return ResponseEntity.ok().body(response);
		} else {
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", "방송 생성 실패");

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);

		}
	}

	@PostMapping("/end")
	public ResponseEntity<?> endStream(@RequestBody Map<String, Object> params) {
		int artGroupNo = Integer.parseInt(params.get("artGroupNo").toString());
		log.info("방송 종료 진입->artGroupNo: {}", artGroupNo);

		// 해당 아티스트 그룹의 현재 방송 조회
		StreamVO streamVO = streamService.getStreamByArtGroupNo(artGroupNo);

		if (streamVO == null) {
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", "방송 정보가 없습니다.");

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}

		// 방송 종료 시간 설정
		streamVO.setStreamEndDt(new Date());
		// 방송 상태 변경
		streamVO.setStreamStat("end");

		// 방송 정보 업데이트
		int result = streamService.updateStreamStat(streamVO);

		if (result > 0) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("message", "방송 종료 성공");
			
			return ResponseEntity.ok().body(response);
		} else {
			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", "방송 종료 실패");
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(errorResponse);
		}
	}

}
