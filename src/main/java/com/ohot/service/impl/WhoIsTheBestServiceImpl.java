package com.ohot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ohot.mapper.WhoIsTheBestMapper;
import com.ohot.service.WhoIsTheBestService;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.WhoIsTheBestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WhoIsTheBestServiceImpl implements WhoIsTheBestService{
	@Autowired
	WhoIsTheBestMapper whoIsTheBestMapper;
	
	@Override
	public List<ArtistVO> allPlayers() {
		// TODO Auto-generated method stub
		return this.whoIsTheBestMapper.allPlayers();
	}

	@Override
	public List<ArtistVO> winners() {
		// TODO Auto-generated method stub
		return this.whoIsTheBestMapper.winners();
	}

	@Override
	public void getWinner(WhoIsTheBestVO whoIsTheBest) {
		
		this.whoIsTheBestMapper.getWinner(whoIsTheBest);
	}

}
