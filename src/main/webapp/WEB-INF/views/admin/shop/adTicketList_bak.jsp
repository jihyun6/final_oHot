<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">	
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<!-- 컨텐츠-->
	<div class="content-wrapper">
		<h1>TICKETlIST </h1>
<%-- 		${goodsVOList } --%>
		<div class="row text-center" style="padding: 40px;">
			<a type="button" href="/admin/shop/adTicketCreate"  class="btn btn-primary col-sm-1 ms-auto" >공연등록</a>
			<div class="card-body table-responsive p-0"  style="text-align: center">
				<table class="table table-hover text-nowrap">
					<thead>
						<th>상품넘버</th>
						<th>포스터</th>
						<th>공연명</th>
						<th>공연장소</th>
						<th>공연기간</th>
						<th>대표가격</th>
						<th>공연자</th>
						<th>담당자</th><label ></label>
						<th>등록일자</th>
					</thead>
					<tbody>
						<c:forEach var="goodsVO" items="${goodsVOList}" varStatus="stat">
							<tr onclick="location.href='adTicketDetail?gdsNo=${goodsVO.gdsNo }'" style="cursor: pointer;">
								<td>${goodsVO.gdsNo}</td>
								<td><img src="/upload/${goodsVO.ticketVO.tkFileSaveLocate}" alt="포스터등록" width="50px" height="80px"></td>
								<td>${goodsVO.gdsNm}</td>
								<td>${goodsVO.ticketVO.tkLctn}</td>
								<td>${goodsVO.ticketVO.tkStartYmd } ~ ${goodsVO.ticketVO.tkFinishYmd }</td>
								<td><fmt:formatNumber type="number">${goodsVO.unitPrice}</fmt:formatNumber>원</td>
								<c:if test="${empty goodsVO.artGroupNm}">
									<td>${goodsVO.artActNm }</td>
								</c:if>
								<c:if test="${empty goodsVO.artActNm}">
									<td>${goodsVO.artGroupNm}</td>
								</c:if>
								<td>${goodsVO.pic}</td>
								<td>${goodsVO.regDt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		
		</div>
	</div>

	<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
	
</div>
</body>
</html>