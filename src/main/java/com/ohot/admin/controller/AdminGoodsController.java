package com.ohot.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ohot.admin.service.AdminGoodsService;
import com.ohot.mapper.CommonCodeGroupMapper;
import com.ohot.service.ArtistGroupService;
import com.ohot.service.ArtistService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.TkDetailVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.ArtistVO;
import com.ohot.vo.CommonCodeGroupVO;
import com.ohot.vo.FileDetailVO;
import com.ohot.vo.FileGroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/shop")
public class AdminGoodsController {
	
	@Autowired
	AdminGoodsService adminGoodsService;
	
	@Autowired
	ArtistGroupService artistGroupService;
	
	@Autowired
	ArtistService artistService;
	
	@Autowired
	CommonCodeGroupMapper commonCodeGroupMapper;
	
	// /shop 시리즈의 공통 model
	@ModelAttribute
	public void gongTong(Model model) {

		CommonCodeGroupVO commonCodeGroupVO = new CommonCodeGroupVO();
		commonCodeGroupVO.setCommCodeGrpNo("GD01");

		commonCodeGroupVO = this.commonCodeGroupMapper.commonCodeGroupList(commonCodeGroupVO);
		log.info("gongTong->commonCodeGroupVO : " + commonCodeGroupVO);

		// 굿즈크기(GD01) : S/M/L
		model.addAttribute("commonCodeGroupVO", commonCodeGroupVO);
	}

	// /shop 시리즈 공통 model(상품유형 가져오기)
	@ModelAttribute
	public void gongTongGdsType(Model model) {
		CommonCodeGroupVO commonCodeGroupVO = new CommonCodeGroupVO();
		commonCodeGroupVO.setCommCodeGrpNo("GD03");

		commonCodeGroupVO = this.commonCodeGroupMapper.commonCodeGroupList(commonCodeGroupVO);
		log.info("gongTongGdsType->commonCodeGroupVO : " + commonCodeGroupVO);

		// 상품유형(GD03) : G/A/M/D
		model.addAttribute("commonCodeGroupVOGdsType", commonCodeGroupVO);
	}
	
	
	//굿즈 리스트
	@GetMapping("/adGoodsList")
	public String adGoodsList(Model model) {
		log.info("adGoodsList Start!");
		
		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		return "admin/shop/adGoodsList";
	}
	
	// 굿즈 상세검색
	@ResponseBody
	@PostMapping("/goodsListSearchPost")
	public Map<String, Object> goodsListSearchPost(@RequestBody Map<String, Object> data, Model model) {
		log.info("goodsListSearchPost: " + data);

		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}

		log.info("안담기니? 담기렴" + data);
		int size = 10;

		List<ArtistGroupVO> goodsVOList = this.adminGoodsService.goodsListSearchPost(data);
		log.info("search->goodsListSearchPost: " + goodsVOList);
		
		int total = goodsVOList.get(0).getTotalCnt(); // 새로 추가해야 함
		log.info("total 행" + total);

		int totalPages = (int) Math.ceil((double) total / size);
		int startPage = Math.max(1, currentPage - 5);
		int endPage = Math.min(totalPages, currentPage + 4);

		log.info("이게 필요핸가?: " + totalPages + "start: " + startPage + "end: " + endPage);

		Map<String, Object> result = new HashMap<>();
		result.put("content", goodsVOList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("total", total);

		return result;
	}
	
	// 상품 등록
	@GetMapping("/adGoodsCreate")
	public String adGoodsCreate(ArtistGroupVO artistGroupVO, Model model) {
		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		//List<ArtistVO> artistVOList = this.artistService.artistList();
		//model.addAttribute("artistVOList", artistVOList);
		
		//상품번호를 가져오는 메소드
		GoodsVO goodsVO = adminGoodsService.getMaxGdsNo();
		
		log.info("adminGoods goodsVO : " + goodsVO);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonStr;
		try {
			//Java 객체(VO, Map)등을 JSON 문자열로 변환
			jsonStr = objectMapper.writeValueAsString(goodsVO);
		} catch (JsonProcessingException e) {
			jsonStr = "Error";
		}
		
		model.addAttribute("jsonStr", jsonStr);
		model.addAttribute("title", "굿즈샵 등록");
		
		return "admin/shop/adGoodsCreate";
	}
	
	// 상품 등록 처리 DB 저장
	@ResponseBody
	@PostMapping("/adGoodsCreatePost")
	public int adGoodsCreatePost(GoodsVO goodsVO , @RequestPart(value="uploadFile") MultipartFile[] uploadFiles) {
		
		log.info("goodsVO : " + goodsVO);
		int result = adminGoodsService.goodsInsert(goodsVO, uploadFiles);
		
		return result;
	}
	
