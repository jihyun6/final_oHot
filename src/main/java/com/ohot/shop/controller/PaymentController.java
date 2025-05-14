package com.ohot.shop.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.interfaces.RSAPrivateCrtKey;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.crypto.RSADecrypter;
import com.nimbusds.jwt.EncryptedJWT;
import com.ohot.home.community.vo.CommunityProfileVO;
import com.ohot.shop.service.PaymentService;
import com.ohot.shop.vo.GoodsVO;
import com.ohot.shop.vo.MemberShopVO;
import com.ohot.shop.vo.OrdersDetailsVO;
import com.ohot.shop.vo.OrdersVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.SeqGeneratorVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	CartController cartController;
	
	@GetMapping("/confirm")
	public String confirmPayment(String orderId, 
								 String amount, 
								 String paymentKey, 
								 HttpSession session, 
								 @AuthenticationPrincipal CustomUser customUser) throws Exception {
		
		//서버에서 반환되는 reader값을 JSON으로 변환하기 위해 사용
		JSONParser parser = new JSONParser();
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("orderId", orderId);
		param.put("amount", amount);
		param.put("paymentKey", paymentKey);
		
		//Param JSON 설정
		JSONObject obj = new JSONObject(param);
//        obj.put("orderId", orderId);
//        obj.put("amount", amount);
//        obj.put("paymentKey", paymentKey);
        
        // TODO: 개발자센터에 로그인해서 내 결제위젯 연동 키 > 시크릿 키를 입력하세요. 시크릿 키는 외부에 공개되면 안돼요.
        // @docs https://docs.tosspayments.com/reference/using-api/api-keys
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        
		// 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
		// 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
		// @docs
		// https://docs.tosspayments.com/reference/using-api/authorization#%EC%9D%B8%EC%A6%9D
		Base64.Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
		String authorizations = "Basic " + new String(encodedBytes);
        
		// 결제 승인 API를 호출하세요.
        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        // @docs https://docs.tosspayments.com/guides/v2/payment-widget/integration#3-결제-승인하기
		URI uri = new URI("https://api.tosspayments.com/v1/payments/confirm");
		URL url = uri.toURL();
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        
        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(obj.toString().getBytes("UTF-8"));

        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;
        
        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
        
        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject jsonObject = (JSONObject) parser.parse(reader);
        responseStream.close();
        
        log.info("jsonObject" + jsonObject);
        
        //결제정보확인
        List<GoodsVO> goodsVOList = (List<GoodsVO>)session.getAttribute("goodsVOList");
        
        log.info("goodsVOList : " + goodsVOList.get(0).getGramt());
        log.info("totalAmount : " + jsonObject.get("totalAmount"));
        
        //결제정보 중 
        int gramtClient = goodsVOList.get(0).getGramt();
        int gramtServer = Integer.parseInt(jsonObject.get("totalAmount").toString());
        
        if(gramtClient != gramtServer) {
        	log.info("비 정상적인 결제입니당! : " + jsonObject);
        	return "redirect:/payment/fail";
        }else {
        	//정상 결제가 이루어진경우 session에서 값을 꺼내서 DB에 저장하는 코드
        	SeqGeneratorVO seqGeneratorVO = (SeqGeneratorVO)session.getAttribute("seqGeneratorVO");
        	OrdersVO ordersVO = new OrdersVO();
        	UsersVO usersVO = new UsersVO();
        	
        	usersVO = customUser.getUsersVO();
        	
        	int orderNo = Integer.parseInt(seqGeneratorVO.getCrtrYmd() + seqGeneratorVO.getReqSn());
        	
        	ordersVO.setOrderNo(orderNo);
        	ordersVO.setMemNo(usersVO.getUserNo());
        	ordersVO.setGramt(gramtClient);
        	ordersVO.setStlmYn("Y");
        	
        	
        	List<OrdersDetailsVO> ordersDetailsVOList = new ArrayList<OrdersDetailsVO>();
        	
        	log.info("goodsVOList.size() : " + goodsVOList.size());
        	
        	for(int i=0;i<goodsVOList.size();i++) {
        		//주문 상세 만들기
        		OrdersDetailsVO ordersDetailsVO = new OrdersDetailsVO();
        		
        		ordersDetailsVO.setGdsNo(goodsVOList.get(i).getGdsNo());
        		ordersDetailsVO.setOrderNo(orderNo);
        		ordersDetailsVO.setQty(goodsVOList.get(i).getQty());
        		ordersDetailsVO.setAmount(goodsVOList.get(i).getAmount());
        		ordersDetailsVO.setOption1(goodsVOList.get(i).getCommCodeGrpNo());
        		ordersDetailsVO.setOption2(goodsVOList.get(i).getOption2());
        		ordersDetailsVOList.add(i, ordersDetailsVO);
        	}
        	
        	log.info("ordersDetailsVOList : " + ordersDetailsVOList);
        	
        	ordersVO.setOrdersDetailsVOList(ordersDetailsVOList);
        	paymentService.ordersInsert(ordersVO, seqGeneratorVO);
        }
        
        return "redirect:/payment/success";
    }
	
	 /**
     * 인증성공처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@ResponseBody
	@Transactional
    @GetMapping(value = "/complete")
    public String paymentRequest(HttpSession session, 
    							 @AuthenticationPrincipal CustomUser customUser,
    							 @RequestParam(value="shippingInfoNo", defaultValue = "0") int shippingInfoNo,
    							 Model model) throws Exception {
    	//결제정보확인
        List<GoodsVO> goodsVOList = (List<GoodsVO>)session.getAttribute("goodsVOList");
        log.info("goodsVOList : " + goodsVOList.get(0).getGramt());
        
        //정상 결제가 이루어진경우 session에서 값을 꺼내서 DB에 저장하는 코드
    	SeqGeneratorVO seqGeneratorVO = (SeqGeneratorVO)session.getAttribute("seqGeneratorVO");
    	OrdersVO ordersVO = new OrdersVO();
    	UsersVO usersVO = new UsersVO();
    	
    	usersVO = customUser.getUsersVO();
    	
    	int orderNo = Integer.parseInt(seqGeneratorVO.getCrtrYmd() + seqGeneratorVO.getReqSn());
    	int gramtClient = goodsVOList.get(0).getGramt();
    	
    	ordersVO.setOrderNo(orderNo);
    	ordersVO.setMemNo(usersVO.getUserNo());
    	ordersVO.setGramt(gramtClient);
    	ordersVO.setStlmYn("N");
    	ordersVO.setOrderPayNo(seqGeneratorVO.getUuid().toString());
    	ordersVO.setShippingInfoNo(shippingInfoNo);
    	
    	List<OrdersDetailsVO> ordersDetailsVOList = new ArrayList<OrdersDetailsVO>();
    	
    	log.info("goodsVOList.size() : " + goodsVOList.size());
    	
    	String gdsType = goodsVOList.get(0).getGdsType();
    	
    	log.info("gdsType : " + gdsType);
    	
    	//MemberShip인경우 MemberShip Table Insert!
    	if(gdsType != null && "M".equals(gdsType)) {
    		MemberShopVO memberShopVO = new MemberShopVO();
    		
    		memberShopVO.setGdsNo(goodsVOList.get(0).getGdsNo());
    		memberShopVO.setMemNo(usersVO.getUserNo());
    		
    		//COM_PROFILE_NO 찾아오기
    		CommunityProfileVO communityProfileVO= paymentService.findComProfileNo(memberShopVO);
    		log.info("communityProfileVO : " + communityProfileVO);
    		
    		memberShopVO.setComProfileNo(communityProfileVO.getComProfileNo());
    		
    		//Member Ship Table Insert!
    		int result = paymentService.memberShipInsert(memberShopVO);
    		
    		if(result > 0) {
    			//COMMUNITY_PROFILE MemberShip_N => Y
    			paymentService.CommunityProfileUpdate(communityProfileVO);
    		}
    	}
    	
    	for(int i=0;i<goodsVOList.size();i++) {
    		//주문 상세 만들기
    		OrdersDetailsVO ordersDetailsVO = new OrdersDetailsVO();
    		
    		ordersDetailsVO.setGdsNo(goodsVOList.get(i).getGdsNo());
    		ordersDetailsVO.setOrderNo(orderNo);
    		ordersDetailsVO.setQty(goodsVOList.get(i).getQty());
    		ordersDetailsVO.setAmount(goodsVOList.get(i).getAmount());
    		ordersDetailsVO.setOption1(goodsVOList.get(i).getCommCodeGrpNo());
    		ordersDetailsVO.setOption2(goodsVOList.get(i).getOption2());
    		ordersDetailsVOList.add(i, ordersDetailsVO);
    	}
    	
    	log.info("ordersDetailsVOList : " + ordersDetailsVOList);
    	
    	ordersVO.setOrdersDetailsVOList(ordersDetailsVOList);
    	paymentService.ordersInsert(ordersVO, seqGeneratorVO);
    	
    	//model
    	model.addAttribute("ordersVO", ordersVO);
    	model.addAttribute("goodsVOList", goodsVOList);
    	//cartController.cartDeleteList(goodsVOList, customUser);
    	
    	return "complete";
    }
    
	@Transactional
	@ResponseBody
	@GetMapping("/completeUpdate")
	public String completeUpdate(@AuthenticationPrincipal CustomUser customUser, 
			 					 @RequestParam String paymentKey,
			 					 @RequestParam int gramt,
			 					 HttpSession session,
			 					 Model model) {
		
		
		UsersVO usersVO = null;
		
    	//
    	if(customUser != null ) {
    		usersVO = customUser.getUsersVO();
    	}
    	
//    	log.info("gramt : " + gramt);
    	
//    	gramt = 0;
    	
    	String returnURL = "payment/fail";
    	
		//OrdersVO 조회(회원의 마지막 주문번호를 조회)
    	OrdersVO ordersVO = paymentService.getLatestOrder(usersVO);
    	
    	if(gramt != ordersVO.getGramt()) {
    		ordersVO.setStlmYn("N");
    	}else {
    		ordersVO.setStlmYn("Y");
    	}
    	
    	ordersVO.setPaymentKey(paymentKey);
    	int result = paymentService.UpdateOrdersComplete(ordersVO);
    	
    	if(result > 0 && "Y".equals(ordersVO.getStlmYn())) {
    		returnURL = "payment/success";
    	}
    	
    	//model
    	model.addAttribute("ordersVO", ordersVO);
    	
    	//cart 지우기
    	List<GoodsVO> goodsVOList = (List<GoodsVO>)session.getAttribute("goodsVOList");
    	cartController.cartDeleteList(goodsVOList, customUser);
    	
		return returnURL;
	}
    
    
    @GetMapping("/success")
    public String success(@AuthenticationPrincipal CustomUser customUser, Model model) {
    	UsersVO usersVO = null;
    	
    	//
    	if(customUser != null ) {
    		usersVO = customUser.getUsersVO();
    	}
    	
    	//OrdersVO 조회(회원의 마지막 주문번호를 조회)
    	OrdersVO ordersVO = paymentService.getLatestOrder(usersVO);
    	
    	log.info("ordersVO : " + ordersVO);
    	model.addAttribute("ordersVO", ordersVO);
    	
    	return "payment/success";
    }
    
    
    @GetMapping("/completeForm")
    public String completeForm(@AuthenticationPrincipal CustomUser customUser, Model model) {
    	UsersVO usersVO = null;
    	
    	//
    	if(customUser != null ) {
    		usersVO = customUser.getUsersVO();
    	}
    	
    	//OrdersVO 조회(회원의 마지막 주문번호를 조회)
    	OrdersVO ordersVO = paymentService.getLatestOrder(usersVO);
    	
    	log.info("ordersVO : " + ordersVO);
    	model.addAttribute("ordersVO", ordersVO);
    	
    	return "payment/complete";
    }
	
	/**
     * 인증실패처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/fail")
    public String failPayment(@RequestParam(value="error" , defaultValue = "오류가 발생했습니다.") String error, Model model) throws Exception {
    	
    	log.info("error : " + error);
    	model.addAttribute("error", error);
    	
        return "payment/fail";
    }
    
    @ResponseBody
    @PostMapping(value= "/decrypterPayment")
    public String decrypterPayment(@RequestBody Map<String,Object> jwtPayment, HttpSession session) {
    	
    	log.info("jwtPayment : " + jwtPayment);
    	
    	String jwtString = String.valueOf(jwtPayment.get("jwtString"));
    	
    	jwtString = jwtString.replace("\"", "");
    	
    	log.info("jwtString : " + jwtString);
    	
    	KeyPair keyPair = (KeyPair) session.getAttribute("keyPair");
    	
    	// Parse
		EncryptedJWT encryptedJWT;
		String claim = null;
		try {
			encryptedJWT = EncryptedJWT.parse(jwtString);
			
			RSAPrivateCrtKey rsaPrivateCrtKey = (RSAPrivateCrtKey) keyPair.getPrivate();

			// Create a decrypter with the specified private RSA key
			RSADecrypter decrypter = new RSADecrypter(rsaPrivateCrtKey);

			// Decrypt
			encryptedJWT.decrypt(decrypter);
			
			log.info("encryptedJWT : " + encryptedJWT.getJWTClaimsSet().getClaim("gramt"));
			claim = String.valueOf(encryptedJWT.getJWTClaimsSet().getClaim("gramt")); 
			
		} catch (ParseException | JOSEException e) {
			e.printStackTrace();
		}
    	
    	return claim;
    }
}