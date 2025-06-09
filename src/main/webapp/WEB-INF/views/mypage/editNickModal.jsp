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
</head>
<body>
 <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<%-- ${userVO} --%>

<c:set var="memberVO" value="${userVO.memberVO}" />

  <!-- 모달 배경 -->
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" style="display:none;" id="editNickModal">
    <!-- 모달 본체 -->
    <div class="bg-white rounded-xl w-full max-w-md p-8 shadow-lg">
      
      <!-- 타이틀 -->
      <h2 class="text-sm text-gray-800 font-semibold mb-1">
      	<spring:message code="mypage.nicknm.title1" />
      </h2>
      <br>
      <!-- 안내 텍스트 -->
      <h3 class="text-2xl font-bold text-gray-900 mb-2">
		<spring:message code="mypage.nicknm.title2" />
	  </h3>
      <p class="text-sm text-gray-500 mb-6">
        <spring:message code="account.text" />
      </p>
      
      <!-- 닉네임 입력 -->
      <label class="block text-sm text-gray-700 mb-1" for="nickname">
      	 <spring:message code="signup.nicknm" />
      </label>
      <div class="relative">
        <input id="memNicknm" value="${memberVO.memNicknm}"
          class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900"
        />
        <!-- 닉네임 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('memNicknm').value = ''">
          &#x2715;
        </button>
      </div>

      <!-- 버튼들 -->
      <div class="flex justify-between mt-10">
        <button id="cancelBtn" class="text-sm text-gray-700 font-semibold hover:underline">
        	<spring:message code="mypage.cancel" />
        </button>
        <button id="duplBtn" class="text-sm text-teal-500 font-semibold hover:underline" onClick="nickDuplCheck()">
        	<spring:message code="signup.dupl.btn" />
        </button>
        <button id="saveBtn" class="text-sm text-teal-500 font-semibold hover:underline" style="display: none;">
        	<spring:message code="mypage.save" />
        </button>
      </div>

    </div>
  </div>
  
  
  <script>
  
  const i18n5 = {
			nicknm: "<spring:message code='signup.nicknm'/>",
			nicknmText: "<spring:message code='signup.nicknm.text'/>",
			duplicatedTitle1: "<spring:message code='alert.duplicated.title1'/>",
			duplicatedTitle2: "<spring:message code='alert.duplicated.title2'/>",
			duplicatedText1: "<spring:message code='alert.duplicated.text1'/>",
			duplicatedText2: "<spring:message code='alert.duplicated.text2'/>",
			duplFailTitle: "<spring:message code='alert.duplFail.title'/>",
			duplFailText: "<spring:message code='alert.duplFail.text'/>",
			duplSuccessTitle1: "<spring:message code='alert.duplSuccess.title1'/>",
			duplSuccessTitle2: "<spring:message code='alert.duplSuccess.title2'/>",
			valiFailTitle1: "<spring:message code='alert.valiFail.title1'/>",
			valiFailTitle2: "<spring:message code='alert.valiFail.title2'/>",
			valiFailText: "<spring:message code='alert.valiFail.text'/>",
			editSuccess: "<spring:message code='mypage.edit.success'/>",
			editFailTitle: "<spring:message code='mypage.edit.fail.title'/>",
			editFailText: "<spring:message code='mypage.edit.fail.text'/>",
			confirm: "<spring:message code='alert.confirm' />"
		}
  

	  
  
  	let nickChecked = false;
  	
  	const duplBtn = document.getElementById("duplBtn");
  	const saveBtn = document.getElementById("saveBtn");
  	const cancelBtn = document.getElementById("cancelBtn");
  	const editNickModal = document.getElementById("editNickModal");
  	
 	// 닉네임 입력 감지 시 다시 중복검사 유도
  	document.getElementById("memNicknm").addEventListener("input", function(e) {
  	    nickChecked = false; // 검사 결과 무효화
  	 	saveBtn.style.display = "none";
  	  	duplBtn.style.display = "inline-block";
  	})
  	
	//닉네임 중복 검사
	function nickDuplCheck() {

		// 1. 입력값 형식 검사
		const memNicknm = document.getElementById("memNicknm");

		// 1-1. 형식에 일치 할 경우
		if (memNicknm.value.length > 0 && memNicknm.value.length <= 20) { // 20자 이하

			axios.post("/nickDuplCheck", { memNicknm : memNicknm.value }).then(resp => {
				console.log("nickDuplCheck : ",resp.data);
				
				if(resp.data == "duplicate") { // 중복됨
					duplicated(i18n5.nicknm);
				} else if(resp.data == "fail") { // 실패
					duplFail();
				} else { // 성공!
					duplSuccess(i18n5.nicknm);
				
					duplBtn.style.display = "none";
					saveBtn.style.display = "inline-block";
				}
			})
		} else { //1-2. 형식에 불일치할 경우
			valiFail(i18n5.nicknm);
		}
	}
 	

 	// 저장 버튼을 눌렀을 때 실행
	saveBtn.addEventListener("click", () => {
		const changedNicknm = document.getElementById("memNicknm").value;
		console.log("changedNicknm ", changedNicknm);
		
		editAccess({ type : "memNicknm" , info1 : changedNicknm });
	});
 	
 	// 취소 버튼을 눌렀을 때 실행
 	cancelBtn.addEventListener("click", function(e) {
    	 editNickModal.style.display = "none";
    	 memNicknm.value = "${memberVO.memNicknm}";
    });
 	
  </script>
  
  <script src="/js/mypage/editInfo.js" ></script>
</body>
</html>