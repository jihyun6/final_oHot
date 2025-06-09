<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<style>
  .reply-content {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
  }
  .reply-content.expanded {
    -webkit-line-clamp: unset;
    display: block;
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
											<label for="category" class="small">카테고리</label>
											<select id="category" class="form-select" style="width: 100%;">
												<option selected value="">전체</option>					
												<option value="boardY">커뮤니티</option>
												<option value="mediaY">미디어</option>
												<option value="tkY" >티켓</option>
											</select>
										</div>
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="urlCategory" class="small">유저 타입</label>
											<select id="urlCategory" class="form-select " style="width: 100%;">
												<option value="" selected>전체</option>
												<option value="ROLE_MEM">멤버</option>
												<option value="ROLE_ART">아티스트</option>
											</select>
										</div>
										
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="replyDelyn" class="small">삭제 여부</label>
											<select id="replyDelyn" class="form-select" style="width: 100%;">
												<option selected value="">전체</option>					
												<option value="Y">Y</option>
												<option value="N">N</option>
											</select>
										</div>
										
										<div class="col-md-2 form-group gap-5 mb-1">
											<label class="small">작성일시</label>
											<div class="input-group date " id="replyCreateDate" data-target-input="nearest">
												<input type="text" class="form-control datetimepicker-input"
													data-target="#replyCreateDate">
												<div class="input-group-append" data-target="#replyCreateDate"
													data-toggle="datetimepicker">
													<div class="input-group-text"><i class="fa fa-calendar"></i></div>
												</div>
											</div>
										</div>
										
										
									</div>
									
										<!-- 2행 시작 -->
									<div class="row mb-4"
											style="margin-bottom: 0px !important; margin-top: 0px !important">	
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="memNo"  class="small">유저 번호</label>
											<input type="text" id="memNo" name="memNo" class="form-control"
												placeholder="이름을 입력하세요">
										</div>
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="boardNo"  class="small">커뮤니티 게시글 번호</label>
											<input type="text" id="boardNo" name="boardNo" class="form-control"
												placeholder="게시글 번호를 입력하세요">
										</div>
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="mediaPostNo"  class="small">미디어 게시글 번호</label>
											<input type="text" id="mediaPostNo" name="mediaPostNo" class="form-control"
												placeholder="게시글 번호를 입력하세요">
										</div>
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="tkNo"  class="small">티켓 번호</label>
											<input type="text" id="tkNo" name="tkNo" class="form-control"
												placeholder="티켓 번호를 입력하세요">
										</div>
										<div class="col-md-2 form-group gap-5 mb-1">
											<label for="replyNo"  class="small">댓글 번호</label>
											<input type="text" id="replyNo" name="replyNo" class="form-control"
												placeholder="댓글 번호를 입력하세요">
										</div>
									
										<!-- 시작일 선택 -->


									</div>
									<!-- 검색 2행 끝 -->

									<!-- 검색 3행 시작 -->
									<div class="row mb-4"
										style="margin-bottom: 0px !important; margin-top: 0px !important">
										
										
										<div class="col-md-6 form-group gap-5 mb-1">
											<label for="replyContent" class="small">댓글 내용</label>
											<input id="replyContent" name="replyContent" type="text" class="form-control "
												placeholder="댓글 내용을 입력하세요">
										</div>
										<div class="col-md-6 d-flex justify-content-end align-items-end">
											<div class="me-2">
												<label for="search-title" class="small">&ensp;</label>
												<p>
													<button type="reset" class="btn btn-outline-dark col-md-12" id="resetBtn">초기화</button>
												</p>
											</div>
											<div >
												<label for="search-title" class="small">&ensp;</label>
												<p>
													<a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12">검색</a>
												</p>
											</div>
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
									<th>내용</th>
									<th>유저 타입</th> <!--  Y면 멤버십 전용 게시물 -->
									<th>작성일시</th> <!-- Y면 팬 전용 게시물 -->
									<th>삭제여부</th>
									<th>유저번호</th>
									<th>커뮤니티 게시글 번호</th><!--ROLE_MEM OR ROLE_ART -->
									<th>미디어 게시글 번호</th><!-- MEM_NO -->
									<th>티켓 번호</th><!-- MEM_NO -->
									<th>댓글 번호</th><!-- MEM_NO -->
									<th></th>
								</thead>
								<tbody id="listBody">

								</tbody>
							</table>
						</div>
						<!-- 페이징이 들어갈 영역 -->
						<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
						<div class="d-flex justify-content-end mt-3 mb-5 px-5">
						  <a href="/api/excel/replyList/download" class="btn btn-success">
						    <i class="fas fa-file-excel"></i> 엑셀 다운로드
						  </a>
						</div>
					</div>
	<!-- 관리자 풋터 -->  
	
</div>

	<%@ include file="../adminFooter.jsp"%>
<script src="/js/community/replyList.js?a=2"></script>
<script type="text/javascript">

function confirmDelete(replyNo) {
	  Swal.fire({
	    title: '댓글을 숨기겠습니까?',
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
	      window.location.href = `/admin/community/replyDelete?replyNo=\${replyNo}`;
	    }
	  });
	}
	function confirmUnDelete(replyNo) {
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
	      window.location.href = `/admin/community/replyUnDelete?replyNo=\${replyNo}`;
	    }
	  });
	}

	  $(document).on('click', '.toggle-reply', function () {
	    const $btn = $(this);
	    const $content = $btn.siblings('.reply-content');

	    $content.toggleClass('expanded');
	    $btn.text($content.hasClass('expanded') ? '접기' : '더보기');
	  });


</script>
</body>
</html>