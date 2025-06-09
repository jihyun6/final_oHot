package com.ohot.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin/live")
@Controller
public class AdminLiveController {

	@GetMapping("/home")
	public String adminLiveHome() {
		
		return "admin/live/liveMain";
	}
}
