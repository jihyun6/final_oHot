package com.ohot.shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ohot.mapper.SeqGeneratorMapper;
import com.ohot.shop.mapper.CartMapper;
import com.ohot.shop.service.CartService;
import com.ohot.shop.vo.CartVO;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	CartMapper cartMapper;
	
	@Autowired
	SeqGeneratorMapper seqGeneratorMapper;
	
	@Override
	public int cartInsert(CartVO cart) {
		
		return cartMapper.cartInsert(cart);
	}

	@Transactional
	@Override
	public int cartInsert(CartVO cart, SeqGeneratorVO seqGeneratorVO) {
		
		int result = cartMapper.cartInsert(cart);
		
		if(result > 0) {
			seqGeneratorMapper.incrementSeqGenerator(seqGeneratorVO);
		}
		
		return result;
	}

	@Override
	public List<CartVO> cartList(UsersVO usersVO) {
		return cartMapper.cartList(usersVO);
	}

	@Override
	public int cartDelete(CartVO cartVO) {
		return cartMapper.cartDelete(cartVO);
	}

	@Override
	public int cartDeleteList(List<CartVO> cartVOList) {
		return cartMapper.cartDeleteList(cartVOList);
	}

	@Override
	public int isAlreadyInCart(CartVO cartVO) {
//		CartVO(cartNo=2025041149, gdsNo=53, memNo=9, qty=1, amount=10900, prodOption=S, goodsVO=null)
		int result = this.cartMapper.isAlreadyInCart(cartVO);
		log.info("isAlreadyInCart->result : " + result);
		return result;
	}

	@Override
	public int cartUpdate(CartVO cartVO) {
		return cartMapper.cartUpdate(cartVO);
	}

	@Override
	public String getCartNo(UsersVO usersVO) {
		return cartMapper.getCartNo(usersVO);
	}

	//장바구니에 상품이 있는지 확인
	@Override
	public int isAlreadyInCart2(CartVO cartVO) {
		return this.cartMapper.isAlreadyInCart2(cartVO);
	}
}
