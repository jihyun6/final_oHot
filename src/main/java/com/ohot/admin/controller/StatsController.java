package com.ohot.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.service.StatsService;
import com.ohot.util.ArticlePage;
import com.ohot.util.Pazing;
import com.ohot.vo.ReportmanageVO;
import com.ohot.vo.StatsVO;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class StatsController {
	
	@Autowired StatsService statsservice;
	 

	@GetMapping("/stats/list")
	public String list(Model model ,StatsVO statsVO ) {
		
		List<StatsVO> statsList = this.statsservice.statsList(statsVO);
		List<StatsVO> SubscriptionTotal = this.statsservice.SubscriptionTotal(statsVO);
		List<StatsVO> memberTotal = this.statsservice.memberTotal(statsVO);
		List<StatsVO> FollowersTotal = this.statsservice.FollowersTotal(statsVO);
		List<StatsVO> goodTotal = this.statsservice.goodTotal(statsVO);
		List<StatsVO> goodcnt = this.statsservice.goodcnt(statsVO);
		List<StatsVO> goodNm = this.statsservice.goodNm(statsVO);
		List<StatsVO> salesVolume = this.statsservice.salesVolume(statsVO);
		List<StatsVO> totalSales = this.statsservice.totalSales(statsVO);
		List<StatsVO> reservationTotalSales = this.statsservice.reservationTotalSales(statsVO);
		List<StatsVO> concertSales = this.statsservice.concertSales(statsVO);
		List<StatsVO> fanSales = this.statsservice.fanSales(statsVO);
		List<StatsVO> restSales = this.statsservice.restSales(statsVO);
		List<StatsVO> reportTotal = this.statsservice.reportTotal(statsVO);
		
		/* 판매수 List<StatsVO> volume = this.statsservice.volume(statsVO); */
		
		log.info("SubscriptionTotal========================================== : " + SubscriptionTotal);
		log.info("memberTotal========================================== : " + memberTotal);
		log.info("FollowersTotal========================================== : " + FollowersTotal);
		log.info("goodTotal========================================== : " + goodTotal);
		log.info("concertSales========================================== : " + concertSales);
		
		/* log.info("volume========================================== : " + volume); */
		
		
		
		model.addAttribute("statsList",statsList);
		model.addAttribute("SubscriptionTotal",SubscriptionTotal);
		model.addAttribute("memberTotal",memberTotal);
		model.addAttribute("FollowersTotal",FollowersTotal);
		model.addAttribute("goodTotal",goodTotal); 
		model.addAttribute("goodcnt",goodcnt); 
		model.addAttribute("goodNm",goodNm); 
		model.addAttribute("salesVolume",salesVolume); 
		model.addAttribute("totalSales",totalSales); 
		model.addAttribute("reservationTotalSales",reservationTotalSales);
		model.addAttribute("concertSales",concertSales);
		model.addAttribute("fanSales",fanSales);
		model.addAttribute("restSales",restSales);
		model.addAttribute("reportTotal",reportTotal);
		log.info("SubscriptionTotal========================================== : " + SubscriptionTotal);
		log.info("memberTotal========================================== : " + memberTotal);
		log.info("FollowersTotal========================================== : " + FollowersTotal);
		log.info("goodTotal========================================== : " + goodTotal);
		log.info("totalSales========================================== : " + totalSales);
		log.info("concertSales========================================== : " + concertSales);
		
		return "admin/stats/list";
	}
	
	

	@ResponseBody
	@PostMapping("/stats/listAjax")
	public List<StatsVO> listAjax(StatsVO statsVO) {
		
	
		List<StatsVO> statsList = this.statsservice.statsList(statsVO);
		
		log.info("listAjax->statsList : " + statsList);
		
		return statsList;
	}
//	다음꺼양

	@ResponseBody
	@PostMapping("/stats/listBarAjax")
	public List<StatsVO> listBarAjax(StatsVO statsVO) {
		
	
		List<StatsVO> listBarAjax = this.statsservice.listBarAjax(statsVO);
		
		log.info("statsList2 : " + listBarAjax);
		
		return listBarAjax;
	}
	
	
		

	
	
	@ResponseBody
	@GetMapping("/admin/stats/memberSignUp")
	public String memberSignUp (
			HttpServletRequest request, HttpServletResponse response
			){
		
		return "admin/stats/memberSignUp";
	}
	
	//회원
	@ResponseBody
	@PostMapping("/stats/listMemberAjax")
	public List<StatsVO> listMemberAjax(StatsVO statsVO,Model model) {
		
		List<StatsVO> listMemberAjax = this.statsservice.listMemberAjax(statsVO);
		
		model.addAttribute("listMemberAjax",listMemberAjax);
		
		log.info("List->listMemberAjax : " + listMemberAjax);
		
		return listMemberAjax;
	}
	
	//커뮤니티 통계
	
	 @ResponseBody
	 @GetMapping("/admin/stats/communityMember") public String communityMember
	 (HttpServletRequest request, HttpServletResponse response, Model
	 model,StatsVO statsVO){
	 
		 List<StatsVO> communityMember = this.statsservice.communityMember(statsVO);
		 log.info("communityMember -> communityMember : ",communityMember);
		 
		 
		 model.addAttribute("communityMember",communityMember);
		 
		 
		 return "admin/stats/communityMember"; 
	 }
	 
	 //이번달 티켓 굿즈 디엠 멤버십 현황
	 @ResponseBody
	@PostMapping("/stats/listdoughnutAjax")
	public StatsVO listdoughnutAjax(StatsVO statsVO,Model model) {
		
		
		StatsVO listdoughnutAjax = this.statsservice.listdoughnutAjax(statsVO);
		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("listdoughnutAjax", listdoughnutAjax)   ;
//		log.info("listdoughnutAjax->map : " + map);
		model.addAttribute("listdoughnutAjax",listdoughnutAjax);
		log.info("listdoughnutAjax========================================== : " + listdoughnutAjax);
		
		return listdoughnutAjax;
	}
	 
	 //커뮤니티 통계 티켓 굿즈 디엠 멤버쉽
	 @ResponseBody
	 @PostMapping("/stats/listdoughnutAjax2")
	 public List<StatsVO> listdoughnutAjax2(StatsVO statsVO) {
		 
		 
		 List<StatsVO> listdoughnutAjax2 = this.statsservice.listdoughnutAjax2(statsVO);
		 
		 HashMap<String, Object> map = new HashMap<String, Object>();
		 map.put("listdoughnutAjax2", listdoughnutAjax2)   ;
		 log.info("listdoughnutAjax->map : " + map);
		 
		 log.info("statsList3========================================== : " + listdoughnutAjax2);
		 
		 return listdoughnutAjax2;
	 }
	
	//굿즈매출통계
	@GetMapping("/stats/goodsStatistics")
	public String GoodsStatistics(StatsVO statsVO, Model model
			, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage
			, @RequestParam(value="keyword",required=false,defaultValue="") String keyword
			) {
		
		//페이징 및 검색
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);	
		//map{currentPage:2,keyword:""}
		log.info("list2->map : " + map);
		
		//1. total
		int total = this.statsservice.getTotal(map);
		log.info("list2->total : " + total);//79
		
		int size = 10;
		
		List<StatsVO> goodsStatistics = this.statsservice.goodsStatistics(map);
		log.info("goodsStatistics->goodsStatistics : " + goodsStatistics);
		
		model.addAttribute("goodsStatistics", goodsStatistics);
		
		ArticlePage<StatsVO> articlePage = 
				new ArticlePage<StatsVO>(total, currentPage, size, keyword, goodsStatistics);
		
		log.info("list2->articlePage : " + articlePage);
		
		model.addAttribute("articlePage", articlePage);
		
		List<StatsVO> topList = this.statsservice.topList(statsVO);
		log.info("list2->topList : " + topList);
		
		model.addAttribute("topList", topList);
		
		return "admin/stats/goodsStatistics";
	}	
		
	//아이돌 인기top6사진 업로드
	@ResponseBody
	@PostMapping("/stats/idolPost")
	public List<StatsVO> editPost(StatsVO statsVO) {
	
		 
		log.info("editPost->statsVO(전) : " + statsVO);
		
		List<StatsVO> result = this.statsservice.editPost(statsVO);
		log.info("editPost->result : " + result);

		log.info("registerPost->statsVO(후) : " + statsVO);
		
		
		 
		return result;
		
	}
	@ResponseBody
	@GetMapping("/stats/GoodsStatistics")
	public List<StatsVO> GoodsStatisticsAjax(StatsVO statsVO) {
		
	
		List<StatsVO> GoodsStatistics = this.statsservice.GoodsStatisticsAjax(statsVO);
		
		log.info("listAjax->statsList : " + GoodsStatistics);
		
		return GoodsStatistics;
	}

	//커뮤티니티 통계
	@GetMapping("/stats/subscription")
	public String subscription(StatsVO statsVO, Model model,
			 @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
	         @RequestParam(value="keyword",required=false,defaultValue="") String keyword
			) {
		List<StatsVO> totalSales = this.statsservice.totalSales(statsVO);
		  
		  Map<String,Object> map = new HashMap<String,Object>();
		  map.put("currentPage", currentPage);
	      map.put("keyword", keyword);

	      //map{currentPage=1}
	      log.info("subscription->map : " + map);
	      
	    //전체 글 수(검색 포함)
	      int total = this.statsservice.pazing(map);
	      log.info("subscription->total : " + total);
	      
	     
	      
			/*
			 * Pazing<StatsVO> pazing = new Pazing(total, currentPage, 8, keyword, null)<>;
			 * log.info("books->articlePage : " + pazing);
			 */
	      
	      model.addAttribute("totalSales", "totalSales");
	      model.addAttribute("title", "페이징");
			/* model.addAttribute("pazing", pazing); */
	        
	      
	      
	      return "/admin/stats/subscription";
	}	

	//날짜 검색*******
		//datas{"startDate": "","endDate": "","page": 1,"blockSize": 10,"startRow": 1,"endRow": 10}
