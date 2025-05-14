package com.ohot.home.dm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.dm.service.DmService;
import com.ohot.home.dm.vo.DmMsgVO;
import com.ohot.home.dm.vo.DmSubVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DmWebsocketController {

	
	@Autowired
	DmService dmService;

	@Autowired
	SimpMessagingTemplate messagingTemplate;
	
//	//final은 한번 초기화 되면 바꿀 수 없도록 고정시키는 키워드 -> 생성자에서 한번만 초기화! 안정적이다
//	private final SimpMessagingTemplate messagingTemplate;
//	
//	public ChatController (SimpMessagingTemplate messagingTemplate, DmService dmService) {
//		//생성자 초기화 : 테스트용이하고 불변성을 유지할 수 있다 순환참조 문제 감지 가능하고 명확한 의존성 표현 가능
//		this.messagingTemplate = messagingTemplate;
//		this.dmService= dmService;
//	}
	
	@MessageMapping("/dm/msgByFan") // 팬이 메시지 보냄
    public ResponseEntity<String> msgByFan(DmMsgVO dmMsgVO) {
        log.info("팬이 보낸 메시지: {}", dmMsgVO.getMsgContent());

        int result = dmService.saveMsg(dmMsgVO);
        log.info("메시지 저장 성공 여부: {}", result);

        messagingTemplate.convertAndSend("/toArtist/dmRoom/" + dmMsgVO.getDmSubNo(), dmMsgVO);

        return ResponseEntity.ok("팬 → 아티스트 메시지 전송 완료");
    }
	
	@MessageMapping("/dm/msgByArtist") // 아티스트가 메시지 보냄
    public ResponseEntity<String> msgByArtist(DmMsgVO dmMsgVO) {
        log.info("아티스트가 보낸 메시지: {}", dmMsgVO.getMsgContent());

        int result = dmService.saveMsg(dmMsgVO);
        log.info("메시지 저장 성공 여부: {}", result);

        messagingTemplate.convertAndSend("/toFan/dmRoom/" + dmMsgVO.getDmSubNo(),dmMsgVO);

        return ResponseEntity.ok("아티스트 → 팬 메시지 전송 완료");
    }
	
	//기존채팅내역 불러오기
	@ResponseBody
	@RequestMapping(value="/dm/lastChat", method = RequestMethod.POST)
	public List<DmMsgVO> lastChat(@RequestParam long dmSubNo
			, @RequestParam int artNo
			, @RequestParam int page
			, @RequestParam int size){
		
		int start = (page * size) + 1;
		int end = (page + 1) * size;
		DmMsgVO dmMsgVO = new DmMsgVO();
		dmMsgVO.setDmSubNo(dmSubNo);
		dmMsgVO.setArtNo(artNo);
		dmMsgVO.setStart(start);
		dmMsgVO.setEnd(end);
		
		if(artNo==0) {
			List<DmMsgVO> lastChatListForFan = this.dmService.lastChat(dmMsgVO);
			log.debug("회원일 경우");
			
			return lastChatListForFan;
		}else {
			List<DmMsgVO> lastChatListforArt = this.dmService.lastChatForArt(dmMsgVO);
			log.debug("아티스트일 경우"+ lastChatListforArt);
			return lastChatListforArt;
		}
		
	}
	
	
	//아티스트가 구독할 팬채팅방 리스트
	@ResponseBody
	@RequestMapping(value="/dm/myFanList", method = RequestMethod.POST)
	public List<DmSubVO> myFanList (@RequestParam int artNo){
		
		log.info("artNO: "+artNo);
		List<DmSubVO> myFanVOList=this.dmService.myFanList(artNo);
		
		return myFanVOList;
	}

	
}
