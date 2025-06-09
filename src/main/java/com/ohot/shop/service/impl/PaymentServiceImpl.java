package com.ohot.shop.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.dm.mapper.DmMapper;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.mapper.SeqGeneratorMapper;
import com.ohot.shop.mapper.PaymentMapper;
import com.ohot.shop.service.PaymentService;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersDetailsVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentServiceImpl implements PaymentService{
	
	@Autowired
	PaymentMapper paymentMapper;
	
	@Autowired
	SeqGeneratorMapper seqGeneratorMapper;
	
	@Autowired
	DmMapper dmMapper;
	
	@Override
	@Transactional
	public int ordersInsert(OrdersVO ordersVO, SeqGeneratorVO seqGeneratorVO) {
		
		log.info("ordersVO" + ordersVO);
		
		//1. OrdersVO Insert
		int ordersInsert = paymentMapper.ordersInsert(ordersVO);
		
		//2. OrdersVODetail Insert
		int seq = 1;
		
		//2-1) 꺼내서
		List<OrdersDetailsVO> ordersDetailsVOList = ordersVO.getOrdersDetailsVOList();
		//SEQ 채워주기(ORDERS_DETAILS 테이블의 GDS_NO, ORDER_NO, SEQ 컬럼은 복합키임)
		for(OrdersDetailsVO ordersDetailsVO : ordersDetailsVOList) {
			//2-2) 일련번호 처리 후
			ordersDetailsVO.setSeq(seq++);
		}
		//2-3) 다시 ordersVO에 넣어줌
		ordersVO.setOrdersDetailsVOList(ordersDetailsVOList);
		
		int ordersDetailInsert = paymentMapper.ordersDetailInsert(ordersVO);
		
		
		//순번 증가
		seqGeneratorMapper.incrementSeqGenerator(seqGeneratorVO);
		
		return ordersInsert;
	}

	@Override
	public OrdersVO getLatestOrder(UsersVO usersVO) {
		return paymentMapper.getLatestOrder(usersVO);
	}

	@Override
	public CommunityProfileVO findComProfileNo(MemberShopVO memberShopVO) {
		return paymentMapper.findComProfileNo(memberShopVO);
	}

	@Override
	public int memberShipInsert(MemberShopVO memberShopVO) {
		return paymentMapper.memberShipInsert(memberShopVO);
	}

	@Override
	public int CommunityProfileUpdate(CommunityProfileVO communityProfileVO) {
		return paymentMapper.CommunityProfileUpdate(communityProfileVO);
	}

	@Override
	@Transactional(rollbackFor = {IOException.class, SQLException.class, IllegalStateException.class})
	public int UpdateOrdersComplete(OrdersVO ordersVO) {
		
		int completeDmOrders = paymentMapper.UpdateOrdersComplete(ordersVO);
		int dmResult=0;
		
		//결제 최종 승인되고 gdsNo=98이면 dm_sub 업데이트
		if(completeDmOrders !=0 && "Y".equals(ordersVO.getStlmYn())) {
			log.info("결제완료후 정보가 담기나요? "+ordersVO);
			
			//gdsNo 받으러 갔다와야함
			int gdsNoDm = this.dmMapper.getGdsNoAfterY(ordersVO.getOrderNo());
			
			if(gdsNoDm==98) {
				
				//dm 주문정보가져오기
				DmSubVO dmSubVO = this.paymentMapper.ordersDetailSelect(ordersVO.getOrderNo());
				dmResult=this.dmMapper.dmSubInsert(dmSubVO);
				
				if(dmResult==0) {
					throw new IllegalStateException("dm 월구독권 결제 실패");
				}else {
					
					return dmResult;
				}
				
			}
		}
				
		return completeDmOrders;
	}

}
