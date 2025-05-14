package com.ohot.home.live.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.live.vo.ChatMsgVO;

@Mapper
public interface ChatMsgMapper {

	// 채팅 저장
	public int createChatMsg(ChatMsgVO chatMsgVO);
	
	// 방송별 채팅리스트 조회
	public List<ChatMsgVO> getChatMsgListByStreamNo(int streamNo);
	
	// 채팅 내역 수 기준 채팅 조회
	public List<ChatMsgVO> getChatMsgList(int streamNo, int chatCount);
	
}
