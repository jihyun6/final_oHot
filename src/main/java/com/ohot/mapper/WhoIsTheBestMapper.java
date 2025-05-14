package com.ohot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ohot.vo.ArtistVO;
import com.ohot.vo.WhoIsTheBestVO;

@Mapper
public interface WhoIsTheBestMapper {

	List<ArtistVO> allPlayers();

	List<ArtistVO> winners();

	void getWinner(WhoIsTheBestVO whoIsTheBest);

}
