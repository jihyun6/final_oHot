<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<title>Insert title here</title>
 <!--     Fonts and icons     -->
 <link id="pagestyle" href="../assets/css/material-dashboard.css?v=3.2.0" rel="stylesheet" />
 <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,900" />
 <!-- Nucleo Icons -->
 <link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
 <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
 <!-- Font Awesome Icons -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
 <!-- <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script> -->
 <!-- Material Icons -->
 <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
 <!-- CSS Files -->
 <!-- 문서 양식 css -->
 <link href="../assets/css/atrz-form.css" rel="stylesheet">
 <link href="/images/oHoT_logo.png" rel="icon">
 <script>
 document.addEventListener("DOMContentLoaded", function () {
	  const currentPath = window.location.pathname;

	  // 드롭다운 메뉴 열기 조건
	  const isAtrzPage = currentPath.includes("/emp/atrzHome") || currentPath.includes("/emp/atrzList") || currentPath.includes("/emp/atrzDocBox")  ;

	  if (isAtrzPage) {
	    // 드롭다운 열기
	    const submenu = document.getElementById("submenu1");
	    submenu?.classList.add("show");

	    // 부모 메뉴 강조
	    const parentLink = document.querySelector('a[href="#submenu1"]');
	    parentLink?.classList.add("active", "bg-gradient-dark", "text-white");

	    // 현재 페이지에 해당하는 하위 메뉴 강조 (파란 글씨)
	    document.querySelectorAll("#submenu1 a").forEach(link => {
	      if (currentPath === link.getAttribute("href")) {
	        link.classList.add("active", "text-primary");
	      }
	    });
	  } else {
	    // 그 외 단독 메뉴 처리
	    const navLinks = document.querySelectorAll(".nav-link");
	    navLinks.forEach(link => {
	      const href = link.getAttribute("href");
	      if (href && currentPath === href) {
	        link.classList.add("active", "bg-gradient-dark", "text-white");
	      }
	    });
	  }
	});
</script>

<style type="text/css">
.profile-dropdown {
  display: none;
  position: absolute;
  top: 100%;
  right: 0;
  background-color: white;
  list-style: none;
  margin: 0;
  padding: 0;
  min-width: 150px;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
  z-index: 1000;
}

/* 드롭다운 항목 스타일 */
.profile-dropdown li a {
  display: block;
  padding: 10px 15px;
  color: #333;
  text-decoration: none;
  font-size: 14px;
}

/* hover 시 색 변화 */
.profile-dropdown li a:hover {
  background-color: #f0f0f0;
  color: #000;
}

/* 프로필 이미지 스타일 조금 다듬기 */
.profile-img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}
.notification-icon {
  position: relative;
  display: inline-block;
  width: 24px;
  height: 24px;
}

.badgeNoti {
  position: absolute;
  top: 8px;
  left: 15px;
  width: 10px;
  height: 10px;
  background-color: #F86D72;
  border-radius: 50%;
  border: 1px solid white; 
  display: none;
}
</style>   
</head>
<body class="g-sidenav-show  bg-gray-100">
    
    <!--   Core JS Files   -->
    <script src="../assets/js/core/popper.min.js"></script>
    <script src="../assets/js/core/bootstrap.min.js"></script>
    <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
    <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
    <script src="../assets/js/plugins/chartjs.min.js"></script>
    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 <!-- Navbar -->
 <nav class="navbar navbar-main navbar-expand-lg px-0 mx-3 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
    <div class="container-fluid py-1 px-3">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
          <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">Pages</a></li>
          <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Dashboard</li>
        </ol>
      </nav>
      <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
        <div class="ms-md-auto pe-md-3 d-flex align-items-center">
        <!-- <form action="/emp/logout" method="post" id="logoutForm">
	  		<input type="hidden" name="redirectURL" value="/oho" />
	  		<button>임시로그아웃버튼</button>
	  	</form> -->
          <!-- <div class="input-group input-group-outline">
            <label class="form-label">Type here...</label>
            <input type="text" class="form-control">
          </div> -->
        </div>
        <ul class="navbar-nav d-flex align-items-center  justify-content-end">
          <!-- <li class="nav-item px-3 d-flex align-items-center">
            <a href="javascript:;" class="nav-link text-body p-0">
              <i class="material-symbols-rounded fixed-plugin-button-nav">settings</i>
            </a>
          </li> -->
          <li class="nav-item px-3 d-flex align-items-center alarm-warapper" style="position: relative; display: inline-block;">
            <a style="cursor: pointer;" onclick="toggleAlarm()" id="alarmIcon" class="nav-link text-body p-0">
              <div class="notification-icon">
                <i class="bi bi-bell" style="font-size: 25px; "></i>
                <span class="badgeNoti"></span>
              </div>
            </a>
            <div  id="alarmBox" >
              <h5 style="border-bottom: 1px solid gray; padding: 5px; margin: 15px; margin-bottom: 0;">알림🔔</h5>
              <!-- 알림생성되는 곳 -->
              <%@ include file="../alarm/alarmEmp.jsp" %>
            </div>
          </li>
          
          <li class="dropdown nav-item d-flex align-items-center position-relative">
			  <a id="profileButton" style="cursor: pointer;">
			    <c:choose>
			      <c:when test="${not empty userVO.employeeVO.profileSaveLocate }">
			        <img src="/upload${userVO.employeeVO.profileSaveLocate}" alt="프로필" class="profile-img">
			      </c:when>
			      <c:otherwise>
			        <img src="/images/defaultProfile.jpg" alt="기본 프로필" class="profile-img">
			      </c:otherwise>
			    </c:choose>
			  </a>
			  <ul class="profile-dropdown">
			    <li><a href="#" id="employeeLink">로그아웃</a></li>
			    <li><a href="/emp/empProfile">기본 정보</a></li>
			  </ul>
		  </li>
          
        </ul>
      </div>
    </div>
  </nav>
  
  <form action="/emp/logout" method="post" id="logoutForm"></form>
  <!-- End Navbar -->
</body>
<script type="text/javascript">
window.addEventListener("DOMContentLoaded", function() {
	
	const profileButton = document.getElementById('profileButton');
	const dropdownMenu = profileButton.nextElementSibling;

	profileButton.addEventListener('click', function(event) {
	  event.stopPropagation(); // 이벤트 버블링 방지
	  dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
	});

	// 다른 곳 클릭하면 드롭다운 닫기
	document.addEventListener('click', function() {
	  dropdownMenu.style.display = 'none';
	});
	
	let employeeLink = document.getElementById('employeeLink')
	
	if(employeeLink){
		document.getElementById('employeeLink').addEventListener("click", function(e){
			e.preventDefault();
			document.getElementById('logoutForm').submit();
		});
	}

});
</script>
</html>