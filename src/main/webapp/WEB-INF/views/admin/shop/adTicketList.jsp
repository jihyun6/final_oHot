<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin ticket</title>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">
	<c:set var="title" value="공연/티켓관리"></c:set>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp" %>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp" %>

			<!-- 컨텐츠-->
			<div class="content-wrapper">
				<%-- ${goodsVOList } --%>
				
				<div class="col-md-12" style="padding: 10px 20px 0px 20px">
						<div class="card card-secondary" style="margin-bottom: 8px;">
							<div class="card-header ">
							</div>

							<!-- /.card-header -->
							<!-- form start -->
							<form onsubmit="return false;" id="srhFrm">
								<!-- /.card-body -->
								<div class="card-body" style="padding: 10px 10px 0px;">
									<div class="row mb-4" style="margin-bottom: 0px !important">
										<!-- 커뮤니티 선택 폼 그룹 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="artGroupNo" class="small">공연자(그룹)</label>
											<select id="artGroupNo" class="form-control select2bs4" style="width: 100%;">
												<option selected value="">전체</option>
												<c:forEach var="artistGroup" items="${artistGroupVOList}" varStatus="stat">
													<option value="${artistGroup.artGroupNo}" name="artGroupNo">
														${artistGroup.artGroupNm}</option>
												</c:forEach>
												
											</select>
										</div>

										<!-- 커뮤니티 선택 폼 그룹 -->
										<div class="col-md-2 form-group mb-1">
											<label for="artNo" class="small">공연자(개인)</label>
											<select id="artNo" class="form-control select2bs4" style="width: 100%;">
												<option selected value="">전체</option>
												<c:forEach var="artist" items="${artistVOList}" varStatus="stat">
													<option value="${artist.artNo}" name="artNo" >
														${artist.artActNm}</option>
												</c:forEach>
											</select>
										</div>

										<!-- 공연장소 선택 폼 그룹 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="tkCtgr" class="small">공연유형</label>
											<select id="tkCtgr" class="form-select "
												style="width: 100%;">
												<option selected value="">전체</option>
												<option class="dropdown-item" name="ticketVO.tkCtgr">콘서트</option>
												<option class="dropdown-item" name="ticketVO.tkCtgr">팬미팅</option>
												<option class="dropdown-item" name="ticketVO.tkCtgr">기타</option>
											</select>
										</div>

										<!-- 공연기간 선택 폼 그룹 -->
										<div class="col-md-5 form-group mb-1">
											<label for="start-date" class="small">공연기간</label>
											<div class="d-flex align-items-center">
												<div class="input-group date" id="start-date" data-target-input="nearest">
													<input type="text" class="form-control datetimepicker-input" data-target="#start-date">
													<div class="input-group-append" data-target="#start-date" data-toggle="datetimepicker">
														<div class="input-group-text"><i class="fa fa-calendar"></i></div>
													</div>
												</div>

												<b style="font-size: 20px; margin: 0px 10px;">~</b>

												<div class="input-group date" id="end-date" data-target-input="nearest">
													<input type="text" class="form-control datetimepicker-input" data-target="#end-date">
													<div class="input-group-append" data-target="#end-date" data-toggle="datetimepicker">
														<div class="input-group-text"><i class="fa fa-calendar"></i></div>
													</div>
												</div>
											</div>
										</div>

										<!-- 삭제 여부 선택 -->
										<div class="col-md-1 form-group gap-5 mb-1">
											<label for="gdsDelYn" class="small">공연공개여부</label>
											<select id="gdsDelYn" class="form-select " style="width: 100%;">
												<option value="">전체</option>
												<option value="N" selected>Y</option>
												<option value="Y">N</option>
											</select>
										</div>



									</div>
									<!-- 검색 1행 끝 -->

									<!-- 검색 2행 시작 -->
									<div class="row mb-4"
										style="margin-bottom: 0px !important; margin-top: 0px !important">

										<div class="col-md-6 form-group gap-5 mb-0">
											<label for="search-title" class="small">공연명</label>
											<input id="gdsNm" name="gdsNm" type="text" class="form-control " placeholder="공연명을 입력하세요">
										</div>

										<!-- 공연장소별 여부 선택 -->
										<div class="col-md-4 form-group gap-5 mb-0">
											<label for="tkLctn" class="small">공연장소</label>
											<input type="text" id="tkLctn" name="tkLctn" class="form-control "
												placeholder="장소를 입력하세요">
										</div>

										<div class="col-md-1 form-group gap-5 mb-0">
											<label for="search-title" class="small">&ensp;</label>
											<p>
												<button type="reset" class="btn btn-outline-dark col-md-12 " id="resetBtn">초기화</button>
											</p>
										</div>
										<div class="col-md-1 form-group gap-5 mb-0">
											<label for="search-title" class="small">&ensp;</label>
											<p>
											<a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12 ">검색</a>
											</p>
										</div>
									</div>

									<!-- 검색옵션 2행 끝  -->

								</div>
							</form>
						</div>
					</div>
					
					
					<div class="row text-center" style="padding: 0px 40px 0px 40px">
						<div class="d-flex justify-content-end">
							<a href="/admin/shop/adTicketCreate" class="btn btn-primary " >&ensp;<i class="fas fa-plus"></i> 공연등록 &ensp;</a>
						</div>
						<div class="card-body table-responsive p-0" style="text-align: center;">
							<table class="table table-hover text-nowrap" style="table-layout: auto; ">
								<thead>
									<th>순번</th>
									<!-- <th>포스터</th> -->
									<th>공연명</th>
									<th>공연자</th>
									<th>판매좌석수</th>
									<th>공연기간</th>
									<th>공연장소</th>
									<th style="text-align: right;">대표가격(원)</th>
								</thead>
								<tbody id="listBody">

								</tbody>
							</table>
						</div>
						<!-- 페이징이 들어갈 영역 -->
						<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
					</div>
			</div>
			<!-- 관리자 풋터 -->
			<%@ include file="../adminFooter.jsp" %>
</div>


</div>
<script src="/js/ticket/adTicketList.js"></script>
</body>
</html>