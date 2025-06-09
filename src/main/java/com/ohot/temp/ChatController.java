package com.ohot.temp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohot.home.dm.service.DmService;
import com.ohot.home.dm.vo.DmMsgVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
//	@Autowired
//	DmService dmService;
//
//	
//    @MessageMapping("/chat.sendMessage")  // /app/chat.sendMessage
//    @SendTo("/topic/public")              // 구독 주소
//    public void sendMessage(String message) {
//
//        System.out.println(message);
//    }
//    
}