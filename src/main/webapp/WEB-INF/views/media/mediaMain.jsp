<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Media</title>
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
        <a class="nav-link active"
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
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/new?artGroupNo=${param.artGroupNo}">최신 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/membership?artGroupNo=${param.artGroupNo}">멤버쉽 미디어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/oho/community/media/all?artGroupNo=${param.artGroupNo}">전체 미디어</a>
  </li>
</ul>
<!--미디어 하위 탭 끝  -->

<!-- 넘어오는 객체들 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<!-- SELECT  U.USER_NO, U.USER_MAIL, USER_PSWD, A.AUTH_NM -->
<!-- <div>${usersVO}</div>
	 <div>${mediaPostVOList}</div>
	 <div>${banerPostVOList}</div>
   <div>${comProfilVO}
 -->

<!-- 배너 -->
<c:choose>
  <c:when test="${not empty banerPostVOList}">
    <div id="imageCarousel" class="carousel slide carousel-fade weverse-carousel mb-5" data-bs-ride="carousel">
      <div class="carousel-inner">
        <c:forEach items="${banerPostVOList}" var="banerPostVO" varStatus="stat">
          <div class="carousel-item ${stat.first ? 'active' : ''}">
            <div class="container px-5">
              <div class="row g-0 align-items-stretch">
                <!-- 이미지 영역 -->
                <div class="col-md-8 d-flex">
                  <div class="image-container w-100">
                    <a href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${banerPostVO.mediaPostNo}&artGroupNo=${param.artGroupNo}" class="w-100">
                      <c:choose>
                        <c:when test="${banerPostVO.mediaMebershipYn eq 'Y'}">
                          <img src="/upload${banerPostVO.thumNailPath}" alt="${banerPostVO.mediaPostTitle}" />
                        </c:when>
                        <c:otherwise>
                          <img src="https://img.youtube.com/vi/${banerPostVO.thumNailPath}/maxresdefault.jpg" alt="${banerPostVO.mediaPostTitle}" />
                        </c:otherwise>
                      </c:choose>
                    </a>
                  </div>
                </div>
                <!-- 텍스트 영역 -->
                <div class="col-md-4 d-flex">
                  <div class="carousel-caption position-static w-100">
                    <div class="caption-title text-truncate">${banerPostVO.mediaPostTitle}</div>
                    <div class="caption-body content-text">${banerPostVO.mediaPostCn}</div>
                    <div class="caption-date"><fmt:formatDate value="${banerPostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" /></div>
                  </div>
                </div>
              </div>
            </div>
          </div>          
        </c:forEach>
      </div>

      <button class="carousel-control-prev" type="button" data-bs-target="#imageCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">이전</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#imageCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">다음</span>
      </button>

      <div class="carousel-indicators">
        <c:forEach items="${banerPostVOList}" var="banerPostVO" varStatus="stat">
          <button type="button" data-bs-target="#imageCarousel" data-bs-slide-to="${stat.index}" class="${stat.first ? 'active' : ''}" aria-label="Slide ${stat.index + 1}"></button>
        </c:forEach>
      </div>
    </div>
  </c:when>
  <c:otherwise>
    <div class="text-center py-5 text-muted" style="background: #f8f9fa; border-radius: 16px;">
      <p class="fs-5">등록된 배너가 없습니다.</p>
    </div>
  </c:otherwise>
</c:choose>

<!-- 배너 끝 -->

