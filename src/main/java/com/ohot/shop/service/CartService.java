package com.ohot.shop.service;

import java.util.List;

import com.ohot.shop.vo.CartVO;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

public interface CartService {

	public int cartInsert(CartVO cart);

	public int cartInsert(CartVO cart, SeqGeneratorVO seqGeneratorVO);

	public List<CartVO> cartList(UsersVO usersVO);

	public int cartDelete(CartVO cartVO);

	public int cartDeleteList(List<CartVO> cartVOList);

	public int isAlreadyInCart(CartVO cartVO);

	public int cartUpdate(CartVO cartVO);

	public String getCartNo(UsersVO usersVO);

	//장바구니에 상품이 있는지 확인
	public int isAlreadyInCart2(CartVO cartVO);
	
}
