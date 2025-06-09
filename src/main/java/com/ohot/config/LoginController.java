package com.ohot.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.mapper.UsersMapper;
import com.ohot.service.MemberService;
import com.ohot.vo.CustomUser;
import com.ohot.vo.MemberVO;
import com.ohot.vo.UsersVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	
	@Autowired
	UsersMapper usersMapper;
	
	@Autowired
	MemberService memberService;
	
	 @Autowired
     private JavaMailSender mailSender;
	
	 	// 홈페이지, 굿즈샵 로그인
		@GetMapping("/login")
		public String loginPage(@RequestParam(required = false) String redirectURL
								, @AuthenticationPrincipal CustomUser customUser
				) {
			log.info("로그인 페이지 포워딩");
			log.info("loginPage -> redirectURL : "+redirectURL);
			
			// 이미 로그인한 사용자면 홈으로 리디렉트
			log.info("loginPage -> customUser : " + customUser);
			if (customUser != null) {
		        return "redirect:/oho";
			}
			
			return "login";
		}
		
		@GetMapping("/emp/login")
		public String employeeLogin() {
			log.info("직원 로그인 포워딩");
			
			return "employee/empLogin";
		}
		
		// 관리자 로그인
		@GetMapping("/admin/login")
		public String adminLogin() {
			log.info("관리자 로그인 포워딩");
			
			return "admin/adminLogin";
		}
		
		@PostMapping("/logout")
		public void logout(HttpServletRequest request, HttpServletResponse response) {
			new SecurityContextLogoutHandler().logout(request, response, 
					SecurityContextHolder.getContext().getAuthentication()
					);
		}
		
		@PostMapping("/admin/logout")
		public void adminlogout(HttpServletRequest request, HttpServletResponse response) {
			new SecurityContextLogoutHandler().logout(request, response, 
					SecurityContextHolder.getContext().getAuthentication()
					);
		}
		
		@PostMapping("/emp/logout")
		public void emplogout(HttpServletRequest request, HttpServletResponse response) {
			new SecurityContextLogoutHandler().logout(request, response, 
					SecurityContextHolder.getContext().getAuthentication()
					);
		}
		
		// 로그인 요청
		@GetMapping("/loginRequired")
		public String loginRequired(@RequestParam String from) {
			log.info("loginRequired -> from : " + from);
			
			return "/loginRequired";
		}
		
		// 회원가입
		@PostMapping("/signup")
		public String signup(@RequestParam String newEmail
							, @RequestParam String newPassword
							, Model model
				) {
			log.info("newEmail : "+ newEmail);
			log.info("newPassword : "+ newPassword);
			
		    model.addAttribute("memEmail", newEmail);
		    model.addAttribute("memPswd", newPassword);
		    model.addAttribute("snsMemYn", "N");
			
			return "signup";
		}
		
		// 카카오 회원가입일 경우
		@GetMapping("/signup")
		public String signup(Model model
							, HttpSession session
				) {
			String email = (String) session.getAttribute("KAKAO_EMAIL");
			 log.info("가입 요청 카카오 이메일 : " + email);

			 model.addAttribute("snsMemYn", "Y");
			 model.addAttribute("memEmail", email);
			 model.addAttribute("memPswd", "kakao");

		    return "signup"; // → signup.jsp 렌더링
		}
		
		// 회원가입 진행
		@PostMapping("/signupAccess")
		public String signupAccess(MemberVO memberVO,
									HttpServletRequest request
				) {
			log.info("signupAccess -> memberVO : "+ memberVO);
			
			if(memberVO != null) {
				int result = this.memberService.signUp(memberVO);
				
				// 가입 실패
				if(result==0) {
					return "redirect:" + request.getRequestURI()+ "?error=true";
				}
				// 가입 성공
				else {
					log.info("여기 오나????");
					HttpSession session = request.getSession(false); // false -> 새 세션을 만들지 않고 이미 있는 세션만 가져 옴
			        if (session != null) session.invalidate();
			        
		            return "redirect:/login?signup=true";
				}
			} else {
				return"redirect:" + request.getRequestURI()+ "?error=true";
			}
			
		}
		
		// 이메일 체크 비동기
		@ResponseBody
		@PostMapping("/emailCheck")
		public String emailCheck(@RequestBody Map<String, Object> map) {
			log.info("map : " + map);
			String email = (String) map.get("email");
			log.info("email : " + email);
			
			String result;
			
			UsersVO usersVO = this.usersMapper.findByEmail(email);
			log.info("usersVO : " + usersVO);
			if(usersVO == null) {
				result = "success";
			}else result = "fail";
			
			return result;
		}
		
		// 인증코드 발송
		@ResponseBody
		@PostMapping("/sendCode")
		public ResponseEntity<?> sendCode(@RequestBody Map<String, Object> map, HttpSession session) {
			log.info("map : "+ map);
			String email = (String) map.get("email");
			String code = createCode();
			
			// 인증 정보 객체 생성
			Map<String, Object> authInfo = new HashMap<>();
			authInfo.put("code", code);
			authInfo.put("time", System.currentTimeMillis());
			
			// 세션에 저장
			session.setAttribute("auth_" + email, authInfo);
			
			sendEmail(email, code);
			
			return ResponseEntity.ok().build();
		}
		
		// 인증번호 일치 여부 확인
		@ResponseBody
		@PostMapping("/verifyCode")
		public ResponseEntity<?> verifyCode(@RequestBody Map<String, Object> map, HttpSession session) {
			log.info("verifyCode -> map : " + map);
			String email = (String)map.get("email");
			String inputCode = (String)map.get("code");
			
			
			@SuppressWarnings("unchecked")
			Map<String, Object> authInfo = (Map<String, Object>) session.getAttribute("auth_"+email);
			
			// 해당 이메일에 대한 인증정보 객체가 없을 경우
			if(authInfo == null) return ResponseEntity.ok("fail");
			
			String correctCode = (String)authInfo.get("code");
			long sentTime = (long)authInfo.get("time");
			long now = System.currentTimeMillis();
			
			// 유효시간 (3분 = 180,000 ms) 초과 했을 경우
			if(now-sentTime > 180000) {
				// session에서 해당 이메일 삭제
				session.removeAttribute("auth_"+email);
				return ResponseEntity.ok("timeOut");
			}
			
			// 입력코드와 세션에 저장된 코드(발급된코드)가 일치할 경우
			if(inputCode.equals(correctCode)) {
				// session에서 해당 이메일 삭제
				session.removeAttribute("auth_"+email);
				return ResponseEntity.ok("success");
			}
			
			return ResponseEntity.ok("fail");
		}
		
		// 설정한 메일로 코드 전송
		private void sendEmail(String email, String code) {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(email);
			message.setSubject("[oHoT] 이메일 인증 코드");
			message.setText("인증코드: " +  code);
			mailSender.send(message);
		}
		
		// 인증코드 6자리 생성
		private String createCode() {
			return String.valueOf((int)(Math.random() * 900000 ) + 100000 );
		}
		
		// 핸드폰 번호 중복검사
		@ResponseBody
		@PostMapping("/phoneDuplCheck")
		public ResponseEntity<?> phoneDuplCheck(@RequestBody Map<String, Object> data) {
			log.info("data : "+ data);
			
			if(data != null) {
				log.info("data : "+ data.get("memTelno"));
				MemberVO memberVO = this.memberService.phoneDuplCheck((String)data.get("memTelno"));
				if(memberVO != null) return ResponseEntity.ok("duplicate");
				else return ResponseEntity.ok("success");
			}else return ResponseEntity.ok("fail");
		}
		
		// 닉네임 중복 검사
		@ResponseBody
		@PostMapping("/nickDuplCheck")
		public ResponseEntity<?> nickDuplCheck(@RequestBody Map<String, Object> data) {
			log.info("data : "+data);
			
			if(data != null) {
				MemberVO memberVO = this.memberService.nickDuplCheck((String)data.get("memNicknm"));
				if(memberVO != null) return ResponseEntity.ok("duplicate");
				else return ResponseEntity.ok("success");
			}else return ResponseEntity.ok("fail");
		}
	
		
		// 회원 탈퇴
		@PostMapping("/member/delete")
		public String deleteMember(HttpServletRequest request
									, @AuthenticationPrincipal CustomUser customUser) {
		    // 1. 현재 유저 아이디 가져오기
		    int memNo = (int)customUser.getUsersVO().getUserNo();
		    
		    // 2. 서비스 통해 DB에서 사용자 삭제
		    this.memberService.memberDelete(memNo);
		    
		    // 3. Security 로그아웃 처리
		    SecurityContextHolder.clearContext();
		    
		    // 4. 세션 무효화
		    HttpSession session = request.getSession(false);
		    if (session != null) {
		        session.invalidate();
		    }

		    return "redirect:/oho";  // 탈퇴 완료 페이지로 리디렉션
		}
		
}
