<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Live</title>
<link rel="styleSheet" href="/css/media-live/media-live.css">
<link rel="styleSheet" href="/css/media-live/live-hearder.css">
</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="../header.jsp" %>
<!-- 커뮤니티페이지 네비, 탭-->
<div class="weverse-tabs d-flex justify-content-center" style="margin-top: 0; padding-top: 1;">
    <ul class="nav nav-pills nav-fill">
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${param.artGroupNo}">
          Fan
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${param.artGroupNo}">
          Artist
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link "
           href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">
          Media
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active"
           href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${param.artGroupNo}">
          Live
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${param.artGroupNo}"
           target="_blank">
          Shop
        </a>
      </li>
    </ul>
  </div>
<!--네비탭 끝 -->

<!-- 넘어오는 객체들 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<!-- SELECT  U.USER_NO, U.USER_MAIL, USER_PSWD, A.AUTH_NM -->
<!-- ${usersVO}
<hr/>
${communityProfileVO}
<hr/>
${liveStreamVO}
<hr/>
${livePostVOList} -->

<c:if test="${not empty errorMassage}">
    <script>
        alert('${errorMassage}');
    </script>
</c:if>

<!-- 본문 영역 -->

<!-- 방송중인 방송 영역, stream정보 없을 때 보임 -->
<c:if test="${not empty liveStreamVO}">
  <section class="container py-4" style="background: linear-gradient(135deg, #e0f7fa, #f1f8e9); border-radius: 1rem; box-shadow: 0 4px 20px rgba(0,0,0,0.05);">
    <div class="row justify-content-center align-items-center">
      <div class="col-md-10 d-flex rounded overflow-hidden" style="background-color: white; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
        <!--라이브 미리보기 -->
       <div class="col-md-6 p-3" style="background: #fafafa;">
		  <div id="livePreview" style="width: 100%; height: 250px; position: relative; overflow: hidden; border-radius: 8px;">
		    <img alt="라이브썸네일" src="/images/live-thumnail.png" style="height: 250px; width: 100%;">
		  </div>
		</div>

        <!-- 정보 + 버튼 -->
        <div class="col-md-6 d-flex flex-column justify-content-between p-4">
          <div>
            <h4 class="fw-bold" style="color: #00796b;">🎥 현재 방송 중</h4>
            <h5 class="mb-2 text-dark">${liveStreamVO.streamTitle}</h5>
            <pre class="small text-muted" style="white-space: pre-wrap;">${liveStreamVO.streamExpln}</pre>
          </div>
          <div class="text-end mt-3">
            <a href="${pageContext.request.contextPath}/oho/community/live/stream?artGroupNo=${param.artGroupNo}&streamNo=${liveStreamVO.streamNo}" 
               class="btn" 
               style="background: linear-gradient(45deg, #26c6da, #00acc1); color: white; font-weight: bold; border-radius: 50px; padding: 10px 20px; box-shadow: 0 4px 10px rgba(0, 172, 193, 0.3); transition: all 0.3s ease;">
              <i class="fa-solid fa-circle-play me-2"></i> 지금 시청하기
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
</c:if>


<!-- 방송중인 방송 영역 끝 -->
<!-- 방송 아닐때 아티스트에게 노출되는 영역 -->
<c:if test="${empty liveStreamVO and communityProfileVO.comAuth eq 'ROLE_ART' and communityProfileVO.artGroupNo eq param.artGroupNo}">
  <div class="container-fruid" style="padding: 25px 20px;">
    <div style="width: 800px; margin: 0 auto;">
      <div class="card" style="border-radius: 15px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.1); background: linear-gradient(135deg, #fff8e1, #ffecb3);">
        <div class="card-body p-4">
          <div class="row align-items-center">
            <div class="col-8">
              <h5 style="margin-top: 5px; color: #ff6d00; font-weight: bold;">✨ ${communityProfileVO.comNm}님! 지금 Live 방송이 없어요 ✨</h5>
              <p style="color: #555; font-size: 1.1rem; margin-top: 8px;">팬들이 기다리고 있어요! 지금 소통을 시작해 볼까요?</p>
            </div>
            <div class="col-4 d-flex justify-content-end">
              <a href="${pageContext.request.contextPath}/oho/community/live/studio?artGroupNo=${param.artGroupNo}" class="btn" style="background: linear-gradient(45deg, #ff5722, #ff9800); color: white; border: none; padding: 10px 20px; border-radius: 50px; font-weight: bold; box-shadow: 0 4px 10px rgba(255, 153, 0, 0.3); transition: all 0.3s ease;">
                <i class="fa-solid fa-tv me-2"></i> 방송 시작하기
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- 지난라이브 영역 -->
<div class="container-fluid px-6 py-3" id="custom-cards">
    <div class="d-flex justify-content-between align-items-center ps-5 pb-2 border-bottom">
                <h2 class="mb-0">지난 라이브</h2>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-4 mt-3">
              <c:set var="hasLivePost" value="false" />
            <c:forEach var="livePostVO" items="${livePostVOList}">
              <c:if test="${livePostVO.mediaMebershipYn eq 'L'}">
                <c:set var="hasLivePost" value="true" />
              </c:if>
            </c:forEach>

            <c:if test="${not hasLivePost}">
              <div class="text-center py-5 w-100">
                <p class="text-muted">등록된 지난 라이브가 없습니다.</p>
              </div>
            </c:if>
        <c:forEach var="livePostVO" items="${livePostVOList}" varStatus="stat">
          <c:if test="${livePostVO.mediaMebershipYn eq 'L'}">
              <div class="col">
                  <div class="card h-100 rounded-3">
                        <div style="height: 180px; width: 100%; overflow: hidden;">
                          <a href="#" style="display: block; width: 100%; height: 100%;">
                              <img src="/upload${livePostVO.thumNailPath}" 
                                  class="card-img-top rounded-3"
                                  style="width: 100%; height: 100%; object-fit: cover;">
                          </a>
                      </div>
                      <div class="card-body">
                          <h5 class="card-title text-truncate border-bottom pb-2">${livePostVO.mediaPostTitle}</h5>
                          <p class="card-text" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; height: 3em;">
                              ${livePostVO.mediaPostCn}
                          </p>
                          <small class="text-body-secondary">
                              <fmt:formatDate value="${livePostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" />
                          </small>
                      </div>
                  </div>
              </div>
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