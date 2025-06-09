package com.ohot.shop.mapper;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.SeatVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.shop.vo.TkRsvtnVO;

@Mapper 
public interface TicketMapper {
	
	public List<GoodsVO> ticketList(String tkCtgr);

	public GoodsVO ticketDetail(GoodsVO goodsVO);

	public List<SeatVO> tkSeat(long tkDetailNo);
	
	public TicketVO seatTkDetail(long tkNo);

	public int tkRsvtn(TkRsvtnVO tkRsvtnVO);
	
	public int seatCurrentEnum(TkRsvtnVO tkRsvtnVO);

	public int countMemBought(int memNo, long tkDetailNo);

	public int resetUnpaidSeats();
	
	public int replyInsert(CommunityReplyVO communityReplyVO);

	public List<CommunityReplyVO> replyList(long tkNo);

	public int replyDelete(int replyNo);

	public int replyUpdate(CommunityReplyVO communityReplyVO);
}

