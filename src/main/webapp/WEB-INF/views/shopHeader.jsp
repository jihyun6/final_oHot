<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title></title>
<meta name="description" content="">
<meta name="keywords" content="">
<title>oHot Shop</title>
<link rel="stylesheet" href="/bootstrap-5.3.3-dist/css/bootstrap.css" />
<link rel="stylesheet" href="/bookly/style.css" />

<!-- Favicons -->
<link href="/images/oHoT_logo.png" rel="icon">
<link href="/main/assets//img/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/main/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/main/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="/main/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/main/assets/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="/main/assets/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">

<!-- Main CSS File -->
<link href="/main/assets/css/main.css" rel="stylesheet">
<link rel="stylesheet" href="/main/assets/css/card.css">

<!-- =======================================================
  * Template Name: OnePage
  * Template URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
  * Updated: Aug 07 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<style type="text/css">
.marginLeft {
	margin-left: 100px;
}

.marginRight {
	margin-right: 100px;
}

.marginRight15 {
	margin-right: 15px;
}

#shopArtGroup {
      width: 20%;
      padding: 12px 16px;
      border: none;
      border-radius: 12px;
      appearance: none;
      background-color: #f9f9f9;
      font-size: 16px;
      cursor: pointer;
      transition: border 0.3s ease;
    }

</style>

</head>
<body>
	<header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center" style="max-width: 1320px; !important;">
		
      <a href="/shop/home" class="logo d-flex align-items-center me-auto">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
		<img src="/images/oHoT_logo.png" class="logo" style="width : 100px; height : 100%">
	  </a>
	  
	  <c:if test="${artistGroupList != null}">
	    <select class="form-select" name="artGroupNo" id="shopArtGroup">
		  <option disabled="disabled" selected="selected">artistGroup</option>
		  <c:forEach var="artistGroupVO" items="${artistGroupList}">
		    <option value="${artistGroupVO.artGroupNo}">
		      ${artistGroupVO.artGroupNm}
		    </option>
		  </c:forEach>
	    </select>
	  </c:if>
	  
      <nav id="navmenu" class="navmenu">
        <ul>
        
          <!-- 비회원에게 보여짐 시작 -->
          <sec:authorize access="!isAuthenticated()">
          <!-- 로그인 버튼 -->
           <li>
          	<a class="btn-getstarted" href="#" onclick="redirectToLogin()"><spring:message code="signin" /></a>
          </li>
          </sec:authorize>
          <!-- 비회원에게 보여짐 끝 -->
          
          <!-- 메인서비스와 굿즈샵 사에이 경계선 -->
          <li>
          	<a>
          		<div style="border-left: 2px solid #FFF; height: 30px; margin: 0 10px;"></div>
          	</a>
          </li>
          
          <!-- 회원에게 보여짐 시작 -->
          <sec:authorize access="isAuthenticated()">
          <!-- 홈 버튼 -->
          <li>
            <a href="/oho" target="_blank">
              <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
  		        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5z"/>
		      </svg>
		    </a>
          </li>
          <!-- 장바구니 이동 버튼 -->
          <li>
          	<a href="/shop/cart/list">
	 			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
				  <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
				</svg>
          	</a>
		  </li>
		  <!-- 마이페이지 버튼 -->
          <li class="dropdown">
          	<a style="cursor: pointer;">
	 			<span>MY</span>
	 			<i class="bi bi-chevron-down toggle-dropdown"></i>
          	</a>
          	<ul>
              <li><a href="#" id="employeeLink">로그아웃</a></li>
              <li><a href="/shop/ordersDetail">주문내역</a></li>
              <li><a href="/shop/addrManager">배송주소 관리</a></li>
              <!-- toggle-dropdown 버튼 
              <li class="dropdown"><a href="#"><span>Deep Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                <ul>
                  <li><a href="#">Deep Dropdown 1</a></li>
                  <li><a href="#">Deep Dropdown 2</a></li>
                  <li><a href="#">Deep Dropdown 3</a></li>
                  <li><a href="#">Deep Dropdown 4</a></li>
                  <li><a href="#">Deep Dropdown 5</a></li>
                </ul>
              </li>
              -->
            </ul>
		  </li>
          </sec:authorize>
          <!-- 회원에게 보여짐 끝 -->
        </ul>
      </nav>
    </div>
  </header>
  
  <!-- 임시 로그아웃 버튼 -->
  <form action="/logout" method="post" id="myForm"></form>
</body>

<script>
<!-- 로그인 버튼 클릭 시 현재 페이지 redirectURL로 저장하기 -->
 function redirectToLogin() {
	  const currentURL = window.location.pathname + window.location.search;
	  const encodedURL = encodeURIComponent(currentURL);
	  console.log("currentURL : ", currentURL);
	  console.log("encodedURL : ", encodedURL);
	  
	  window.location.href = '/login?redirectURL=' + encodedURL;
 }
 
//DOMContentLoaded: 문서가 완전히 로드 된 후 실행!
window.addEventListener("DOMContentLoaded", function() {
	
	let employeeLink = document.getElementById('employeeLink')
	
	if(employeeLink){
		document.getElementById('employeeLink').addEventListener("click", function(e){
			e.preventDefault();
			document.getElementById('myForm').submit();
		});
	}
	
	//그룹 홈페이지 이동
	let artGroup = document.getElementById('shopArtGroup')
	
	if(artGroup) {
		document.getElementById('shopArtGroup').addEventListener("change", function(e){
			window.location.href = '/shop/artistGroup?artGroupNo=' + e.currentTarget.value;
		});
	}
});
</script>

<script src="/js/jquery-3.6.0.js" ></script>
<script src="/bootstrap-5.3.3-dist/js/bootstrap.bundle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- Preloader -->
<div id="preloader"></div>

<!-- Vendor JS Files -->
<!-- <script src="/main/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->
<!-- <script src="/main/assets/vendor/php-email-form/validate.js"></script> -->
<!-- <script src="/main/assets/vendor/aos/aos.js"></script> -->
<!-- <script src="/main/assets/vendor/purecounter/purecounter_vanilla.js"></script> -->
<!-- <script src="/main/assets/vendor/glightbox/js/glightbox.min.js"></script> -->
<!-- <script src="/main/assets/vendor/swiper/swiper-bundle.min.js"></script> -->
<!-- <script src="/main/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script> -->
<!-- <script src="/main/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script> -->

<!-- Main JS File -->
<script src="/main/assets/js/main.js"></script>
</html>