<!-- 최신 미디어 영역-->
<div class="container-fluid px-6 py-3" id="custom-cards">
    <div class="d-flex justify-content-between align-items-center ps-5 pb-2 border-bottom">
        <h2 class="mb-0">최신 미디어</h2>
        <a class="btn btn-outline-dark" style="color: #F86D72;" href="${pageContext.request.contextPath}/oho/community/media/new?artGroupNo=${param.artGroupNo}">더보기</a>
    </div>
    <c:set var="hasLatestMedia" value="false"/>
    <c:forEach var="mediaPostVO" items="${mediaPostVOList}">
      <c:if test="${mediaPostVO.mediaMebershipYn eq 'N'}">
        <c:set var="hasLatestMedia" value="true"/>
      </c:if>
    </c:forEach>
    <c:if test="${not hasLatestMedia}">
      <div class="text-center py-5 w-100">
        <p class="text-muted">등록된 최신 미디어가 없습니다.</p>
      </div>
    </c:if>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-4 mt-3">
        <c:set var="count" value="0" />
        <c:forEach var="mediaPostVO" items="${mediaPostVOList}" varStatus="stat">
            <c:if test="${mediaPostVO.mediaMebershipYn eq 'N' && count < 5}">
                <div class="col">
                    <div class="card h-100 rounded-3">
                        <div class="media-image-wrapper rounded-3 ">
                          <a href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${mediaPostVO.mediaPostNo}&artGroupNo=${param.artGroupNo}" class="media-image-link">
                            <img src="https://img.youtube.com/vi/${mediaPostVO.mediaVideoUrl}/maxresdefault.jpg" class="media-image" alt="미디어 썸네일">
                          </a>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate border-bottom pb-2">${mediaPostVO.mediaPostTitle}</h5>
                            <p class="card-text" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; height: 3em;">
                                ${mediaPostVO.mediaPostCn}
                            </p>
                            <small class="text-body-secondary"><fmt:formatDate value="${mediaPostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" /></small>
                        </div>
                    </div>
                </div>
                <c:set var="count" value="${count + 1}" scope="page" />
            </c:if>
        </c:forEach>
    </div>
</div>
<!-- 디자인 정말 토나오네요 -->
<!-- 최신 미디어 영역 끝 -->

<!-- 멤버쉽 미디어 영역 -->
<<!-- 멤버쉽 미디어 영역 -->
<div class="container-fluid px-6 py-3" id="custom-cards">
  <div class="d-flex justify-content-between align-items-center ps-5 pb-2 border-bottom">
    <h2 class="mb-0">멤버쉽 미디어</h2>
    <a class="btn btn-outline-dark" style="color: #F86D72;" href="${pageContext.request.contextPath}/oho/community/media/membership?artGroupNo=${param.artGroupNo}">더보기</a>
  </div>
  <c:set var="hasMembershipMedia" value="false"/>
  <c:forEach var="mediaPostVO" items="${mediaPostVOList}">
    <c:if test="${mediaPostVO.mediaMebershipYn eq 'Y'}">
      <c:set var="hasMembershipMedia" value="true"/>
    </c:if>
  </c:forEach>
  <c:if test="${not hasMembershipMedia}">
    <div class="text-center py-5 w-100">
      <p class="text-muted">등록된 멤버쉽 미디어가 없습니다.</p>
    </div>
  </c:if>
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-5 g-4 mt-3">
    <c:set var="count" value="0" scope="page" />
    <c:forEach var="mediaPostVO" items="${mediaPostVOList}" varStatus="stat">
      <c:if test="${mediaPostVO.mediaMebershipYn eq 'Y' and count < 5}">
        <div class="col">
          <div class="card h-100 rounded-3 position-relative overflow-hidden">
            <div class="media-thumb-wrapper" style="height: 180px; overflow: hidden;">
              <c:choose>
                <c:when test="${communityProfileVO.membershipYn eq 'Y'}">
                  <a class="btn px-1 py-1" href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${mediaPostVO.mediaPostNo}&artGroupNo=${param.artGroupNo}">
                    <img src="/upload${mediaPostVO.thumNailPath}" class="card-img-top rounded-3" alt="..." style="width: 100%; object-fit: cover;">
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
            </div>
            <div class="card-body">
              <h5 class="card-title text-truncate border-bottom pb-2">${mediaPostVO.mediaPostTitle}</h5>
              <p class="card-text content-text">${mediaPostVO.mediaPostCn}</p>
              <small class="text-body-secondary"><fmt:formatDate value="${mediaPostVO.mediaRegDt}" pattern="yyyy년 MM월 dd일" /></small>
            </div>
          </div>
        </div>
        <c:set var="count" value="${count + 1}" scope="page" />
      </c:if>
    </c:forEach>
  </div>
</div>
<!-- 멤버쉽 미디어 영역 끝 -->
<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	<!-- 	<i class="bi bi-arrow-up-short"></i> -->
<script src="/main/assets/js/main.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
  const tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
});
</script>
<%@ include file="../footer.jsp" %>
</body>
</html>