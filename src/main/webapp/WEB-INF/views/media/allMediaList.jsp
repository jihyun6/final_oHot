<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHot All Media</title>
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
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">
          Media
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
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

<!-- 미디어 하위 탭 -->

<ul class="nav nav-pills justify-content-center gap-5 medi-subnav">
  <li class="nav-item">
    <a class="nav-link " aria-current="page" href="${pageContext.request.contextPath}/oho/community/media/new?artGroupNo=${param.artGroupNo}">최신 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/membership?artGroupNo=${param.artGroupNo}">멤버쉽 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #ff69b4 !important" aria-current="page" href="${pageContext.request.contextPath}/oho/community/media/all?artGroupNo=${param.artGroupNo}">전체 미디어</a>
  </li>
</ul>

<!--미디어 하위 탭 끝  -->
<!-- 본문 영역  -->
<div class="album pt-0 py-5 bg-body-tertiary px-6">
	<div class="grid text-center pt-5 mb-5">
	  <div class="g-col-4"></div>
	  <div class="g-col-4"><h2>전체 미디어</h2></div>
	  <div class="g-col-4"></div>
</div>
    <div class="container-fluid ">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
        <c:forEach var="mediaPostVO" items="${mediaPostVOList}">
<c:if test="${mediaPostVO.mediaMebershipYn ne 'L'}">
  <div class="col">
    <div class="card h-100 rounded-3 position-relative overflow-hidden">
      <div class="media-thumb-wrapper" style="height: 180px; overflow: hidden;">
        <c:choose>
          <c:when test="${mediaPostVO.mediaMebershipYn eq 'Y'}">
            <c:choose>
              <c:when test="${communityProfileVO.membershipYn eq 'Y'}">
                <a href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${mediaPostVO.mediaPostNo}&artGroupNo=${param.artGroupNo}">
                  <img src="/upload${mediaPostVO.thumNailPath}" class="card-img-top rounded-3" style="width: 100%; height: 100%; object-fit: cover;">
                </a>
              </c:when>

              <c:otherwise>
                <div class="blur-thumb position-relative">
                  <img src="/upload${mediaPostVO.thumNailPath}" 
                       class="blur-image" 
                       alt="..." />
                  <div class="blur-overlay-top text-center">
                    <span class="text-white fw-bold small">멤버쉽 전용 콘텐츠</span>
                  </div>
                </div>
              </c:otherwise>
            </c:choose>
          </c:when>

          <c:otherwise>
            <a href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${mediaPostVO.mediaPostNo}&artGroupNo=${param.artGroupNo}">
              <img src="https://img.youtube.com/vi/${mediaPostVO.mediaVideoUrl}/maxresdefault.jpg" class="card-img-top rounded-3" style="width: 100%; height: 100%; object-fit: cover;">
            </a>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 본문 -->
      <div class="card-body">
        <h5 class="card-title text-truncate border-bottom pb-2">${mediaPostVO.mediaPostTitle}</h5>
        <p class="card-text content-text">${mediaPostVO.mediaPostCn}</p>
        <small class="text-body-secondary">
          <fmt:formatDate value="${mediaPostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" />
        </small>
      </div>
    </div>
  </div>
    </c:if>
</c:forEach>
        
        <!-- 데이터가 없는 경우 더미 데이터로 레이아웃 유지 -->
        <!-- 해야되나 체크해야 함 -->
      </div>
    </div>
  </div>
<!-- 본문 영역 끝  -->
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