	//상품 조회
	@GetMapping("/adGoodsDetail")
	public String adGoodsDetail(int gdsNo,Model model) {
		log.info("adGoodsDetail->goodsVO: "+ gdsNo);
		
		GoodsVO goodsVO = this.adminGoodsService.goodsDetail(gdsNo);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonStr;
		try {
			//Java 객체(VO, Map)등을 JSON 문자열로 변환
			jsonStr = objectMapper.writeValueAsString(goodsVO);
		} catch (JsonProcessingException e) {
			jsonStr = "";
		}
		
		model.addAttribute("jsonStr", jsonStr);
		
		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		model.addAttribute("title", "굿즈샵 상세");
		
		return "admin/shop/adGoodsCreate";
	}
	
	// 상품 업데이트
	@ResponseBody
	@PostMapping("/adGoodsUpdatePost")
	public int adGoodsUpdatePost(GoodsVO goodsVO, @RequestPart(value = "uploadFile") MultipartFile[] uploadFiles) {

		log.info("goodsVO : " + goodsVO);
		
		//GoodsUpdate
		int result = this.adminGoodsService.goodsUpdate(goodsVO);
		
		//파일 Detail 목록 조회
		List<FileDetailVO> fileDetailVOList = goodsVO.getFileGroupVO().getFileDetailVOList();
		result += adminGoodsService.fileSnChange(fileDetailVOList);
		
		return result;
	}
	
	//상품 삭제
	@ResponseBody
	@PostMapping("/adGoodsDeletePost")
	public int adGoodsDeletePost(GoodsVO goodsVO) {
		return this.adminGoodsService.ticketDelete(goodsVO.getGdsNo());
	}
	
	//공연 리스트
	@GetMapping("/adTicketList")
	public String ticketList(GoodsVO goodsVO, Model model) {
		log.info("ticketLsit->goodsVO: "+goodsVO);
		List<GoodsVO> goodsVOList = this.adminGoodsService.ticketList();
		model.addAttribute("goodsVOList", goodsVOList);
		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		List<ArtistVO> artistVOList = this.artistService.artistList();
		model.addAttribute("artistVOList", artistVOList);
		
		return "admin/shop/adTicketList";
	}
	
	
	//상세검색
	@ResponseBody
	@PostMapping("/tkListSearchPost")
	public Map<String, Object> tkListSearchPost(@RequestBody  Map<String, Object> data) {
		log.info("tkListSearchPost: "+data);
		
		//기본값
		int currentPage = 1;
		int rowSize=10;
	    int blockSize=10;
	    
		try {
		    currentPage = Integer.parseInt(String.valueOf(data.get("page")));
		    rowSize = Integer.parseInt(String.valueOf(data.get("rowSize")));
		    blockSize = Integer.parseInt(String.valueOf(data.get("blockSize")));
		} catch (Exception e) {
		    log.warn("페이지 파싱 실패, 기본값  사용");
		}

	    log.info("안담기니? 담기렴"+data);
	    
		List<GoodsVO> goodsVOList = this.adminGoodsService.tkListSearchPost(data);
		log.info("search->tkListSearchPost: "+goodsVOList);
		
		int total = adminGoodsService.tkListCount(data); // 새로 추가해야 함
		log.info("total 행"+total);
		 
		int totalPages = (int) Math.ceil((double) total / rowSize); 
		int startPage = ((currentPage - 1) / blockSize) * blockSize + 1;
	    int endPage = Math.min(startPage + blockSize - 1, totalPages);
	    
//	    log.info("이게 필요핸가?: "+totalPages+ "start: "+startPage+"end: "+endPage);
	    
		
	    Map<String, Object> result = new HashMap<>();
	    result.put("content", goodsVOList);
	    result.put("currentPage", currentPage);
	    result.put("totalPages", totalPages);
	    result.put("startPage", startPage);
	    result.put("endPage", endPage);
	    result.put("total", total);
	
		return result;
	}
	
