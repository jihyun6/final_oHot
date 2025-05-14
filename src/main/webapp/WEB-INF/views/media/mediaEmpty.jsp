<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHot Media</title>
<link rel="styleSheet" href="/css/media-live/media-live.css">

</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="../header.jsp" %>
<!-- 커뮤니티페이지 네비, 탭-->
<div class="border border-danger">
<header class="d-flex justify-content-center py-1">
<ul class="nav nav-pills nav-fill gap-c1">
   <li class="nav-item">
    <a class="nav-link" href="#">Fan</a>
  </li>
   <li class="nav-item">
    <a class="nav-link" href="#">Artist</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">Media</a>
  </li>
   <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${param.artGroupNo}">Live</a>
  </li>
    <li class="nav-item">
    <a class="nav-link" href="#">Shop</a>
  </li>
</ul>
</header>
</div>
<!--네비탭 끝 -->

<!-- 미디어 하위 탭 -->
<div class="border border-danger-subtle py-1">
<ul class="nav nav-pills justify-content-center gap-5">
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/new?artGroupNo=${param.artGroupNo}">최신 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/membership?artGroupNo=${param.artGroupNo}">멤버쉽 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/all?artGroupNo=${param.artGroupNo}">전체 미디어</a>
  </li>
</ul>
</div>
<!--미디어 하위 탭 끝  -->

<!-- 넘어오는 객체들 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<!-- SELECT  U.USER_NO, U.USER_MAIL, USER_PSWD, A.AUTH_NM -->
<!-- ${usersVO} -->

<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	<!-- 	<i class="bi bi-arrow-up-short"></i> -->
<script src="/main/assets/js/main.js"></script>
<%@ include file="../footer.jsp" %>
</body>
</html>