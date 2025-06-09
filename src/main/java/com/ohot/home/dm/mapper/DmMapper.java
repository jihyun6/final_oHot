package com.ohot.home.dm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ohot.home.dm.vo.DmMsgVO;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.vo.ArtistGroupVO;

@Mapper
public interface DmMapper {

	public List<ArtistGroupVO> artGroupList(int memNo);

	public List<ArtistGroupVO> myArtistList(int memNo);

	public int dmSubInsert(DmSubVO dmSubVO);

	public List<DmSubVO> checkPurchaseDm(DmSubVO dmSubVO);

	public int resetExpiredDms();

	public int saveMsg(DmMsgVO dmMsgVO);
	
	public List<DmSubVO> myFanList(int artNo);

	public List<DmMsgVO> lastChat(DmMsgVO dmMsgVO);

	public List<DmMsgVO> lastChatForArt( DmMsgVO dmMsgVO );

	public List<ArtistGroupVO> dmsearchFilter(@Param("artGroupNo") int artGroupNo, @Param("dmSrhKeyword") String dmSrhKeyword);

	public int getGdsNoAfterY(int orderNo);

	public int updateReadY(long dmSubNo);
	
	

}
