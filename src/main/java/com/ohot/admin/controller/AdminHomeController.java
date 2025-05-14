package com.ohot.admin.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ohot.service.StatsService;
import com.ohot.service.impl.UsersServiceImpl;
import com.ohot.vo.StatsVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminHomeController {
	
	@Autowired
	UsersServiceImpl usersService;
	
	@Autowired
	StatsService statsservice;

	@GetMapping("/home")
	public String adminHome(Model model) {
		
		log.info("어드민 홈페이지 진입");
		
		LocalDate currentDate = LocalDate.now();
		int month = currentDate.getMonthValue();
		
		List<StatsVO> memberTotal = this.statsservice.memberTotal(null);
		List<StatsVO> subscriptionTotal = this.statsservice.SubscriptionTotal(null);
		List<StatsVO> followersTotal = this.statsservice.FollowersTotal(null);
		List<StatsVO> goodTotal = this.statsservice.goodTotal(null);
		List<StatsVO> salesVolume = this.statsservice.salesVolume(null);
		List<StatsVO> totalSales = this.statsservice.totalSales(null);
		List<StatsVO> reservationTotalSales = this.statsservice.reservationTotalSales(null);
		List<StatsVO> concertSales = this.statsservice.concertSales(null);
		List<StatsVO> fanSales = this.statsservice.fanSales(null);
		List<StatsVO> restSales = this.statsservice.restSales(null);
		
		model.addAttribute("month", month);
		model.addAttribute("memberTotal", memberTotal);
		model.addAttribute("subscriptionTotal", subscriptionTotal);
		model.addAttribute("goodTotal", goodTotal);
		model.addAttribute("salesVolume", salesVolume);
		model.addAttribute("followersTotal", followersTotal);
		model.addAttribute("totalSales", totalSales);
		model.addAttribute("reservationTotalSales", reservationTotalSales);
		model.addAttribute("concertSales", concertSales);
		model.addAttribute("fanSales", fanSales);
		model.addAttribute("restSales", restSales);
		
		return "admin/adminHome";
	}
	
}
