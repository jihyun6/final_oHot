package com.ohot.shop.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.home.dm.vo.DmSubVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.vo.UsersVO;

@Mapper
public interface PaymentMapper {

	public int ordersInsert(OrdersVO ordersVO);

	public int ordersDetailInsert(OrdersVO ordersVO);

	public OrdersVO getLatestOrder(UsersVO usersVO);

	public CommunityProfileVO findComProfileNo(MemberShopVO memberShopVO);

	public int memberShipInsert(MemberShopVO memberShopVO);

	public int CommunityProfileUpdate(CommunityProfileVO communityProfileVO);

	public DmSubVO ordersDetailSelect(int orderNo);

	public int UpdateOrdersComplete(OrdersVO ordersVO);
	
}
