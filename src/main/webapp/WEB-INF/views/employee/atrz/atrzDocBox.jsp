<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT EMP</title>
<script src="/js/jquery-3.6.0.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
td, th {
	border : none !important;
}
#tdtitle {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 300px;
}
</style>
</head>
<body class="g-sidenav-show  bg-gray-100">
	
  <!-- 사이드바 -->
  <%@ include file="../sidebar.jsp"%>
  <!-- 컨텐츠 -->
  <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
      <!-- 헤더 -->
      <%@ include file="../header.jsp"%>
        <div class="container-fluid py-2">
            <h4 class="fw-bold mb-3">문서함</h4>
			  <!-- 탭 메뉴 -->
			  <ul class="nav nav-tabs mb-3" id="documentTabs" role="tablist">
			    <li class="nav-item" role="presentation">
			      <button class="nav-link active" id="all-tab" data-type="ALL" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" onclick="changeTab(this)">전체</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="draft-tab" data-type="DRAFTER" data-bs-toggle="tab" data-bs-target="#draft" type="button" role="tab" onclick="changeTab(this)">기안 문서함</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="approval-tab" data-type="APPROVAL" data-bs-toggle="tab" data-bs-target="#approval" type="button" role="tab" onclick="changeTab(this)">결재 문서함</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="reference-tab" data-type="REFERENCE" data-bs-toggle="tab" data-bs-target="#reference" type="button" role="tab" onclick="changeTab(this)">참조 문서함</button>
			    </li>
			  </ul>
			
			  <!-- 공통 툴바 -->
			  <div class="d-flex justify-content-between align-items-center mb-3">
			    <div class="d-flex gap-2 align-items-center">
			      <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-download"></i> 목록 다운로드</button>
			    </div>
			    
			    <div class="d-flex align-items-center gap-2">
			        <label class="form-label mb-0">기안 일자(선택)</label>
			    	<select id="periodSelect" class="form-select form-select-sm bg-white" style="width: 120px;">
					  <!-- <option value="">전체</option> -->
					  <option value="1WEEK">1주일</option>
					  <option value="1MONTH">1개월</option>
					  <option value="3MONTH">3개월</option>
					</select>
					
			    	<label class="form-label mb-0">기안 일자(직접 입력)</label>
				    <input id="startDate" type="date" class="form-control form-control-sm bg-white" style="width: 160px;">
				    <span>~</span>
				    <input id="endDate" type="date" class="form-control form-control-sm bg-white" style="width: 160px;">
				    
				    <select id="selectOption" class="form-select form-select-sm bg-white" style="width: 120px;">
					  <option value="all">전체</option>
					  <option value="drftTtl">제목</option>
					  <option value="drafter">기안자</option>
					  <option value="deptNm">기안부서</option>
					  <option value="docFrmNm">결재양식</option>
					  <option value="atrzDocNo">문서번호</option>
					  <option value="atrzSttsCd">결재상태</option>
					</select>
					
					<input type="text" id="keywordInput" class="form-control form-control-sm bg-white" placeholder="검색어 입력" style="width: 200px;">
					<button type="button" id="btnSearch" class="btn btn-info">검색</button>
					<button type="button" id="btnReset" class="btn btn-secondary">초기화</button>
			    </div>
			    
			  </div>
			
			 <div class="table-responsive bg-white rounded shadow-sm">
			    <table class="table table-hover align-middle mb-0">
			      <thead class="table-light text-center">
			        <tr>
			          <!-- <th><input type="checkbox" /></th> -->
			          <th>기안 일자</th>
			          <th>마감 일자</th>
			          <th>결재 양식</th>
			          <th>긴급</th>
			          <th>제목</th>
			          <th>첨부</th>
			          <th>기안자 / 부서 명</th>
			          <th>문서 번호</th>
			          <th>결재 상태</th>
			        </tr>
			      </thead>
			      <tbody class="text-center" id="listBody">
			      	
			      </tbody>
			    </table>
			  </div> 
			
			  <!-- 페이징이 들어갈 영역 -->
			  <div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
        </div>


        <!-- 풋터 -->
        <%@ include file="../footer.jsp"%>
    </main>
    
     

<script src="/js/employee/atrzDocBox.js"></script>
</body>
</html>