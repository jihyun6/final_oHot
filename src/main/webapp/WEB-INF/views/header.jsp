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
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>oHoT</title>
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
<link rel="styleSheet" href="/css/media-live/media-live.css">	
<!-- font어썸 -->
<!-- font어썸이 css만 아니라 font 파일도 있어야하는데 지금 없어서 그냥 cdn방식으로 처리함 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Main CSS File -->
<link href="/main/assets/css/main.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- toastify -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- =======================================================
  * Template Name: OnePage
  * Template URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
  * Updated: Aug 07 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<style type="text/css">
a {
  text-decoration: none; /* 밑줄 제거 */
  color: inherit;         /* 부모 요소의 글자 색상 상속 (또는 원하는 색상 지정) */
}
.marginLeft {
	margin-left: 100px;
}

.marginRight {
	margin-right: 100px;
}

.marginRight15 {
	margin-right: 15px;
}


/* myCommunityList */
  .dropdown-menu.weverse-dropdown {
    width: 250px;
    max-height: 300px; /* 최대 높이 제한 */
    overflow-y: auto;  /* 세로 스크롤 생성 */
    border-radius: 16px;
    padding: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }

  .dropdown-item.weverse-artist-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 8px 10px;
    border-radius: 10px;
    transition: background-color 0.2s ease;
  }

  .dropdown-item.weverse-artist-item:hover {
    background-color: #f0f0f0;
  }

  .weverse-artist-name {
    font-weight: 600;
    color: #333;
  }

  .weverse-add {
    color: #00c3af;
    font-weight: 500;
    border-top: 1px solid #eee;
    padding-top: 10px;
    margin-top: 10px;
    display: block;
    text-align: center;
  }
  /* myCommunityList 끝 */

  .notification-icon {
  position: relative;
  display: inline-block;
  width: 24px;
  height: 24px;
}

.badgeNoti {
  position: absolute;
  top: 0px;
  left: 20px;
  width: 10px;
  height: 10px;
  background-color: #F86D72;
  border-radius: 50%;
  border: 1px solid white; 
  display: none;
}

</style>

</head>
<body>
<fmt:setBundle basename="messages" />
<c:if test="${not empty param.lang}">
  <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>
	<header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center">

      <div class="d-flex align-items-center me-auto">
	      <!-- 로고 -->
		  <a href="/oho" class="logo d-flex align-items-center">
		    <img src="/images/oHoT_logo.png" class="logo" style="width: 100px; height: 100%;">
		  </a>
	  	  <!-- select 옵션 박스 -->
		    <select class="form-select me-3" style="width: 70px;" name="lang" onchange="changeLang(this)">
		        <option value="ko" <c:if test="${sessionScope.lang == 'ko' || empty sessionScope.lang}">selected</c:if>>KO</option>
		        <option value="en" <c:if test="${sessionScope.lang == 'en'}">selected</c:if>>EN</option>
		    </select>
		    
		<c:if test="${not empty myCommunityList}">
		  <div class="d-flex align-items-center p-3">
		    <div class="dropdown">
		      <button class="btn btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
		        ${artistGroupVO.artGroupNm}
		      </button>
		      <ul class="dropdown-menu weverse-dropdown">
		
		        <c:forEach var="myCommunity" items="${myCommunityList}">
		          <li>
		            <a class="dropdown-item weverse-artist-item" href="/oho/community/fanBoardList?artGroupNo=${myCommunity.artGroupNo}">
		              <span class="weverse-artist-name">${myCommunity.artGroupNm}</span>
		            </a>
		          </li>
		        </c:forEach>
		
		        <li>
		          <a href="/oho" class="weverse-add">
		            + 새로운 아티스트를 만나보세요!
		          </a>
		        </li>
		      </ul>
		    </div>
		  </div>
		</c:if>
	</div>
	 

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
          
          <!-- 회원에게 보여짐 시작 -->
          <sec:authorize access="isAuthenticated()">
          <!-- 검색 버튼-->
          <li id="searchToggle">
          	<!-- 검색 아이콘 -->
          	<a id="searchIcon" style="cursor: pointer;">
	 			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
				</svg>
          	</a>
          	
          	 <!-- 검색 입력창 -->
          	 <div class="custom-search-wrapper" id="searchBox" style="display: none; position: relative;">
			  <i class="bi bi-search search-icon"></i>
			  <input type="text" id="searchInput" class="custom-search-input" placeholder="<spring:message code="home.keyword" />" />
			  <button class="clear-btn" id="clearSearch" type="button">
			    <i class="bi bi-x-lg"></i>
			  </button>
				  <div id="searchResults" class="dropdown-menu show p-0" style="position: absolute; top: 60px; left: 0; width: 100%; display: none; z-index: 999;">
				  <!-- 결과 리스트 출력 div -->
				  </div>
			</div>
		  </li>
           <!-- 알림버튼 -->
		   <li class="alarm-warapper" style="position: relative; display: inline-block;">
				<a style="cursor: pointer;" onclick="toggleAlarm()" id="alarmIcon">
					<div class="notification-icon">
						<i class="bi bi-bell" style="font-size: 25px; width: 100%;  height: 100%;"></i>
						<span class="badgeNoti"></span>
					</div>
				</a>
				<div  id="alarmBox" >
					<h5 style="border-bottom: 1px solid gray; padding: 5px; margin: 15px; margin-bottom: 0;">알림🔔</h5>
					<!-- 알림생성되는 곳 -->
					<%@ include file="./alarm/alarm.jsp" %>
				</div>
			</li>
		  
		  <!-- MY 버튼 -->
		  <li class="dropdown">
          	<a style="cursor: pointer;">
	 			<span style="color: inherit !important;">MY</span>
	 			<i class="bi bi-chevron-down toggle-dropdown"></i>
          	</a>
          	<ul>
              <li><a href="javascript:void(0)" id="logout"><spring:message code="logout" /></a></li>
              <li><a href="/oho/mypage"><spring:message code="myPage"/></a></li>
              <li><a href="#"><spring:message code="settings" /></a></li>
            </ul>
		  </li>
          
          </sec:authorize>
          <!-- 회원에게 보여짐 끝 -->
		  
          <!-- 메인서비스와 굿즈샵 사에이 경계선 -->
          <li>
          	<a>
          		<div style="border-left: 2px solid #d9d9d9; height: 30px; margin: 0 10px;"></div>
          	</a>
          </li>
          <!-- 굿즈샵 이동 버튼 -->
          <li>
          	<a href="/shop/home" target="_blank">
	 			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-bag" viewBox="0 0 16 16">
				  <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1m3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"/>
				</svg>
          	</a>
		  </li>
        </ul>
      </nav>
    </div>

      <form action="/logout" method="post" id="logoutForm">
	  	<input type="hidden" name="redirectURL" value="/oho" />
	  </form>
  </header>

