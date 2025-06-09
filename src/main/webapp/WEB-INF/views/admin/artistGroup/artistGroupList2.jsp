<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<div class="container mt-4">
				<h2 class="mb-4">아티스트 그룹 관리</h2>
				${boardPage}
				<!-- 분류명 검색 폼 -->
				<form action="/admin/artistGroup/artistGroupList" method="get"
					class="form-inline mb-3">
					<div class="form-group mr-2">
						<label for="mode" class="mr-2">분류명</label> <select name="mode"
							id="mode" class="form-control">
							<option value="all">전체</option>
							<option value="artGroupNm"
								<c:if test="${param.mode=='artGroupNm' }">selected</c:if>>그룹명</option>
							<option value="artGroupRegYmd"
								<c:if test="${param.mode=='artGroupRegYmd' }">selected</c:if>>등록일</option>
						</select>

					</div>
					<div class="form-group mr-2">
						<input type="text" name="keyword" placeholder="검색어 입력"
							class="form-control" />
					</div>
					<button type="submit" class="btn btn-primary mr-2">검색</button>
					<a href="/admin/artistGroup/artistGroupRegister"><button
							type="button" class="btn btn-primary">등록</button></a>
				</form>


				<!-- 테이블 스타일링 -->
				<div class="table-responsive">
					<table class="table table-bordered table-striped">
						<thead class="thead-dark">
							<tr>
								<th>No</th>
								<th>아티스트 그룹명</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="artistGroupVO" items="${boardPage.content}"
								varStatus="stat">
								<tr>
									<td>${artistGroupVO.rnum}</td>
									<td><a
										href="/admin/artistGroup/artistGroupDetail?artGroupNo=${artistGroupVO.artGroupNo}">
											${artistGroupVO.artGroupNm} </a></td>
									<td>${artistGroupVO.artGroupRegYmd}</td>
								</tr>
							</c:forEach>
						</tbody>
						
					</table>
			
					<div class="d-flex justify-content-center mt-3">
						<ul class="pagination">
							<li class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a href="/admin/artistGroup/artistGroupList?currentPage=1&keyword=${param.keyword}&mode=${param.mode}" class="page-link"><<</a>
							</li>
							<li class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a href="/admin/artistGroup/artistGroupList?currentPage=${boardPage.startPage - 1}&keyword=${param.keyword}&mode=${param.mode}" class="page-link"><</a>
							</li>

							<c:forEach var="pNo" begin="${boardPage.startPage}" end="${boardPage.endPage}" step="1">
								<li class="paginate_button page-item <c:if test='${param.currentPage == pNo}'>active</c:if>">
									<a href="/admin/artistGroup/artistGroupList?currentPage=${pNo}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">${pNo}</a>
								</li>
							</c:forEach>

							<li class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a href="/admin/artistGroup/artistGroupList?currentPage=${boardPage.startPage + boardPage.blockSize}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">></a>
							</li>
							<li class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a href="/admin/artistGroup/artistGroupList?currentPage=${boardPage.totalPages}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">>></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!--
		EL태그 정리 
		== : eq(equal)
		!= : ne(not equal)
		<  : lt(less than)
		>  : gt(greater than)
		<= : le(less equal)
		>= : ge(greater equal)
	  -->
			
		</div>

		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>

	</div>
</body>
</html>