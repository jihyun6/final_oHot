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

	<c:set var="title" value="문의글 관리"></c:set>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
		
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<!-- 컨텐츠-->
	<div class="content-wrapper">
<%-- 	${inqTypeVOList} --%>
		<div class="col-md-12" style="padding: 10px 20px 0px 20px">
			<div class="card card-secondary" style="margin-bottom: 8px;">
				<div class="card-header ">
				</div>

				<!-- 검색옵션 시작 -->
				<form onsubmit="return false;" id="srhFrm">
					<!-- 1행 시작 -->
					<div class="card-body" style="padding: 10px 10px 0px;">
						<div class="row mb-4" style="margin-bottom: 0px !important">
							<!-- 문의유형 선택 -->
							<div class="col-md-2 form-group gap-5 mb-1">
								<label for="inqTypeNo" class="small">문의유형</label>
								<select id="inqType" class="form-select form-select-sm " style="width: 100%;">
									<option selected value="">전체</option>
									<c:forEach var="inqType" items="${inqTypeVOList}">
										<option class="dropdown-item" value="${inqType.inqTypeNo}">
											${inqType.inqTypeNm}
										</option>
									</c:forEach>
								</select>
							</div>
							<!-- 회원유형 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label for="isMember" class="small">회원여부</label>
								<select id="isMember" class="form-select form-select-sm " style="width: 100%;">
									<option selected value="">전체</option>
									<option class="dropdown-item" value="Y">Y
									<option class="dropdown-item" value="N">N
								</select>
							</div>
							<!-- 답글여부 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label for="ansYn" class="small">답글여부</label>
								<select id="ansYn" class="form-select form-select-sm " style="width: 100%;">
									<option selected value="">전체</option>
									<option class="dropdown-item" value="Y">Y
									<option class="dropdown-item" value="N">N
								</select>
							</div>
							<!-- 삭제여부 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label for="bbsDelYn" class="small">삭제여부</label>
								<select id="bbsDelYn" class="form-select form-select-sm " style="width: 100%;">
									<option selected value="">전체</option>
									<option class="dropdown-item" value="Y">Y
									<option class="dropdown-item" value="N">N
								</select>
							</div>
							<!-- 비밀글여부 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label for="isSecret" class="small">비밀글상태</label>
								<select id="isSecret" class="form-select form-select-sm " style="width: 100%;">
									<option selected value="">전체</option>
									<option class="dropdown-item" value="Y">비밀글
									<option class="dropdown-item" value="N">공개글
								</select>
							</div>

							<!-- 작성기간 시작일 선택 -->
							<div class="col-md-2 form-group gap-5 mb-1">
								<label class="small">작성기간</label>
								<div class="input-group date " id="start-date" data-target-input="nearest">
									<input class="form-control form-control-sm datetimepicker-input"
										data-target="#start-date" id="startDate">
									<div class="input-group-append" data-target="#start-date"
										data-toggle="datetimepicker">
										<div class="input-group-text"><i class="fa fa-calendar"></i></div>
									</div>
								</div>
							</div>
							
							<!-- 작성기간 종료일 선택 -->
							<div class="col-md-2 form-group gap-5 mb-1  me-3">
								<label class="small" style="visibility: hidden;">~</label>
								<div class="input-group date" id="end-date" data-target-input="nearest">
									~ &nbsp;&nbsp;&nbsp;
									<input class="form-control form-control-sm datetimepicker-input"
										data-target="#end-date" id="endDate">
									<div class="input-group-append" data-target="#end-date"
										data-toggle="datetimepicker">
										<div class="input-group-text"><i class="fa fa-calendar"></i></div>
									</div>
								</div>
							</div>
					</div>
						<!-- 1행 끝 -->

						<!-- 2행 시작 -->
						<div class="row mb-4"
							style="margin-bottom: 0px !important; margin-top: 0px !important">

							<!-- 내용유형 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label for="mode" class="small">내용유형</label>
								<select id="mode" class="form-select form-select-sm" style="width: 100%;">
									<option selected value="all">전체</option>
									<option class="dropdown-item" value="bbsTitle">제목</option>
									<option class="dropdown-item" value="bbsCn">내용</option>
								</select>
							</div>
							<div class="col-md-4 form-group gap-5 mb-0">
								<label for="keyword" class="small">내용입력</label>
								<input id="keyword" type="text" class="form-control form-control-sm "
										placeholder="검색 내용을 입력하세요">
							</div>
							
							<!-- 작성자 검색 -->
							<div class="col-md-2 form-group gap-5 mb-1">
								<label for="inqWriter"  class="small">작성자</label>
								<input type="text" id="inqWriter"  class="form-control form-control-sm"
									placeholder="작성자를 입력하세요">
							</div>
							<div class="col-md-3" ></div>
							<div class="col-md-1 form-group gap-5 mb-0">
								<label for="search-title" class="small">&ensp;</label>
								<p>
									<button type="reset" class="btn btn-sm btn-outline-dark col-md-12 " id="btnReset">초기화</button>
								</p>
							</div>
							<div class="col-md-1 form-group gap-5 mb-0">
								<label for="search-title" class="small">&ensp;</label>
								<p>
								<a type="button" id="btnSearch" class="btn btn-sm btn-outline-primary col-md-12 ">검색</a>
								</p>
							</div>
						</div>
						<!-- 2행 끝 -->
					</div>
				</form>
				<!-- 검색옵션 끝 -->
			</div>
		</div>
		
		
		<div class="row text-center" style="padding: 0px 40px 0px 40px">
			<div class="card-body table-responsive p-0" style="text-align: center; height: 610px">
				<table class="table table-hover text-nowrap" style="table-layout: auto;">
					<thead>
						<tr>
							<th>순번</th>
							<th>문의유형</th>
							<th>제목</th>
							<th>작성일자</th>
							<th>작성자</th>
							<th>회원여부</th>
							<th>답글여부</th>
							<th>삭제여부</th>
							<th>비밀글상태</th>
						</tr>
					</thead>
					<!-- 리스트 내용 들어갈 곳 -->
					<tbody id="listBody">
					</tbody>
				</table>
			</div>
			<!-- 페이징이 들어갈 영역 -->
			<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
		</div>
	</div>
	<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
</div>


<script src="/js/inquiryPost/adInquiryPost.js"></script>

</body>
</html>