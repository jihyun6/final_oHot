package com.ohot.home.live.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ohot.home.live.service.ChatMsgService;
import com.ohot.home.live.vo.ChatMsgVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/live/chat")
public class ChatMsgAPI {
	
	private final ChatMsgService chatMsgService;
	
	// 채팅 저장
	 @PostMapping("/create")
	 public ResponseEntity<?> createChatMsg(@RequestBody ChatMsgVO chatMsgVO) {
	     log.info("createChatMsg->chatMsgVO: {}", chatMsgVO);
	     
	     int result = chatMsgService.createChatMsg(chatMsgVO);
	     
	     Map<String, Object> response = new HashMap<>();
	     if (result > 0) {
	         response.put("success", true);
	         response.put("message", "채팅 저장 성고");
	         return ResponseEntity.ok(response);
	     } else {
	         response.put("success", false);
	         response.put("message", "채팅 저장 실패");
	         return ResponseEntity.badRequest().body(response);
	     }
	 }
	 
	 // 방송 별 채팅 조회
	 @GetMapping("/all")
	 public ResponseEntity<?> getChatMsgListByStreamNo(@RequestParam("streamNo") int streamNo) {
	     log.info("getChatMessages->streamNo: {}", streamNo);
	     
	     List<ChatMsgVO> chatMsgVOList = chatMsgService.getChatMsgListByStreamNo(streamNo);
	     
	     Map<String, Object> response = new HashMap<>();
	     response.put("success", true);
	     response.put("data", chatMsgVOList);
	     
	     // 어차피 자동으로 Json변환
	     return ResponseEntity.ok(response);
	 }
	 
	 // 채팅 수 제한 조회
	 @GetMapping("/list")
	 public ResponseEntity<?> getChatMsgList(
	         @RequestParam("streamNo") int streamNo,
	         @RequestParam(value = "chatCount", defaultValue = "50") int chatCount) {
	     
	     log.info("getChatMsgList-> streamNo: {}, limit: {}", streamNo, chatCount);
	     
	     List<ChatMsgVO> chatMsgVOList = chatMsgService.getChatMsgList(streamNo, chatCount);
	     
	     Map<String, Object> response = new HashMap<>();
	     response.put("success", true);
	     response.put("data", chatMsgVOList);
	        
	     return ResponseEntity.ok(response);
	 }

}
