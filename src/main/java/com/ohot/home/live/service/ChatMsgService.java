package com.ohot.home.live.service;

import java.util.List;

import com.ohot.home.live.vo.ChatMsgVO;

public interface ChatMsgService {

    public int createChatMsg(ChatMsgVO chatMessageVO);
    
    public List<ChatMsgVO> getChatMsgListByStreamNo(int streamNo);
   
    public List<ChatMsgVO> getChatMsgList(int streamNo, int limit);
    
}