//	RequestParam(value="startDate",required=false,defaultValue="") String startDate,
//	RequestParam(value="endDate",required=false,defaultValue="") String endDate,
//	RequestParam(value="page",required=false,defaultValue="1") int page,
//	RequestParam(value="blockSize",required=false,defaultValue="10") int blockSize,
//	RequestParam(value="startRow",required=false,defaultValue="1") int startRow,
//	RequestParam(value="endRow",required=false,defaultValue="10") int endRow) {
	@ResponseBody
	@PostMapping("/stats/dateSubscriptionAjax") 
	public Map<String,Object> dateSubscriptionAjax(StatsVO statsVO){
		
		log.info("statsVO : " + statsVO);
		/*
		StatsVO(..startDate=2025-04-01,..., startRow=1, endRow=10)
		 */
		log.info("(개똥이)subscriptionTotal->statsVO : " + statsVO);
		
		//0) 1) + 2)
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		//1) 굿즈, 티켓 통계
		List<StatsVO> subscriptionList = this.statsservice.subscriptionList(statsVO);
		log.info("subscriptionTotal->subscriptionList : " + subscriptionList);
		
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		
		if(statsVO.getGubun().equals("GD02")) {
			//2) 티켓 -> 티켓예매 매출(*)
			//총매출, 콘서트, 팬미팅, 기타 매출 
			mapList = this.statsservice.subscriptionStatList(statsVO);
			log.info("subscriptionTotal->mapList : " + mapList);
		}
		
		resultMap.put("stat1", subscriptionList);
		resultMap.put("stat2", mapList);
		
		return resultMap;
	}
		
		
//	티켓 예매별 매출비용
	@ResponseBody
	@PostMapping("/stats/subscriptionAjax") 
	public List<StatsVO> subscriptionTotal( Model model,StatsVO statsVO){
		log.info("subscriptionTotal->statsVO : " + statsVO);
		
		List<StatsVO> subscriptionList = this.statsservice.subscriptionList(statsVO);
		
		log.info("subscriptionTotal->subscriptionList : " + subscriptionList);
		
		return subscriptionList;
	 }
	
	
	
	
//	연령별 통계
	@ResponseBody
	@PostMapping("/stats/subscriptionAjax2") 
	public List<StatsVO> subscriptionTotal2( Model model,StatsVO statsVO){
		
		
		List<StatsVO> subscriptionList2 = this.statsservice.subscriptionList2(statsVO);
		
		log.info("subscriptionTotal->subscriptionList : " + subscriptionList2);
		
		return subscriptionList2;
		
	}
}
	