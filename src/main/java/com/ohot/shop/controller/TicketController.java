package com.ohot.shop.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticatedPrincipal;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.community.vo.CommunityReplyVO;
import com.ohot.shop.service.TicketService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.SeatRsvtnVO;
import com.ohot.shop.vo.SeatVO;
import com.ohot.shop.vo.TicketVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.shop.vo.TkRsvtnVO;
import com.ohot.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/shop/ticket")
public class TicketController {
	
	@Autowired
	TicketService ticketService;
	
	//티켓 리스트 출력
	@GetMapping("/ticketList")
	public String ticketList(Model model,@RequestParam(value = "tkCtgr", required = false) String tkCtgr) {
		List<GoodsVO> goodsVOList = this.ticketService.ticketList(tkCtgr);
		log.info("ticketList -> GoodsVO : "+goodsVOList);
		
		model.addAttribute("goodsVOList", goodsVOList);
		
		
		return "ticket/ticketList";
	}
	
	@ResponseBody
	@PostMapping("/ticketListPost")
	public List<GoodsVO> ticketListPost(@RequestBody Map<String, String> param ,Model model) {
		String tkCtgr = param.get("tkCtgr");
	    log.info("tkCtgr: " + tkCtgr);
		List<GoodsVO> goodsVOList = this.ticketService.ticketList(tkCtgr);
		model.addAttribute("goodsVOList", goodsVOList);
		log.info("ticketList -> GoodsVO : "+goodsVOList);		
		
		return goodsVOList;
	}
	 
	//티켓 디테일
	@GetMapping("/ticketDetail")
	public String ticketDetail(Model model
			, @RequestParam(value="gdsNo") int gdsNo
			, GoodsVO goodsVO) {
		log.info("ticketDetail -> gdsNo: " +gdsNo);

		goodsVO = this.ticketService.ticketDetail(goodsVO);
		log.info("ticketDetail -> goodsVO: "+goodsVO);
		
		List<CommunityReplyVO> communityReplyVOList = this.ticketService.replyList(goodsVO.getTicketVO().getTkNo());
		log.info("ticketDetail -> communityReplyVO"+communityReplyVOList);
		
		model.addAttribute("goodsVO", goodsVO);
		model.addAttribute("communityReplyVOList", communityReplyVOList);
		
		return "ticket/ticketDetail";
	}
	@GetMapping("/seat")
	public String seat(long tkNo, long tkDetailNo, int artGroupNo,
	                   Model model,
	                   @AuthenticationPrincipal CustomUser customUser) {

	    int memNo = (int) customUser.getUsersVO().getUserNo();

	    // 좌석 및 예매 수 정보 가져오기
	    SeatRsvtnVO rsvtnVO = this.ticketService.tkSeat(tkDetailNo, memNo);

	    log.info("rsvtnVO: "+rsvtnVO);
	    model.addAttribute("seatVOList", rsvtnVO.getSeatVOList());
	    model.addAttribute("boughtCnt", rsvtnVO.getBoughtCnt());

	    // 좌석 구역
	    Set<String> sectionSet = rsvtnVO.getSeatVOList().stream()
	            .map(SeatVO::getSeatSection)
	            .collect(Collectors.toCollection(LinkedHashSet::new));
	    model.addAttribute("sectionList", new ArrayList<>(sectionSet));

	    // 층-구역 맵핑
	    Map<Integer, List<String>> floorSectionMap = new LinkedHashMap<>();
	    for (SeatVO seat : rsvtnVO.getSeatVOList()) {
	        floorSectionMap
	                .computeIfAbsent(seat.getSeatFloor(), k -> new ArrayList<>())
	                .add(seat.getSeatSection());
	    }
	    floorSectionMap.replaceAll((floor, sections) -> sections.stream().distinct().toList());
	    model.addAttribute("floorSectionMap", floorSectionMap);

	    // 회차 정보
	    TicketVO ticketVO = this.ticketService.seatTkDetail(tkNo);
	    log.info("ticketVO: "+ticketVO);
	    log.info("artGroupNo: "+artGroupNo);
	    log.info("tkDetailNo: "+tkDetailNo);
	    model.addAttribute("ticketVO", ticketVO);
	    model.addAttribute("artGroupNo", artGroupNo);
	    model.addAttribute("tkDetailNo", tkDetailNo);

	    return "ticket/seat";
	}
	
//	//티켓 좌석선택
//	@GetMapping("/seat")
//	public String seat(long tkNo, long tkDetailNo, int artGroupNo
//			,  Model model
//			, @AuthenticationPrincipal CustomUser customUser
//			) {
//
//		int memNo= (int)customUser.getUsersVO().getUserNo();
//		
//		//좌석정보
//		List<SeatVO> seatVOList = this.ticketService.tkSeat(tkDetailNo,memNo);
//		model.addAttribute("seatVOList", seatVOList);
//		log.info("seat->seatVOList : "+seatVOList);
//		
//		// 좌석 구역 이름 추출 (중복 제거)
//		Set<String> sectionSet = seatVOList.stream().map(SeatVO::getSeatSection)
//		    .collect(Collectors.toCollection(LinkedHashSet::new)); // 순서 유지
//		model.addAttribute("sectionList", new ArrayList<>(sectionSet));
//		log.info("이것인가"+sectionSet);
//		
//		// 2. 층별 - 구역별 Map 생성 (중복 제거)
//	    Map<Integer, List<String>> floorSectionMap = new LinkedHashMap();
//	    for (SeatVO seat : seatVOList) {
//	        floorSectionMap
//	            .computeIfAbsent(seat.getSeatFloor(), k -> new ArrayList<>())
//	            .add(seat.getSeatSection());
//	    }
//	    
//	    // 3. 각 층의 구역 리스트 중복 제거
//	    floorSectionMap.replaceAll((floor, sections) ->
//	        sections.stream().distinct().toList()
//	    );
//	    model.addAttribute("floorSectionMap", floorSectionMap);
//	    
//	    
//		//다른회차정보
//		TicketVO ticketVO =this.ticketService.seatTkDetail(tkNo);
//		model.addAttribute("ticketVO", ticketVO);
//		model.addAttribute("artGroupNo", artGroupNo);
//		model.addAttribute("tkDetailNo", tkDetailNo);
//		log.info("seat-> ticketVO: "+ticketVO);
//		
//		return "ticket/seat";
//	}
	
