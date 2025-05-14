package com.ohot.shop.service;

import java.util.List;
import java.util.Map;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.shop.vo.ShippingInfoVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.UsersVO;

public interface ShopService {
	public List<CommunityProfileVO> communityProfileBaseList();

	public List<CommunityProfileVO> communityProfileList(UsersVO usersVO);

	public List<ArtistGroupVO> artstGroupList(UsersVO usersVO);
	
	public List<ArtistGroupVO> artstGroupBaseList(List<Integer> artistGroupNoList);

	public GoodsVO goodsDetail(GoodsVO goodsVO);

	public List<ArtistGroupVO> topArtistsList(int limit);

	public List<ArtistGroupVO> topArtistGoodsList(ArtistGroupVO artistGroupVO);

	public List<OrdersVO> getOrdersList(OrdersVO ordersVO);

	public int shippingInfoInsert(ShippingInfoVO shippingInfoVO);

	public List<ShippingInfoVO> getShippingInfoList(UsersVO usersVO);

	public ShippingInfoVO getShippingInfo(ShippingInfoVO shippingInfoVO);

	public int shippingInfoUpdate(ShippingInfoVO shippingInfoVO);

	public int shippingInfoDelete(ShippingInfoVO shippingInfoVO);

	public GoodsVO getMemberShip(GoodsVO goodsVO);

	public List<GoodsVO> getGdsTypeList(GoodsVO goodsVO);

	public Integer shippingInfoIsDefaultChecked(long userNo);

	public int shippingInfoIsDefaultUpdate(int isDefaultChkInt);

	public List<GoodsVO> getComfirmGoodsVOList(List<GoodsVO> goodsVOList);

	public List<CommunityProfileVO> communityProfileListPage(Map<String, Object> data);

	public List<ArtistGroupVO> artistGroupList();

	public String getMemberShipCheck(CommunityProfileVO communityProfileVO);

	public CommunityProfileVO findComProfileNoCheck(MemberShopVO memberShopVO);
	
}