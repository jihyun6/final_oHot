package com.ohot.home.alarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.home.alarm.service.AlarmService;
import com.ohot.home.alarm.vo.NotiStngVO;
import com.ohot.home.alarm.vo.NotificationVO;
import com.ohot.home.community.vo.CommunityPostVO;
import com.ohot.vo.ArtistGroupVO;

import lombok.extern.slf4j.Slf4j;
import retrofit2.http.POST;

@Slf4j
@Controller
@RequestMapping("/oho/alarm")
public class AlarmController {
	
	@Autowired
	AlarmService alarmService;
	
	//emp readEnum
	@ResponseBody
	@PostMapping("/empReadEnum")
	public int empReadEnum(@RequestParam long empNo) {
		log.info("empReadEnum: "+empNo);
		int result = this.alarmService.empReadEnum(empNo);
		
		return result;
	}
	
	//emp check not read
	@ResponseBody
	@PostMapping("/empCheckEnum")
	public int empCheckEnum(@RequestParam long empNo) {
		log.info("empCheckEnum: "+empNo);
		
		int result = this.alarmService.empCheckEnum(empNo);
		
		return result;
	}
	
	//emp알림list
	@ResponseBody
	@PostMapping("/empDetailList")
	public List<NotificationVO> empDetailList(@RequestParam long memNo){
		
		List<NotificationVO> NotificationVOList = this.alarmService.empDetailList(memNo);
		
		return NotificationVOList;
	}
	
	//알림 유무 체크
	@ResponseBody
	@PostMapping("/checkEnum")
	public int checkEnum (@RequestParam int memNo){
		log.info("checkEnum 실행: "+memNo);
		int result = this.alarmService.checkEnum(memNo);
		
		return result;
	}
	
	//알림 상태 읽음 업데이트
	@ResponseBody
	@PostMapping("/readEnum")
	public int updateReadEnum (@RequestParam int memNo) {
		log.info("updateReadEnum 실행: "+memNo);
		int result =this.alarmService.updateReadEnum(memNo);
		
		return result;
	}
	
	//알림셋팅 내역 저장
	@ResponseBody
	@PostMapping("/savePersonalStng")
	public int savePersonalStng (@RequestBody NotiStngVO notiStngVO) {
		
		log.debug("savePersonalStng 실행중 vo= "+notiStngVO);
		int result = this.alarmService.savePersonalStng(notiStngVO);
		
		return result;
	}
	
	
	//알림셋팅 내역
	@ResponseBody
	@PostMapping("/personalStng")
	public NotiStngVO personalStng(@RequestParam int comProfileNo){
		log.debug("personalStng 작동중 param= "+comProfileNo);
		NotiStngVO notiStngVO = this.alarmService.personalStng(comProfileNo);
		return notiStngVO;
	}
	
	//그룹별 알림내역
	@ResponseBody
	@PostMapping("/alarmDetailList")
	public List<NotificationVO> alarmDetailList(@RequestParam int memNo,  @RequestParam int artGroupNo){
		
		log.debug(memNo+"alarmDetailList 실행~! "+artGroupNo);
		List<NotificationVO> notificationVOList = this.alarmService.alarmDetailList(memNo,artGroupNo);
		
		return notificationVOList;
	}
	
	//가입한 커뮤니티 
	@ResponseBody
	@PostMapping("/registeredGroupList")
	public List<ArtistGroupVO> registeredGroupList(@RequestParam int memNo) {
		log.info("registeredGroupList 실행~! "+memNo);
		List<ArtistGroupVO> artistGroupVOList = this.alarmService.registeredGroupList(memNo);
		
		return artistGroupVOList;
	}


}