<script>
let stompClientAlarm= null;
let isAlarmSocketConnected=false;

const memNoForAlarm='${userVO.userNo}';

alarmconnect();

function alarmconnect(){
	const socket = new SockJS("/ws/alarm");
	stompClientAlarm = Stomp.over(socket);
	if(isAlarmSocketConnected)return callback?.();

	stompClientAlarm.connect({}, (frame)=>{
		console.log("연결성공: "+JSON.stringify(frame));
		isAlarmSocketConnected=true;

		//알림 받을 경로 구독
		stompClientAlarm.subscribe('/toAll/memNo/'+memNoForAlarm, (alarmMsgs)=>{
			const alarmMsg =JSON.parse(alarmMsgs.body);
			console.log("알림온 내용"+JSON.stringify(alarmMsg));

			Toastify({
				text: `
					<div style="display: flex; align-items: center;" onclick="toggleAlarm()">
						<img src="/upload\${alarmMsg.fileSaveLocate}" 
							alt="💗" 
							style="width: 50px; height: 50px; border-radius: 50%; margin-right: 10px;">
						<div style="text-align:center; color:white;">
							<strong>\${alarmMsg.notiCn}</strong>
						</div>
					</div>
				`,
				duration: 4000,
				gravity: "top", // Position: top or bottom
				position: "right", // Position: left, center, or right
				backgroundColor: "rgb(240, 248, 255);",
				stopOnFocus: true, // Prevents dismissing on hover
				escapeMarkup: false, // Allows HTML content
			}).showToast();

			const badgeYnHeader = document.querySelector('.badgeNoti');
			badgeYnHeader.style.display='block';

		})
	})

}

<!-- 로그인 버튼 클릭 시 현재 페이지 redirectURL로 저장하기 -->
 function redirectToLogin() {

	  const currentURL = window.location.pathname + window.location.search;
	  const encodedURL = encodeURIComponent(currentURL);
	  console.log("currentURL : ", currentURL);
	  console.log("encodedURL : ", encodedURL);
	  
	  window.location.href = "/login?redirectURL=" + encodedURL;
 }
 
 function changeLang(select) {
   const url = new URL(window.location.href);
   url.searchParams.set("lang", select.value);
   window.location.href = url.toString();
 }
 
 const i18n = {
		 notFound : "<spring:message code='home.not.found' />",
		 searchFail : "<spring:message code='home.search.fail' />"
 }
 
 window.addEventListener("DOMContentLoaded", function() {
	   document.getElementById('logout').addEventListener("click", function(e){
	      e.preventDefault();
	      document.getElementById('logoutForm').submit();
	   });
	});
 
</script>

</body>
<script src="/js/header/search.js" ></script>
<script src="/js/jquery-3.6.0.js" ></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>


<!-- Vendor JS Files -->
<script src="/main/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/main/assets/vendor/php-email-form/validate.js"></script>
<script src="/main/assets/vendor/aos/aos.js"></script>
<script src="/main/assets/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="/main/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="/main/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="/main/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="/main/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>


</html>