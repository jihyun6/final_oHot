package com.ohot.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.javassist.expr.NewExpr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ohot.service.ArtistService;
import com.ohot.service.WhoIsTheBestService;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.WhoIsTheBestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oho/game")
public class WhoIsTheBestController {
	
	@Autowired
	ArtistService artistService;
	
	@Autowired
	WhoIsTheBestService whoIsTheBestService;
	
	//<a href="/oho/game/play">랜덤 인기 투표하기</a>
	@GetMapping("/play")
	public String getPlayers(
			Model model
			){

		List<ArtistVO> allPlayers = this.whoIsTheBestService.allPlayers();
		
		int[] getIndex = new int[14];
		
		int cntPlayers = allPlayers.size()-2;
		int cnt=0;
		//int[] check = new int[16];
		//32강 = 총 16명
		while (cnt < 14) {
		    int ran = (int)(Math.random() * cntPlayers);
		    boolean isDuplicate = false;

		    for (int i = 0; i < cnt; i++) {
		        if (getIndex[i] == ran) {
		            isDuplicate = true;
		            break;
		        }
		    }

		    if (!isDuplicate) {
		        getIndex[cnt] = ran;
		        System.out.println(cnt + "번째 값: " + ran);
		        cnt++;
		    }
		}
		//16명의 아티스트 넘버값 getIndex에 저장
		//플레이어를 players List에 저장
	    List<ArtistVO> players = new ArrayList<>();
	    
	    players.add(allPlayers.get(allPlayers.size()-1));
	    
	    for (int i = 0; i<getIndex.length;i++) {
	        players.add(allPlayers.get(getIndex[i]));
	    }
		
	    players.add(allPlayers.get(allPlayers.size()-2));
	    
	    log.info("first"+allPlayers.get(allPlayers.size()-1));
		log.info("Last"+allPlayers.get(allPlayers.size()-2));
		int count = 16;
		model.addAttribute("players", players);
		model.addAttribute("16", count);
		return "/community/play";
	}
	
	@PostMapping("/getWinner")
	public String winnerStatistic(
			String artActNm,
			Model model
			) {
		log.info("artActNm->"+artActNm);
		WhoIsTheBestVO whoIsTheBest = new WhoIsTheBestVO();
		whoIsTheBest.setArtActNm(artActNm);
		this.whoIsTheBestService.getWinner(whoIsTheBest);
		
		ArtistVO yourPick = new ArtistVO();
		
		List<ArtistVO> whoIsTheBestVO = this.whoIsTheBestService.winners();
		for (ArtistVO artistVO : whoIsTheBestVO) {
			if(artistVO.getArtActNm().equals(artActNm)) {
				yourPick=artistVO;
				log.info("오고있니?");
			}
		}
		log.info("yourPick::::"+yourPick);
		model.addAttribute("yourPick",yourPick);
		model.addAttribute("winners", whoIsTheBestVO);
		return "/community/statistic";
	}
	
	
}
