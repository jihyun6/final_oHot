package com.ohot.shop.service;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

public interface PaymentService {
	public int ordersInsert(OrdersVO ordersVO, SeqGeneratorVO seqGeneratorVO);

	public OrdersVO getLatestOrder(UsersVO usersVO);

	public CommunityProfileVO findComProfileNo(MemberShopVO memberShopVO);

	public int memberShipInsert(MemberShopVO memberShopVO);

	public int CommunityProfileUpdate(CommunityProfileVO communityProfileVO);

	public int UpdateOrdersComplete(OrdersVO ordersVO);
}
