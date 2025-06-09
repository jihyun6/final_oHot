<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<title>Insert title here</title>
</head>
<body>
  <!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../shopHeader.jsp" %>
    
    <!-- ✅ content 시작 -->
    <div class="content">
      <div class="d-flex justify-content-center">
        <div class="col-8">
          <h3 class="mt-5">주문완료</h3>
        </div>
      </div>
        
      <div class="container">
	    <div class="card card-container d-flex justify-content-center align-items-center">
	      <div class="card-body card-body-container">
	        <div class="">
	          <img src="/images/complete.png" width="300px;" height="300px;" />
	        </div>
	        <div class="d-flex flex-column justify-content-center p-3">
	          <h3>주문이 완료되었습니다.</h3>
	          <h5>주문번호: ${ordersVO.orderNo}</h5>
	        </div>
	      </div>
	    </div>
	    
	    <!-- 버튼 -->
	    <div class="d-flex justify-content-center mt-4 gap-3">
        <a href="#" onclick="ordersDetail()" class="btn-add-to-cart text-center">주문목록 상세</a>
        <a href="#" onclick="goodsList()" class="btn-buy-now text-center">Goods 목록</a>
      </div>
    </div>
    
    </div> <!-- wrapper 영역 종료 -->
    <%@ include file="../shopfooter.jsp" %>

<script>
  function ordersDetail(){
    
    if (window.opener && !window.opener.closed) {
    window.opener.location.href = '/shop/ordersDetail'; 
      // 현재 창 닫기
      window.close();
    } else {
      window.location.href = '/shop/ordersDetail'; 
    }
  }
  function goodsList(){

    if (window.opener && !window.opener.closed) {
    window.opener.location.href = '/shop/home'; 

      // 현재 창 닫기
      window.close();
    } else {
      window.location.href = '/shop/home'; 
    }

  }
</script>
</body>
</html>