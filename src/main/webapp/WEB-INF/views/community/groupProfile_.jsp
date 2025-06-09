<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/main/assets/css/card.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <style>
 body {
   background-color: #222222 !important;
   color: white !important;
 }
 h1, h2, h3, h4, h5, h6, p, span {
    color: white !important;
 }
   
   .card {
  position: relative;
  overflow: hidden;
  border: none !important;
}

.card::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 50%; /* 그라데이션 높이 (필요에 따라 조절) */
  background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
  z-index: 1;
}
   
   .card-img-overlay {
  position: relative;
  z-index: 2;
  display: flex;
  flex-direction: column;  /* 세로 정렬 */
  justify-content: flex-end;  /* 아래쪽 정렬 유지 */
  align-items: center;
  padding-bottom: 20px;
  text-align: center;
}

.card-img-overlay p {
  color: white;
  font-weight: 700;
  text-shadow: 1px 1px 3px black;
}
   
.fixed-bottom-center {
	position: fixed;
	bottom: 20px; /* 하단에서 20px 위 */
	left: 50%;
	transform: translateX(-50%);
	z-index: 1000; /* 다른 요소 위에 보이도록 */
}
  .community-btn {
    background: linear-gradient(135deg, #ff9a9e, #fad0c4);
    color: white;
    font-size: 16px;
    font-weight: bold;
    padding: 12px 24px;
    border: none;
    border-radius: 999px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .community-btn:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
  }

  .community-btn:active {
    transform: scale(0.98);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  }
 </style>
</head>
<body>
<%@ include file="../header.jsp"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="userVO" />
</sec:authorize>
<%-- 	<p>memNo : ${userVO.userNo}</p> --%>
<%-- 	<p>artGroupNo : ${artGroupNo}</p> --%>
<!-- 	<!-- 그룹번호 --> 
	<form id="submit" action="/oho/community/fanBoardList" class="fixed-bottom-center">
		<input type="hidden" name="artGroupNo" value="${param.artGroupNo}"/> <!-- 그룹 번호 (PK) -->
		<button type="button" class="community-btn" onClick="memberCheck( {type: 'community'} )">
		<spring:message code="group.go.commu" />
		</button>
	</form> 

	<div>
		<p>artistGroupVO 정보 출력</p>
		${artistGroupVO}
		<p>artistList 정보 출력</p>
		${artistList}
		<p>goodsList 정보 출력</p>
		${goodsList}
		<p>mediaList 정보 출력</p>
		${mediaList}
		<p>liveList 정보 출력</p>
		${liveList}
	</div>
	<input type="hidden" id="artistInfo" value='${fn:escapeXml(artistList)}'/>
	<div class="container">
		<!-- 그룹 소개 시작 -->
		<div class="card rounded-4">
		  <c:set value="${artistGroupVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" var="mainImg" />
		  <img class="card-img" src="/upload${mainImg}" alt="Card image">
		  <div class="card-img-overlay">
		    <p class="display-1">${artistGroupVO.artGroupNm}</p>
		    <p class="font-weight-normal ">${artistGroupVO.artGroupExpln}</p>
		  </div>
		</div>
		<!-- 그룹 소개 끝 -->
	
		<!-- 멤버 소개 시작 -->
		<div class="container py-5">
			<h4 class="text fw-bold mb-4">
				<spring:message code="group.profile" />
			</h4>
			<div id="artistContainer">
				<c:forEach var="artist" items="${artistList}">
					<c:set value="${artist.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" var="artistImg" />
					<button class="btn-artist" onClick="artistProfile(${artist.artNo})">
						<img src="/upload${artistImg}">
						<h6>${artist.artActNm }</h6>
					</button>
				</c:forEach>
			</div>
		</div>
		<!-- 멤버 소개 끝 -->
		
		<!-- 라이브 영상 시작 -->
		<c:if test="${liveList[0] != null}" >
			<div class="container py-5">
				<h4 class="text fw-bold mb-4">
					<spring:message code="group.live" />
				</h4>
				<div id="liveContainer">
					<c:forEach var="live" items="${liveList}" begin="0" end="5">
						<!-- mediaMebershipYn=L일 경우에는 관리자가 썸네일 지정 -->
						<c:if test="${live.mediaMebershipYn eq 'L'}">
							<c:set value="${live.thumNailPath}" var="liveThumNail" />
							<a class="liveThumNail btn px-1 py-1 text-start" href="${pageContext.request.contextPath}/oho/community/media/post?postNo=${live.mediaPostNo}&artGroupNo=${param.artGroupNo}">
	                        	<img src="https://img.youtube.com/vi/${liveThumNail}/maxresdefault.jpg" 
	                            	 class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
	                        </a>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<!-- 라이브 영상 끝// -->
		
		<!-- 미디어 영상 시작 -->
		<c:if test="${mediaList[0] != null}" >
			<div class="container py-5">
				<h4 class="text fw-bold mb-4">
					<spring:message code="group.media" />
				</h4>
				<div id="mediaContainer">
					<c:set var="count" value="0" />
					<c:forEach var="media" items="${mediaList}">
						<!-- mediaMebershipYn=N일 경우에는 유튜브 영상 아이디 사용  -->
						<!-- mediaMebershipYn=Y일 경우에는 관리자가 썸네일 지정 -->
						<c:if test="${media.mediaMebershipYn eq 'N' && count lt 4}">
							<c:set var="count" value="${count + 1}" />
							<c:set value="${media.thumNailPath}" var="mediaThumNail" />
							<a class="mediaThumNail btn px-1 py-1 text-start" href="javascript:void(0)" onClick="memberCheck( { type:'media', memberShipYn:'N', mediaPostNo:${media.mediaPostNo} })">
	                            <img src="https://img.youtube.com/vi/${mediaThumNail}/maxresdefault.jpg" 
	                                 class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
                             <h5 class="card-title text-truncate-2">${media.mediaPostTitle}</h5>
			                 <p class="card-text"><small style="color:#999;"><fmt:formatDate value="${media.mediaRegDt}" pattern="yyyy년 MM월 dd일" /></small></p>
                             </a>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<!-- 미디어 영상 끝 -->
		
		<!-- 굿즈 정보 시작 -->
		<c:if test="${goodsList[0].gdsNo != 0}" >
			<div class="container py-5">
				<h4 class="text fw-bold mb-4">
					<spring:message code="group.merch" />
				</h4>
				<div id="goodsContainer">
					<c:forEach var="goods" items="${goodsList}" begin="0" end="4">
						<c:set value="${goods.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" var="goodsImg" />
						<c:choose>
						<c:when test="${goods.commCodeGrpNo=='GD02'}">
							<a class="goodsImg btn px-1 py-1 text-start" href="${pageContext.request.contextPath}/shop/ticket/ticketDetail?gdsNo=${goods.gdsNo}">
	                        	<img src="/upload${goods.ticketVO.tkFileSaveLocate}" class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
	                        	<h6 class="card-title text-truncate-2 mb-2">${goods.gdsNm}</h6>
	                        	<h6 class="card-title text-truncate-2 mb-5">₩ <fmt:formatNumber value="${goods.unitPrice}" type="number" /></h6>
	                        </a>
						</c:when>
						<c:otherwise>
							<a class="goodsImg btn px-1 py-1 text-start" href="${pageContext.request.contextPath}/shop/artistGroup/${goods.artGroupNo}/detail/${goods.gdsNo}">
	                        	<img src="/upload${goodsImg}" class="card-img-top rounded-3" alt="..." style="width: 100%; height: 100%; object-fit: cover;">
	                        	<h6 class="card-title text-truncate-2  mb-2">${goods.gdsNm}</h6>
	                        	<h6 class="card-title text-truncate-2 mb-5">₩ <fmt:formatNumber value="${goods.unitPrice}" type="number" /></h6>
	                        </a>
						</c:otherwise>	                   	
						</c:choose>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<!-- 굿즈 정보 끝 -->
	</div>
	
	<c:forEach begin="0" end="9">
		<br/>
	</c:forEach>
<!-- group.go.commu=커뮤니티 바로가기 -->


<script>
<!-- 회원 여부 체크 함수 -->
function memberCheck({ type, memberShipYn, mediaPostNo }) {
	
	console.log("type", type);
	console.log("memberShipYn", memberShipYn);
	console.log("mediaPostNo", mediaPostNo);

	if(${userVO.userNo == null}) { // 비회원일 경우
		
		alert("로그인이 필요합니다.");
	
	} else { // 회원일 경우
		
		if(type == "community") { // 커뮤니티 바로가기 버튼을 눌렀을 경우
			
			document.getElementById("submit").submit();
			
		}else { // 영상을 클릭했을 경우
			
			location.href = "${pageContext.request.contextPath}/oho/community/media/post?postNo=" + mediaPostNo + "&artGroupNo=${param.artGroupNo}";
			
		}
	}
}

</script>
</body>
</html>