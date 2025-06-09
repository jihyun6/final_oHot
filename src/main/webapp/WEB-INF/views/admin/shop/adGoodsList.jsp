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

.main-sidebar {
	height: auto !important;
}
</style>

</head>
<body class="sidebar-mini" style="height: auto;">
  <div class="wrapper">	
	<!-- 관리자 헤더네비바  -->
	<c:set var="title" value="굿즈샵 관리"></c:set>
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>
	
	<!-- 컨텐츠-->
	<div class="content-wrapper" style="padding: 20px; min-height: 824px;">
      <!-- card 영역 -->
      <div class="card card-secondary">
	    <div class="card-header ">
		</div>

		<!-- /.card-header -->
		<!-- form start -->
		<form onsubmit="return false;" id="srhFrm">
		  <!-- /.card-body -->
		  <div class="card-body" style="padding: 10px 10px 0px;">
		    <div class="row mb-4" style="margin-bottom: 0px !important">
			  <!-- 1행 1열 -->
			  <div class="col-md-2 form-group gap-5 mb-1">
			    <!-- 그룹명 -->
			    <label for="artGroupNo" class="small">그룹명</label>
      		    <select class="form-select select2bs4" name="artGroupNo" id="artGroupNo">
      		      <option value="" selected="selected">전체</option>
      		      <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
      		        <option value="${artistGroupVO.artGroupNo}">
      		          ${artistGroupVO.artGroupNm}
      		        </option>
      		      </c:forEach>
      		    </select>
			  
			    <!-- 2행 1열 -->
			    <!-- 상품 등록 조회기간 시작 -->
			    <label for="" class="small">상품 등록기간</label>
			    <div class="d-flex">
			      <div class="input-group date " id="start-date" data-target-input="nearest">
				    <input type="text" class="form-control datetimepicker-input" data-target="#start-date">
				    <div class="input-group-append" data-target="#start-date" data-toggle="datetimepicker">
				      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
				    </div>
				  </div>
			      <span class="ms-3 align-self-center">~</span>
			    </div>
			  </div>  
			 
			  <!-- 상품번호 1행 2열 -->
			  <div class="col-md-2 form-group gap-5 mb-1">
			    <!-- 상품유형 -->
			    <label for="gdsType"  class="small">상품유형</label>
      		      <select class="form-select" name="gdsType" id="gdsType">
      		        <option value="" selected="selected">전체</option>
      		        <c:forEach var="commonDetailCodeVO" items="${commonCodeGroupVOGdsType.commonDetailCodeVOList}">
      		          <c:choose>
      		            <c:when test="${commonDetailCodeVO.commDetCodeNm != 'I' and commonDetailCodeVO.commDetCodeNm != 'GD02'}">
      		          	  <option value="${commonDetailCodeVO.commDetCodeNm}" 
      		          	    <c:if test="${commonDetailCodeVO.commDetCodeNm == 'G' ? 'selected=selected' : ''}"></c:if>>
      		            
      		            	<!-- 상품유형에 따른 분기 -->
      		                <c:if test="${commonDetailCodeVO.commDetCodeNm == 'G'}">Group</c:if>
      		            	<c:if test="${commonDetailCodeVO.commDetCodeNm == 'M'}">MemberShip</c:if>
      		            	<c:if test="${commonDetailCodeVO.commDetCodeNm == 'A'}">Album</c:if>
      		          	  </option>
      		            </c:when>
      		          </c:choose>
      		        </c:forEach>
      		      </select>
			  
			    <!-- 상품번호 2행 2열 -->
			    <!-- 상품 등록 조회기간 종료 -->
			    <label for="end-date" class="small">&ensp;</label>
			    <div class="input-group date " id="end-date" data-target-input="nearest">
				  <input type="text" class="form-control datetimepicker-input" data-target="#end-date">
				  <div class="input-group-append" data-target="#end-date" data-toggle="datetimepicker">
				    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
				  </div>
				</div>
			  </div>
			 
			  <!-- 상품번호 1행 3열 -->
			  <div class="col-md-2 form-group mb-1">
			    <label for="gdsNm" class="small">상품명</label>
			    <input type="text" id="gdsNm" name="gdsNm" class="form-control" placeholder="상품명">
			  </div>
			 
			  <!-- 상품번호 1행 4열 -->
			  <div class="col-md-2 form-group mb-1" >
			    <label for="unitPricePre" class="small">판매가격(원)</label>
			    <div class="d-flex">
			      <!-- mx-2 align-self-center: ~을 가운데 정렬하면서 좌우에 여백(mx-2)  -->
			      <input type="text" id="unitPricePre" name="unitPricePre" class="form-control">
			      <span class="mx-2 align-self-center">~</span>
			      <input type="text" id="unitPricePost" name="unitPricePost" class="form-control">
			    </div>
			  </div>
			 
			  <!-- 상품번호 1행 5열 -->
			  <div class="col-md-2 form-group mb-1">
			    <label for="pic" class="small">담당자명</label>
			    <input type="text" id="pic" name="pic" class="form-control" placeholder="담당자명">
			  </div>
			 
			  <!-- 삭제 여부 선택 -->
			  <div class="col-md-1 form-group gap-5 mb-1">
			    <label for="gdsDelYn" class="small">삭제여부</label>
				<select id="gdsDelYn" class="form-select " style="width: 100%;">
				  <option value="">전체</option>
				  <option value="N" selected>N</option>
				  <option value="Y">Y</option>
				</select>
				
				<label for="search-title" class="small">&ensp;</label>
				<p class=""><button type="reset" class="btn btn-outline-dark col-md-12" id="resetBtn">초기화</button></p>
			  </div>
			  
			  <!-- 비어있는 행 -->
			  <div class="col-md-1 form-group gap-5 mb-1">
			    <label class="small invisible">&ensp;</label>
				<select class="form-select invisible" style="width: 100%;">
				</select>
				
				<label for="search-title" class="small">&ensp;</label>
				<p><a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12">검색</a></p>
			  </div>
			</div><!-- 검색 1행 끝 -->
		  </div>	 
		</form>
	  </div>
	  
      <!-- List 영역 시작 -->
      <div class="row text-center" style="padding: 0px 40px 0px 40px">
	    <!-- 등록 -->
	    <div class="d-flex justify-content-end">
		  <a href="/admin/shop/adGoodsCreate" class="btn btn-primary " >&ensp;<i class="fas fa-plus"></i> 상품등록 &ensp;</a>
		</div>
		
		<!-- card-body 영역 시작 -->
		<div class="card-body table-responsive p-0" style="text-align: center;">
		  <table class="table table-hover text-nowrap" style="table-layout: auto; ">
		    <thead>
		      <tr>
			    <th>순번</th>
			    <th>그룹명</th>
			    <th>상품유형</th>
			    <th>상품명</th>
			    <th>판매가격(원)</th>					
			    <th>담당자명</th>
			    <th>등록일시</th>
			    <th>삭제여부</th>
			  </tr>				
			</thead>						
			<tbody id="listBody">
			
			</tbody>					
		  </table>							
		</div>							
								
		<!-- 페이징이 들어갈 영역 -->						
		<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
	  </div>						
    </div><!-- 컨텐츠 끝 -->
      <%@ include file="../adminFooter.jsp"%>
  </div><!-- wrapper 끝 -->
  <!-- 관리자 풋터 -->


<script src="/js/goods/adGoodsList.js"></script>
</body>
</html>