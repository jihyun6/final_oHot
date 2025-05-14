package com.ohot.home.alarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.ohot.home.alarm.service.AlarmService;
import com.ohot.home.alarm.vo.AlarmVO;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.home.community.vo.LikeDetailVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AlarmWebSocketController {

	@Autowired
	SimpMessagingTemplate messagingTemplate;
	
	@Autowired
	AlarmService alarmService;
	
	
	@MessageMapping("/alarm/fromPost")
	public ResponseEntity<String> alarmFromPost(AlarmVO alarmVO){
		
		NotificationVO notificationVO = new NotificationVO();

		//포스트에서 날라올때
		CommunityPostVO postVO = alarmVO.getCommunityPostVO();
		if ( postVO != null && postVO.getBoardNo() != 0 ) {
			notificationVO.setNotiSndrNo(alarmVO.getCommunityPostVO().getArtGroupNo());
			notificationVO.setNotiOrgNo(alarmVO.getCommunityPostVO().getBoardNo());
			notificationVO.setNotiOrgTb("COMMUNITY_POST");
			log.info("포스트 실시간 실행"+notificationVO);
		}
		
		//댓글에서 날라올때
		CommunityReplyVO replyVo = alarmVO.getCommunityReplyVO();
		if( replyVo!= null && replyVo.getReplyNo() != 0 ) {
			notificationVO.setNotiSndrNo(replyVo.getArtGroupNo());
			notificationVO.setNotiOrgNo(replyVo.getReplyNo());
			notificationVO.setNotiOrgTb("COMMUNITY_REPLY");
			log.info("댓글 실시간 실행"+notificationVO);
		}
		
		//좋아요에서 날라올때
		LikeDetailVO likeDetailVO = alarmVO.getLikeDetailVO();
		if(likeDetailVO !=null && likeDetailVO.getLikeNo() !=0 ) {
			//엄청난 사건 여기는 DB에 artGroupNo 존재 하지 않음 
			notificationVO.setNotiSndrNo(likeDetailVO.getArtGroupNo());
			notificationVO.setNotiOrgNo(likeDetailVO.getLikeNo());
			notificationVO.setNotiOrgTb("LIKE");
		}

		List<NotificationVO> notiList= this.alarmService.forRealTimeAlarm(notificationVO);
		
		for(NotificationVO vo : notiList) {
			
			log.info("커뮤니티 사람들에게 알림전송시작");
			int rcvrNo =vo.getNotiRcvrNo();
			
			messagingTemplate.convertAndSend("/toAll/memNo/"+rcvrNo, vo);
			
		}
		return ResponseEntity.ok("글 작성 + 알림 전송 완료");
	}

	
}
