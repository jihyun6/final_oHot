package com.ohot.shop.controller;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateCrtKey;
import java.security.interfaces.RSAPublicKey;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.EncryptionMethod;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWEAlgorithm;
import com.nimbusds.jose.JWEHeader;
import com.nimbusds.jose.crypto.RSADecrypter;
import com.nimbusds.jose.crypto.RSAEncrypter;
import com.nimbusds.jwt.EncryptedJWT;
import com.nimbusds.jwt.JWTClaimsSet;
import com.ohot.home.community.service.ArtistGroupNoticeService;
import com.ohot.home.community.vo.ArtistGroupNoticeVO;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.mapper.CommonCodeGroupMapper;
import com.ohot.mapper.SeqGeneratorMapper;
import com.ohot.service.BannerFileService;
import com.ohot.service.MemberService;
import com.ohot.shop.service.PaymentService;
import com.ohot.shop.service.ShopService;
import com.ohot.shop.service.TicketService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.shop.vo.ShippingInfoVO;
import com.ohot.vo.ArtistGroupVO;
import com.ohot.vo.BannerFileVO;
import com.ohot.vo.CommonCodeGroupVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CommonCodeGroupMapper commonCodeGroupMapper;
	
	@Autowired
	SeqGeneratorMapper seqGeneratorMapper;
	
	@Autowired
	TicketService ticketService;
	
	@Autowired
	BannerFileService bannerFileService;
	
	@Autowired
	ArtistGroupNoticeService artistGroupNoticeService;
	
	// /shop 시리즈의 공통  model
	@ModelAttribute
	public void gongTong(Model model) {
		
		CommonCodeGroupVO commonCodeGroupVO = new CommonCodeGroupVO();
		commonCodeGroupVO.setCommCodeGrpNo("GD01");
		
		commonCodeGroupVO = this.commonCodeGroupMapper.commonCodeGroupList(commonCodeGroupVO);
		log.info("gongTong->commonCodeGroupVO : " + commonCodeGroupVO);
		
		//굿즈크기(GD01) : S/M/L
		model.addAttribute("commonCodeGroupVO", commonCodeGroupVO);
	}
	
	// /shop 시리즈 공통 model(상품유형 가져오기)
	@ModelAttribute
	public void gongTongGdsType(Model model) {
		CommonCodeGroupVO commonCodeGroupVO = new CommonCodeGroupVO();
		commonCodeGroupVO.setCommCodeGrpNo("GD03");
		
		commonCodeGroupVO = this.commonCodeGroupMapper.commonCodeGroupList(commonCodeGroupVO);
		log.info("gongTongGdsType->commonCodeGroupVO : " + commonCodeGroupVO);
		
		//상품유형(GD03) : G/A/M/D
		model.addAttribute("commonCodeGroupVOGdsType", commonCodeGroupVO);
	}
	
	/* shop Main Home Page */
	@GetMapping("/home")
	public String goodsForm(Model model, @AuthenticationPrincipal CustomUser customUser, @RequestParam(value = "tkCtgr", required = false) String tkCtgr) {
		
		UsersVO usersVO = null;
		
		List<CommunityProfileVO> communityProfileVOList = null;
		List<ArtistGroupVO> artistGroupVOList = null;
		
		//로그인 여부 체크
		if(customUser != null) {
			usersVO = customUser.getUsersVO();
			log.info("usersVO : "+ usersVO);
			
			//Recommended Artist 조회
			communityProfileVOList = shopService.communityProfileList(usersVO);
			log.info("communityProfileVOList : " + communityProfileVOList);
		}
		
		//artist 목록이 없을 때 처리
		if(communityProfileVOList == null || communityProfileVOList.isEmpty()) {
			
			//Recommended Artist 조회
			model.addAttribute("title", "Recommended Artist");
			
			//비 회원이거나 아티스트 그룹 목록이 없을 때 출력
			communityProfileVOList = shopService.communityProfileBaseList();
			
			//아티스트 그룹번호 조회
			List<Integer> artistGroupNoList = new ArrayList<Integer>();
			for (CommunityProfileVO communityProfileVO : communityProfileVOList) {
				artistGroupNoList.add(communityProfileVO.getArtistGroupVO().getArtGroupNo());
			}
			
			log.info("artistGroupNoList : " + artistGroupNoList);
			
			artistGroupVOList = shopService.artstGroupBaseList(artistGroupNoList);
			
		}else {	//회원이면서 아티스트 그룹 목록이 있을 때 출력
			//artistGroupVOList 조회
			artistGroupVOList = shopService.artstGroupList(usersVO);
			log.info("artistGroupVOList 값은 : " + artistGroupVOList);
			model.addAttribute("title", "My Artist");
		}
		
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		model.addAttribute("communityProfileVOList", communityProfileVOList);
		
		//BannerList
		//TASK_SE_NM(업무구분명으로 조회)
		String taskSeNm = "shop";
		List<BannerFileVO> bannerFileVOList = bannerFileService.bannerFileList(taskSeNm);
		log.info("bannerFileVOList : " + bannerFileVOList);
		
		//artist 그룹목록(최상위3개-굿즈 판매량 순) 가져오기
		int limit = 3;
		List<ArtistGroupVO> topArtistsList = shopService.topArtistsList(limit);
		log.info("topArtistsList : " + topArtistsList);
		
		//artist 최상위그룹(1번)에 대한 굿즈 목록 가져오기
		ArtistGroupVO artistGroupVO = topArtistsList.get(0);
		List<ArtistGroupVO> topArtist = shopService.topArtistGoodsList(artistGroupVO); 
		log.info("topArtist : " + topArtist);
		
		//티켓 리스트 목록 가져오기
		List<GoodsVO> goodsVOList = this.ticketService.ticketList(tkCtgr);
		log.info("ticketList -> GoodsVO : "+goodsVOList);
		
		//totalPage 구하기
		int total = artistGroupVOList.size();
		int size = 9;
		int totalPage = (int) Math.ceil((double) total / size);
		
		log.info("totalPage : " + totalPage);
		
		//currentPage setting
		int currentPage = 1;
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("topArtistsList", topArtistsList);
		model.addAttribute("topArtist", topArtist);
		model.addAttribute("bannerFileVOList", bannerFileVOList);
		model.addAttribute("goodsVOList", goodsVOList);
		
		//artist 목록 가져오기
		List<ArtistGroupVO> artistGroupList = shopService.artistGroupList();
		model.addAttribute("artistGroupList", artistGroupList);
		
		return "shop/home";
	}
	
	//Artist 구독 리스트 페이지 출력
	@ResponseBody
	@PostMapping("/communityProfileListPage")
	public List<CommunityProfileVO> communityProfileListPage(@AuthenticationPrincipal CustomUser customUser, 
															 @RequestBody Map<String, Object> data) {
		
		UsersVO usersVO = null;
		List<CommunityProfileVO> communityProfileListPage = null;
		//로그인 여부 체크
		if(customUser != null) {
			usersVO = customUser.getUsersVO();
			log.info("usersVO : "+ usersVO);
			
			data.put("userNo", usersVO.getUserNo());
			
			communityProfileListPage = shopService.communityProfileListPage(data);
			
			log.info("communityProfileListPage : " + communityProfileListPage);
		}
		
		return communityProfileListPage;
	}
	
	/* 아티스트 굿즈샵 홈페이지 */
	@GetMapping("/artistGroup")
	public String artistGroupForm(Model model, @RequestParam(required = false, defaultValue = "0") int artGroupNo) {
		
		//아티스트 그룹번호 조회
		List<Integer> artistGroupNoList = new ArrayList<Integer>();
		
		artistGroupNoList.add(artGroupNo);
		
		List<ArtistGroupVO> artistGroupVOList = shopService.artstGroupBaseList(artistGroupNoList);
		
		model.addAttribute("artistGroupVOList", artistGroupVOList);
		
		GoodsVO goodsVO = new GoodsVO();
		goodsVO.setArtGroupNo(artGroupNo);
		List<GoodsVO> goodsList = shopService.getGdsTypeList(goodsVO);
		model.addAttribute("goodsList", goodsList);
		
		//커뮤니티 공지사항 불러오는 곳 // 그 중 상위 4개만 불러오기
	    Map<String, Object> map = new HashMap<String,Object>();
	    int currentPage = 1;
        map.put("artGroupNo", artGroupNo);
        map.put("currentPage", currentPage);
      
        List<ArtistGroupNoticeVO> artistGroupNoticeVOList = this.artistGroupNoticeService.artistGroupNoticeList(map);
        List<ArtistGroupNoticeVO> recentNoticeList = new ArrayList<ArtistGroupNoticeVO>();
      
        log.info("artistGroupNoticeVOList:::"+artistGroupNoticeVOList);
        int i=0;
        
        //공지 5개만 불러오기
        for (ArtistGroupNoticeVO artistGroupNotice : artistGroupNoticeVOList) {
           if(i==3)break;
           recentNoticeList.add(artistGroupNotice);
           i++;
        }
      
        log.info("recentNoticeList:::::"+recentNoticeList);
      
        model.addAttribute("recentNoticeList",recentNoticeList);
		
        //artist 목록 가져오기
      	List<ArtistGroupVO> artistGroupList = shopService.artistGroupList();
      	model.addAttribute("artistGroupList", artistGroupList);
        
		return "shop/groupList";
		
	}
	
	/* 아티스트 상품 유형 조회 */
	@ResponseBody
	@PostMapping("/artistGroup/gdsTypeAjax")
	public List<GoodsVO> gdsTypeAjax(@RequestBody GoodsVO goodsVO) {
		
		log.info("goodsVO : " + goodsVO);
		
		List<GoodsVO> goodsList = shopService.getGdsTypeList(goodsVO);
		
		log.info("goodsList : "  + goodsList);
		
		return goodsList;
	}
	
	
	/* 아티스트의 그룹 상품을 조회 */
	@ResponseBody
	@PostMapping("/artistGroup/topArtistAjax")
	public List<ArtistGroupVO> topArtistAjax(@RequestBody ArtistGroupVO artistGroupVO) {
		
		log.info("artistGroupVO : " + artistGroupVO);
		
		List<ArtistGroupVO> topArtist = shopService.topArtistGoodsList(artistGroupVO); 
		
		return topArtist;
	}
	
	
	/* Goods Shop Detail */
	/* localhost:28080/shop/artistGroup/6/detail/24 */
	@GetMapping("/artistGroup/{artistGroup}/detail/{gdsNo}")
	public String goodsDetailForm(@PathVariable int artistGroup, @PathVariable int gdsNo, Model model, 
								  RedirectAttributes redirectAttributes) {
		
		// URL 파라미터로 받은 artistGroup과 gdsNo 값 로깅
		log.info("artistGroup : " + artistGroup);
		log.info("gdsNo : " + gdsNo);
		
		// GoodsVO 객체 생성하여 artistGroup과 gdsNo 값 설정
		GoodsVO goodsVO = new GoodsVO();
		goodsVO.setArtGroupNo(artistGroup);
		goodsVO.setGdsNo(gdsNo);
		
		// shopService를 사용하여 해당 상품에 대한 상세 정보를 가져옴
		goodsVO = shopService.goodsDetail(goodsVO);
		
		log.info("goodsVO : " + goodsVO);
		
		// goodsVO가 null인 경우, 상품 정보를 찾을 수 없으므로 홈 페이지로 리다이렉트
		if(goodsVO == null ) {
			redirectAttributes.addFlashAttribute("alertMessage", "상품 페이지가 없습니다!");
			return "redirect:/shop/error";
		}else {
			model.addAttribute("goodsVO", goodsVO);
			return "shop/detail";
		}
	}
	
	/* error 발생 시 예외 처리 */
	@GetMapping("/error")
	public String error(@ModelAttribute("alertMessage") String alertMessage,
					    @ModelAttribute("referer") String referer,
						Model model) {
		
		log.info("alertMessage : " + alertMessage);
		
		if(referer == null || referer.equals("")) {
			referer = "error";
		}
		
		model.addAttribute("alertMessage", alertMessage);
		model.addAttribute("referer", referer);
		
		return "shop/error";
	}
	
	
	
	/* Goods Shop orders*/
	@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@PostMapping("/ordersPost")
	public String goodsPostOrdersForm(ArtistGroupVO artistGroupVO, Model model, 
									  @AuthenticationPrincipal CustomUser customUser,
									  HttpSession session,
									  @RequestParam(required = false) String gdsType,
									  @RequestParam(required = false, defaultValue = "0") int artGroupNo,
									  RedirectAttributes redirectAttributes,
									  HttpServletRequest request) {
		
		log.info("goodsPostOrdersForm->artistGroupVO : " + artistGroupVO);
		UsersVO usersVO = null;
		MemberVO memberVO = new MemberVO();
		
		// seqGenerator에서 관리하는 시퀀스 정보를 가져와서, orders 테이블의 기본키 값을 삽입하기 위한 코드
		SeqGeneratorVO seqGeneratorVO = new SeqGeneratorVO();
		
		
		List<GoodsVO> goodsVOList = new ArrayList<GoodsVO>();
		
		//로그인 체크
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
		}else {
			usersVO = customUser.getUsersVO();
			memberVO.setMemNo((int)usersVO.getUserNo());
			
			//커뮤니티 가입여부 확인
			MemberShopVO memberShopVO = new MemberShopVO();
			
			//MemberShip 결제인 경우
			//artGroupNo > 0 && gdsType: 커뮤니티에서 넘어올 때 처리
			if(artGroupNo == 0) {
				artGroupNo = artistGroupVO.getGoodsVOList().get(0).getArtGroupNo();
				gdsType = artistGroupVO.getGoodsVOList().get(0).getGdsType();
			}
			
			if( artGroupNo > 0 && "M".equals(gdsType) ) {
				//MemberShip 결제를 했는지? 체크
				CommunityProfileVO communityProfileVO = new CommunityProfileVO();
				memberShopVO.setArtGroupNo(artGroupNo);
				memberShopVO.setMemNo(usersVO.getUserNo());
				communityProfileVO = shopService.findComProfileNoCheck(memberShopVO);
				
				if(communityProfileVO == null) {
					redirectAttributes.addFlashAttribute("alertMessage", "커뮤니티 가입 후 이용바랍니다.");
					return "redirect:/shop/error";
				}
				
				long userNo = usersVO.getUserNo();
				int userNoInt = (int)userNo;
				
				communityProfileVO.setMemNo(userNoInt);
				communityProfileVO.setArtGroupNo(artGroupNo);
				
				String result = shopService.getMemberShipCheck(communityProfileVO);
				
				log.info("result : " + result);
				
				if("Y".equals(result)) {
					redirectAttributes.addFlashAttribute("alertMessage", "이미 멤버쉽 회원입니다!");
					return "redirect:/shop/error";
				}
				
				GoodsVO goodsVO = new GoodsVO();
				goodsVO.setArtGroupNo(artGroupNo);
				goodsVO.setGdsType("M");
				goodsVO = shopService.getMemberShip(goodsVO);
				
				log.info("goodsVO : " + goodsVO);
				
				if(goodsVO == null) {
					redirectAttributes.addFlashAttribute("alertMessage", "해당 상품이 존재하지 않습니다!");
					return "redirect:/shop/error";
				}
				
				String fileSaveLocate = goodsVO.getFileGroupVO().getFileDetailVOList().get(0).getFileSaveLocate();
				
				goodsVO.setFileSavePath(fileSaveLocate);
				goodsVO.setQty(1);
				goodsVO.setAmount(goodsVO.getUnitPrice());
				goodsVO.setGramt(goodsVO.getUnitPrice());
				
				goodsVOList.add(goodsVO);
				artistGroupVO.setGoodsVOList(goodsVOList);
				
				
			}else {	//Param 변조 체크
				goodsVOList = artistGroupVO.getGoodsVOList();
				log.info("goodsVOList : " + goodsVOList);
				
				//데이터베이스에 등록된 값 확인
				List<GoodsVO> comfirmGoodsVOList = shopService.getComfirmGoodsVOList(goodsVOList);
				
				log.info("comfirmGoodsVOList : " + comfirmGoodsVOList);
				
				if(comfirmGoodsVOList.isEmpty()) {
					redirectAttributes.addFlashAttribute("alertMessage", "비 정상적인 결제 입니다!");
					String referer = request.getHeader("Referer");
					redirectAttributes.addFlashAttribute("referer", referer);
					return "redirect:/shop/error";
				}
				
				log.info("goodsVOList.size() : " + goodsVOList.size());
				
				int gramt = 0;
				for(int i=0;i<goodsVOList.size();i++) {
					if(goodsVOList.get(i).getAmount() != comfirmGoodsVOList.get(i).getAmount()) {
						redirectAttributes.addFlashAttribute("alertMessage", goodsVOList.get(i).getAmount() + "원, 비 정상적인 접근입니다!");
						log.info("goodsVOList.get(i).getAmount() : " + goodsVOList.get(i).getGramt());
						log.info("comfirmGoodsVOList.get(i).getAmount() : " + comfirmGoodsVOList.get(i).getAmount());
						String referer = request.getHeader("Referer");
						redirectAttributes.addFlashAttribute("referer", referer);
						return "redirect:/shop/error";
					}else {
						log.info("goodsVOList.get(i).getAmount() : " + goodsVOList.get(i).getAmount());
						gramt += goodsVOList.get(i).getAmount();
					}
				}
				
				//총합계 비교
				if(gramt != goodsVOList.get(0).getGramt()) {
					log.info("goodsVOList.get(0).getGramt() : " + goodsVOList.get(0).getGramt());
					log.info("gramt : " + gramt);
					redirectAttributes.addFlashAttribute("alertMessage", goodsVOList.get(0).getGramt() + "원, 비 정상적인 접근입니다!");
					String referer = request.getHeader("Referer");
					redirectAttributes.addFlashAttribute("referer", referer);
					return "redirect:/shop/error";
				}
			}
			
			session.setAttribute("goodsVOList", goodsVOList);
			
			// seqGeneratorVO에 업무 유형("order") 값을 설정하고, seqGenerator에서 해당 시퀀스 값을 조회하여 가져옴
			seqGeneratorVO.setTaskSeNm("order");
			
			// NULL or seqGeneratorVO return;
			seqGeneratorVO = seqGeneratorMapper.findSeqGenerator(seqGeneratorVO);
			//seqGenerator 값이 null인 경우
			if(seqGeneratorVO == null) {
				seqGeneratorVO = new SeqGeneratorVO();
				seqGeneratorVO.setTaskSeNm("order");
				seqGeneratorMapper.updateSeqGeneratorDate(seqGeneratorVO);
				seqGeneratorVO = seqGeneratorMapper.findSeqGenerator(seqGeneratorVO);
				log.info("seqGeneratorVO : " + seqGeneratorVO);
			}
			
			//Payment param에 사용하는 OrderesId 생성코드
			seqGeneratorVO.setUuid(UUID.randomUUID());
			
			session.setAttribute("seqGeneratorVO", seqGeneratorVO);
			
			//Member 정보가져오기
			memberVO = memberService.memberDetail(memberVO);
			
			//배송정보 가져오기
			List<ShippingInfoVO> shippingInfoVOList = shopService.getShippingInfoList(usersVO);
			
			//https://connect2id.com/products/nimbus-jose-jwt/examples/jwt-with-rsa-encryption
			//google Search: keyGen return RSA java
			//https://stackoverflow.com/questions/31915617/how-to-encrypt-string-with-public-key-and-decrypt-with-private-key
			// JWT claims set
			Date now = new Date();

			// JWTClaimSet: JSON Web Token
			JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
										.issuer("ShopController") // token 발급자
										.subject("payment") //
										.claim("gramt", goodsVOList.get(0).getGramt())
										.expirationTime(new Date((now.getTime() + 1000 * 60 * 10))) // 10 minutes(1000밀리초: 1초 * 60(초) * 5 = 10분)
										.notBeforeTime(now) // 토큰 생성시간
										.issueTime(now) // 토큰 유효시간(시간) 설정
										.jwtID(UUID.randomUUID().toString()).build();

			JWEHeader header = new JWEHeader(JWEAlgorithm.RSA_OAEP_256, EncryptionMethod.A128GCM);

			// 암호화된 JSON Web Token
			EncryptedJWT jwt = new EncryptedJWT(header, jwtClaimsSet);

			// 비밀키 생성
			String jwtString = null;
			try {
				KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
				keyPairGenerator.initialize(2048);

				KeyPair keyPair = keyPairGenerator.generateKeyPair();

				RSAPublicKey rsaPublicKey = (RSAPublicKey) keyPair.getPublic();

				RSAEncrypter encrypter = new RSAEncrypter(rsaPublicKey);

				jwt.encrypt(encrypter);

				jwtString = jwt.serialize();

				log.info("jwtString : " + jwtString);
				session.setAttribute("keyPair", keyPair);

			} catch (NoSuchAlgorithmException | JOSEException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ObjectMapper objectMapper = new ObjectMapper();
			
			try {
				//Java 객체(VO, Map)등을 JSON 문자열로 변환
				jwtString = objectMapper.writeValueAsString(jwtString);
			} catch (JsonProcessingException e) {
				jwtString = "Error";
			}
			
			model.addAttribute("jwtString", jwtString);
			
			model.addAttribute("artistGroupVO", artistGroupVO);
			model.addAttribute("memberVO", memberVO);
			model.addAttribute("shippingInfoVOList", shippingInfoVOList);
		}
		
		return "shop/orders";
	}
	
	/* orders Detail */
	//@PreAuthorize("hasAnyRole('MEM', 'ART')")
	@GetMapping("/ordersDetail")
	public String ordersDetailForm(@AuthenticationPrincipal CustomUser customUser, Model model, RedirectAttributes redirectAttributes) {
		UsersVO usersVO = null;
		OrdersVO ordersVO = new OrdersVO();
		
		if(customUser == null) {
			redirectAttributes.addFlashAttribute("alertMessage", "로그인 후 이용바랍니다!");
			return "redirect:/shop/error";
		}else {
			usersVO = customUser.getUsersVO();
			ordersVO.setMemNo(usersVO.getUserNo());
		}
		
		//결제 내역 가져오기
		List<OrdersVO> ordersList = shopService.getOrdersList(ordersVO);
		log.info("ordersList : " + ordersList);
		
		model.addAttribute("ordersList", ordersList);
		
		return "shop/ordersDetail";
	}
	
	/* 배송 관리*/
	@GetMapping("/addrManager")
	public String addrManageFrom(@AuthenticationPrincipal CustomUser customUser, Model model) {
		
		UsersVO usersVO = null;
		
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
			
		}else {
			usersVO = customUser.getUsersVO();
		}
		
		//배송 주소 목록 가져오기
		List<ShippingInfoVO> shippingInfoVOList = shopService.getShippingInfoList(usersVO);
		
		log.info("shippingInfoVOList : " + shippingInfoVOList);
		
		model.addAttribute("shippingInfoVOList", shippingInfoVOList);
		
		return "shop/addr/addrManager";
	}
	
	/* 배송 주소 등록*/
	@ResponseBody
	@PostMapping("/addrManagerPost")
	public String addrManagePost(@AuthenticationPrincipal CustomUser customUser, ShippingInfoVO shippingInfoVO) {
		
		log.info("shippingInfoVO" + shippingInfoVO);
		
		UsersVO usersVO = null;
		
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
			return "fail";
		}else {
			usersVO = customUser.getUsersVO();
			shippingInfoVO.setMemNo(usersVO.getUserNo());
			
			//기본 배송지가 있는지 체크
			Integer isDefaultChk = shopService.shippingInfoIsDefaultChecked(usersVO.getUserNo());
			
			//기본 배송지가 있는 경우 기본 배송 주소를 N으로 변경
			if(isDefaultChk != null) {
				int isDefaultChkInt = (int)isDefaultChk; 
				shopService.shippingInfoIsDefaultUpdate(isDefaultChkInt);
			}
			
			
			//입력된 배송주소를 DB에 저장
			int result = shopService.shippingInfoInsert(shippingInfoVO);
			
			if(result > 0) {
				return "success";
			}
			
		}
		return "fail";
	}
	
	@ResponseBody
	@PostMapping("/addrManagerUpdateForm")
	public ShippingInfoVO addrManageUpdateForm(@AuthenticationPrincipal CustomUser customUser, @RequestBody ShippingInfoVO shippingInfoVO) {
		log.info("shippingInfoVO" + shippingInfoVO);
		
		UsersVO usersVO = null;
		
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
			
		}else {
			usersVO = customUser.getUsersVO();
			shippingInfoVO.setMemNo(usersVO.getUserNo());
		}
		
		//배송 주소 목록 가져오기
		shippingInfoVO = shopService.getShippingInfo(shippingInfoVO);
		
		log.info("shippingInfoVO : " + shippingInfoVO);
		
		return shippingInfoVO;
	}
	
	/* 배송 주소 업데이트 */
	@ResponseBody
	@PostMapping("/addrManagerUpdatePost")
	public String addrManagerUpdatePost(@AuthenticationPrincipal CustomUser customUser, ShippingInfoVO shippingInfoVO) {
		
		log.info("shippingInfoVO" + shippingInfoVO);
		
		UsersVO usersVO = null;
		
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
			return "fail";
		}else {
			usersVO = customUser.getUsersVO();
			shippingInfoVO.setMemNo(usersVO.getUserNo());
			
			//기본 배송지가 있는지 체크
			Integer isDefaultChk = shopService.shippingInfoIsDefaultChecked(usersVO.getUserNo());
			
			//기본 배송지가 있는 경우 기본 배송 주소를 N으로 변경
			if(isDefaultChk != null) {
				int isDefaultChkInt = (int)isDefaultChk; 
				shopService.shippingInfoIsDefaultUpdate(isDefaultChkInt);
			}
			
			//입력된 배송주소를 DB에 저장
			int result = shopService.shippingInfoUpdate(shippingInfoVO);
			
			if(result > 0) {
				return "success";
			}
			
		}
		return "fail";
	}
	
	/* 배송 주소 삭제 */
	@ResponseBody
	@PostMapping("/addrManagerDeletePost")
	public String addrManagerDeletePost(@AuthenticationPrincipal CustomUser customUser, @RequestBody ShippingInfoVO shippingInfoVO) {
		
		log.info("shippingInfoVO" + shippingInfoVO);
		
		UsersVO usersVO = null;
		
		if(customUser == null) {
			//비정상적인 접근으로 로그인 페이지로 이동시켜야함.
			return "fail";
		}else {
			usersVO = customUser.getUsersVO();
			shippingInfoVO.setMemNo(usersVO.getUserNo());
			
			//입력된 배송주소를 DB에 저장
			int result = shopService.shippingInfoDelete(shippingInfoVO);
			
			if(result > 0) {
				return "success";
			}
			
		}
		return "fail";
	}
	
	/* ordersPostAjax: 미사용 코드(참조용) */
	@ResponseBody
	@PostMapping("/ordersPostAjax")
	public ArtistGroupVO goodsOrdersPost(@RequestBody ArtistGroupVO artistGroupVO) {
		log.info("artistGroupVO : "+ artistGroupVO);
		return artistGroupVO;
	}
}