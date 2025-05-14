package com.ohot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ohot.home.dm.service.DmService;
import com.ohot.shop.service.TicketService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class SchedulerConfiguration {
	
	@Autowired
	TicketService ticketService;
	
	@Autowired
	DmService dmService;
    

//	@Scheduled(fixedDelay = 30000) //서버시작후 1분마다 실행 시연용
	@Scheduled(fixedDelay = 3600000) //작업을 위해 1시간마다 실행 
    public void resetUnpaidSeats() {
		log.debug("좌석reset 실행");
    	this.ticketService.resetUnpaidSeats();
    	
    }
	
//	@Scheduled(cron = "1 31 0 * * *") //초(1) 분(0) 시(0) 매일 매월 매요일 실행 서울로 시간 맞춰야 사용가능
	@Scheduled(fixedDelay = 3600000) //1시간마다
	public void resetExpiredDms() {
		log.info("만료된 dm reset 실행");
		this.dmService.resetExpiredDms();
	}
	

}