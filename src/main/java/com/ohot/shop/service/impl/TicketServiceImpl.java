package com.ohot.shop.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.shop.mapper.TicketMapper;
import com.ohot.shop.service.TicketService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.SeatRsvtnVO;
import com.ohot.shop.vo.SeatVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkRsvtnVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TicketServiceImpl implements TicketService{
	
	@Autowired
	TicketMapper ticketMapper;
	
	@Override
	public List<GoodsVO> ticketList(String tkCtgr) {
		// TODO Auto-generated method stub
		return this.ticketMapper.ticketList(tkCtgr);
	}

	@Override
	public GoodsVO ticketDetail(GoodsVO goodsVO) {
		// TODO Auto-generated method stub
		return this.ticketMapper.ticketDetail(goodsVO);
	}


	@Override
	public SeatRsvtnVO tkSeat(long tkDetailNo, int memNo) {

		//예매 갯수 제한
		int boughtCnt=this.ticketMapper.countMemBought(memNo, tkDetailNo);
		
		//좌석정보
		List<SeatVO> seatVOList= this.ticketMapper.tkSeat(tkDetailNo);
		
		SeatRsvtnVO rsvtnVO = new SeatRsvtnVO();
		rsvtnVO.setSeatVOList(seatVOList);
		rsvtnVO.setBoughtCnt(boughtCnt);
		rsvtnVO.setMemNo(memNo);
		rsvtnVO.setTkDetailNo(tkDetailNo);
		
		return rsvtnVO;
	}

	@Override
	public TicketVO seatTkDetail(long tkNo) {
		// TODO Auto-generated method stub
		return this.ticketMapper.seatTkDetail(tkNo);
	}

	@Override
	@Transactional(rollbackFor = {IOException.class, 
			SQLException.class, IllegalStateException.class,
			DataAccessException.class, NullPointerException.class})
	public int tkRsvtn(SeatRsvtnVO seatRsvtnVO)  {
	
		int inserted=0;
		
		try {
			
			long tkDetailNo =seatRsvtnVO.getTkDetailNo();
			int memNo = seatRsvtnVO.getMemNo();
			
			TkRsvtnVO tkRsvtnVO =new TkRsvtnVO();
			tkRsvtnVO.setTkDetailNo(tkDetailNo);
			tkRsvtnVO.setMemNo(memNo);
			
			List<SeatVO> seatVOList = seatRsvtnVO.getSeatVOList();
			for(SeatVO seat: seatVOList) {
				String seatNo= seat.getSeatNo();
				tkRsvtnVO.setSeatNo(seatNo);
				
				//예매된 좌석인지 확인
				int seatCurrentEnum = this.ticketMapper.seatCurrentEnum(tkRsvtnVO);
				if(seatCurrentEnum>0) {
					log.warn("이미 예매된 좌석번호: "+seatNo);
					throw new IllegalStateException("이미 선택된 좌석입니다");
				}else {
				
					//예매진행
					inserted= this.ticketMapper.tkRsvtn(tkRsvtnVO);
					if(inserted==0) {
						log.error("예매실패 - Insert 실패");
						throw new SQLException("예매 중 오류가 발생했습니다");
					}
					inserted++;
				
				}
				log.info("티켓 구매 매수:"+inserted);

			}
		} catch (NullPointerException e) {
	        log.error("예매 실패 - Null 발생: " + e.getMessage(), e);
	        throw new IllegalStateException("예매실패 - 데이터가 누락되었습니다");
	    } catch (Exception e) {
	        log.error("예매 실패 - 예상치 못한 예외", e);
	        throw new RuntimeException("예매 중 알 수 없는 오류가 발생했습니다");
	    }
		return inserted;
		
	}

	@Override
	public int replyInsert(CommunityReplyVO communityReplyVO) {
		// TODO Auto-generated method stub
		return this.ticketMapper.replyInsert(communityReplyVO);
	}

	@Override
	public List<CommunityReplyVO> replyList(long tkNo) {
		// TODO Auto-generated method stub
		return this.ticketMapper.replyList(tkNo);
	}

	@Override
	public int replyDelete(int replyNo) {
		// TODO Auto-generated method stub
		return this.ticketMapper.replyDelete(replyNo);
	}

	@Override
	public int replyUpdate(CommunityReplyVO communityReplyVO) {
		// TODO Auto-generated method stub
		return this.ticketMapper.replyUpdate(communityReplyVO);
	}

	@Override
	public void resetUnpaidSeats() {
		int count = ticketMapper.resetUnpaidSeats();
		log.debug("초기화된 좌석 수: " + count);
	}
	

}
