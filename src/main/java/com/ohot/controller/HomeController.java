package com.ohot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.service.MemberService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	// 홈페이지
	@GetMapping("/oho")
	public String homePage(Model model
							, @AuthenticationPrincipal CustomUser customUser
			) {
			
			List<ArtistGroupVO> dmList = getDMList();
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", 1);
			map.put("end", 15);
			map.put("artGroupNo", 0);
			
			BoardPage<ArtistGroupVO> newArtistGroupList = getNewArtistGroupList(customUser, 1);
			
			BoardPage<ArtistGroupVO> joinArtistGroupList = null;
			List<ArtistGroupVO> artWithGoodsList = null ;
			List<GoodsVO> goodsVOList = null;
			if(customUser != null) {
				joinArtistGroupList = getjoinArtistGroupList(customUser, 1);
				
				artWithGoodsList = getArtWithGoodsList(customUser);
				goodsVOList = getGoodsList(map, customUser);
			}
				
			model.addAttribute("dmList", dmList);
			model.addAttribute("newArtistGroupList", newArtistGroupList);
			model.addAttribute("joinArtistGroupList", joinArtistGroupList);
			model.addAttribute("newArtistGroupList", newArtistGroupList);
			model.addAttribute("artWithGoodsList", artWithGoodsList);
			model.addAttribute("goodsVOList", goodsVOList);
		
			return "home";
	}
	
	// 새로운 아티스트를 만나보세요 페이징 비동기
	@ResponseBody
	@GetMapping("/oho/getNewArtistGroupList")
	public BoardPage<ArtistGroupVO> getNewArtistGroupList(
												@AuthenticationPrincipal CustomUser customUser
												, @RequestParam(required=true) int currentPage
											) {
		Map<String, Object> unMemMap = new HashMap<>();
		Map<String, Object> unjoinMap = new HashMap<>();
		
		int pageSize = 15;
		int start = (currentPage - 1) * pageSize + 1;
		int end = currentPage * pageSize;
		
		BoardPage<ArtistGroupVO> newArtistGroupList;
		
		if(customUser == null) {
			
			unMemMap.put("join", "no");
			unMemMap.put("memNo", null);
			unMemMap.put("start", start);
			unMemMap.put("end", end);
			
			List<ArtistGroupVO> resultList = this.memberService.getNewArtistGroupList(unMemMap);
			int totalCnt = resultList==null? 0 : resultList.get(0).getTotalCnt();
			newArtistGroupList = new BoardPage<>(totalCnt, currentPage, pageSize, null, resultList, null);
			
		} else {
			
			int memNo = (int) customUser.getUsersVO().getUserNo();
			
			// 가입하지 않은 그룹 리스트
			unjoinMap.put("join", "no");
			unjoinMap.put("memNo", memNo);
			unjoinMap.put("start", start);
			unjoinMap.put("end", end);
			List<ArtistGroupVO> resultList = this.memberService.getNewArtistGroupList(unjoinMap);
			
			int totalCnt = resultList.isEmpty() ? 0 : resultList.get(0).getTotalCnt();
			newArtistGroupList = new BoardPage<>(totalCnt, currentPage, pageSize, null, resultList, null);
			
		}
		
		return newArtistGroupList;
	}
	
	// 가입한 그룹 리스트 페이징 비동기
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@ResponseBody
	@GetMapping("/oho/getJoinArtistGroupList")
	public BoardPage<ArtistGroupVO> getjoinArtistGroupList(
											@AuthenticationPrincipal CustomUser customUser
											, @RequestParam(required=true) int currentPage
										) {
		Map<String, Object> joinMap = new HashMap<>();
		
		int pageSize = 5;
		int start = (currentPage - 1) * pageSize + 1;
		int end = currentPage * pageSize;
		
		BoardPage<ArtistGroupVO> joinArtistGroupList = null;
		
		// 가입한 그룹 리스트
		if(customUser != null) {
			int memNo = (int) customUser.getUsersVO().getUserNo();
			joinMap.put("join", "yes");
			joinMap.put("memNo", memNo);
			joinMap.put("start", start);
			joinMap.put("end", end);
			
			List<ArtistGroupVO> resultList = this.memberService.getJoinArtistGroupList(joinMap);
			int totalCnt = resultList.isEmpty() ? 0 : resultList.get(0).getTotalCnt();
			joinArtistGroupList = new BoardPage<>(totalCnt, currentPage, pageSize, null, resultList, null);
			joinArtistGroupList.setIsLastPage(end >= totalCnt);  // 마지막 페이지 여부 체크
		}
		
		return joinArtistGroupList;
	}
	
	// 굿즈 상품이 있는 그룹명리스트
	public List<ArtistGroupVO> getArtWithGoodsList(
								@AuthenticationPrincipal CustomUser customUser
							) {
		
		if(customUser != null) {
			List<ArtistGroupVO> artWithGoodsList = this.memberService.getArtWithGoods((int)customUser.getUsersVO().getUserNo());	
			return artWithGoodsList;
		}else {
			return null;
		}
		
	}
	
	// 굿즈샵 리스트 비동기
	@ResponseBody
	@GetMapping("/oho/getGoodsList")
	public List<GoodsVO> getGoodsList(@RequestParam Map<String, Object> params,
									@AuthenticationPrincipal CustomUser customUser
					) {
		if(customUser != null) {
			params.put("memNo", customUser.getUsersVO().getUserNo());

			if("0".equals(params.get("artGroupNo").toString())) { // artGroupNo=0 ===> 전체 리스트 출력
				params.put("artGroupNo", null);
			}
			
			List<GoodsVO> goodsList = this.memberService.getGoodsVOList(params);
			
			return goodsList;
		}else {
			return null;
		}
	}
	
	// DM List 리렌더링
	@ResponseBody
	@GetMapping("/oho/getDMList")
	public List<ArtistGroupVO> getDMList() {
		
		Map<String, Object> map = new HashMap<>();
		map.put("join", null);
		map.put("orderby", "random");
		map.put("start", 1);
		map.put("end", 10);
		
		List<ArtistGroupVO> dmList = this.memberService.getDmList(map);
		
		return dmList;
	}
	
	// 아티스트 그룹 검색
	@ResponseBody
	@GetMapping("/oho/searchArtGroupList")
	public List<ArtistGroupVO> searchArtGroupList(@RequestParam String keyword) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword.trim());
		map.put("join", null);
		
		List<ArtistGroupVO> searchArtGroupList = this.memberService.getDmList(map);
		
		return searchArtGroupList;
	}
	
}

