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
				<h2 class="mb-4">아티스트 관리</h2>
				${boardPage}
				<!-- 분류명 검색 폼 -->
				<!-- 분류명 검색 폼 -->
		<form class="form-inline mb-3" action="/admin/artist/artistList" method="get">
			<div class="form-group mr-2">
				<label for="mode" class="mr-2">분류명</label>
				<select name="mode" id="mode" class="form-control">
					<option value="all">전체</option>
					<option value="artActNm" <c:if test="${param.mode=='artActNm' }">selected</c:if>>활동명</option>
					<option value="memEmail" <c:if test="${param.mode=='memEmail' }">selected</c:if>>이메일</option>
				</select>
			</div>
			<div class="form-group mr-2">
				<input type="text" name="keyword" placeholder="검색어 입력" class="form-control" value="${param.keyword }" />
			</div>
			<button type="submit" class="btn btn-primary mr-2">검색</button>
			<a href="/admin/artist/artistRegister"><button
							type="button" class="btn btn-primary">등록</button></a>
		</form>

		<!-- 아티스트 테이블 -->
		<div class="table-responsive">
			<table class="table table-bordered table-striped">
				<thead class="thead-dark">
					<tr>
						<th>No</th>
						<th>아티스트 활동명</th>
						<th>이메일</th>
						<th>생년월일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="artistVO" items="${boardPage.content}" varStatus="stat">
						<tr>
							<td>${artistVO.rnum}</td>
							<td>
								<a href="/admin/artist/artistDetail?artNo=${artistVO.artNo}">
									${artistVO.artActNm}
								</a>
							</td>
							<td>${artistVO.memVO.memEmail}</td>
							<td>${artistVO.memVO.memBirth}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
					<div class="d-flex justify-content-center mt-3">
						<ul class="pagination">
							<li class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a href="/admin/artist/artistList?currentPage=1&keyword=${param.keyword}&mode=${param.mode}" class="page-link"><<</a>
							</li>
							<li class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a href="/admin/artist/artistList?currentPage=${boardPage.startPage - 1}&keyword=${param.keyword}&mode=${param.mode}" class="page-link"><</a>
							</li>

							<c:forEach var="pNo" begin="${boardPage.startPage}" end="${boardPage.endPage}" step="1">
								<li class="paginate_button page-item <c:if test='${param.currentPage == pNo}'>active</c:if>">
									<a href="/admin/artist/artistList?currentPage=${pNo}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">${pNo}</a>
								</li>
							</c:forEach>

							<li class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a href="/admin/artist/artistList?currentPage=${boardPage.startPage + boardPage.blockSize}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">></a>
							</li>
							<li class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a href="/admin/artist/artistList?currentPage=${boardPage.totalPages}&keyword=${param.keyword}&mode=${param.mode}" class="page-link">>></a>
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