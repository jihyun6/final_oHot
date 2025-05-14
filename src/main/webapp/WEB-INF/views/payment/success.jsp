<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/bootstrap-5.3.3-dist/css/bootstrap.css" />
</head>
<body>
  <div class="container p-4" style="max-width: 450px; background-color: #fff; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
    <!-- 상단 이미지 & 메시지 -->
    <div class="d-flex flex-column align-items-center text-center">
      <img src="/images/paymentSuccess.png" width="100px" alt="결제 성공 이미지" />
      <h2 class="mt-3 fw-bold text-success">결제를 완료했어요</h2>
    </div>

    <!-- 결제 정보 -->
    <div class="mt-4 px-2 py-3 bg-light rounded">
      <div class="d-flex justify-content-between">
        <span class="fw-bold">🧾 주문번호</span>
        <span class="fw-normal text-muted">${ordersVO.orderNo}</span>
      </div>
    <hr />
      <div class="d-flex justify-content-between">
        <span class="fw-bold">💳 결제금액</span>
        <span class="fw-bold text-primary">₩ <fmt:formatNumber value="${ordersVO.gramt}" pattern="#,###" /></span>
      </div>
    </div>
  </div>
</body>

<!-- JS 영역 -->
<script src="/js/jquery-3.6.0.js" ></script>
<script src="/bootstrap-5.3.3-dist/js/bootstrap.bundle.js"></script>   
    
</html>