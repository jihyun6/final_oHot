<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - oHoT</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/mypage/mypage.css">
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

  
 <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<c:set var="memberVO" value="${userVO.memberVO}" />
<%-- ${userVO} --%>

<div class="container pt-5">
  <div class="mb-4 text-white p-4" style="background-color: #F86D72; border-radius: 12px;">
    <h4 class="text-white">${memberVO.memNicknm}</h4>
    <p class="mb-1">${memberVO.memEmail}</p>
    <div class="d-flex justify-content-between">
	    <a href="javascript:void(0)" id="myLogout" class="text-white text-decoration-underline"><spring:message code="logout"/></a>
	    <a href="javascript:void(0)" onclick="memberDelete()" class="text-white text-decoration-underline">계정삭제</a>
  </div>
  </div>
  <!-- 상단 카드 -->
  <div class="row mb-3">
    <div class="col-2 md-2">
      <button class="card-box d-flex justify-content-between align-items-center col-12" onClick="myProfile()">
        <span><strong><spring:message code="mypage.my.profile"/></strong></span>
      </button>
      <button class="card-box d-flex justify-content-between align-items-center col-12" onClick="myInquiyPost(1)">
        <span><strong><spring:message code="mypage.my.inquiries"/></strong></span>
      </button>
    </div>

    <!-- 콘텐츠 카테고리 -->
    <div class="col-md-10">
      <div class="card-box" style="height: 580px;">
        <div class="d-flex flex-column mx-5 my-2" id="mypageCard">
        </div>
      </div>
    </div>
  </div>
</div>

<form id="deleteForm" action="/member/delete" method="post" style="display: none;">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

<script>
const mypage_i18n = {
	email : "<spring:message code='mypage.email'/>",
	profile : "<spring:message code='mypage.my.profile'/>",
	nicknm : "<spring:message code='signup.nicknm'/>",
	name : "<spring:message code='mypage.name'/>",
	editBtn : "<spring:message code='mypage.edit.btn'/>",
	telno :	"<spring:message code='signup.telno'/>",
	pswd : "<spring:message code='password'/>"
		
}

</script>

<!-- 모달 -->
<jsp:include page="/WEB-INF/views/mypage/editNickModal.jsp" />
<jsp:include page="/WEB-INF/views/mypage/editNameModal.jsp" />
<%-- <jsp:include page="/WEB-INF/views/mypage/editTelNoModal.jsp" /> --%>
<jsp:include page="/WEB-INF/views/mypage/editPswdModal.jsp" />
    
<%@ include file="/WEB-INF/views/footer.jsp" %>

<script src="/js/mypage/mypage.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
