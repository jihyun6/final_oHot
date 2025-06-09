<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="../header.jsp" %>

    <meta charset="UTF-8">
    <title>이상형 월드컵 결과</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .artist-card {
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .artist-card:hover {
            transform: scale(1.02);
        }
        .artist-img {
            width: 100%;
            aspect-ratio: 1 / 1;
            object-fit: cover;
            border-radius: 1rem 1rem 0 0;
        }
        .card-body {
            text-align: center;
        }
        .nickname {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 0.5rem;
        }
        .vote-count {
            font-size: 0.9rem;
            color: #6c757d;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin: 2rem 0 1rem;
            color: #6c63ff;
            text-align: center;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">

	
	<div class="section-title mt-5">💖 당신의 선택</div>
	<div class="row justify-content-center">
	  <div class="col-md-4 col-sm-6">
	    <div class="card artist-card border-primary shadow rounded-4 overflow-hidden position-relative">
	      <c:set var="fileVO" value="${yourPick.fileGroupVO.fileDetailVOList[0]}" />
	
	
	      <!-- 아티스트 이미지 -->
	      <img class="card-img-top img-fluid" 
	           style="object-fit: cover; height: 300px;" 
	           src="/upload${fileVO.fileSaveLocate}" 
	           alt="${yourPick.artActNm}">
	
	      <div class="card-body text-center">
	        <h5 class="card-title fw-bold">${yourPick.artActNm}</h5>
	        <p class="text-muted">💖 당신의 이상형!</p>
	      </div>
	    </div>
	  </div>
	</div>

    <div class="section-title">🏆 인기 많은 아티스트 TOP</div>
    <div class="row g-4">
        <c:forEach var="item" items="${winners}">
            <div class="col-md-2 col-sm-6">
                <div class="card artist-card">
                    <img class="artist-img" src="/upload${item.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" alt="${item.artActNm}">
                    <div class="card-body">
                        <div class="nickname">${item.artActNm}</div>
                        <div class="vote-count">총 ${item.cnt}회 선택됨</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../footer.jsp" %>

</body>
</html>
