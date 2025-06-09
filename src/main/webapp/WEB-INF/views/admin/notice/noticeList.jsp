<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@1.6.2/dist/select2-bootstrap4.min.css" rel="stylesheet" />

<title>oHoT Admin</title>
<style>
table a {
  color: inherit;         /* 부모 색상 상속 */
  text-decoration: none;  /* 밑줄 제거 */
}
.content-preview-wrapper {
  max-width: 300px;
}

.content-preview {
  white-space: normal;
  word-break: break-word;
  overflow: hidden;
  max-height: 4.5em; /* 약 3줄 */
  transition: max-height 0.3s ease;
}

.content-preview.expanded {
  max-height: 1000px; /* 충분히 큰 값 */
}

.toggle-btn {
  padding: 0;
  font-size: 0.85rem;
  color: #007bff;
  text-decoration: none;
  background: none;
  border: none;
}
</style>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">	

<c:set var="title" value="공지사항 관리"></c:set>

	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

			<!-- 컨텐츠-->
<div class="content-wrapper">
	<%-- ${goodsVOList } --%>
	
	<div class="col-md-12" style="padding: 20px 20px 0px 20px">
	 <div class="card card-secondary">
      <div class="card-header">

      </div>
      <form onsubmit="return false;" id="srhFrm">
        <div class="card-body">
          <div class="row g-3">

            <!-- 아티스트 그룹 -->
			<div class="col-md-2">
			  <label for="categoryArtGroupNo" class="small">아티스트 그룹명</label>
			  <select id="categoryArtGroupNo" class="form-select select2">
			    <option selected value="">전체</option>
			    <c:forEach var="item" items="${artGroupList}">
			      <option value="${item.artGroupNo}">${item.artGroupNm}</option>
			    </c:forEach>
			  </select>
			</div>

            <!-- 삭제 여부 -->
            <div class="col-md-2">
              <label for="bbsDelYn" class="small">삭제 여부</label>
              <select id="bbsDelYn" class="form-select">
                <option selected value="">전체</option>
                <option value="Y">Y</option>
                <option value="N">N</option>
              </select>
            </div>

            <!-- 등록일 -->
            <div class="col-md-2">
              <label class="small">게시글 등록일</label>
              <div class="input-group" id="bbsRegDt" data-target-input="nearest">
                <input type="text" class="form-control datetimepicker-input" data-target="#bbsRegDt">
                <span class="input-group-text" data-target="#bbsRegDt" data-toggle="datetimepicker">
                  <i class="fa fa-calendar"></i>
                </span>
              </div>
            </div>

            <!-- 제목 -->
            <div class="col-md-4">
              <label for="bbsTitle" class="small">제목</label>
              <input type="text" id="bbsTitle" name="bbsTitle" class="form-control" placeholder="제목을 입력하세요">
            </div>

            <!-- 버튼 -->
            <div class="col-md-1 d-grid">
              <label class="form-label invisible">초기화</label>
              <button type="reset" class="btn btn-outline-dark" id="resetBtn">초기화</button>
            </div>
            <div class="col-md-1 d-grid">
              <label class="form-label invisible">검색</label>
              <a type="button" id="btnSearch" class="btn btn-outline-primary">검색</a>
            </div>

          </div>
        </div>
      </form>
    </div>

    <!-- 등록 버튼 -->
    <div class="d-flex justify-content-end mb-3">
      <a href="/admin/notice/addNotice" class="btn btn-primary">
        <i class="fas fa-plus"></i> 공지 등록
      </a>
    </div>

    <!-- 리스트 테이블 -->
    <div class="row text-center" style="padding: 0px 40px 0px 40px">
      <div class="card-body p-0">
        <div class="card-body table-responsive p-0" style="text-align: center;">
          <table class="table table-hover text-nowrap" style="table-layout: auto; ">
            <thead class="table-light">
              <tr>
                <th scope="col">순번</th>
                <th scope="col" class="text-start ps-4">제목</th>
                <th scope="col">작성일시</th>
                <th scope="col">아티스트 그룹명</th>
                <th scope="col">삭제 여부</th>
                <th scope="col"></th>
                <th scope="col"></th>
              </tr>
            </thead>
            <tbody id="listBody">
              <!-- 데이터 바인딩 -->
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- 페이지네이션 -->
    <div id="pagination-container" class="d-flex justify-content-center mt-4"></div>

  </div>
</div>
	<%@ include file="../adminFooter.jsp"%>
</div>

<script src="/js/notice/noticeList.js?a=2"></script>
<script type="text/javascript">
function confirmDelete(bbsPostNo) {
  Swal.fire({
    title: '게시글을 숨기겠습니까?',
    text: "사용자가 더이상 볼 수 없습니다",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#6c757d',
    confirmButtonText: '네',
    cancelButtonText: '취소'
  }).then((result) => {
	  ${bbsPostNo}
    if (result.isConfirmed) {
      // 삭제 요청 보내기
      window.location.href = `/admin/notice/deleteNotice?bbsPostNo=\${bbsPostNo}`;
    }
  });
}
function confirmReupload(bbsPostNo) {
  Swal.fire({
    title: '다시 게시하시겠습니까?',
    text: "클릭 시 즉시 다시 게시됩니다",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#6c757d',
    confirmButtonText: '네',
    cancelButtonText: '취소'
  }).then((result) => {
	  ${bbsPostNo}
    if (result.isConfirmed) {
      // 삭제 요청 보내기
      window.location.href = `/admin/notice/unDeleteNotice?bbsPostNo=\${bbsPostNo}`;
    }
  });
}

$(document).ready(function() {
	  $('#categoryArtGroupNo').select2({
	    theme: 'bootstrap4',  // ★ 여기 추가
	    width: '100%',
	    placeholder: "아티스트 선택",
	    allowClear: true
	  });
	});
</script>



</body>
</html>