	@ResponseBody
	@PostMapping("/tkRsvtnPost")
	public ResponseEntity<String> tkRsvtnPost(@RequestBody SeatRsvtnVO seatRsvtnVO)  {
		log.info("tkRsvtnPost왔고 ->seatRsvtnVO:  "+seatRsvtnVO);
		try {

			this.ticketService.tkRsvtn(seatRsvtnVO);
			return ResponseEntity.ok("success");
			
		} catch (IllegalStateException  e) {
			log.warn("예매실패: "+e.getMessage());
			return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
			
		}catch (Exception   e) {
			log.warn("예외발생: "+e.getMessage());
			return ResponseEntity.status(HttpStatus.CONFLICT).body("예매중 오류가 발생했습니다");
		}
		
	}
	
	@ResponseBody
	@PostMapping("/replyInsert")
	public CommunityReplyVO replyInsert(@ModelAttribute CommunityReplyVO communityReplyVO) {
		log.info("replyPost실행"+communityReplyVO);
		
		this.ticketService.replyInsert(communityReplyVO);
		
		
		return communityReplyVO;
	}
	
	@ResponseBody
	@PostMapping("/replyDelete")
	public int replyDelete(@RequestParam int replyNo) {
		log.info("replyDelete 실행: "+replyNo);
		int result= this.ticketService.replyDelete(replyNo);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/replyUpdate")
	public int replyUpdate(@RequestBody CommunityReplyVO communityReplyVO) {
		log.info("communityReplyVO: "+communityReplyVO);
		
		int result=this.ticketService.replyUpdate(communityReplyVO);
		
		return result;
		
	}

	
}
