package com.ohot.shop.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.SeatRsvtnVO;
import com.ohot.shop.vo.SeatVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.shop.vo.TkRsvtnVO;

public interface TicketService {

	//티켓 전체 목록 출력
	public List<GoodsVO> ticketList(String tkCtgr);

	public GoodsVO ticketDetail(GoodsVO goodsVO);

	public SeatRsvtnVO tkSeat(long tkDetailNo, int memNo);
	
	public TicketVO seatTkDetail(long tkNo);

	public int tkRsvtn(SeatRsvtnVO seatRsvtnVO) ;

	public int replyInsert(CommunityReplyVO communityReplyVO);

	public List<CommunityReplyVO> replyList(long tkNo);

	public int replyDelete(int replyNo);

	public int replyUpdate(CommunityReplyVO communityReplyVO);

	public void resetUnpaidSeats();



}
