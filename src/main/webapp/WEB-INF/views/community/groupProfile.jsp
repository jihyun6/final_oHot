<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT</title>
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
  
  
  .modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.85);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
	width: 40% !important;
	height: 400px !important;
	top: 25%;
    left: 30%;
    width: 100%;
    color: var(--bs-modal-color);
    background-color: var(--bs-modal-bg);
    border: var(--bs-modal-border-width) solid var(--bs-modal-border-color);
/* 	background: linear-gradient(to bottom, #1c1c1c, #000000);  */
    border-radius: 10px !important;
    padding: 40px;
	align-items: center
}

.profile-img {
  width: 250px;
  height: 250px;
  border-radius: 10%;
  object-fit: cover;
  margin-bottom: 60px;
}

.profile-name {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 5px;
}

.profile-birth {
  font-size: 14px;
  color: #ccc;
  margin-bottom: 15px;
}

.profile-desc {
  font-size: 14px;
  color: #ddd;
  line-height: 1.6;
}

.close-btn {
  position: absolute;
  top: 15px;
  right: 15px;
  background: none;
  color: #fff;
  font-size: 24px;
  border: none;
  cursor: pointer;
  font-size: 50px;
}
  
 </style>
</head>
<body>
<%@ include file="../header.jsp"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="userVO" />
</sec:authorize>
<!-- <p>그룹 번호</p> -->
<%-- ${param.artGroupNo} --%>
<input type="hidden" id="artGroupNo" value="${param.artGroupNo}"/>
	<!-- 그룹번호 --> 
	<form id="submit" action="/oho/community/fanBoardList" class="fixed-bottom-center">
		<input type="hidden" name="artGroupNo" value="${param.artGroupNo}"/> <!-- 그룹 번호 (PK) -->
		<button type="button" class="community-btn" onClick="memberCheck( {type: 'community'} )">
		<spring:message code="group.go.commu" />
		</button>
	</form> 
	
	<input type="hidden" id="artistInfo" value='${fn:escapeXml(artistList)}'/>
	<div class="container">
		<!-- 그룹 소개 시작 -->
		<div id="groupInfoCard" class="card rounded-4">
		</div>
		<!-- 그룹 소개 끝 -->
	
		<!-- 멤버 소개 시작 -->
		<div id="artistInfoCard" class="container py-5">
		</div>
		<!-- 멤버 소개 끝 -->
		
		<c:if test="${not empty albumId}">
			<h4 class="text fw-bold mb-4"> 앨범</h4>
	       <iframe src="https://open.spotify.com/embed/album/${albumId}" width="100%" height="380">
			</iframe>
		</c:if>
		
		<!-- 라이브 영상 시작 -->
		<div id="liveListCard">
		</div>
		<!-- 라이브 영상 끝// -->
		
		<!-- 미디어 영상 시작 -->
		<div id="mediaListCard">
		</div>
		<!-- 미디어 영상 끝 -->
		
		<!-- 굿즈 정보 시작 -->
		<div id="goodsListCard">
		</div>
		<!-- 굿즈 정보 끝 -->
	</div>
	
	<c:forEach begin="0" end="9">
		<br>
	</c:forEach>
	
<!-- group.go.commu=커뮤니티 바로가기 -->


<!-- 모달 배경 -->
<div class="modal-overlay" id="profileModal" style="display:none;">
  <div class="modal-content" style="width: 50%;">
  </div>
</div>

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

const gp_i18n = {
		groupProfile: "<spring:message code='group.profile'/>",
		groupLive: "<spring:message code='group.live'/>",
		groupMedia: "<spring:message code='group.media'/>",
		groupMerch: "<spring:message code='group.merch'/>"
		
}
</script>


<script src="/js/groupProfile/groupProfile.js"></script>
</body>
</html>