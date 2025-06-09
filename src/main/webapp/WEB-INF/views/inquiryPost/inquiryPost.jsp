<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8">
 <title>oHoT - 문의하기</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  .empty-row {
    text-align: center !important;
    vertical-align: middle !important;
    height: 100px !important;
    font-size: 1.2rem !important;
  }
   /* 활성 페이지 색상 */
  .pagination .page-item.active .page-link {
    background-color: #F86D72 !important;
    border-color: #F86D72 !important;
    color: white !important;
  }

  /* 일반 페이지 */
  .pagination .page-link {
    color: #2d3436 !important; /* 텍스트 색상 */
  }

  .pagination .page-link:hover {
    background-color: #dfe6e9 !important;
  }

  /* 비활성화 상태 */
  .pagination .page-item.disabled .page-link {
    color: #b2bec3 !important;
    pointer-events: none !important;
    background-color: #f1f2f6 !important;
  }
   .btn-outline-custom {
    color: #F86D72 !important;
    border: 1px solid #F86D72 !important;
    background-color: transparent !important;
    transition: all 0.2s ease !important;
  }

  .btn-outline-custom:hover {
    background-color: #F86D72 !important;
    color: #fff !important;
  }
</style>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>
<sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<c:set var="memberVO" value="${userVO.memberVO}" />
<!-- <p>유저 정보</p> -->
<%-- ${userVO} --%>

<div class="container py-5">
  <!-- 콘텐츠 내용 시작 -->
    <div style="height: 700px;">
    	<div class="d-flex">
      		<h2 class="col-6"><spring:message code="mypage.my.inquiries"/></h2>
       		<form onsubmit="return false;" id="srhFrm" class="d-flex gap-2 align-items-center flex-wrap">
			  <select id="inqType" class="form-select form-select-sm w-auto">
			    <option value="" selected>문의유형(전체)</option>
			    <c:forEach var="type" items="${inqTypeVOList}">
			      <option value="${type.inqTypeNo}">${type.inqTypeNm}</option>
			    </c:forEach>
			  </select>

			  <select id="mode" class="form-select form-select-sm w-auto">
			    <option value="bbsTitle">제목</option>
			    <option value="bbsCn">내용</option>
			    <option value="inqWriter">작성자</option>
			  </select>
			  <input id="keyword" class="form-control form-control-sm w-auto" placeholder="검색어 입력">
			
			  <button id="btnSearch" class="btn btn-sm btn-outline-custom">
			    검색
			  </button>
			  <button id="btnReset" class="btn btn-sm btn-outline-secondary">
			    초기화
			  </button>
			</form>
    	</div>
    	<br>
      	<table class="table table-hover">
		  <thead>
		    <tr>
		      <th scope="col">No</th>
		      <th scope="col">문의유형</th>
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">작성일</th>
		      <th scope="col">비밀글</th>
		    </tr>
		  </thead>
		  <tbody class="table-group-divider" id="listBody">
		  </tbody>
		</table>
    </div>
    
    <div class="row mt-2">
	    <!-- 페이지네이션 들어갈 곳 -->
	    <div id="pagination-container" class="col-11 d-flex justify-content-center mt-3 ps-5"></div>
	    <form action="/oho/inquiryPost/createPost" method="get" class="col-1">
		   	<button class="btn mt-3" style="background-color: #F86D72; color: white;" >
				등록
			</button>
		</form>
    </div>
    
  <!-- 콘텐츠 내용 끝 -->
	
</div>


<!-- 비밀번호 입력 모달 -->
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" id="pswdModal" style="display:none;">
    <!-- 모달 본체 -->
    <div class="bg-white rounded-xl w-full max-w-md p-8 shadow-lg">
      
      <!-- 타이틀 -->
      <h2 class="text-sm text-gray-800 font-semibold mb-1">
      	비밀글
      </h2>
      <br>
      
      <!-- 안내 텍스트 -->
      <h3 class="text-2xl font-bold text-gray-900 mb-2">
		숫자 4자리를 입력해 주세요.
	  </h3>
	  <br>
      
      <div class="relative">
        <input id="inputPswd" type="password" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '')"
      			class="w-full border-b border-gray-300 focus:outline-none focus:border-black pb-1 pr-6 text-gray-900">
		<span class="focus-input100"></span>
		<span onclick="togglePassword(this)" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;">
	        <i id="eyeIcon" class="fa fa-eye-slash" aria-hidden="true"></i>
	    </span>
        <!-- 성 삭제 버튼 (x 아이콘) -->
        <button class="absolute right-0 top-1 text-gray-400 hover:text-gray-600" onclick="document.getElementById('memLastName').value = ''">
          &#x2715;
        </button>
      </div>
      <br>

      <!-- 버튼들 -->
      <div class="flex justify-between mt-10">
        <button id="cancelBtn" class="text-sm text-gray-700 font-semibold hover:underline">
        	<spring:message code="mypage.cancel" />
        </button>
        <button id="nextBtn" class="text-sm text-teal-500 font-semibold hover:underline">
        	입력
        </button>
      </div>

    </div>
  </div>
  
<script>
function failAlert() {
	Swal.fire({
	    icon: 'error',
	    title: '비밀번호 불일치',
	    text: '다시 입력해 주세요',
	    confirmButtonText: '확인'
	})
}
</script>


<script src="/js/inquiryPost/inquiryPost.js?a=2"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
