<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>

<style type="text/css">
.search-label {
  width: 100px;	
  align-items: center;
}

.search-input {
  width: 320px !important;
  margin-right: 10px;
}
</style>

</head>
<body class="sidebar-mini" style="height: auto;">
  <div class="wrapper">	
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>
	
	<!-- 컨텐츠-->
	<div class="content-wrapper" style="padding: 20px;">
	  <!-- Hedaer 영역 -->
	  <div class="content-header">
	    <div class="container-fluid">
	      <div class="row mb-2">
	        <div class="col-sm-6">
	          <h1 class="m-0">상품 관리</h1>
	        </div>
	      </div>
	    </div>
      </div>
      
      <!-- 검색 영역 -->
      <div class="serch-option">
        <div class="card card-primary">
          <div class="card-header">
            <h3 class="card-title">검색 옵션</h3>
          </div>
          
          <div class="card-body">
      	    <form>
	          <div class="mb-1 row">
	            <div class="d-flex align-items-center">
	              <!-- 상품명 검색 -->
		          <label for="goodsName" class="col-form-label text-left p-3 search-label">상품명</label>
	              <input type="text" class="form-control search-input" id="goodsName" placeholder="상품명을 입력하세요.">
	              
	               <!-- 날짜 범위 검색 -->
	              <label for="dateRange" class="col-form-label text-left p-3 search-label">등록일</label>
		          <div>
	                <input type="date" class="form-control" id="startDate" placeholder="시작일">
	              </div>
	              <span class="p-3">~</span>
	              <div>
	                <input type="date" class="form-control" id="endDate" placeholder="종료일">
	              </div>
	              
	              <!-- 카테고리 검색 -->
	              <label for="categorySelect" class="form-label text-left p-3 search-label">카테고리</label>
	              <div>
	                <select class="form-select search-input" id="categorySelect">
			          <option selected>전체</option>
			          <option value="category1">카테고리 1</option>
			          <option value="category2">카테고리 2</option>
			          <option value="category3">카테고리 3</option>
			        </select>
	              </div>
	            </div>
	          </div>
			  
			  <!-- 검색 및 초기화 버튼 -->
	          <div class="row">
	            <div class="col-md-12 text-right">
	              <button type="submit" class="btn btn-primary">검색</button>
	              <button type="reset" class="btn btn-secondary">초기화</button>
	            </div>
	          </div>
			</form>
		  </div>
		</div>
	  </div>
    </div>
    
	<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
  </div>

</body>

<!-- Jquery 영역 -->
<script type="text/javascript">
</script>
</html>