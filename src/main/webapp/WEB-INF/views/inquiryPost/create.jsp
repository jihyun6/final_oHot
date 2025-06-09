<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/dompurify@2.4.0/dist/purify.min.js"></script>
<style>
.ck-editor__editable_inline {
  min-height: 400px !important;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO" />
	</sec:authorize>
	<c:set var="memberVO" value="${userVO.memberVO}" />
<!-- 	<p>유저 정보</p> -->
<%-- 	${userVO} --%>
<!-- 	<p>유저 상세 정보</p> -->
<%-- 	${memberVO} --%>
<!-- 	<p>수정될 글 정보</p> -->
<%-- 	${boardPostVO} --%>

	<!-- 본문 시작 -->
	<div class="container py-5">
    <div class="card shadow p-4 rounded-4">
      <h2 class="mb-3">${boardPostVO != null ? "게시글 수정" : "게시글 작성"}</h2>
      <c:if test="${boardPostVO == null}">
      	<p class="text-muted">비회원은 글을 수정 또는 삭제할 수 없습니다.</p>
      </c:if>
      <hr>

      <form action="${boardPostVO != null ? '/oho/inquiryPost/editPost' : '/oho/inquiryPost/createPostAcess'}"
        	id="${boardPostVO != null ? 'frmEditSubmit' : 'frmSubmit'}" method="post">

		
        <input type="hidden" name="bbsPostNo" value="${boardPostVO != null ? boardPostVO.bbsPostNo : boardNo}" />
        <input type="hidden" name="replyPostNo" value="${boardPostVO.replyPostVO != null ? boardPostVO.replyPostVO.bbsPostNo : null}" />
        <input type="hidden" name="pswdStatus" value="${boardPostVO.inquiryPostVO.inqPswd != null ? 'pswdEdit' : 'pswdAdd' }" />
		
		<div class="row">
	        <div class="col-3 mb-3">
	          <label class="form-label">문의 유형</label>
	          <select class="form-select" name="inqTypeNo">
	            <c:forEach var="inqType" items="${inqTypeVOList}">
	              <option value="${inqType.inqTypeNo}">${inqType.inqTypeNm}</option>
	            </c:forEach>
	          </select>
	        </div>
	        <div class="col-3 mb-3">
	          <label class="form-label">작성자</label>
	          <input type="text" id="writer" name="${userVO != null ? '' : 'writer'}" class="form-control"
	                 value="${userVO != null ? userVO.userMail : '' || boardPostVO != null ? boardPostVO.inquiryPostVO.inqWriter : ''}"
	                 ${userVO != null || boardPostVO != null ? 'disabled' : 'required'}>
	        </div>
	        <div class="col-3 mb-3">
	          <label class="form-label">비밀번호 (숫자 4자리)</label>
	          <input type="text" name="inqPswd" class="form-control" maxlength="4"
	                 value="${boardPostVO != null ? boardPostVO.inquiryPostVO.inqPswd : ''}"
	                 oninput="this.value = this.value.replace(/[^0-9]/g, '')">
	        </div>
		</div>

        <div class="mb-3">
          <label class="form-label">제목</label>
          <input type="text" id="bbsTitle" name="bbsTitle" class="form-control" value="${boardPostVO.bbsTitle}" required>
        </div>

        <div class="mb-3">
          <label class="form-label">내용</label>
          <textarea name="bbsHtmlCn" id="editor1">${boardPostVO.bbsHtmlCn}</textarea>
        </div>

        <input type="hidden" id="plainText" name="bbsCn">

        <div class="d-flex justify-content-end gap-2">
          <input type="button" id="${boardPostVO != null ? 'saveBtn' : 'submitBtn'}" value="${boardPostVO != null ? '저장' : '등록'}" style="background-color: #F86D72; color: white;" class="btn px-4">
          <input type="button" id="cancelBtn" value="취소" class="btn btn-outline-secondary px-4">
        </div>
      </form>
    </div>
  </div>
	<!-- 본문 끝 -->

    <script src="/js/inquiryPost/inquiryPostCreate.js"></script>
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>