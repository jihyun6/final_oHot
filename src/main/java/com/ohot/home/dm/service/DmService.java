package com.ohot.home.dm.service;

import java.util.List;

import com.ohot.home.dm.vo.DmMsgVO;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.vo.ArtistGroupVO;

public interface DmService {

	public List<ArtistGroupVO> artGroupList(int memNo);

	public List<ArtistGroupVO> myArtistList(int memNo);

	//dm 구매이력확인 및 채팅방
	public List<DmSubVO> checkPurchaseDm(DmSubVO dmSubVO);

	//만료된 구독권 Y 처리
	public void resetExpiredDms();

	//웹소켓 메세지 저장
	public int saveMsg(DmMsgVO dmMsgVO);
	
	//아티스트 웹소켓 구독할 방번호들
	public List<DmSubVO> myFanList(int artNo);

	public List<DmMsgVO> lastChat(DmMsgVO dmMsgVO);

	public List<DmMsgVO> lastChatForArt(DmMsgVO dmMsgVO);

	public List<ArtistGroupVO> dmsearchFilter(int artGroupNo,String dmSrhKeyword);

	public int updateReadY(long dmSubNo);

}