	//티켓상세
	@GetMapping("/adTicketDetail")
	public String ticketDetail(int gdsNo,Model model) {
		log.info("ticketDetail->goodsVO: "+gdsNo);
		
		GoodsVO goodsVO= this.adminGoodsService.ticketDetail(gdsNo);
		model.addAttribute("goodsVO", goodsVO);
		
		return "admin/shop/adTicketDetail";
	}
	
	
	//티켓수정
	@GetMapping("/adTicketUpdate")
	public String ticketUpdate(int gdsNo, Model model) {
		log.info("adTicketUpdate 실행"+gdsNo);
		GoodsVO goodsVO=this.adminGoodsService.ticketDetail(gdsNo);
		model.addAttribute("goodsVO", goodsVO);
		
		return "admin/shop/adTicketUpdate";
	}
	
	//티켓수정업데이트
	@PostMapping("/adTicketUpdatePost")
	public String ticketUpdatePost(GoodsVO goodsVO, @RequestPart(value="uploadFile") MultipartFile[] uploadFiles) {
		log.info("adTicketUpdatePost 실행"+goodsVO);
		
		 this.adminGoodsService.ticketUpdate(goodsVO, uploadFiles);
		
		
		return "redirect:/admin/shop/adTicketDetail?gdsNo="+goodsVO.getGdsNo();
	}
	
	//티켓 등록
	@GetMapping("/adTicketCreate")
	public String ticketCreate(ArtistGroupVO artistGroupVO, Model model) {
		log.info("ticketCreate->artistGroupVO: "+artistGroupVO);
		
		List<ArtistGroupVO> artistGroupVOList = this.artistGroupService.homeArtistGroupList();
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		List<ArtistVO> artistVOList = this.artistService.artistList();
		model.addAttribute("artistVOList", artistVOList);
		
		return "admin/shop/adTicketCreate";
	}
	
	
	long tkNo = 0L;
	//1) /admin/goods/ticketCreate 에서 왼쪽 하단의 [저장]버튼 클릭
	@ResponseBody
	@PostMapping("/ticketCreatePost")
	public int ticketCreatePost( GoodsVO goodsVO , @RequestPart(value="uploadFile") MultipartFile[] uploadFiles) {
		
		log.info("ticketCreatePost-> goodsVO: "+goodsVO);
		
		int gdsNo = this.adminGoodsService.ticketInsert(goodsVO, uploadFiles);
		tkNo=goodsVO.getTicketVO().getTkNo();
		log.info("ticketcreate->gdsNo: "+gdsNo);
		
		return gdsNo;
	}
	
	@ResponseBody
	@PostMapping("/ticketEventPost")
	public long ticketEventPost(@RequestBody List<TkDetailVO> tkDetailVOList) {
		
		log.info("ticketEventPost실행->tkDetailVOList : " + tkDetailVOList);
		/*
		 * for (TkDetailVO detail : tkDetailVOList) { log.info("tkYmd 값: " +
		 * detail.getTkYmd()); log.info("tkRound 타입: " + ( ((Object)
		 * detail.getTkRound()).getClass() == Long.class )); log.info("tkYmd 타입: " +
		 * (((Object) detail.getTkYmd()).getClass() == Long.class ));
		 * log.info("gdsNm 타입: " + (detail.getGdsNm().getClass() == String.class)); }
		 * log.info("----------------------"+tkDetailVOList);
		 */
		for (TkDetailVO tkDetailVO : tkDetailVOList) {
			//3) 전역 프로퍼티 활용
			tkDetailVO.setTkNo(this.tkNo);
			
			//TkDetailVO(tkDetailNo=0, tkYmd=20250408, tkRound=1, tkNo=15, gdsNm=에스파 봄콘서트)
			log.info("ticketEventPost->tkDetailVO[전] : " + tkDetailVO);
			int result=0;
			result += this.adminGoodsService.tkDetailInsert(tkDetailVO); // 서비스 호출
			log.info("ticketEventPost-> tkDetailVO[후] : "+ tkDetailVO);
			
	    }
		
		//4) 전역 프로퍼티 활용
		return this.tkNo;
	}
	
	//티켓포스터 등록
	@ResponseBody
	@PostMapping("/ticketPosterPost")
	public FileDetailVO ticketPosterPost(@RequestParam(value="uploadFile") MultipartFile[] uploadFile) {
		FileDetailVO result=this.adminGoodsService.ticketPoster(uploadFile);
		log.info(result+"dddd");
		return result;
	}
	
	//티켓 삭제
	@ResponseBody
	@PostMapping("/ticketDelete")
	public String ticketDelete(@RequestBody  Map<String, Object> data) {
		int gdsNo = Integer.parseInt(data.get("gdsNo").toString());
		log.info("delete옴 gdsNo: "+gdsNo);
		this.adminGoodsService.ticketDelete(gdsNo);
		
		return "success";
	}


	
}
