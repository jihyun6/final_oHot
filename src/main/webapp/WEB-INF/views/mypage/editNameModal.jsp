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
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" style="display:none;" id="editNameModal">
    <!-- 모달 본체 -->
    <div class="bg-white rounded-xl w-full max-w-md p-8 shadow-lg">
      
      <!-- 타이틀 -->
      <h2 class="text-sm text-gray-800 font-semibold mb-1">
      	<spring:message code="mypage.name.title" />
      </h2>
      <br>
      
      <!-- 안내 텍스트 -->
      <h3 class="text-2xl font-bold text-gray-900 mb-2">
		<spring:message code="mypage.name.text" />
	  </h3>
	  <br>
      
      <!-- 성 입력 -->
      <label class="block text-sm text-gray-700 mb-1" for="nickname">
      	 <spring:message code="signup.lastnm" />
      </label>
      <div class="relative">
        <input id="memLastName" value="${memberVO.memLastName}"
          class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900"
        />
        <!-- 성 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('memLastName').value = ''">
          &#x2715;
        </button>
      </div>
      <br>
      <!-- 이름 입력 -->
      <label class="block text-sm text-gray-700 mb-1" for="nickname">
      	 <spring:message code="signup.firstnm" />
      </label>
      <div class="relative">
        <input id="memFirstName" value="${memberVO.memFirstName}"
          class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900"
        />
        <!-- 이름 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('memFirstName').value = ''">
          &#x2715;
        </button>
      </div>

      <!-- 버튼들 -->
      <div class="flex justify-between mt-10">
        <button id="cancelNameBtn" class="text-sm text-gray-700 font-semibold hover:underline">
        	<spring:message code="mypage.cancel" />
        </button>
        <button id="saveNameBtn" class="text-sm text-teal-500 font-semibold hover:underline">
        	<spring:message code="mypage.save" />
        </button>
      </div>

    </div>
  </div>
  
  
  <script>
  
  	const saveNameBtn = document.getElementById("saveNameBtn");
  	const cancelNameBtn = document.getElementById("cancelNameBtn");
  	const editNameModal = document.getElementById("editNameModal");
  	
  	const lastNmInput = document.getElementById("memLastName");
  	const firstNmInput = document.getElementById("memFirstName");
  	
  	// 입력 값 없을 시 저장버튼 숨김
  	function toggleSaveBtn() {
  	  if (lastNmInput.value.trim().length === 0 || firstNmInput.value.trim().length === 0) {
  	    saveNameBtn.style.display = "none";
  	  } else {
  	    saveNameBtn.style.display = "block";
  	  }
  	}

  	lastNmInput.addEventListener("input", toggleSaveBtn);
  	firstNmInput.addEventListener("input", toggleSaveBtn);
  	
  	
  	if(memLastName.length == 0 || memFirstName.length == 0 ) {
  		saveBtn.style.display = "none";
  	}
  	
 	// 저장 버튼을 눌렀을 때 실행
	saveNameBtn.addEventListener("click", () => {
		const memLastName = document.getElementById("memLastName").value;
		const memFirstName = document.getElementById("memFirstName").value;
		console.log("memLastName ", memLastName);
		console.log("memFirstName ", memFirstName);
		
		editAccess({ type : "name" , info1 : memLastName, info2 : memFirstName });
	});
 	
 	// 취소 버튼을 눌렀을 때 실행
 	cancelNameBtn.addEventListener("click", function(e) {
    	 editNameModal.style.display = "none";
    	 lastNmInput.value = "${memberVO.memLastName}";
    	 firstNmInput.value = "${memberVO.memFirstName}";
    });
 	
  </script>
  
  <script src="/js/mypage/editInfo.js" ></script>
</body>
</html>