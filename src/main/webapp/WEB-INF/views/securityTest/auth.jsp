<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
 
<sec:authentication property="principal.memberVO.authVOList" var="authList"/>
<sec:authentication property="principal.memberVO.memLastName" var="memLastName"/>
<sec:authentication property="principal.memberVO.memFirstName" var="memFirstName"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>축하해요 ${memLastName}${memFirstName}님 인증 OK!</h1>
	<h2>${userName}님 권한은 다음과 같아요</h2>
	<ul>
		<c:forEach items="${authList}" var="auth">
			<li> ${auth.authNm} </li>
		</c:forEach>
	</ul>
 
	<h2>${userName}님 상세정보</h2>
	<p>	<sec:authentication property="principal.memberVO" /></p>
	
	<hr>
	<h2>${userNam }님 갈 수 있는 곳은</h2>
	<sec:authorize url="/ceo" access="hasRole('ADMIN')">
		<a href="/#">사당님 페이지</a><br>
	</sec:authorize>
 
	<sec:authorize url="/manager" access="hasAnyRole('ART','MEM')">
		<a href="/testOho/mem">회원 페이지</a><br>
	</sec:authorize>
	
 <!-- 
 	로그인한 사용자만 보게 하고 싶다면 isAuthenticated()
	로그인 안 한 사용자만 보게 하고 싶다면 isAnonymous()
  -->
	<sec:authorize access="isAuthenticated"> 
		<a href="/#">커뮤니티</a><br>
		<a href="/#">안녕</a><br>
	</sec:authorize>
	<sec:authorize access="isAnonymous"> 
		익명인 테스트
	</sec:authorize>
 
	<a href="/">홈</a><br>
	
</body>
</html>