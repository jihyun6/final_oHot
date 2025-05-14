package com.ohot.shop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.shop.vo.CartVO;
import com.ohot.vo.UsersVO;

@Mapper
public interface CartMapper {

	public int cartInsert(CartVO cart);

	public List<CartVO> cartList(UsersVO usersVO);

	public int cartDelete(CartVO cartVO);

	public int cartDeleteList(List<CartVO> cartVOList);

	public int isAlreadyInCart(CartVO cartVO);

	public int cartUpdate(CartVO cartVO);

	public String getCartNo(UsersVO usersVO);

	//장바구니에 상품이 있는지 확인
	public int isAlreadyInCart2(CartVO cartVO);

}
