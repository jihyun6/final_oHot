package com.ohot.home.live.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatMsgVO {
	private int chatMsgNo;
	private int streamNo;
	private int artNo;
	private int memNo;
	private String chatCn;
	private Date chatSendDt;
	private int comProfileNo;
}
