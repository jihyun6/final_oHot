package com.ohot.shop.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.shop.mapper.ShopMapper;
import com.ohot.shop.service.ShopService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.shop.vo.ShippingInfoVO;
import com.ohot.util.UploadController;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ShopImpl implements ShopService{
	
	@Autowired
	ShopMapper shopMapper;
	
	@Autowired
	UploadController uploadController;

	
	@Override
	public List<CommunityProfileVO> communityProfileBaseList() {
		return shopMapper.communityProfileBaseList();
	}
	
	@Override
	public List<CommunityProfileVO> communityProfileList(UsersVO usersVO) {
		return shopMapper.communityProfileList(usersVO);
	}
	
	@Override
	public List<ArtistGroupVO> artstGroupBaseList(List<Integer> artistGroupNoList) {
		// TODO Auto-generated method stub
		return shopMapper.artstGroupBaseList(artistGroupNoList);
	}
	
	@Override
	public List<ArtistGroupVO> artstGroupList(UsersVO usersVO) {
		return shopMapper.artstGroupList(usersVO);
	}

	@Override
	public GoodsVO goodsDetail(GoodsVO goodsVO) {
		return shopMapper.goodsDetail(goodsVO);
	}

	@Override
	public List<ArtistGroupVO> topArtistsList(int limit) {
		return shopMapper.topArtistsList(limit);
	}

	@Override
	public List<ArtistGroupVO> topArtistGoodsList(ArtistGroupVO artistGroupVO) {
		return shopMapper.topArtistGoodsList(artistGroupVO);
	}

	@Override
	public List<OrdersVO> getOrdersList(OrdersVO ordersVO) {
		return shopMapper.getOrdersList(ordersVO);
	}
	
	@Override
	public int shippingInfoInsert(ShippingInfoVO shippingInfoVO) {
		return shopMapper.shippingInfoInsert(shippingInfoVO);
	}

	@Override
	public List<ShippingInfoVO> getShippingInfoList(UsersVO usersVO) {
		return shopMapper.getShippingInfoList(usersVO);
	}

	@Override
	public ShippingInfoVO getShippingInfo(ShippingInfoVO shippingInfoVO) {
		return shopMapper.getShippingInfo(shippingInfoVO);
	}

	@Override
	public int shippingInfoUpdate(ShippingInfoVO shippingInfoVO) {
		return shopMapper.shippingInfoUpdate(shippingInfoVO);
	}

	@Override
	public int shippingInfoDelete(ShippingInfoVO shippingInfoVO) {
		return shopMapper.shippingInfoDelete(shippingInfoVO);
	}

	@Override
	public GoodsVO getMemberShip(GoodsVO goodsVO) {
		return shopMapper.getMemberShip(goodsVO);
	}

	@Override
	public List<GoodsVO> getGdsTypeList(GoodsVO goodsVO) {
		return shopMapper.getGdsTypeList(goodsVO);
	}

	@Override
	public Integer shippingInfoIsDefaultChecked(long userNo) {
		return shopMapper.shippingInfoIsDefaultChecked(userNo);
	}

	@Override
	public int shippingInfoIsDefaultUpdate(int isDefaultChkInt) {
		return shopMapper.shippingInfoIsDefaultUpdate(isDefaultChkInt);
	}

	@Override
	public List<GoodsVO> getComfirmGoodsVOList(List<GoodsVO> goodsVOList) {
		return shopMapper.getComfirmGoodsVOList(goodsVOList);
	}

	@Override
	public List<CommunityProfileVO> communityProfileListPage(Map<String, Object> data) {
		return shopMapper.communityProfileListPage(data);
	}

	@Override
	public List<ArtistGroupVO> artistGroupList() {
		return shopMapper.artistGroupList();
	}

	@Override
	public String getMemberShipCheck(CommunityProfileVO communityProfileVO) {
		return shopMapper.getMemberShipCheck(communityProfileVO);
	}

	@Override
	public CommunityProfileVO findComProfileNoCheck(MemberShopVO memberShopVO) {
		return shopMapper.findComProfileNoCheck(memberShopVO);
	}
}
