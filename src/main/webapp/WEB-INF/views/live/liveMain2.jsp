<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHot Media</title>
<link rel="styleSheet" href="/css/media-live/media-live.css">

</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="../header.jsp" %>
<!-- 커뮤니티페이지 네비, 탭-->
<div class="border border-danger">
<header class="d-flex justify-content-center py-1">
<ul class="nav nav-pills nav-fill gap-c1">
   <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${param.artGroupNo}">Fan</a>
  </li>
   <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${param.artGroupNo}">Artist</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">Media</a>
  </li>
   <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${param.artGroupNo}">Live</a>
  </li>
    <li class="nav-item">
    <a class="nav-link" href="#">Shop</a>
  </li>
</ul>
</header>
</div>
<!--네비탭 끝 -->

<!-- 넘어오는 객체들 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<!-- SELECT  U.USER_NO, U.USER_MAIL, USER_PSWD, A.AUTH_NM -->
${usersVO}
<hr/>
${communityProfileVO}
<hr/>
${liveStreamVO}
<hr/>
${streamVOList}

<!-- 본문 영역 -->

<!-- 방송중인 방송 영역, stream정보 없을 때 보임 -->
<c:if test="${empty liveStreamVO}">
    <div class="" style="background-color: teal;">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="row g-0">
                        <div class="col-md-6" style="background-color: aqua;">
                            <a href="#">
                                <img src="/images/noImage.png" class="img-fluid rounded-start" alt="..." style="height: 200px; width: 100%;">
                            </a>
                        </div>
                        <div class="col-md-6">
                            <div class="card-body d-flex flex-column" style="height: 100%;">
                                <div>
                                    <h5>방송 타이틀</h5>
                                    <hr>
                                    <pre>방송 설명</pre>
                                </div>
                                <div class="mt-auto">
                                    <a href="#" class="btn btn-primary"><i class="fa-solid fa-tv"> 방송 보러가기</i> </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- 방송중인 방송 영역 끝 -->
 <!-- 방송 아닐때 아티스트에게 노출되는 영역 -->
 <c:if test="${empty liveStreamVO and communityProfileVO.comAuth eq 'ROLE_MEM'}">
    <div class="live-container row" style="background-color: yellow;">
        <div class="col-md-4 offset-md-4 card ali">
            <div class="card-body ">
                <div class="row">
                    <div class="col-8 align-self-center">
                        <h5 style="margin-top: 5px;">현재 방송중이 아닙니다! 방송을 시작해볼까요?</h2>
                    </div>
                    <div class="col-1"></div>
                    <div class="col-3"><a href="#" class="btn btn-primary"><i class="fa-solid fa-tv"> 방송 하기</i></a></div>    
                </div>
            </div>
        </div>
    </div>
</c:if>
<!-- 지난라이브 영역 -->
<div class="container-fluid px-6 py-3" id="custom-cards">
    <div class="d-flex justify-content-between align-items-center ps-5 pb-2 border-bottom">
        <h2 class="mb-0">지난 라이브</h2>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/oho/community/live/list?artGroupNo=${param.artGroupNo}">더보기</a>
    </div>
    
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-4 mt-3">
        <c:set var="count" value="0" />
        <c:forEach var="mediaPostVO" items="${mediaPostVOList}" varStatus="stat">
            <c:if test="${mediaPostVO.mediaMebershipYn eq 'L' && count < 5}">
                <div class="col">
                    <div class="card h-100 rounded-3">
                        <div style="height: 180px; overflow: hidden;">
                        		<!-- 썸네일은 유튜브 썸네일로 등록 그럼 썸네일 파일 등록할 이유가 없음 아마도? -->
                        	<a class="btn px-1 py-1" style="height: 100%" href="#">
	                            <img src="#" 
	                                 class="card-img-top rounded-3" alt="라이브썸네일" style="width: 100%; height: 100%; object-fit: cover;">
                             </a>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate border-bottom pb-2">라이브 타이틀</h5>
                            <p class="card-text" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; height: 3em;">
                                라이브 설명
                            </p>
                            <small class="text-body-secondary"><fmt:formatDate value="${mediaPostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" /></small>
                        </div>
                    </div>
                </div>
                <c:set var="count" value="${count + 1}" />
            </c:if>
        </c:forEach>
    </div>
</div>
<!-- 지난라이브 영역 끝-->
<!-- 본문 영역 끝-->
<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	<!-- 	<i class="bi bi-arrow-up-short"></i> -->
<script src="/main/assets/js/main.js"></script>
<%@ include file="../footer.jsp" %>
</body>
</html>