package com.ohot.home.live.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ohot.home.live.mapper.ChatMsgMapper;
import com.ohot.home.live.service.ChatMsgService;
import com.ohot.home.live.vo.ChatMsgVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatMsgServiceImpl implements ChatMsgService {

	private final ChatMsgMapper chatMsgMapper;
	
	@Override
	public int createChatMsg(ChatMsgVO chatMsgVO) {
		
		return chatMsgMapper.createChatMsg(chatMsgVO);
	}

	@Override
	public List<ChatMsgVO> getChatMsgListByStreamNo(int streamNo) {
		return chatMsgMapper.getChatMsgListByStreamNo(streamNo);
	}

	@Override
	public List<ChatMsgVO> getChatMsgList(int streamNo, int chatCount) {
		// TODO Auto-generated method stub
		return chatMsgMapper.getChatMsgList(streamNo, chatCount);
	}

}
