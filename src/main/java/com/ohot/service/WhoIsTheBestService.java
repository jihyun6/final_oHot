package com.ohot.service;

import java.util.List;

import com.ohot.vo.ArtistVO;
import com.ohot.vo.WhoIsTheBestVO;

public interface WhoIsTheBestService {

	public List<ArtistVO> allPlayers();

	public List<ArtistVO> winners();

	public void getWinner(WhoIsTheBestVO whoIsTheBest);

}
