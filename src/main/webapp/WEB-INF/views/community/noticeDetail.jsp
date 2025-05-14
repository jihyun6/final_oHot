<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %><!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세</title>
 <%@include file="../header.jsp" %>
  
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
	 body {
	    font-family: "Noto Sans KR", "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
	    color: #333;
	    background-color: #fff;
	  }
    .notice-container {
      max-width: 768px;
      margin: 40px auto;
    }

    .notice-title {
      font-size: 1.5rem;
      font-weight: 700;
    }

    .notice-date {
      font-size: 0.875rem;
      color: #888;
    }

    .notice-content {
      font-size: 1rem;
      line-height: 1.8;
      white-space: pre-wrap; /* 줄바꿈 반영 */
    }

    .notice-link a {
      color: #007bff;
      text-decoration: none;
    }

    .notice-link a:hover {
      text-decoration: underline;
    }

    .notice-card {
      border: none;
      border-radius: 1rem;
      box-shadow: 0 0.25rem 1rem rgba(0, 0, 0, 0.05);
      padding: 2rem;
    }
	/* 헤더 네비 디자인 */
  .weverse-tabs {
    background: linear-gradient(90deg, #0f0f2f, #1a1a40); /* 어두운 배경 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding: 0.75rem 0;
  }

  .weverse-tabs .nav {
    gap: 1.5rem;
  }

  .weverse-tabs .nav-link {
    color: #ccc;
    font-weight: 500;
    font-size: 0.95rem;
    border: none;
    background: transparent;
    border-radius: 2rem;
    padding: 0.4rem 1.2rem;
    transition: all 0.3s ease;
  }

  .weverse-tabs .nav-link:hover {
    color: #fff;
    background-color: rgba(255, 192, 203, 0.1); /* 연한 핑크 호버 효과 */
  }

  .weverse-tabs .nav-link.active {
    background-color: #ff69b4; /* 핫핑크 배경 */
    color: #fff;
    font-weight: 700;
    border-radius: 999px;
    box-shadow: 0 0 10px rgba(255, 105, 180, 0.3);
  }

  @media (max-width: 576px) {
    .weverse-tabs .nav {
      flex-wrap: nowrap;
      overflow-x: auto;
      -webkit-overflow-scrolling: touch;
    }

    .weverse-tabs .nav-link {
      white-space: nowrap;
    }

  }
/* 헤더 네비 디자인 끝  */
  </style>
</head>
<body>
<div class="weverse-tabs d-flex justify-content-center">
  <ul class="nav nav-pills nav-fill">
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${noticeDetail.artGroupNo}">
        Fan
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${noticeDetail.artGroupNo}">
        Artist
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${noticeDetail.artGroupNo}">
        Media
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${noticeDetail.artGroupNo}">
        Live
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${noticeDetail.artGroupNo}"
         target="_blank">
        Shop
      </a>
    </li>
  </ul>
</div>

  <div class="container notice-container">
    <div class="notice-link mt-4">
      <a href="/oho/community/notice?artGroupNo=${noticeDetail.artGroupNo}">← 공지 목록으로 돌아가기</a>
    </div>
    <div class="card notice-card">
      <div class="mb-2">
        <div class="notice-title mb-1">${noticeDetail.bbsTitle}</div>
        <div class="notice-date">${noticeDetail.bbsRegDate}</div>
      </div>

      <div class="notice-content">
        ${noticeDetail.bbsCn}
		   <c:if test="${not empty noticeDetail.fileGroupNo }">
		   
		      <c:forEach var="fileDetail" items="${noticeDetail.fileGroupVO.fileDetailVOList}">
		         <img alt="경로확인" src="/upload/${fileDetail.fileSaveLocate }"  style="width: 100%;" id="explnImg">
		      </c:forEach>
		   
		   </c:if>
      </div>


    </div>
  </div>
<%@ include file="../footer.jsp" %>
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	<!-- 	<i class="bi bi-arrow-up-short"></i> -->

	<!-- Main JS File -->
	<script src="/main/assets/js/main.js"></script>
  <!-- Bootstrap JS (선택사항) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>