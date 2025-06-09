<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<meta name="description" content="">
<meta name="keywords" content="">
<link rel="stylesheet" href="/main/assets/css/card.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" href="./images/oHoT_logo.png">

<!-- Swiper CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<!-- Swiper JS -->
<script	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body {
  user-select: none;
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none;    /* Firefox */
  -ms-user-select: none;     /* IE10+/Edge */
}
</style>
</head>
<body>

	<!-- header.jsp 시작 -->
	<%@ include file="header.jsp"%>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO" />
	</sec:authorize>
	<!-- 
	<div>
	<p>사용자 정보 </p>
	${userVO}
	<p>보드 페이지</p>
	${boardPage }
	<p>새로운 아티스트</p>
	${newArtistGroupList }
	<p>디엠리스트 아티스트 정보</p>
	${dmList }
	<p>굿즈 정보</p>
	${goodsVOList}
	<p>굿즈가 있는 그룹명</p>
	${artWithGoodsList}
	</div>
	<p>가입한 아티스트 정보</p>
	${joinArtistGroupList }
	 -->
	 
	
	<c:if test="${not empty userVO}">
		<script>
			const userVO = {
					userNo : ${userVO.userNo}
			}
		</script>
	</c:if>
	
   <input type="hidden" id="newArtLength" value="${newArtistGroupList.total}">
   <input type="hidden" id="joinArtLength" value="${joinArtistGroupList.total}">

	<main class="main">
		<!-- 
		가입한 커뮤니티 리스트 (회원만)
		가입한 그룹 굿즈 리스트 (회원만)
		디엠 리스트 (회원 + 비회원)
		새로운 아티스트를 만나보세요 (회원+비회원) (회원은 가입하지 않은 그룹만, 비회원은 전체)
	 -->

		<!-- ///// 회원 관점 시작 ///// -->
		<sec:authorize access="isAuthenticated()">
		
			<!-- 나의 커뮤니티 시작 -->
			<c:if test="${joinArtistGroupList.content[0] != null}">
				<div class="grayBackground">
					<div class="container py-5">
						<h5 class="text fw-bold mb-4">
							<spring:message code="home.my.community" />
						</h5>
						<div class="d-flex flex-wrap justify-content-start join-artist-group-list" style="gap: 35px;">
							<!-- 가입한 커뮤니티 리스트 시작 -->
							<c:forEach var="artGroup" items="${joinArtistGroupList.content}">
								<c:set var="groupFile"
									value="${artGroup.fileGroupVO.fileDetailVOList[0]}" />
								<form action="/oho/community/fanBoardList" method="get">
									<input type="hidden" name="artGroupNo" value="${artGroup.artGroupNo}" />
									<button class="card-artist">
										<!-- 그룹 대표 이미지 -->
										<img src="/upload${groupFile.fileSaveLocate}" class="bg-img">
										<!-- 그룹 로고 -->
										<div class="logo-wrap">
											<img src="/upload${artGroup.fileLogoSaveLocate}">
										</div>
										<!-- 그룹 명 -->
										<div class="card-body">
											<h6>${artGroup.artGroupNm}</h6>
										</div>
									</button>
								</form>
							</c:forEach>
							<!-- 가입한 커뮤니티 리스트 끝 -->
						</div>
						<div class="text-center mt-4">
						  <button id="loadMyCommunity" class="btn btn-outline-dark">
					    	<spring:message code="home.more" />
						  </button>
						</div>
						<!-- 닫기 버튼 -->
						<div class="text-center mt-4">
						  <button id="closeMyCommunity" class="btn btn-outline-dark">
					    	<spring:message code="home.close" />
						  </button>
						</div>
					</div>
				</div>
			</c:if>
			<!-- 나의 커뮤니티 끝 -->

			<!-- 구독한 그룹의 굿즈샵 시작 -->
			<c:if test="${artWithGoodsList[0] != null }">
				<div class="container py-5">
					<div class="d-flex align-items-center gap-3 mb-4">
					    <h5 class="fw-bold mb-0">
					        <spring:message code="home.merch" />
					    </h5>
					    <small class="text-muted">
						    <a href="/shop/home" target="_blank" class="text-decoration-none" style="color:#F86D72; !important;">
						        <spring:message code="home.go.shop" /> ▶
						    </a>
						</small>
					</div>
					<!-- 아티스트 그룹 전체 영역 -->
					<div class="d-flex flex-wrap align-items-start" style="gap: 16px;">
					  <!-- 버튼 리스트만 감싸는 부분 (여기에 max-height 적용) -->
					  <div id="artistGroupBtnContainer" class="d-flex flex-wrap align-items-center col-10" style="gap: 16px; max-height: 52px; overflow: hidden; transition: max-height 0.3s; width:90% !important;">
					    <!-- 전체 + 그룹 버튼들 -->
					    <button class="card-artistNm active" data-group="0">
					    	<spring:message code="home.goods.all" />
					    </button>
					    <c:set var="printedGroupNames" value="," />
					    <c:forEach var="artGroup" items="${artWithGoodsList}">
					        <button class="card-artistNm" data-group="${artGroup.artGroupNo}">
					          <div class="artistName">${artGroup.artGroupNm}</div>
					        </button>
					    </c:forEach>
					  </div>

					  <!-- 더보기 버튼은 항상 보이도록 밖에 둠 -->
					  <button id="toggleMoreBtn" class="btn btn-outline-light border col-1" style="white-space: nowrap;">
					    <span id="toggleIcon" style="color: #f86d72;">
					    	<spring:message code="home.more" />
					    </span>
					  </button>
					</div>
				</div>
			</c:if>
				<!-- 굿즈 리스트 (캐러셀) 시작 -->
				<div class="container">
					<div class="swiper mySwiper">
						<div id="goodsListContainer" class="swiper-wrapper">
							<c:set var="count" value="1" />
								<c:forEach var="goods" items="${goodsVOList}">
									<c:if test="${goods.gdsNo != 0}">
										<c:set var="goodsFile" value="${goods.fileGroupVO.fileDetailVOList[0]}" />
										<div class="swiper-slide">
											<c:choose>
												<c:when test="${goods.commCodeGrpNo=='GD02'}">
													<!-- 티켓 상품일 경우 -->
													<form action="/shop/ticket/ticketDetail" method="get">
														<input type="hidden" name="gdsNo" value="${goods.gdsNo}">
														<button class="card-goods">
															<img src="/upload${goods.ticketVO.tkFileSaveLocate}" class="bg-img" />
														</button>
														<div class="goods-name">
															<h6>${goods.gdsNm}</h6>
														</div>
														<h5>
															₩
															<fmt:formatNumber value="${goods.unitPrice}" type="number" />
														</h5>
													</form>
												</c:when>
												<c:otherwise>
													<form
														action="/shop/artistGroup/${goods.artGroupNo}/detail/${goods.gdsNo}">
														<button class="card-goods">
															<img src="/upload${goodsFile.fileSaveLocate}" class="bg-img" />
														</button>
														<div class="goods-name">
															<h6>${goods.gdsNm}</h6>
														</div>
														<h5>
															₩
															<fmt:formatNumber value="${goods.unitPrice}" type="number" />
														</h5>
													</form>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>
								</c:forEach>
						</div>
						<div class="swiper-pagination" style="--swiper-theme-color:#F86D72 !important;"></div>
					</div>
					<!-- 굿즈 리스트 (캐러셀) 끝 -->
				</div>
			<!-- 구독한 그룹의 굿즈샵 끝 -->
		</sec:authorize>
		<!-- ///// 회원 관점 끝 ///// -->

		<!-- ///// 비회원 관점 시작 ///// -->
		<!-- DM 리스트 시작-->
		<div class="container py-5">
			<h5 class="text fw-bold mb-4" style="color: black !important;">
				<spring:message code="home.dm.title" />
				<button class="svg-btn" onclick="getDMList()">
					<svg xmlns="http://www.w3.org/2000/svg" width="27" height="27"
						fill="#33C1CF" stroke-width="2.5" class="bi bi-arrow-clockwise"
						viewBox="0 0 16 16" style="margin-left: 10px;">
					  <path fill-rule="evenodd"
							d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z" />
					  <path
							d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466" />
					</svg>
				</button>
			</h5>
			<!-- DM 리스트 반복 시작 -->
			<div id="dmListContainer">
				<c:forEach var="artGroup" items="${dmList}" varStatus="status">
					<input type="hidden" value="${artGroup.artGroupNo}" />
					<!-- 그룹 번호 (PK) -->
					<button class="btn-dmlist" onclick="toggleDm('${artGroup.artGroupNo}')">
						<!-- 그룹 로고 -->
						<div class="logo-wrap">
							<img src="/upload${artGroup.fileLogoSaveLocate}">
						</div>
						<!-- 그룹 명 -->
						<div class="card-body">
							<h6>${artGroup.artGroupNm}</h6>
						</div>
					</button>
				</c:forEach>
			</div>
			<!-- DM 리스트 반복 끝 -->
			<br> <br> <br><br> 
			
			<!-- 인기 투표 시작 -->
			<div id="voteArtist" style="background-color: #D0F5F2; width: 80%; height: 120px; margin-left: 110px; border-radius: 10px;">
				<div class="row">
					<div class="col-3"></div>
					<div class="col-5 mt-3" style="padding:0">
						<h4 style="font-weight: 600; margin-bottom: 5px;"><spring:message code="home.ad.1" /></h4>
						<h6 style="color: #666; margin-top: 10px;"><spring:message code="home.ad.2" /></h6>
						<a href="/oho/game/play" style="text-decoration: none; color: #F86D72; !important; font-weight: 500;"> <spring:message code="home.ad.3" /> </a>
					</div>
					<div class="col-2" style="padding:0">
					<img src="/images/vote.png" style="width: 140px; height: 120px;">
					</div>
				</div>
			</div>
			<!-- 인기 투표 끝 -->
		</div>
		<!-- DM 리스트 끝-->

		<!-- 새로운 아티스트 그룹 리스트 시작 -->
		<div class="container py-5">
			<h5 class="text fw-bold mb-4">
				<spring:message code="home.new.art.title" />
			</h5>
			<div class="d-flex flex-wrap justify-content-start new-artist-group-list" style="gap: 35px;">
				<!-- 모든 그룹 출력 시작 -->
				<c:forEach var="artGroup" items="${newArtistGroupList.content}">
					<c:set var="groupFile" value="${artGroup.fileGroupVO.fileDetailVOList[0]}" />
					<c:set var="groupFile" value="${artGroup.fileGroupVO.fileDetailVOList[0]}" />
					<form action="/oho/groupProfile" method="get">
						<input type="hidden" name="artGroupNo" value="${artGroup.artGroupNo}" />
						<!-- 그룹 번호 (PK) -->
						<button class="card-artist">
							<!-- 그룹 대표 이미지 -->
							<img src="/upload${groupFile.fileSaveLocate}" class="bg-img">
							<!-- 그룹 로고 -->
							<div class="logo-wrap">
								<img src="/upload${artGroup.fileLogoSaveLocate}">
							</div>
							<!-- 그룹 명 -->
							<div class="card-body">
								<h6>${artGroup.artGroupNm}</h6>
							</div>
						</button>
					</form>
				</c:forEach>
				<!-- 모든 그룹 출력 끝 -->
			</div>
			<!-- 더보기 버튼 -->
			<div class="text-center mt-4">
			  <button id="loadMoreBtn" class="btn btn-outline-dark">
		    	<spring:message code="home.more" />
			  </button>
			</div>
			<!-- 닫기 버튼 -->
			<div class="text-center mt-4">
			  <button id="closeBtn" class="btn btn-outline-dark">
		    	<spring:message code="home.close" />
			  </button>
			</div>
			
		<!-- 아티스트 그룹 리스트 끝 -->
		</div>
		<!-- ///// 비회원 관점 끝 ///// -->
	</main>

	<script>
	
	let swiper;

	document.addEventListener("DOMContentLoaded", () => {
		swiper = new Swiper(".mySwiper", {
			slidesPerView : 4.2,
			grabCursor : true,
			freeMode : true,
			pagination : {
				el : ".swiper-pagination",
				clickable : true,
			},
			navigation : false,
		});
	});
	
	const i18n4 = {
			more : "<spring:message code='home.more' />",
			close : "<spring:message code='home.close' />"
	}
	
	const newArtLength = document.getElementById("newArtLength").value;
	   const joinArtLength = document.getElementById("joinArtLength").value;
	   console.log("newArtLength : ", newArtLength);
	   console.log("joinArtLength : ", joinArtLength);
	   
	   if(newArtLength > 15) {
		   document.getElementById("loadMoreBtn").style.display = "inline-block";
	   }
	   if(joinArtLength > 5) {
		   document.getElementById("loadMyCommunity").style.display = "inline-block";
	   }
	
	</script>

	<%@ include file="footer.jsp"%>

	<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>

	<script src="/main/assets/js/main.js"></script>
	<script src="/js/home/home.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/@egjs/flicking@4.10.1/dist/flicking.min.js"></script>
</body>
</html>