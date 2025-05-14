<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
   <sec:authorize access="isAuthenticated()">
   	<sec:authentication property="principal.usersVO" var="userVO" />
   </sec:authorize>
  
  <!-- 사이드바 -->
  <%@ include file="../sidebar.jsp"%>
  
  <!-- 컨텐츠 -->
  <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
      <!-- 헤더 -->
      <%@ include file="../header.jsp"%>
        <div class="container-fluid py-2">
        	<h4 class="fw-bold mb-2">결재 관리</h4>
			  <p class="text-muted mb-4">요청된 결재 문서를 쉽게 찾고 편리하게 관리하세요</p>
			<%-- ${atrzAllList } --%>
			  <!-- 상단 요약 카드 -->
			  <div class="row g-3 mb-4">
			    <div class="col-md-3">
			      <div class="bg-white rounded shadow-sm p-3 d-flex justify-content-between align-items-center">
			        <div>
			          <div class="fw-bold text-danger">긴급 결재 요청 문서</div>
			          <div class="fs-5 fw-bold">${cntEmrgAtrz }건</div>
			        </div>
			        <i class="bi bi-exclamation-triangle text-danger fs-3"></i>
			      </div>
			    </div>
			    <div class="col-md-3">
			      <div class="bg-white rounded shadow-sm p-3 d-flex justify-content-between align-items-center">
			        <div>
			          <div class="fw-bold">결재 대기 문서</div>
			          <div class="fs-5 fw-bold">${cntWaitAtrz }건</div>
			        </div>
			        <i class="bi bi-check-circle fs-3 text-success"></i>
			      </div>
			    </div>
			    <div class="col-md-3">
			      <div class="bg-white rounded shadow-sm p-3 d-flex justify-content-between align-items-center">
			        <div>
			          <div class="fw-bold">결재 예정 문서</div>
			          <div class="fs-5 fw-bold">${cntReadyAtrz }건</div>
			        </div>
			        <i class="bi bi-clock-history fs-3 text-warning"></i>
			      </div>
			    </div>
			    <div class="col-md-3">
			      <div class="bg-white rounded shadow-sm p-3 d-flex justify-content-between align-items-center">
			        <div>
			          <div class="fw-bold">참조/열람 대기 문서</div>
			          <div class="fs-5 fw-bold">${cntRefAtrz }건</div>
			        </div>
			        <i class="bi bi-file-earmark-text fs-3 text-primary"></i>
			      </div>
			    </div>
			    
			  </div>
			  
			  
			  <!-- 탭 메뉴  -->
			  <ul class="nav nav-tabs mb-3" id="documentTabs" role="tablist">
			    <li class="nav-item" role="presentation">
			      <button class="nav-link active" id="all-tab" data-type="ALL" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" onclick="changeTab(this)">전체</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="emergency-tab" data-type="EMERGENCY" data-bs-toggle="tab" data-bs-target="#emergency" type="button" role="tab" onclick="changeTab(this)">긴급 결재</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="wait-tab" data-type="WAIT" data-bs-toggle="tab" data-bs-target="#wait" type="button" role="tab" onclick="changeTab(this)">결재 대기</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="ready-tab" data-type="READY" data-bs-toggle="tab" data-bs-target="#ready" type="button" role="tab" onclick="changeTab(this)">결재 예정</button>
			    </li>
			    <li class="nav-item" role="presentation">
			      <button class="nav-link" id="reference-tab" data-type="REFERENCE" data-bs-toggle="tab" data-bs-target="#reference" type="button" role="tab" onclick="changeTab(this)">참조 대기</button>
			    </li>
			    
			  </ul>
			  
			  <!-- 필터 영역 -->
			  <div class="d-flex justify-content-end align-items-center gap-2 mb-3">
			  	
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
				</select>
				
				<input type="text" id="keywordInput" class="form-control form-control-sm bg-white" placeholder="검색어 입력" style="width: 200px;">
				<button type="button" id="btnSearch" class="btn btn-info">검색</button>
				<button type="button" id="btnReset" class="btn btn-secondary">초기화</button>
			  </div>
			
			  <!-- 결재 리스트 테이블 -->
			  <div class="table-responsive bg-white rounded shadow-sm">
			    <table class="table table-hover align-middle mb-0">
			      <thead class="table-light text-center">
			        <tr>
			          <th>기안 일자</th>
			          <th>마감 일자</th>
			          <th>긴급</th>
			          <th>제목</th>
			          <th>결재 양식</th>
			          <th>첨부</th>
			          <th>기안자 / 부서 명</th>
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

	<script type="text/javascript">
	const empNo = '${userVO.userNo}';
    
	document.addEventListener("click", function (e) {
	  if (e.target.classList.contains("ref-doc-link")) {
	    e.preventDefault();

	    const atrzDocNo = e.target.dataset.atrzDocNo;
	    const refEmpNo = empNo; 

	    const data = {
	      refEmpNo: empNo,
	      atrzDocNo: atrzDocNo
	    };

	    fetch('/emp/updateRefRead', {
	      method: "POST",
	      headers: {
	        "Content-Type": "application/json"
	      },
	      body: JSON.stringify(data)
	    })
	    .then(resp => resp.text())
	    .then(data => {
	      console.log("참조 읽음 처리 완료", data);
	      
	      window.location.href = "/emp/atrzDocDetail?atrzDocNo=" + data;
	    })
	    .catch(err => {
	      console.error("참조 읽음 실패", err);
	    });
	  }
	});
    	
    	
    </script>  
<script src="/js/employee/atrzList.js"></script>
</body>
</html>