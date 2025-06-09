<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.tailwindcss.com"></script>
<style>
.rule {
    color: #999; /* 기본 색 */
    transition: color 0.2s;
  }
 .valid {
   color: green; /* 유효하면 초록색으로 변경 */
 }
</style>
</head>
<body>
 <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<%-- ${userVO} --%>

<c:set var="memberVO" value="${userVO.memberVO}" />

  <!-- 모달 배경 -->
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" style="display:none;" id="editPswdModal">
    <!-- 모달 본체 -->
    <div class="bg-white rounded-xl w-full max-w-md p-8 shadow-lg">
      
      <!-- 타이틀 -->
      <h2 class="text-sm text-gray-800 font-semibold mb-1">
      	<spring:message code="mypage.pswd.title" />
      </h2>
      <br>
      <!-- 안내 텍스트 -->
      <h3 class="text-2xl font-bold text-gray-900 mb-2">
		<spring:message code="mypage.pswd.text" />
	  </h3>
      <br>
      <!-- 새로운 비밀번호 입력 -->
      <label class="block text-sm text-gray-700 mb-1" for="nickname">
      	 <spring:message code="password" />
      </label>
      <div class="relative">
      	<input id="newPw" type="password" autocomplete="current-password"
      			class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900">
		<span class="focus-input100"></span>
		<span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
	        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
	    </span>
	
        <!-- 새로운 비밀번호 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('newPw').value = ''">
          &#x2715;
        </button>
      </div>
		  <small id="rule-length" class="txt1 rule"><spring:message code="pswd.vali.1"/></small><br>
		  <small id="rule-letter" class="txt1 rule"><spring:message code="pswd.vali.2"/></small><br>
		  <small id="rule-number" class="txt1 rule"><spring:message code="pswd.vali.3"/></small><br>
		  <small id="rule-special" class="txt1 rule"><spring:message code="pswd.vali.4"/></small><br>
		
	  <br>
      
      <!-- 새로운 비밀번호 재입력 -->
      <label class="block text-sm text-gray-700 mb-1" for="nickname">
      	 <spring:message code="re.enter.pswd" />
      </label>
      <div class="relative">
		<input id="pwConfirm" type="password" autocomplete="current-password"
				class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900">
		<span class="focus-input100"></span>
		<span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
	        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
	    </span>
        <!-- 새로운 비밀번호 재입력 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('pwConfirm').value = ''">
          &#x2715;
        </button>
      </div>
      <small id="pwMsg"></small>

      <!-- 버튼들 -->
      <div class="flex justify-between mt-10">
        <button id="cancelPswdBtn" class="text-sm text-gray-700 font-semibold hover:underline">
        	<spring:message code="mypage.cancel" />
        </button>
        <button id="savePswdBtn" class="text-sm text-teal-500 font-semibold hover:underline" style="display:none;">
        	<spring:message code="mypage.save" />
        </button>
      </div>

    </div>
  </div>
  
  
  <script>
  const i18n6 = {
			pswdMatchO: "<spring:message code='pswd.match.o'/>",
			pswdMatchX: "<spring:message code='pswd.match.x'/>",
			pswdFormatCheck: "<spring:message code='pswd.format.check'/>",
			verifyFailTitle: "<spring:message code='alert.verifyFail.title'/>",
			verifyFailText: "<spring:message code='alert.verifyFail.text'/>",
			verifySuccessTitle: "<spring:message code='alert.verifySuccess.title'/>",
			verifySuccessText: "<spring:message code='alert.verifySuccess.text'/>",
			serverErrorTitle: "<spring:message code='alert.serverError.title'/>",
			serverErrorText: "<spring:message code='alert.serverError.text'/>",
		};
  
  		let isPwValid = false;
  	
	  	const savePswdBtn = document.getElementById("savePswdBtn");
	  	const cancelPswdBtn = document.getElementById("cancelPswdBtn");
	  	const editPswdModal = document.getElementById("editPswdModal");
	  	const newPwInput = document.getElementById("newPw");
		const pwConfirm = document.getElementById("pwConfirm");
		
		const ruleLength = document.getElementById("rule-length");
		const ruleLetter = document.getElementById("rule-letter");
		const ruleNumber = document.getElementById("rule-number");
		const ruleSpecial = document.getElementById("rule-special");

		pwCheck();

		// 비밀번호 유효성 체크
		newPwInput.addEventListener("input", function () {
			const pw = this.value;

			// 유효성 조건
			const isLengthOk = pw.length >= 8 && pw.length <= 32;
			const hasLetter = /[a-zA-Z]/.test(pw);
			const hasNumber = /[0-9]/.test(pw);
			const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pw);

			// 각각 조건에 따라 색 변경
			isLengthOk ? ruleLength.classList.add("valid") : ruleLength.classList.remove("valid");
			hasLetter ? ruleLetter.classList.add("valid") : ruleLetter.classList.remove("valid");
			hasNumber ? ruleNumber.classList.add("valid") : ruleNumber.classList.remove("valid");
			hasSpecial ? ruleSpecial.classList.add("valid") : ruleSpecial.classList.remove("valid");

			// 유효성 통과 여부 저장
			isPwValid = isLengthOk && hasLetter && hasNumber && hasSpecial;

			// 비밀번호 재입력 체크 다시 실행
			checkPwMatch(); // 아래 함수로 분리
		});

		// 비밀번호/비밀번호 재입력 체크 함수
		function pwCheck() {
			const pwConfirm = document.getElementById("pwConfirm");
			// checkPwMatch 콜백함수로서 참조
			pwConfirm.addEventListener("input", checkPwMatch);
		}

		function checkPwMatch() {
			const newPw = document.getElementById("newPw").value;
			const pwConfirm = document.getElementById("pwConfirm").value;
			const pwMsg = document.getElementById("pwMsg");

			if (pwConfirm === "") {
				pwMsg.textContent = "";
				savePswdBtn.style.display = "none";
				return;
			}
			
			if (pwConfirm === newPw) {
				if (isPwValid) {
					pwMsg.textContent = i18n6.pswdMatchO;
					pwMsg.style.color = "green";
					savePswdBtn.style.display = "inline-block";
				} else {
					pwMsg.textContent = i18n6.pswdFormatCheck;
					pwMsg.style.color = "red";
					savePswdBtn.style.display = "none";
				}
			} else {
				pwMsg.textContent = i18n6.pswdMatchX;
				pwMsg.style.color = "red";
				savePswdBtn.style.display = "none";
			}
		}
	
	// 비밀번호 토글
	function togglePassword(iconSpan) {
		const input = iconSpan.parentElement.querySelector('input');
		const eyeIcon = iconSpan.querySelector('i');

		if (input.type === "password") {
			input.type = "text";
			eyeIcon.classList.remove("fa-eye-slash");
			eyeIcon.classList.add("fa-eye");
		} else {
			input.type = "password";
			eyeIcon.classList.remove("fa-eye");
			eyeIcon.classList.add("fa-eye-slash");
		}
	}
 	

 	// 저장 버튼을 눌렀을 때 실행
	savePswdBtn.addEventListener("click", () => {
		const changedPswd = document.getElementById("newPw").value;
		console.log("changedPswd ", changedPswd);
		
		editAccess({ type : "memPswd" , info1 : changedPswd });
	});
 	
 	
 	// 취소 버튼을 눌렀을 때 실행
 	cancelPswdBtn.addEventListener("click", function(e) {
 		 editPswdModal.style.display = "none";
 		 newPw.value = "";
 		 pwConfirm.value = "";
 		 pwMsg.innerText="";
 		 ruleLength.classList.remove("valid");
 		 ruleLetter.classList.remove("valid");
 		 ruleNumber.classList.remove("valid");
 		 ruleSpecial.classList.remove("valid");
    });
 	
 	
  </script>
  
  <script src="/js/mypage/editInfo.js" ></script>
</body>
</html>