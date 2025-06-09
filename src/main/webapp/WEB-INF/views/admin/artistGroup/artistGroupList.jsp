<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<style type="text/css">
.table td, .table th{
	padding: .45rem !important;
	vertical-align: middle !important;
}
</style>
</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
		<c:set var="title" value="아티스트 그룹 관리"></c:set>
		<!-- 관리자 헤더네비바  -->
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper">
			<!-- 검색 옵션 영역 -->
			<div class="col-md-12" style="padding: 10px 20px 0px 20px">
				<div class="card card-secondary" style="margin-bottom: 8px;">
					<div class="card-header">
					</div>
					<!-- /.card-header -->
					<!-- form start -->
					<form id="searchForm">
						<div class="card-body">
						    <div class="form-row">
						        <!-- 아티스트 그룹 선택 -->
						        <div class="form-group col-md-2">
						            <label for="artGroupNm" class="small">아티스트 그룹명</label> 
						            <select id="artGroupNm" name="artGroupNm" class="form-control select2bs4">
						                <option value="all">전체</option>
						                <c:forEach var="artistGroupVO" items="${artistGroupVOList}" varStatus="stat">
						                    <option value="${artistGroupVO.artGroupNm}">${artistGroupVO.artGroupNm}</option>
						                </c:forEach>
						            </select>
						        </div>
						
						        <!-- 시작일 -->
						        <div class="form-group col-md-3">
						            <label class="small">그룹등록 일자</label>
						            <div class="input-group date" data-target-input="nearest">
						                <input id="startDate" name="startDate" type="text" class="form-control datetimepicker-input" data-target="#startDate">
						                <div class="input-group-append" data-target="#startDate" data-toggle="datetimepicker">
						                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						                </div>
						                <span class="mx-2 align-self-center">~</span>
						                <input id="endDate" name="endDate" type="text" class="form-control datetimepicker-input" data-target="#endDate">
						                <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
						                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						                </div>
						            </div>
						        </div>
						        
								
						        <!-- 종료일 -->
						        <!-- <div class="form-group col-md-2">
						            <label class="small">그룹 등록 일자</label>
						            <div class="input-group date" data-target-input="nearest">
						                <input id="endDate" name="endDate" type="text" class="form-control datetimepicker-input" data-target="#endDate">
						                <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
						                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						                </div>
						            </div>
						        </div> -->
						
						        <!-- 데뷔 일자 -->
						        <div class="form-group col-md-2">
						            <label for="artGroupDebutYmd" class="small">그룹 데뷔 일자</label>
						            <input type="text" id="artGroupDebutYmd" name="artGroupDebutYmd" placeholder="YYYYMMDD" class="form-control" />
						        </div>
						
						        <!-- 삭제 여부 -->
						        <div class="form-group col-md-2">
						            <label for="artGroupDelYn" class="small">서비스 중단 여부</label>
						            <select id="artGroupDelYn" name="artGroupDelYn" class="form-control select2bs4">
						                <option value="all" selected="selected">전체</option>
						                <option value="Y">Y</option>
						                <option value="N">N</option>
						            </select>
						        </div>
						        <div class="col-md-1" ></div>
						        <div class="col-md-1 form-group gap-5 mb-0">
									<label for="search-title" class="small">&ensp;</label>
									<p>
										<button type="button" class="btn btn-outline-dark col-md-12 " id="btnReset">초기화</button>
									</p>
								</div>
								<div class="col-md-1 form-group gap-5 mb-0">
									<label for="search-title" class="small">&ensp;</label>
									<p>
										<a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12 ">검색</a>
									</p>
								</div>
						    </div>
						</div>
					</form>
				</div>
			</div>
			<!-- 검색옵션 끝 -->
			
			<div class="row text-center" style="padding: 0px 40px 0px 40px">
				<div class="d-flex justify-content-end">
					<a href="/admin/artistGroup/artistGroupRegister" class="btn btn-primary">&ensp;<i class="fas fa-plus"></i> 그룹 등록 &ensp;</a>
				</div>
				<div class="card-body table-responsive p-0" style="text-align: center;">
					<table class="table table-hover text-nowrap" style="table-layout: auto; ">
						<thead>
							<tr>
								<th>순번</th>
								<th>대표 로고</th>
								<th>아티스트 그룹명</th>
								<th>그룹 등록 일자</th>
								<th>그룹 데뷔 일자</th>
								<th>서비스 중단 여부</th>
								<th>수정</th>
							</tr>
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
	<%@ include file="../adminFooter.jsp"%>

	</div>
<script src="/js/artistGroup/artistGroupList.js"></script>
</body>
</html>