<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 - 관리자</title>
<!-- Bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Helvetica Neue', sans-serif;
    }
    .weverse-card {
        border-radius: 1.5rem;
        border: none;
        box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }
    .weverse-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #212529;
    }
    .weverse-label {
        font-weight: 500;
        color: #6c757d;
    }
    .weverse-content {
        white-space: pre-wrap;
        line-height: 1.7;
        font-size: 1rem;
        color: #343a40;
    }
    .btn-outline-light-gray {
        border: 1px solid #dee2e6;
        color: #495057;
    }
    .object-fit-cover {
    object-fit: cover;
	}
</style>
</head>
<body>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>
<div class="container py-5">
    <div class="card weverse-card p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="weverse-title">게시글 상세보기</div>
            <a href="/admin/community/postList" class="btn btn-outline-light-gray rounded-pill px-4">목록으로</a>
        </div>
        
        <div class="mb-4">
            <div class="weverse-label mb-1">제목</div>
            <div class="fs-5 fw-semibold">${postDetail.boardTitle }</div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <div class="weverse-label mb-1">작성자</div>
                <div>${postDetail.comNm }</div>
            </div>
            <div class="col-md-6">
                <div class="weverse-label mb-1">작성일</div>
                <div>${postDetail.boardCreateDate }</div>
            </div>
        </div>
		
		<!-- 이미지 포함된 게시글 내용 영역 -->
		<div class="mb-4">
		    <div class="weverse-label mb-1">내용</div>
		    <div class="border rounded p-3 bg-white weverse-content mb-3">${postDetail.boardContent }</div>
		    
		    <c:if test="${not empty postDetail.fileGroupVO.fileDetailVOList}">
		        <div class="row g-3">
		            <c:forEach var="item" items="${postDetail.fileGroupVO.fileDetailVOList}">
		                <div class="col-6 col-md-4">
		                    <div class="ratio ratio-1x1 rounded overflow-hidden shadow-sm">
		                        <img src="/upload${item.fileSaveLocate}" class="img-fluid object-fit-cover w-100 h-100" alt="첨부 이미지">
		                    </div>
		                </div>
		            </c:forEach>
		        </div>
		    </c:if>
		</div>


        <div class="text-end mt-4">
        <c:choose>
        	<c:when test="${postDetail.boardDelyn=='N' }">
            	<a href="/admin/community/postDelete?boardNo=${postDetail.boardNo }" class="btn btn-outline-danger rounded-pill px-4"
               		onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </c:when>
            <c:otherwise>
            	    <a href="/admin/community/postUnDelete?boardNo=${postDetail.boardNo }" class="btn btn-outline-secondary rounded-pill px-4"
               		onclick="return confirm('다시 게시하시겠습니까?')">재게시</a>
            </c:otherwise>
        </c:choose>       
        </div>
    </div>
</div>
<%@ include file="../adminFooter.jsp"%>

<!-- Bootstrap JS (선택사항) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>