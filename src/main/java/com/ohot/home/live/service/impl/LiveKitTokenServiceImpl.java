package com.ohot.home.live.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ohot.home.live.mapper.StreamMapper;
import com.ohot.home.live.service.LiveKitTokenService;
import com.ohot.home.live.service.StreamService;
import com.ohot.home.live.vo.StreamVO;

import io.livekit.server.AccessToken;
import io.livekit.server.RoomAdmin;
import io.livekit.server.RoomCreate;
import io.livekit.server.RoomJoin;
import io.livekit.server.RoomName;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class LiveKitTokenServiceImpl implements LiveKitTokenService {
	// 방송 키
	@Value("${livekit.api.key}")
	private String apiKey;
	
	// 스트림 비밀번호
	@Value("${livekit.api.secret}")
	private String apiSecret;
	
	// stream 매퍼
	private final StreamMapper streamMapper;
	
	private final StreamService streamService;
	
	// 방송자 토큰 생성
	public String createStreamerToken(int streamNo, int artGroupNo) throws JsonProcessingException {
	    StreamVO streamVO = streamMapper.getStream(streamNo);

	    if(streamVO == null || streamVO.getArtGroupNo() != artGroupNo) {
	        log.info("방송 인증 실패"); 
	    }

	    AccessToken token = new AccessToken(apiKey, apiSecret);
	    token.setName("streamer");
	    token.setIdentity("artistGroup_" + artGroupNo);

	    ObjectMapper objectMapper = new ObjectMapper();
	    Map<String, String> metadata = new HashMap<>();
	    metadata.put("role", "streamer");
	    metadata.put("artGroupNo", String.valueOf(artGroupNo));
	    metadata.put("streamNo", String.valueOf(streamNo));
	    
	    String metadataJson = objectMapper.writeValueAsString(metadata);
	    token.setMetadata(metadataJson);

	    String roomName = "Stream_" + streamNo;

	    token.addGrants(
	        new RoomJoin(true),
	        new RoomName(roomName)
	    );

	    log.debug("방송자 토큰 생성: {}", token.toJwt());
	    return token.toJwt();
	}
	
	//시청자 토큰 생성
	public String createViewerToken(int streamNo, int memberNo, boolean isMembership) throws JsonProcessingException {
	    // 스트림 정보 조회
	    StreamVO streamVO = streamMapper.getStream(streamNo);
	    
	    // 존재하지 않는 스트림인 경우
	    if(streamVO == null) {
	        log.info("존재하지 않는 방송: {}", streamNo);
	        throw new IllegalArgumentException("Stream not found");
	    }
	    
	    // 멤버십 확인
		/*
		 * if(!isMembership) { log.info("회원: {}", memberNo); throw new
		 * IllegalArgumentException("Membership required to view this stream"); }
		 */
	    
	    // LiveKit 토큰 생성
	    AccessToken token = new AccessToken(apiKey, apiSecret);
	    
	    // 토큰 설정
	    token.setName("viewer_" + memberNo);
	    token.setIdentity("member_" + memberNo);
	    
	    // 메타데이터 설정
	    ObjectMapper objectMapper = new ObjectMapper();
	    Map<String, String> metadata = new HashMap<>();
	    metadata.put("role", "viewer");
	    metadata.put("memberNo", String.valueOf(memberNo));
	    metadata.put("streamNo", String.valueOf(streamNo));
	    
	    // JSON 변환
	    String metadataJson = objectMapper.writeValueAsString(metadata);
	    token.setMetadata(metadataJson);
	    
	    // 방 이름 설정, 방송자랑 시청자랑 이게 같을 수 있나..?
	    String roomName = "Stream_" + streamNo;
	    
	    
	    token.addGrants(new RoomJoin(true), new RoomName(roomName));
	    
	    log.debug("시청자 토큰 생성: {}", token.toJwt());
	    
	    return token.toJwt();
	}
	
	// 기본토큰 테스트용
	public String createToken(String identity, String roomName) throws JsonProcessingException {
	    // LiveKit 토큰 생성
	    AccessToken token = new AccessToken(apiKey, apiSecret);
	    
	    // 토큰 기본 정보 설정
	    token.setIdentity(identity);
	    token.setName("test"); // 선택적으로 name 설정
	    
	    // 공식 문서 방식대로 권한 설정
	    token.addGrants(new RoomJoin(true), new RoomName(roomName));
	    
	    log.debug("기본 테스트토큰 생성: {}", token.toJwt());
	    
	    return token.toJwt();
	}
	
	// 미리보기 썸네일
	/*
	@Override
	public String captureStreamThumbnail(int streamNo) {
	    try {
	        // StreamVO 정보 가져오기
	        StreamVO streamVO = streamService.getStream(streamNo);
	        
	        String thumbnailPath = "/upload/thumbnails/stream_" + streamNo + "_" + System.currentTimeMillis() + ".jpg";
	        String thumbnailFullPath = System.getProperty("user.dir") + thumbnailPath;
	        
	        // LiveKit Egress 캡처 ffmpeg로 하던가
	        
	        // 썸네일 저장 경로를 DB에 업데이트
	        streamVO.setStreamThmimgUrl(thumbnailPath);
	        streamService.updateStreamStat(streamVO);
	        
	        return thumbnailPath;
	    } catch (Exception e) {
	        log.error("썸네일 캡처 실패: {}", e.getMessage());
	        return null;
	    }
	}
	*/
	
}