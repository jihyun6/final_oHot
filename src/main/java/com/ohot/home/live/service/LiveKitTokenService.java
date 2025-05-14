package com.ohot.home.live.service;

import com.fasterxml.jackson.core.JsonProcessingException;

public interface LiveKitTokenService {

	// 방송자 토큰
	public String createStreamerToken(int streamNo, int artGroupNo) throws JsonProcessingException;
	
	// 시청자 토큰
	public String createViewerToken(int streamNo, int memberNo, boolean isMembership) throws JsonProcessingException;
	 
	 // 일반토큰
	public String createToken(String identity, String roomName) throws JsonProcessingException;
	
	// 라이브 썸네일
	//public void captureStreamThumbnail(int streamNo);
}
