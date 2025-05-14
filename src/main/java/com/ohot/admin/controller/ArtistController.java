package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ohot.service.ArtistService;
import com.ohot.util.BoardPage;
import com.ohot.vo.ArtistVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/artist")
public class ArtistController {

	@Autowired
	ArtistService artistService;
	
	@GetMapping("/artistList")
	public String artistList(
			Model model,
			@RequestParam(value = "mode", required = false, defaultValue = "") String mode,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage) {
	
		int size = 5;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mode", mode);
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		int total = artistService.getTotalArtist(map);
		
		List<ArtistVO> artistVOList = this.artistService.artistSearchList(map);
		log.info("artistList검색" + artistVOList);
		
		BoardPage<ArtistVO> boardPage = new BoardPage<>(total, currentPage, size, keyword, artistVOList, mode);
		
		model.addAttribute("boardPage", boardPage);
		
		return "admin/artist/artistList";
	}
	
	@GetMapping("/artistDetail")
	public String artistDetail(Model model, ArtistVO artistVO) {
		
		ArtistVO artistVODetail = this.artistService.artistDetail(artistVO);
		
		model.addAttribute("artistVODetail", artistVODetail);
		
		return "admin/artist/artistDetail";
		
	}
	
}
