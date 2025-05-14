<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<style>
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

<c:set var="title" value="게시글 관리"></c:set>

	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

			<!-- 컨텐츠-->
			<div class="content-wrapper">
				<%-- ${goodsVOList } --%>
				
				<div class="col-md-12" style="padding: 20px 20px 0px 20px">
						<div class="card card-secondary">
							<div class="card-header ">
							</div>

							<!-- /.card-header -->
							<!-- form start -->
							<form onsubmit="return false;" id="srhFrm">
								<!-- /.card-body -->
								<div class="card-body" style="padding: 10px 10px 0px;">
									<div class="row mb-4" style="margin-bottom: 0px !important">
										<!-- 멤버십 전용 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="boardOnlyMembership" class="small">멤버십 전용</label>
											<select id="boardOnlyMembership" class="form-select" style="width: 100%;">
												<option selected value="">전체</option>					
												<option value="Y" name="boardOnlyMembership">Y</option>
												<option value="N" name="boardOnlyMembership">N</option>
											</select>
										</div>

										<!-- 팬 전용 게시글 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="boardOnlyFan" class="small">팬 전용</label>
											<select id="boardOnlyFan" class="form-select"
												style="width: 100%;">
												<option selected value="">전체</option>
												<option value="Y" name="boardOnlyFan">Y</option>
												<option value="N" name="boardOnlyFan">N</option>
				
											</select>
										</div>



										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="boardDelyn" class="small">삭제 여부</label>
											<select id="boardDelyn" class="form-select" style="width: 100%;">
												<option selected value="">전체</option>					
												<option value="Y" name="boardDelyn">Y</option>
												<option value="N" name="boardDelyn">N</option>
											</select>
										</div>


										<!-- 삭제 여부 선택 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="urlCategory" class="small">유저 타입</label>
											<select id="urlCategory" class="form-select" style="width: 100%;">
												<option value="" selected>전체</option>
												<option value="ROLE_MEM">멤버</option>
												<option value="ROLE_ART">아티스트</option>
											</select>
										</div>


										<!-- 담당자 검색 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="memNo"  class="small">유저 번호</label>
											<input type="text" id="memNo" name="memNo" class="form-control"
												placeholder="유저 번호를 입력하세요">
										</div>

										<!-- 시작일 선택 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label class="small">작성 일시</label>
											<div class="input-group date " id="boardCreateDate" data-target-input="nearest">
												<input type="text" class="form-control datetimepicker-input"
													data-target="#boardCreateDate">
												<div class="input-group-append" data-target="#boardCreateDate"
													data-toggle="datetimepicker">
													<div class="input-group-text"><i class="fa fa-calendar"></i></div>
												</div>
											</div>
										</div>


									</div>
									<!-- 검색 1행 끝 -->

									<!-- 검색 2행 시작 -->
									<div class="row mb-4"
										style="margin-bottom: 0px !important; margin-top: 0px !important">
										

										<!-- 공연장소별 여부 선택 -->
										<div class="col-md-4 form-group gap-5 mb-1">
											<label for="boardTitle" class="small">제목</label>
											<input type="text" id="boardTitle" name="boardTitle" class="form-control"
												placeholder="제목을 입력하세요">
										</div>
										
										<div class="col-md-6 form-group gap-5 mb-1">
											<label for="boardContent" class="small">내용</label>
											<input id="boardContent" name="boardContent" type="text" class="form-control "
												placeholder="내용을 입력하세요">
										</div>

										<div class="col-md-1 form-group gap-5 mb-1">
											<label for="search-title" class="small">&ensp;</label>
											<p>
												<button type="reset" class="btn btn-outline-dark col-md-12" id="resetBtn">초기화</button>
											</p>
										</div>
										<div class="col-md-1 form-group gap-5 mb-1">
											<label for="search-title" class="small">&ensp;</label>
											<p>
											<a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12">검색</a>
											</p>
										</div>
									</div>

									<!-- 검색옵션 2행 끝  -->

								</div>
							</form>
						</div>
					</div>
					
					<div class="row text-center" style="padding: 0px 40px 0px 40px">
						<div class="card-body table-responsive p-0" style="text-align: center;">
							<table class="table table-hover text-nowrap" style="table-layout: auto; ">
								<thead>
									<th>순번</th>
									<th>제목</th>
									<th>멤버십 전용</th> <!--  Y면 멤버십 전용 게시물 -->
									<th>팬 전용</th> <!-- Y면 팬 전용 게시물 -->
									<th>삭제여부</th>
									<th>작성일시</th>
									<th>유저 타입</th><!--ROLE_MEM OR ROLE_ART -->
									<th>유저 번호</th><!-- MEM_NO -->
									<th>숨김</th>
								</thead>
								<tbody id="listBody">

								</tbody>
							</table>
						</div>
						<!-- 페이징이 들어갈 영역 -->
						<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>						
					</div>
					<div class="d-flex justify-content-end mt-3 mb-5 px-5">
					  <a href="/api/excel/postList/download" class="btn btn-success">
					    <i class="fas fa-file-excel"></i> 엑셀 다운로드
					  </a>
					</div>
	<!-- 관리자 풋터 -->  
		</div>
	<%@ include file="../adminFooter.jsp"%>
</div>

<script src="/js/community/postList.js?a=2"></script>
<script type="text/javascript">

function confirmDelete(boardNo) {
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
	      window.location.href = `/admin/community/postDelete?boardNo=\${boardNo}`;
	    }
	  });
	}
	function confirmUnDelete(boardNo) {
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
	      window.location.href = `/admin/community/postUnDelete?boardNo=\${boardNo}`;
	    }
	  });
	}
	$(document).ready(function() {
		  $('.toggle-btn').on('click', function(e) {
		    e.stopPropagation(); // tr 클릭 방지
		    const content = $(this).siblings('.content-preview');
		    const isExpanded = content.hasClass('expanded');
		    
		    content.toggleClass('expanded collapsed');
		    $(this).text(isExpanded ? '더보기' : '접기');
		  });
		});
</script>
</body>
</html>