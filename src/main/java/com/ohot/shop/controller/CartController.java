package com.ohot.shop.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.mapper.SeqGeneratorMapper;
import com.ohot.shop.service.CartService;
import com.ohot.shop.vo.CartVO;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/shop")
public class CartController {
	
	@Autowired
	SeqGeneratorMapper seqGeneratorMapper;
	
	@Autowired
	CartService cartService;
	
	//장바구니를 추가 했을 때 실행되는 함수
	@ResponseBody
	@PostMapping("/cart/addAjax")
	public String cartAdd(ArtistGroupVO artistGroupVO, @AuthenticationPrincipal CustomUser customUser) {
		
		UsersVO usersVO = null;
		SeqGeneratorVO seqGeneratorVO = new SeqGeneratorVO();
		String cartNoStr;
		int cartNo;
		
		//로그인 체크
		if(customUser == null) {
			return "noLogin";
		}
		
		else {
			usersVO = customUser.getUsersVO();
			
			//1) 비워지지 않은 장바구니가 있는지 체킹 ==null?0:this.cartService.getCartNo(회원조건);
			cartNoStr = this.cartService.getCartNo(usersVO);
			
			if(cartNoStr != null) {//장바구니가 사용중이면 cartNo는 그대로 사용
				log.info("회원의 장바구니가 있습니다!");
				cartNo = Integer.parseInt(cartNoStr);  
				
			}else {//장바구니가 비었다면 새로 생성
				//***** 장바구니 번호(CART_NO) 생성 시작 ****************
				//장바구니 순번 가져오기
				// NULL or seqGeneratorVO return;
				seqGeneratorVO.setTaskSeNm("cart");
				seqGeneratorVO = seqGeneratorMapper.findSeqGenerator(seqGeneratorVO);
				
				// seqGenerator 값이 null인 경우
				if (seqGeneratorVO == null) {
					seqGeneratorVO = new SeqGeneratorVO();
					seqGeneratorVO.setTaskSeNm("cart");
					seqGeneratorMapper.updateSeqGeneratorDate(seqGeneratorVO);
					seqGeneratorVO = seqGeneratorMapper.findSeqGenerator(seqGeneratorVO);
					log.info("seqGeneratorVO : " + seqGeneratorVO);
				}
				cartNo = Integer.parseInt(seqGeneratorVO.getCrtrYmd() + seqGeneratorVO.getReqSn());
				//***** 장바구니 번호(CART_NO) 생성 끝 ****************
			}
			
			//장바구니 데이터 적재
			CartVO cartVO = new CartVO();
			cartVO.setCartNo(cartNo);
			cartVO.setGdsNo(artistGroupVO.getGoodsVOList().get(0).getGdsNo());
			cartVO.setMemNo(usersVO.getUserNo());
			cartVO.setQty(artistGroupVO.getGoodsVOList().get(0).getQty());
			cartVO.setProdOption(artistGroupVO.getGoodsVOList().get(0).getCommCodeGrpNo());
			cartVO.setAmount(artistGroupVO.getGoodsVOList().get(0).getAmount());
			
			/*
			CartVO(cartNo=2025041149, gdsNo=53, memNo=9, qty=1, amount=10900, prodOption=S, goodsVO=null)
			 */
			log.info("장바구니 cartVO : " + cartVO);
			
			//장바구니에 상품이 있는지 확인
			int isGdsNo2 = this.cartService.isAlreadyInCart(cartVO);
			//장바구니에 상품이 있는지 확인
			int isGdsNo = this.cartService.isAlreadyInCart2(cartVO);
			
			log.info("isGdsNo : " + isGdsNo);
			log.info("isGdsNo2 : " + isGdsNo2);
			
			int result = 0;
			if(isGdsNo > 0) {
				
				int maxQty = 100;
				if(maxQty < isGdsNo + cartVO.getQty()) {
					int temp = maxQty - isGdsNo;
					String str = String.valueOf(temp);
					return str;
				}else {
					//상품이 이미 있으면 업데이트
					result = cartService.cartUpdate(cartVO);
				}
				
			}else {
				result = cartService.cartInsert(cartVO, seqGeneratorVO);
			}
			
			log.info("artistGroupVO : " + artistGroupVO);
			
			if(result > 0) {
				return "success";
			}else {
				return "fail";
			}
		}
	}
	
	//로그인한 유저의 장바구니 목록 가져오기
	@GetMapping("/cart/list")
	public String cartList(Model model, @AuthenticationPrincipal CustomUser customUser) {
		UsersVO usersVO = null;
		
		//로그인 체크
		if(customUser == null) {
			return "noLogin";
		}	
		
		else {
			usersVO = customUser.getUsersVO();
			
			List<CartVO> cartList = cartService.cartList(usersVO);
			log.info("cartList" + cartList);
			model.addAttribute("cartList", cartList);
		}
		
		return "shop/cart/list";
		
	}
	
	//로그인한 유저의 요청한 상품을 장바구니에서 제거(단일상품)
	@ResponseBody
	@PostMapping("/cart/delete")
	public String cartDelete(@RequestBody GoodsVO goodVO, @AuthenticationPrincipal CustomUser customUser) {
		
		log.info("goodVO : " + goodVO);
		
		UsersVO usersVO = null;
		CartVO cartVO = new CartVO();
		
		//로그인 체크
		if(customUser == null) {
			return "noLogin";
		}	
		
		else {
			usersVO = customUser.getUsersVO();
			cartVO.setGdsNo(goodVO.getGdsNo());
			cartVO.setMemNo(usersVO.getUserNo());
			
			//option이 있을 경우
			if(goodVO.getCommCodeGrpNo() != null) {
				log.info("상품옵션 : " + goodVO.getCommCodeGrpNo());
				cartVO.setProdOption(goodVO.getCommCodeGrpNo());
			}
			
			int result = cartService.cartDelete(cartVO);
			if(result > 0) {
				return "success";
			}else {
				return "fail";
			}
		}
	}
	
	// 로그인한 유저가 요청한 상품(List)를 장바구니에서 제거
	@ResponseBody
	@PostMapping("/cart/deleteList")
	public String cartDeleteList(@RequestBody List<GoodsVO> gdsNoList, @AuthenticationPrincipal CustomUser customUser) {

		log.info("gdsNoList : " + gdsNoList);
		
		List<CartVO> cartVOList = new ArrayList<CartVO>();
		
		UsersVO usersVO = null;
		
		
		//로그인 체크
		if(customUser == null) {
			return "noLogin";
		}	
		
		else {
			usersVO = customUser.getUsersVO();
			
			//gdsNoList(체크박스에 저장된 값을 꺼내서 cartVO에 담고 CartVOList에 추가)
			for(int i=0;i<gdsNoList.size();i++) {
				CartVO cartVO = new CartVO();
				cartVO.setGdsNo(gdsNoList.get(i).getGdsNo());
				cartVO.setProdOption(gdsNoList.get(i).getCommCodeGrpNo());
				cartVO.setMemNo(usersVO.getUserNo());
				cartVOList.add(cartVO);
			}
			
			log.info("cartVOList : " + cartVOList);
			
			int result = cartService.cartDeleteList(cartVOList);
			if(result > 0) {
				return "success";
			}else {
				return "fail";
			}
		}
	}
}