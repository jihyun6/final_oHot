<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<link rel="stylesheet" href="/css/media-live/admin-media-main.css"> 
<style>
	.main-sidebar {
		height: auto !important;
	}
</style>
</head>
  <!-- 관리자 헤더네비바  -->
<c:set var="title" value="미디어 | 라이브 관리"></c:set>

<body class="sidebar-mini" style="height: auto%;">
<div class="wrapper">
<%@ include file="../adminHeader.jsp"%>
  <!-- 관리자 사이드바 -->
  <%@ include file="../adminSidebar.jsp"%>	
  <!-- 컨텐츠 - 이 영역에 스크롤 적용 -->
  <div class="content-wrapper" style="padding: 8px 20px">
    <!-- 전체 내용을 감싸는 컨테이너 -->
    <div class="fixed-width-container">
      <!-- 검색 옵션 영역 -->
      <div class="card card-secondary">
        <div class="card-header">
        </div>
        <!-- form start -->
        <div class="card-body">
          <div class="form-row align-items-end">
            <div class="col-md-2">
              <label class="small">커뮤니티 이름</label>
              <select id="community-name" class="form-control form-control-sm">
                <option value="" disabled selected hidden>커뮤니티 선택</option>
                <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
                  <option value="${artistGroupVO.artGroupNm}">${artistGroupVO.artGroupNm}</option>
                </c:forEach>
              </select>
            </div>
          
            <div class="col-md-2 d-flex justify-content-between">
              <div class="pr-1 w-33">
                <label class="small">멤버십 여부</label>
                <select id="membership-filter" class="form-control form-control-sm">
                  <option value="">-</option>
                  <option value="Y">Y</option>
                  <option value="N">N</option>
                </select>
              </div>
              <div class="pr-1 w-33">
                <label class="small">배너 여부</label>
                <select id="banner-filter" class="form-control form-control-sm">
                  <option value="">-</option>
                  <option value="Y">Y</option>
                  <option value="N">N</option>
                </select>
              </div>
              <div class="w-33">
                <label class="small">삭제 여부</label>
                <select id="delete-filter" class="form-control form-control-sm">
                  <option value="">-</option>
                  <option value="Y">Y</option>
                  <option value="N">N</option>
                </select>
              </div>
            </div>
          
            <div class="col-md-1-5">
              <label class="small">게시글 등록 기간</label>
              <div class="input-group date" id="start-date" data-target-input="nearest">
                <input type="text" class="form-control datetimepicker-input" data-target="#start-date"/>
                <div class="input-group-append" data-target="#start-date" data-toggle="datetimepicker">
                  <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                </div>
              </div>
            </div>
            <div style="padding: 0px 5px 5px 5px;">~</div>
            <div class="col-md-1-5"> 
              <label class="small">게시글 등록 기간</label>
              <div class="input-group date" id="end-date" data-target-input="nearest">
                <input type="text" class="form-control datetimepicker-input" data-target="#end-date"/>
                <div class="input-group-append" data-target="#end-date" data-toggle="datetimepicker">
                  <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                </div>
              </div>
            </div>
          
            <div class="col-md-3">
              <label class="small">게시글 제목</label>
              <div class="input-group">
                <input type="text" id="search-title" class="form-control form-control" placeholder="게시글 제목 입력">
              </div>
            </div>
            
            <div class="col-md-1 d-flex align-items-end pr-1">
              <button type="button" class="btn btn-outline-dark w-100" id="reset-btn">초기화</button>
            </div>
            
            <div class="col-md-1 d-flex align-items-end">
              <button type="button" class="btn btn-outline-primary w-100" id="search-btn">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- 검색옵션 끝 -->

      <!-- 테이블 영역 -->
        <div class="card-header">
          <div class="d-flex justify-content-between align-items-center" style="padding-right:30px">
            <h3 class="card-title"></h3>
            <a href="/admin/media/create" class="btn btn-primary">
              <i class="fas fa-plus"></i> 게시글 등록
            </a>
          </div>
        </div>
        <!-- 테이블 영역에 고정 높이 지정 -->
        <div class="card-body table-responsive p-0" style="height: 620px;">
          <table class="table table-fixed table-hover mb-0">
            <thead>
              <tr class="text-center">
                <th style="width: 6%;">순번</th>
                <th style="width: 6%;">게시글 번호</th>
                <th style="width: 10%;">커뮤니티 이름</th>
                <th style="width: 30%;">게시글 제목</th>
                <th style="width: 10%;">게시글 등록일</th>
                <th style="width: 6%;">멤버십 여부</th>
                <th style="width: 5%;">배너 여부</th>
                <th style="width: 5%;">삭제 여부</th>
                <th style="width: 10%;">게시글 바로가기</th>
              </tr>
            </thead>
            <tbody id="listBody">
              <tr>
                <td colspan="9" class="text-center">데이터를 불러오는 중...</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <!-- 페이지네이션 -->
      <div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
    </div>
    <%@ include file="../adminFooter.jsp"%>
  </div>
<!-- 관리자 풋터 -->

<script src="/js/media-live/admin-media-main.js"></script>
</body>
</html>