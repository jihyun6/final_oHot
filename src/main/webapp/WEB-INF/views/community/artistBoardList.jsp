<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<title>oHoT ArtistCommunity</title>
<%@include file="../header.jsp" %>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Swiper CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	
	<!-- Swiper JS -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/gh/sunn-us/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/fireworks-js@2.1.2/dist/index.umd.js"></script>


<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/static/css/bootstrap.min.css" /> --%>

    <style>
    a {
  text-decoration: none;
   color: inherit;
}

    
    	#endMessage {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
    padding: 10px;
    font-size: 16px;
    margin-top: 20px;
    text-align: center;
    font-weight: bold;
}
    body {
    font-family: 'SUIT', sans-serif;
    background-color: #f9f9f9;
    }

        .top-nav {
        
            background-color: rgb(211,23,23);
            color: white;
            padding: 10px;
            text-align: center;
            font-weight: bold;
        }
        .artist-card {
            border-radius: 15px;
            padding: 15px;
            background: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .artist-profile {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }
        .feed-box {
            background: white;
            border-radius: 15px;
            padding: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .post-card {
            background: white;
            border-radius: 15px;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 15px;
        }
        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            cursor: pointer;
            
        }
        .profile-img2 {
  width: 80px;                /* 더 크게! */
  height: 80px;
  object-fit: cover;
  border-radius: 50%;
  display: block;             /* 가운데 정렬을 위해 block 설정 */
  margin-left: auto;
  margin-right: auto;
}
/* 그리드,swiper 스타일 */
/* .card-body .grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 8px;
  margin-top: 10px;
}

.card-body .grid img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 10px;
  cursor: pointer;
} */
#editImg {
  overflow: hidden;
  max-width: 100%;
}
/* .grid img {
  width: 100%;
  height: auto;
  max-width: 100%;
  border-radius: 10px;
  object-fit: cover;
  display: block;
}
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 8px;
  margin-top: 10px;
  overflow: hidden;
} */
  .artist-card {
    position: relative;
    height: 300px;
    border-radius: 1rem;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    background-size: cover;
    background-position: center;
    display: flex;
    justify-content: flex-end;
    padding: 1rem;
  }

  .artist-card .overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent 60%);
    z-index: 1;
  }

  .artist-card .artist-text {
    position: relative;
    z-index: 2;
    color: white;
  }

  .artist-card .fw-bold {
    font-weight: 600;
    font-size: 1.1rem;
  }

  .artist-card .artist-message {
    font-size: 0.95rem;
    color: rgba(255, 255, 255, 0.9);
  }

  /* Swiper card width 조정 */
.swiper-slide {
  /* 제거: width 강제 지정 */
  margin-right: 16px;
  min-width: 0; /* 유지 */
}
/* 그리드,swiper 스타일 끝 */
        .post-content {
            font-size: 14px;
            color: #333;
        }
        .post-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .btn-like, .btn-comment {
            border: none;
            background: none;
            color: #6c757d;
            cursor: pointer;
        }
                /* 모달 스타일 */
        .custom-modal .modal-content {
            border-radius: 20px;
            padding: 20px;
        }
        .custom-modal .modal-header {
            border-bottom: none;
            text-align: center;
            justify-content: center;
        }
        .custom-modal .modal-title {
            font-size: 20px;
            font-weight: bold;
        }
        .custom-modal .modal-body {
            text-align: center;
        }
        .custom-textarea1 {
            width: 100%;
            min-height: 50px;
            border: none;
            background-color: #f8f9fa;
            resize: none;
            padding: 15px;
            font-size: 16px;
            border-radius: 10px;
            outline: none;
        }
        .custom-textarea2 {
            width: 100%;
            min-height: 300px;
            border: none;
            background-color: #f8f9fa;
            resize: none;
            padding: 15px;
            font-size: 16px;
            border-radius: 10px;
            outline: none;
        }
        .custom-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-custom {
            background-color: #1c1c1c;
            color: white;
            border-radius: 8px;
            padding: 8px 20px;
        }
    .btn-weverse {
        background-color: white;
        color: #6d8f38;
        font-size: 16px;
        font-weight: bold;
        border: 2px solid #6d8f38;
        border-radius: 25px;
        padding: 12px;
        width: 100%;
        display: block;
        text-align: center;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .btn-weverse:hover {
        background-color: #6d8f38;
        color: white;
    }
        .btn-custom:disabled {
            background-color: #ccc;
        }
        .icon-btn {
            font-size: 24px;
            cursor: pointer;
            margin-right: 10px;
        }
        .dropdown-menu {
    border-radius: 12px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
}
.dropdown-item {
    font-size: 14px;
    font-weight: 500;
}
.badge-star {
    display: inline-block;
    padding: 3px 8px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    background: linear-gradient(45deg, #FF1493, #FF69B4); /* 핑크 그라데이션 */
    border-radius: 8px;
}
.me-2{
	cursor:pointer;
}
/* 오른쪽 디자인 */
    .tempest-box img {
      border-radius: 10px;
      width: 100%;
    }
        .navbar {
      background-color: #77a300;
    }
    .navbar-brand, .nav-link {
      color: black;
    }
    .nav-link:hover {
      color: #d4f09e;
    }
    //커뮤니티 내 정보 보여주는 곳
    .fan-card {
      background-color: white;
      border-radius: 15px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 1rem;
      margin-bottom: 1rem;
      height: 300px; 
      justify-content: center;
      flex-direction: column;
      align-items: center;
       display: flex;
    }
/* 오세인 카드만 높게 */
.profile-card {
  height: 200px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

/* 공지사항 카드 더 길게 */
.notice-card {
  min-height: 250px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

    .tempest-box {
      background:  rgba(248, 109, 114, 0.3);
      border-radius: 15px;
      padding: 1rem;
      color: white;
      text-align: center;
      
    }
      .tempest-box:hover {
    background-color: rgba(248, 109, 114, 0.9);
  }
    .tempest-box img {
      border-radius: 10px;
      width: 100%;
    }
    .post-img {
      width: 100%;
      border-radius: 15px;
      margin-top: 1rem;
    }
      .swiper {
    width: 100%;
    padding-bottom: 50px;
  }

  .swiper-slide {
    width: auto; /* 또는 원하는 고정폭 예: 300px */
  }


.artist-profile {
  width: 100%;                 /* 가로 100%로 부모 안에 꽉 차게 */
  max-width: 120px;            /* 최대 너비 제한 */
  height: auto;                /* 비율 유지하면서 자동 조절 */
  border-radius: 50%;          /* 동그랗게 */
  object-fit: cover;           /* 원형 잘림 없이 채우기 */
  aspect-ratio: 1 / 1;         /* 가로세로 비율 1:1로 고정 */
}
.artist-card img {
  margin: 0 auto; /* 가운데 정렬 */
  display: block;
}
.no-underline {
  text-decoration: none;
  color: inherit;
}
a:hover {
  text-decoration: none;
}
.join-card {
  border: 2px dashed #28a745;
  background-color: #f8fff8;
  transition: background-color 0.3s ease;
}

.join-card:hover {
  background-color: #eaffea;
}
/* 위버스 스타일 버튼 */
.translate-btn-box {
  display: flex;
  justify-content: flex-start;
  margin-top: 8px;
}

.weverse-btn {
  font-size: 12px;
  padding: 4px 14px;
  border: 1px solid #ddd;
  border-radius: 999px;
  background-color: #fff;
  color: #333;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.weverse-btn:hover {
  background-color: #f8f8f8;
  border-color: #ccc;
}
.reply-translate-btn {
  font-size: 11px;
  padding: 2px 10px;
  border: 1px solid #e0e0e0;
  border-radius: 999px;
  background-color: #fff;
  color: #555;
  cursor: pointer;
  transition: background-color 0.2s ease, border-color 0.2s ease;
  margin-top: 6px;
  margin-left: 4px;
}

.reply-translate-btn:hover {
  background-color: #f5f5f5;
  border-color: #ccc;
}
/* 포스트 사진 ( 그리드 지우고 난 후 임 -> 상의 후 아티스트 페이지까지) */
.post-image {
  max-width: 100%;
  max-height: 500px;
  height: auto;
  object-fit: cover; /* 필요시 이미지 잘라내기 */
  cursor:pointer;
}
.vip-membership {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  box-shadow: 0 4px 15px rgba(240, 147, 251, 0.5), 0 6px 20px rgba(245, 87, 108, 0.4);
  border-radius: 1rem;
  animation: glow 2s infinite alternate;
}

@keyframes glow {
  0% {
    box-shadow: 0 0 10px rgba(240, 147, 251, 0.7);
  }
  100% {
    box-shadow: 0 0 20px rgba(245, 87, 108, 1);
  }
}
.bg-gradient-blue {
  background: linear-gradient(135deg, #3f51b5 0%, #2196f3 100%);
}

.blind-card {
  filter: blur(2px);
  pointer-events: none;
  position: relative;
  opacity: 0.6;
}
.blind-card::after {
  content: "멤버십 전용 게시글입니다";
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #fff;
  background-color: rgba(0,0,0,0.6);
  padding: 10px 15px;
  border-radius: 10px;
  font-weight: bold;
  text-align: center;
  white-space: nowrap;
}

  .weverse-birthday-banner {
    position: fixed;
    top: 10px;
    left: 50%;
    transform: translateX(-50%);
    background: linear-gradient(135deg, #ffe2e6, #fff6f9);
    border: 1px solid #ff99bb;
    padding: 0.75rem 1.5rem;
    border-radius: 2rem;
    box-shadow: 0 0 10px rgba(255, 153, 187, 0.3);
    font-size: 1rem;
    font-weight: 600;
    color: #d63384;
    z-index: 1050;
    animation: slideFade 0.7s ease-out;
  }

  @keyframes slideFade {
    from {
      transform: translate(-50%, -20px);
      opacity: 0;
    }
    to {
      transform: translate(-50%, 0);
      opacity: 1;
    }
  }


/*  */

  .birthday-explosion {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    pointer-events: none;
    z-index: 9999;
    display: flex;
    gap: 10px;
  }

  .confetti {
    width: 12px;
    height: 12px;
    background-color: #ff6b81;
    border-radius: 50%;
    animation: explode 1s ease-out forwards;
  }

  .confetti:nth-child(2) { background-color: #feca57; animation-delay: 0.1s; }
  .confetti:nth-child(3) { background-color: #1dd1a1; animation-delay: 0.2s; }
  .confetti:nth-child(4) { background-color: #5f27cd; animation-delay: 0.3s; }

  @keyframes explode {
    0% { transform: scale(1) translate(0, 0); opacity: 1; }
    100% {
      transform: scale(0.5) translate(calc(var(--x) * 100px), calc(var(--y) * -100px));
      opacity: 0;
    }
  }
	
.gift-box-gif {
  position: fixed;
  top: 20%;
  left: -200px; /* 왼쪽 위치 조정 */
  width: 200px; /* 크기를 더 크게 설정 */
  height: 200px; /* 높이도 맞추어 설정 */
  z-index: 9999;
  animation: flyGiftBox 5s linear forwards; /* 애니메이션 시간 5초로 설정 */
  pointer-events: none;

}

@keyframes flyGiftBox {
  0% {
    left: -200px;
    transform: scale(1) rotate(0deg);
  }
  50% {
    top: 30%;
    transform: scale(1.2) rotate(10deg);
  }
  100% {
    left: 110%;
    transform: scale(1) rotate(-10deg);
  }
}

/* 애니메이션 끝나면 숨기기 */
#giftBox {
  animation: flyGiftBox 5s linear forwards;
}

#giftBox.animation-end {
  display: none;
}

/* 헤더 네비 디자인 */
  .weverse-tabs {
    background: linear-gradient(90deg, #0f0f2f, #1a1a40); /* 어두운 배경 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding: 0.75rem 0;
  }

  .weverse-tabs .nav {
    gap: 1.5rem;
  }

  .weverse-tabs .nav-link {
    color: #ccc;
    font-weight: 500;
    font-size: 0.95rem;
    border: none;
    background: transparent;
    border-radius: 2rem;
    padding: 0.4rem 1.2rem;
    transition: all 0.3s ease;
  }

  .weverse-tabs .nav-link:hover {
    color: #fff;
    background-color: rgba(255, 192, 203, 0.1); /* 연한 핑크 호버 효과 */
  }

  .weverse-tabs .nav-link.active {
    background-color: #ff69b4; /* 핫핑크 배경 */
    color: #fff;
    font-weight: 700;
    border-radius: 999px;
    box-shadow: 0 0 10px rgba(255, 105, 180, 0.3);
  }

  @media (max-width: 576px) {
    .weverse-tabs .nav {
      flex-wrap: nowrap;
      overflow-x: auto;
      -webkit-overflow-scrolling: touch;
    }

    .weverse-tabs .nav-link {
      white-space: nowrap;
    }
  }
  
  .custom-textarea2 {
    width: 100%;
    resize: vertical;
    word-break: break-word;
}

/* 헤더 네비 디자인 끝  */

.btn-no-wrap {
  white-space: nowrap;  /* 텍스트 줄바꿈 방지 */
  padding: 0.375rem 0.75rem; /* 필요 시 패딩 조정 */
}
    </style>
</head>
<body>
<div class="weverse-tabs d-flex justify-content-center">
  <ul class="nav nav-pills nav-fill">
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${communityProfileVO.artGroupNo}">
        Fan
      </a>
    </li>
    <li class="nav-item ">
      <a class="nav-link active"
         href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${communityProfileVO.artGroupNo}">
        Artist
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${communityProfileVO.artGroupNo}">
        Media
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${communityProfileVO.artGroupNo}">
        Live
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${communityProfileVO.artGroupNo}"
         target="_blank">
        Shop
      </a>
    </li>
  </ul>
</div>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<div class="row mt-5"></div>
<form id="artGroupInfo" name="artGroupInfo" >
<input type="hidden" id="artGroupNo" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
<input type="hidden" id="memNo" name="memNo" value="${communityProfileVO.memNo }">
<input type="hidden" id="comProfileNo" name="comProfileNo" value="${communityProfileVO.comProfileNo }">
<input type="hidden" id="comNm" name="comNm" value="${communityProfileVO.comNm }">
<input type="hidden" id="saveFileLocate" name="saveFileLocate" value="${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate }">
<input type="hidden" id="userNo" name="userNo" value="${userVO.userNo }">
<input type="hidden" id="authNm" name="authNm" value="${userVO.userAuthList[0].authNm }">
<input type="hidden" id="membershipYn" name="membershipYn" value="${membershipYn }">
</form>


<%-- <!--  <p>개똥이 : ${userVO}</p>

<p>개똥이 : ${userVO}</p>
=======
<p>개똥이 : ${userVO}</p>

<p>========================================</p>
<p>${communityProfileVO }</p>
${artistGroupVO }
<p>========================================</p>

${membershipYn }-->

${membershipYn }

${membershipYn } --%>




	<c:if test="${artistBirth != '없음' && not empty artistBirth }">
	
	<img src="https://i.pinimg.com/originals/8b/e8/af/8be8af400915bec32515d0745d8ad44a.gif" class="gift-box-gif" id="giftBox" />

	
 		<div class="weverse-birthday-banner">
		  🎂 오늘은 <strong >${artistBirth.artActNm}</strong>님의 생일입니다! 💖
		</div>
	  <!-- SweetAlert + Confetti Explosion -->
	  <script>
	    document.addEventListener("DOMContentLoaded", () => {
	    	Swal.fire({
	    		  title: '🎉 축하합니다!',
	    		  html: '<strong>${artistBirth.artActNm}</strong>님의 생일이에요! 💖',
	    		  
	    		  imageWidth: 180,
	    		  imageHeight: 180,
	    		  background: '#fff0f5',
	    		  showConfirmButton: false,
	    		  timer: 2000,
	    		  didOpen: () => {
	    		    const explosion = document.createElement("div");
	    		    explosion.className = "birthday-explosion";
	    		    explosion.innerHTML = `
	    		      <div class="confetti" style="--x:1; --y:1;"></div>
	    		      <div class="confetti" style="--x:-1; --y:1;"></div>
	    		      <div class="confetti" style="--x:1; --y:-1;"></div>
	    		      <div class="confetti" style="--x:-1; --y:-1;"></div>
	    		    `;
	    		    document.body.appendChild(explosion);
	    		    setTimeout(() => explosion.remove(), 1500);
	    		  }
	    		});
	    });
	  </script> 
	</c:if>
<div class="container mt-4 mx-auto">
  <!-- ✅ Swiper Wrapper -->
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">	
	<c:forEach var="reply" items="${artistRecentReplyList}">
		<c:forEach var="artistVO" items="${artistGroupVO.artistVOList }">
			<c:if test="${reply.memNo == artistVO.memNo && reply.replyDelyn=='N'}">
				<div class="swiper-slide">
				  <div class="artist-card text-white text-center d-flex flex-column justify-content-end p-3"
				       style="background-image: url('/upload${artistVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}'); background-size: cover; background-position: center;">
				    <div class="overlay"></div>
				    <div class="artist-text position-relative">
				      <p class="fw-bold mb-1">${reply.comNm}<span class="badge-star">🎵</span></p>
				      <p class="artist-message" style="cursor:pointer;" onclick="fn_load_replies(${reply.boardNo})">${reply.replyContent}</p>
				    </div>
				  </div>
				</div>
			</c:if>
		</c:forEach>
	</c:forEach>
	</div>
    <!-- Optional: 네비게이션 & 페이지네이션 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>
   

    <!-- 댓글 모달 버튼 -->


    <!-- 댓글 모달 -->
    <div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="replyModalLabel">댓글</h5>
                    
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="modal_close" onclick="fn_reply_modal_close()" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="reply-body">
                    <div id="replyList"></div>
                </div>

            </div>
        </div>
    </div>
    <!-- 뎃글 모달 끝 -->
    
    <!-- 게시물 입력 창 -->
    <div class="container mt-4">
	    <div class="col-md-8 mx-auto">
	    <c:choose>
	       <c:when test="${(communityProfileVO.comDelyn=='N')&&(userVO.userNo == communityProfileVO.memNo) && (userVO.userAuthList[0].authNm=='ROLE_ART') && ((communityProfileVO.comProfileNo!=0) && (communityProfileVO.comProfileNo!=null))}">
	          <button class="btn-weverse" data-bs-toggle="modal" data-bs-target="#postModal">포스트 쓰기</button>
	       </c:when>
	       <c:otherwise>
	       	  <button class="btn-weverse" data-bs-toggle="modal" data-bs-target="#postModal" disabled>아티스트만 작성 가능합니다</button>
	       </c:otherwise>
	    </c:choose>   
		</div>
	</div>

</div>

<!-- 모달 -->
<div class="modal fade custom-modal" id="postModal" tabindex="-1" aria-labelledby="postModalLabel" aria-hidden="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- 모달 헤더 -->
			
            <div class="modal-header">
                <h5 class="modal-title" id="postModalLabel">포스트 쓰기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
            <!-- 모달 바디 -->
            
            	<form name="frm" action="/oho/community/addArtBoard" method="post" enctype="multipart/form-data">

				<input type="hidden" id="artGroupNo" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
				<input type="hidden" id="memNo" name="memNo" value="${communityProfileVO.memNo }">
				<input type="hidden" id="comProfileNo" name="comProfileNo" value="${communityProfileVO.comProfileNo }">
				<input type="hidden" id="comProfileNo" name="comProfileVO" value="${communityProfileVO }">
				<input type="hidden" id="comNm" name="comNm" value="${communityProfileVO.comNm }">

	            <div class="modal-body">
					<input type="text" class="form-control mb-1" id="boardTitle" name="boardTitle"
					  placeholder="제목을 입력해주세요" maxlength="24" oninput="checkLength(this, 24, 'titleCounter')" />
					<small><span id="titleCounter">0</span>/24</small>
					
					<!-- 내용 입력 -->
					<textarea class="form-control mb-1 custom-textarea2" id="boardContent" name="boardContent"
					  placeholder="게시글을 작성하세요" oninput="checkLength(this, 200, 'contentCounter'); toggleSubmitButton()" rows="4"
					  maxlength="200"></textarea>
					<small><span id="contentCounter">0</span>/200</small>   
	            </div>
				
					<!-- 모달 푸터 -->
					<div class="modal-footer custom-footer">
						<div>
							<label for="formBoardFile" class="form-label"></label>
							 <input class="form-control" type="file" id="formBoardFile" multiple onchange="readBoardFile(this)" name="uploadFile">
								<div id="editBoardImg"></div>
						</div>
						
						<div>
							  <input type="checkbox" name="boardOnlyMembership"  value="Y" />Board Only Membership
						</div>
						<button type="button" class="btn btn-custom" id="submitBtn"
							onclick="fn_board_add_submit()" disabled>등록</button>
					</div>
                </form>
            
        </div>
    </div>
</div>

<!-- 게시글 수정 모달 -->  
<div class="modal fade custom-modal" id="postEditModal" tabindex="-1" aria-labelledby="postModalLabel" aria-hidden="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- 모달 헤더 -->
			
            <div class="modal-header">
                <h5 class="modal-title" id="postModalLabel">포스트 쓰기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
            <!-- 모달 바디 -->
            
            	<form id="boardEditForm" name="boardEditForm" action="/oho/community/editBoard" method="post" enctype="multipart/form-data">
				<input type="hidden" id="editFileGroupNo" name="fileGroupNo"/>
				<input type="hidden" id="artGroupNo" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
				<input type="hidden" id="memNo" name="memNo" value="${communityProfileVO.memNo }">
				<input type="hidden" id="comProfileNo" name="comProfileNo" value="${communityProfileVO.comProfileNo }">
				<input type="hidden" id="comProfileVo" name="comProfileVO" value="${communityProfileVO }">
				<input type="hidden" id="editBoardNo" name="boardNo">
			   <!--  <input type="hidden" id="deletedFileSnList" name="deletedFileSnList" /> -->
				
				
	            <div class="modal-body">
					<input type="text" class="form-control mb-1" id="boardEditTitle" name="boardTitle"
					  placeholder="제목을 입력해주세요" maxlength="24" oninput="checkLength(this, 24, 'titleCounter')" />
					<small><span id="titleCounter">0</span>/24</small>
					
					<!-- 내용 입력 -->
					<textarea class="form-control mb-1 custom-textarea2" id="boardEditContent" name="boardContent"
					  placeholder="게시글을 작성하세요" oninput="checkLength(this, 200, 'contentCounter'); toggleSubmitButton()" rows="4"
					  maxlength="200"></textarea>
					<small><span id="contentCounter">0</span>/200</small>
	            <div id="editImg">
                	</div>
	            </div>
				
	            <!-- 모달 푸터 -->
	            <div class="modal-footer custom-footer">
                <div>
                      <label for="formFile" class="form-label"></label>

 					  <input class="form-control" type="file" id="formBoardFile"  onchange="readFile(this)" onclick="fn_edit_img_remove()" multiple  name="uploadFile">
                </div>

                <div>
                <input type="checkbox" name="boardOnlyMembership"  value="Y" />Board Only Membership
                </div>
                <button type="button" class="btn btn-custom" id="submitBtn" onclick="fn_board_edit_submit()" >등록</button>
                </div>
                </form>
            
        </div>
    </div>
</div>
<!-- 이미지 크게 보이게 하는 모달  -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body text-center">
        <img id="modalImage" src="" class="img-fluid">
      </div>
    </div>
  </div>
</div>

    <c:if test="${(communityProfileVO.comDelyn=='Y')||(userVO.userNo == communityProfileVO.memNo) && (userVO.userAuthList[0].authNm=='ROLE_MEM') && (communityProfileVO.comProfileNo==0)}">
        <!-- 비회원용 UI -->
        <div class="container text-center mt-4">
            <div class="alert alert-dark d-flex flex-column align-items-center p-4">
                <h5 class="fw-bold">커뮤니티에 가입해 더 많은 기능을 사용해보세요!</h5>

                <a href="/oho/community/join?memNo=${communityProfileVO.memNo }&artGroupNo=${communityProfileVO.artGroupNo}" class="btn btn-success rounded-pill px-4">커뮤니티 가입</a>
            </div>
        </div>
    </c:if>



<h1 style="text-align: center; margin-bottom : 20px"></h1>
<div class="container mt-4" >
  <div class="row gx-1">
    
    <!-- 왼쪽: 피드 게시물 -->
    <div class="col-md-8" id="divBoards">

    </div>
	
    <!-- 오른쪽: 사이드바 -->
    <div class="col-md-4">
     <a href="/oho/groupProfile?artGroupNo=${communityProfileVO.artGroupNo }" style="text-decoration: none;"> 
      <div class="tempest-box mb-3">
        <img src="/upload${artistGroupVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate }" class="img-fluid rounded">
        <h5 class="mt-2 text-white py-2 px-3 rounded" style="font-size: 1.75rem;">${artistGroupVO.artGroupNm }</h5>
      </div>
	 </a>
	<c:choose>
	  <c:when test="${membershipYn == 'Y'}">
	    <div class="fan-card text-center mb-3 p-3 text-white vip-membership">
	      <strong>${artistGroupVO.artGroupNm} Digital Membership</strong>
	      <span class="badge rounded-pill bg-warning text-dark ms-2">멤버십 회원</span>
	    </div>
	  </c:when>
	  <c:otherwise>
		<c:set var="memberShipLink" value="${communityProfileVO.comProfileNo == 0 ? '/oho/community/join' : '/shop/ordersPost'  }"/>
		<c:set var="memberShipMethod" value="${communityProfileVO.comProfileNo == 0 ? 'get' : 'post'  }"/>
		<form action="${memberShipLink }" method="${memberShipMethod }">
	  	<input type="hidden" name="artGroupNo" value="${artistGroupVO.artGroupNo }">
	  	<input type="hidden" name="gdsType" value="M"> 
	    <div class="fan-card text-center mb-3 p-3 text-white bg-gradient-blue rounded shadow">
	      <strong>${artistGroupVO.artGroupNm} Digital Membership</strong>
	      <button class="btn btn-outline-light btn-sm mt-2" onclick="handleMembership()" >구독하기</button>
	    </div>
	    </form>
	  </c:otherwise>
	</c:choose>
		<!-- 오세인 프로필 카드 -->
		<c:choose>
		  <c:when test="${communityProfileVO.comDelyn=='N'&&communityProfileVO.comProfileNo != 0}">
		    <a href="/oho/community/profileDetail?comProfileNo=${communityProfileVO.comProfileNo}&from=artistBoardList" class="no-underline">
		      <div class="fan-card profile-card text-center mb-3">
				<c:set var="profileImgPath" value="/images/defaultProfile.jpg" />
				<c:if test="${not empty communityProfileVO.fileGroupVO.fileDetailVOList 
				             and not empty communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
				    <c:set var="profileImgPath" value="/upload${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />
				</c:if>
				
				<img src="${profileImgPath}" class="profile-img2 mb-2" >
		        <code>${communityProfileVO.comNm}<c:if test="${communityProfileVO.comAuth=='ROLE_ART' }"><span class="badge-star">🎵</span></c:if><c:if test="${membershipYn == 'Y'}"><span class="badge bg-primary texet-white ms-1 align-middle" title="멤버십 회원"><i class="fa-solid fa-gem"></i></span></c:if></code><br>
		        <small class="text-muted">Joined<br>
		        ${communityProfileVO.comJoinYmd}</small>
		      </div>
		    </a>
		  </c:when>
		
		  <c:otherwise>
		    <a href="/oho/community/join?memNo=${userVO.userNo}&artGroupNo=${communityProfileVO.artGroupNo}" class="text-decoration-none">
		      <div class="fan-card join-card text-center mb-3 p-3">
		        <i class="bi bi-person-plus fs-2 text-success mb-2"></i> <!-- 부트스트랩 아이콘 사용 -->
		        <h6 class="mb-0">커뮤니티에 가입하고 활동을 시작하세요!</h6>
		      </div>
		    </a>
		  </c:otherwise>
		</c:choose>
		
		<!-- 공지사항 카드 -->
				<div class="notice-box mb-4">
				  <div class="card shadow-sm rounded-4 px-3 py-3 bg-light border-0">
				    <div class="d-flex justify-content-between align-items-center mb-2">
				      <div class="fw-bold text-dark">
				        <i class="bi bi-megaphone-fill text-warning me-1"></i>
				        커뮤니티 공지사항
				      </div>
				      <a href="/oho/community/notice?artGroupNo=${artistGroupVO.artGroupNo}"
				         class="text-primary small fw-semibold" target="_blank">더보기</a>
				    </div>
				
				    <ul class="list-unstyled mb-2">
					
				      <c:choose>
					      <c:when test="${fn:length(recentNoticeList)>0}"> 
						      <c:forEach var="item" items="${recentNoticeList}">
						        <li class="text-truncate">
						          <a href="/oho/community/noticeDetail?bbsPostNo=${item.bbsPostNo}"
						             class="text-decoration-none text-dark d-block small fw-medium hover-underline">
						            [NOTICE] ${item.bbsTitle}
						          </a>
						        </li>
						      </c:forEach>
					      </c:when>
					      <c:otherwise>
					      		등록된 공지사항이 없습니다
					      </c:otherwise>
				      </c:choose> 
				    </ul>
				  </div>
				</div>

  </div> <!-- row end -->
</div>
</div> <!-- container end -->
<!-- 로그인한 사용자의 정보와 파라미터의 정보가 일치하지 않을 시 강제로 로그아웃 -->
<c:if test="${userVO.userNo != communityProfileVO.memNo}">
    <script>
        alert("잘못된 접근입니다. 다시 로그인해주세요");

        const form = document.createElement("form");
        form.method = "POST";
        form.action = "/logout";
        document.body.appendChild(form);
        form.submit();
    </script>
</c:if>

<div id="endMessage" style="display:none; text-align: center; font-size: 16px; color: black;">
    <strong>마지막 게시글 입니다</strong>
</div>
<!-- ///// 신고하기 모달 시작 ///// -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow rounded-4 border-0">

      <!-- 모달 헤더 -->
      <div class="modal-header border-0">
        <h5 class="modal-title w-100 text-center fw-bold" id="reportModalLabel">🚨 신고하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디 -->
      <div class="modal-body px-4 py-3">

        <!-- 유저 정보 (숨겨진 유저 번호 포함) -->
        <input type="hidden" name="memNo" id="userNoModal" value="${userVO.userNo}" />
        <div class="mb-4">
          <label class="form-label fw-semibold">📧 신고 대상 이메일</label>
          <input type="text" readonly class="form-control-plaintext text-body fw-bold" id="memEmailModal"
            value="${userVO.userMail}" />
        </div>

        <!-- 신고 사유 -->
        <div class="mb-4">
          <label class="form-label fw-semibold fs-5">🚫 신고 사유</label>
          <div class="row row-cols-2 g-2">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle1" value="영리적인/흥보성" />
              <label class="form-check-label" for="reportTitle1">영리적인/홍보성</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle2" value="음란물" />
              <label class="form-check-label" for="reportTitle2">음란물</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle3" value="불법정보" />
              <label class="form-check-label" for="reportTitle3">불법정보</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle4" value="음란성/선정성" />
              <label class="form-check-label" for="reportTitle4">음란성/선정성</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle5" value="욕설/인신공격" />
              <label class="form-check-label" for="reportTitle5">욕설/인신공격</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle6" value="아이디/DB거래" />
              <label class="form-check-label" for="reportTitle6">아이디/DB거래</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle7"
                value="같은 내용 반복(도배)" />
              <label class="form-check-label" for="reportTitle7">같은 내용 반복(도배)</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle8" value="운영규칙 위반" />
              <label class="form-check-label" for="reportTitle8">운영규칙 위반</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle9" value="기타" />
              <label class="form-check-label" for="reportTitle9">기타</label>
            </div>
          </div>
        </div>

        <!-- 상세내용 -->
        <div class="mb-4">
          <label for="reportCn" class="form-label fw-semibold fs-5">📝 상세내용</label>
          <textarea id="reportCn" name="reportCn" class="form-control" rows="5"
            placeholder="ex) 부적절한 게시글입니다."></textarea>
        </div>

        <!-- 신고 사진 업로드 -->
        <div class="mb-4">
          <label for="uploadFile" class="form-label fw-semibold fs-5">📷 신고 관련 이미지</label>
          <input type="file" class="form-control" id="uploadFile" name="uploadFile" multiple />
        </div>

      </div>

      <!-- 모달 푸터 -->
      <div class="modal-footer border-0 justify-content-between px-4 pb-4">
        <button type="button" class="btn btn-outline-secondary" id="btnModalClose" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary px-4" id="btnModalSubmit"
          data-mem-no="${userVO.userNo}">신고 제출</button>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
//자바에서 담아서 보낸(join) 값 및 principle에 들어있는 값
let artGroupNo = $("form[name='artGroupInfo']").find('#artGroupNo').val();
let myComProfileNo = $("form[name='artGroupInfo']").find('#comProfileNo').val();
let memNo =  $("form[name='artGroupInfo']").find('#memNo').val();
let comNm = $("form[name='artGroupInfo']").find('#comNm').val();
let userNo = $("form[name='artGroupInfo']").find('#userNo').val();
let authNm = $("form[name='artGroupInfo']").find('#authNm').val();
let mySaveFileLocate = $("form[name='artGroupInfo']").find('#saveFileLocate').val();
let boardOnlyMembership = $("form[name='artGroupInfo']").find('#membershipYn').val();


	let currentPage =1;
	let isLastPage = false;

	
/* 	function fn_edit_img_remove(){
		let fileInput = document.getElementById("formFile");

            
                $("#editImg").empty();
                console.log("-=-0-0-0-0-fileInput: ",fileInput);

		
	} */
	
	//게시글 수정 시 기존 게시글 내용 아작스로 받아오는 곳
	
	
	
let deletedFileSnList = [];

function fn_post_edit(boardNo) {
	const url = "/oho/community/editFanBoardAjax?boardNo=" + boardNo;

	$.ajax({
		url: url,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		type: "get",
		success: function (communityPostVO) {
			$("#boardEditTitle").val(communityPostVO.boardTitle);
			$("#boardEditContent").val(communityPostVO.boardContent);
			$("#editBoardNo").val(boardNo);
			$("#editFileGroupNo").val(communityPostVO.fileGroupVO?.fileGroupNo || "");

			const imgDiv = document.querySelector("#editImg");
			imgDiv.innerHTML = "";

			let str = "";

			if (communityPostVO.fileGroupVO?.fileDetailVOList?.length > 0) {
				str += `<div class="grid">`;
				$.each(communityPostVO.fileGroupVO.fileDetailVOList, function (idx, fileDetailVO) {
					str += `
						<div class="position-relative d-inline-block me-2 mb-2">
							<img src="/upload\${fileDetailVO.fileSaveLocate}" 
							     data-filesn="\${fileDetailVO.fileSn}"
							     class="edit-preview-img" 
							     style="width: 150px; height: 150px; object-fit: cover; border-radius: 10px;" />
							<button type="button" class="btn-close position-absolute top-0 end-0 delete-file-btn" aria-label="Close"></button>
						</div>`;
				});
				str += `</div>`;
			}

			imgDiv.innerHTML = str;

			// 새 파일 선택 시 기존 미리보기 제거 및 fileGroupNo 초기화
			document.querySelector("#editFileInput").addEventListener("change", () => {
				document.querySelector("#editImg").innerHTML = "";
				document.querySelector("#editFileGroupNo").value = "";
				deletedFileSnList = []; // 초기화
			});
		}
	});
}

//X 버튼 클릭 시 파일 삭제 처리
$(document).on("click", ".delete-file-btn", function () {
	const fileSn = $(this).siblings("img").data("filesn");
	if (fileSn !== undefined) {
		deletedFileSnList.push(fileSn);
		console.log("fileSn",deletedFileSnList);
		console.log("join", deletedFileSnList.join(","));
	}
	$(this).parent().remove();

	// 남은 이미지가 없다면 fileGroupNo 제거
	if ($(".edit-preview-img").length === 0) {
		$("#editFileGroupNo").val("");
	}
});

// 동기 폼 submit 직전 데이터 삽입
$("#boardEditForm").on("submit", function () {
    // 기존 것 제거
    $("#deletedFileSnList").remove();

    if (deletedFileSnList.length > 0) {
        const hiddenInput = $("<input>")
            .attr("type", "hidden")
            .attr("name", "deletedFileSnList")
            .val(deletedFileSnList.join(","));
        $(this).append(hiddenInput);
    }

	// fileGroupNo 값이 없다면 input 비우기
	if ($(".edit-preview-img").length === 0) {
		$("#editFileGroupNo").val("");
	}
});
	//게시물 수정
function fn_board_edit_submit(){
	$("form[name='boardEditForm']").submit();
}	 


	

	
	//댓글 삭제하기
	function fn_delete_reply(replyNo,boardNo){
		
		let data = {
			"replyNo":replyNo,
			"boardNo":boardNo

		};
		let url="/oho/community/deleteReply?replyNo="+replyNo+"&boardNo="+boardNo;
		$.ajax({
			url:url,
			contentType:"aplication/json; charset=utf-8",
			type:"get",
			dataType:"json",
			success: function(replyCnt){
				console.log("성공햇니?",replyCnt);
				let str =`\${replyCnt}`;
				$(`#repCnt\${boardNo}`).html((str));
				$(`#replyNumber\${replyNo}`).remove();
			},
			error : function(){
				alert('error');
			}
			
			})
		
	}
	//모달 취소시 입력값 초기화
	$(document).ready(function(){
		$("#postModal").on("hidden.bs.modal", function () {
		    document.forms["frm"].reset();
		    document.getElementById("submitBtn").disabled = true;
		});
	});
	//게시글 수정 모달 취소시 입력값 초기화
	$(document).ready(function(){
		$("#postEditModal").on("hidden.bs.modal", function () {
		    document.forms["boardEditForm"].reset();
		    document.getElementById("submitBtn").disabled = true;
		});
	});
	//클릭시 사진 크게 보이게하는 기능
	  function openImageModal(src) {
		    document.getElementById("modalImage").src = src;
		    new bootstrap.Modal(document.getElementById('imageModal')).show();
		  }
	  
	//제목과 내용을 입력하지 않으면
	function toggleSubmitButton() {
	    const textArea = document.getElementById("boardContent");
	    const textArea2 = document.getElementById("boardTitle");
	    const submitBtn = document.getElementById("submitBtn");

	    if (textArea.value.trim() !== "" && textArea2.value.trim() !== "") {
	        submitBtn.disabled = false;
	    } else {
	        submitBtn.disabled = true;
	    }
	}



//게시물 추가 submit
	function fn_board_add_submit() {
		$("form[name='frm']").submit();
	}

//댓글 좋아요	
function fn_reply_likeYn(boardNo,replyNo){
	let data = {
			"comProfileNo":myComProfileNo,
			"replyNo":replyNo,
			"boardNo":boardNo
            
	};
	let url="/oho/community/replyLikeYnAjax?"+$.param(data);
	console.log("data1 : ",data);
	console.log("url : ",url);
	
	 $.ajax({
			url:url,
			contentType:"application/json; charset=utf-8",
			type:"get",
			dataType:"json"
    , success: function(replyLikeCnt) {
 	    console.log("replyLikeCnt 성공했습니다 ", replyLikeCnt);
 	   
 	    let str =`\${replyLikeCnt}`;
 	  $(`#replyLikeCnt\${replyNo}`).html(str);
 	},
		error : function() {
		alert('커뮤니티 가입 후 이용해주세요');
   },
   complete : function() {       
	 	replyToggleLike(boardNo,replyNo);
 	  }
	 }); //ajax
}
//댓글 좋아요 토글
function replyToggleLike(boardNo,replyNo) {
    let replyLikeBtn = document.getElementById(`replyLikeBtn\${replyNo}`);
    let heartIcon = document.getElementById(`heartIcon\${replyNo}`);
    console.log(heartIcon);
	console.log("들어오고 있니?",replyNo);
    let isLiked = heartIcon.classList.contains("bi-heart-fill");

    if (isLiked) {
        heartIcon.classList.remove("bi-heart-fill");
        heartIcon.classList.add("bi-heart");
        replyLikeBtn.classList.remove("btn-danger");
        replyLikeBtn.classList.add("btn-outline-danger");

    } else {
        heartIcon.classList.remove("bi-heart");
        heartIcon.classList.add("bi-heart-fill");
        replyLikeBtn.classList.remove("btn-outline-danger");
        replyLikeBtn.classList.add("btn-danger");

    }
}	

//게시물 좋아요 토글
function fn_board_likeYn(boardNo){
	

	
	
	let data = {
			"comProfileNo":myComProfileNo,
			"boardNo":boardNo

	};
	let url="/oho/community/boardLikeYnAjax?"+$.param(data);
	console.log("data : ",data);
	console.log("url : ",url);
	 $.ajax({
			url:url,
			contentType:"application/json; charset=utf-8",
			type:"get",
			dataType:"json"
    , success: function(boardLikeCnt) {
 	    console.log("boardLikeCnt 성공했습니다 ", boardLikeCnt);
 	   
 	    let str =`\${boardLikeCnt}`;
 	  $(`#boardLikeCnt\${boardNo}`).html(str);
 	  
 	},
		error : function() {
	 	alert('커뮤니티 가입 후 이용해주세요');
   },
   complete : function() {       
	 	toggleLike(boardNo);
  	  }
	 }); //ajax
}
//토글 정의 -> 빈하트 하트 유무 체크해서 변화 ( 부트스트랩 5 기능 )
function toggleLike(boardNo) {
    let boardLikeBtn = document.getElementById(`boardLikeBtn\${boardNo}`);
    let heartIcon = document.getElementById(`heartIcon\${boardNo}`);
    console.log(heartIcon);
	console.log("들어오고 있니?",boardNo);
    let isLiked = heartIcon.classList.contains("bi-heart-fill");

    if (isLiked) {
        heartIcon.classList.remove("bi-heart-fill");
        heartIcon.classList.add("bi-heart");
        boardLikeBtn.classList.remove("btn-danger");
        boardLikeBtn.classList.add("btn-outline-danger");

    } else {
        heartIcon.classList.remove("bi-heart");
        heartIcon.classList.add("bi-heart-fill");
        boardLikeBtn.classList.remove("btn-outline-danger");
        boardLikeBtn.classList.add("btn-danger");

    }
}	
	
//댓글 추가
function fn_add_replies(boardNo){
	
	let replyContent =$(`#replyContent\${boardNo}`).val();
	console.log("replyContent",replyContent);
	console.log("memNo",memNo);
	let data ={
			"artGroupNo":artGroupNo,
			"boardNo":boardNo,
			"comProfileNo":myComProfileNo,
			"replyContent":replyContent,
			"comNm":comNm,
			"memNo":memNo
		};
		
		let url = "/oho/community/addReplyAjax?"+$.param(data);
		console.log("data : ",data);
		 $.ajax({
				url:url,
				contentType:"application/json; charset=utf-8",
				type:"get",
				dataType:"json"
	       , success: function(communityReplyVO) {
	    	    console.log("communityReplyVO: ", communityReplyVO);
	    	    console.log("mySaveFileLocate: ", mySaveFileLocate);
	    	    
	    	    let str = "";
 	    	    str += `
 	    	    	<div id="replyNumber\${communityReplyVO.replyNo}">
	    	        <div class="d-flex align-items-start mb-2" id="\${communityReplyVO.replyNo}">`;
	    	           
	    	        
                if(mySaveFileLocate.length > 0){
                    
					
                        str += `<img src="/upload\${mySaveFileLocate}" class="profile-img" onclick="openImageModal(this.src)" />`;
				
                        
            	}else{       	
                	str += ``;
                };
                if(communityReplyVO.memNo==userNo){

                	
                	str+=`               
                		<div class="position-absolute top-1 end-0">
                        <div class="dropdown">
                        
                        <button class="btn btn-light border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            &#x22EE; 
                        </button>
                        
                        
                        <ul class="dropdown-menu shadow-sm border-0" aria-labelledby="dropdownMenuButton">
                            <li>
                                <a class="dropdown-item d-flex align-items-center text-danger" onclick="fn_delete_reply(\${communityReplyVO.replyNo},\${communityReplyVO.boardNo})">
                                    <span class="me-2">🗑️삭제하기</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    </div>
                			
                	`;
                	
                }
                else{
                	str+=`
                		<div class="position-absolute top-1 end-0">
                		<div class="dropdown">
                        
                        <button class="btn btn-light border rounded-circle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            &#x22EE; 
                        </button>
  
                     
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <span class="me-2">🔔</span> 신고하기
                                </a>
                            </li>
                        </ul>
                    </div>
                	</div>		
                	`;
                } 
                
                str +=   `  <div><strong><a href="/oho/community/profileDetail?comProfileNo=\${communityReplyVO.comProfileNo}" class="text-dark text-decoration-none fw-bold">
	    	                        \${communityReplyVO.comNm}
	    	                    </a>`;
                if(authNm=='ROLE_ART'){
                    str+=`<span class="badge-star">🎵</span>`;        
                            }
	    	                    
	    	    str+=`           </strong>
	    	                    <p id="repCreateDt">방금</p>
	    	                <p class="mb-1 card-reply" data-original="\${communityReplyVO.replyContent}">\${communityReplyVO.replyContent}</p>`;
	    	                
	    	              
	    	    str +=   `      <button class="reply-translate-btn" onclick="commuReplyTrans()" data-lang="en" data-status="original">번역하기</button>
	    	    				<button class="btn btn-outline-danger" id="replyLikeBtn\${communityReplyVO.replyNo}" onclick="fn_reply_likeYn(\${communityReplyVO.boardNo}, \${communityReplyVO.replyNo})">
                    			 <i id="heartIcon\${communityReplyVO.replyNo}" class="bi bi-heart"></i> <span id="replyLikeCnt\${communityReplyVO.replyNo}">\${communityReplyVO.replyLikeCnt}</span>
	    	                    </button>
	    	                </div>
	    	            </div>
	    	       
	    	    `;

	    	    console.log(str);
			
	    	    // 바로 fn_page()로 데이터 전달하여 출력
	    	   $("#replyContainer").prepend(str);
	    	   fn_load_replies(boardNo);
	    	},
			error : function() {
	            alert('error');
	      },complete : function(communityReplyVO){
              let replyInput = document.querySelector(`#replyContent\${boardNo}`);
	    	  replyInput.value="";
	    	  
	    	  
	    	  console.log("========",communityReplyVO.responseJSON);
			  let repCnt = $(`#repCnt\${communityReplyVO.responseJSON.boardNo}`).html();
			  console.log("repCnt:게시물 당 댓글 갯수:",repCnt);
              let cnt = parseInt(repCnt);
              $(`#repCnt\${communityReplyVO.responseJSON.boardNo}`).html(cnt+1);
	      }
	
		 }); //ajax
	}
	

//댓글 모달	
function fn_load_replies(boardNo) {
     //토글 방식으로 댓글 보였다 안보였다 하기
/* 	$(`#\${boardNo}`).toggle();
	$(`#repCnt\${boardNo}`).toggle(); */
	console.log("오고있니?",boardNo)
    document.getElementById("replyModalLabel").textContent = `게시글\${boardNo}`;
    
//     let reply = document.getElementById(`\${boardNo}`);
    
//    	let reply = $("#"+boardNo).val();
//     console.log("reply?",reply)
    
//     $("#replyList").html(reply);
    
//     console.log("리플?",reply)
    
    //boardNo에 작성된 댓글 목록 불러오기
	$.ajax({
		url:"/oho/community/replyList",
		data:{"boardNo":boardNo},
		type:"post",
		dataType:"json",
		success:function(communityReplyVOList){

			/*
			{
			    "replyNo": 18,
			    "replyContent": "333",
			    "replyDelyn": "N",
			    "replyCreateDt": null,
			    "boardNo": 19,
			    "artNo": 0,
			    "memNo": 8,
			    "mediaPostNo": 0,
			    "comProfileNo": 1,
			    "repCreateDate": "2025-04-07 12:14:47",
			    "replyLikeCnt": 0,
			    "comNm": "오세인",
			    "comAuth": "ROLE_MEM",
			    "fileSaveLocate": "/2025/04/04/81334eac-5514-4589-8d10-78c637b48be4_0a487495-399b-40c4-bbcf-1ac3c312757e_img2.jpg",
			    "profileFileNo": 0,
			    "fileGroupNo": 0,
			    "communityProfileVO": null,
			    "replyLikeList": null,
			    "fileGroupVO": {
			        "fileGroupNo": 0,
			        "fileRegdate": null,
			        "fileDetailVOList": [
			            {
			                "fileSn": 0,
			                "fileGroupNo": 0,
			                "fileOriginalName": null,
			                "fileSaveName": null,
			                "fileSaveLocate": "/2025/04/04/81334eac-5514-4589-8d10-78c637b48be4_0a487495-399b-40c4-bbcf-1ac3c312757e_img2.jpg",
			                "fileSize": 0,
			                "fileExt": null,
			                "fileMime": null,
			                "fileFancysize": null,
			                "fileSaveDate": null,
			                "fileDowncount": 0
			            }
			        ]
			    },
			    "uploadFile": null
			}
			*/
			console.log("fn_load_replies->communityReplyVOList : ", communityReplyVOList);
			
			let str = "";
			
            str+=` <div class="mb-2">`;
            if(myComProfileNo != 0 && userNo==memNo){
		   str+=`       <div class="d-flex align-items-start gap-2">
		   				<input type="text" id="replyContent\${boardNo}" name="plusReply" class="form-control" placeholder="댓글을 입력하세요" oninput="checkLength(this, 100, 'replyCounter'); toggleReplyButton()" 
							onkeyup="if(event.key === 'Enter') fn_add_replies(\${boardNo})" maxlength="100">
			   			<button class="btn btn-primary btn-no-wrap" id="subBtn" onclick="fn_add_replies(\${boardNo})" disabled>등록</button>
			   			</div>
	   					<small><span id="replyCounter">0</span>/100</small>`;
		            }else{
		   str+=`       <input type="text" id="replyContent\${boardNo}" class="form-control" placeholder="커뮤니티 가입 후 이용하세요" readonly>
			   			`;
		            	}
		            
		    str+=`  </div>`;
            if (communityReplyVOList.length == 0) {
                str += `<p class="text-muted text-center">댓글이 없습니다.</p>`;
            }
			$.each(communityReplyVOList,function(idx,communityReplyVO){
				
				str += `
					<div id="replyContainer">
					<div id="replyNumber\${communityReplyVO.replyNo}">
	                <div class="d-flex align-items-start mb-2">`;
	                	 
	              
                if(communityReplyVO.fileSaveLocate != null && communityReplyVO.fileSaveLocate != ""){             
	                str+=`     <img src="/upload\${communityReplyVO.fileSaveLocate}" class="profile-img" onclick="openImageModal(this.src)">`;
	                }else{
	             	   str+=`     <img src="/images/defaultProfile.jpg" class="profile-img" onclick="openImageModal(this.src)">`;
	                }     
	                
	                 str+=`<div>
	                        <strong><a href="/oho/community/profileDetail?comProfileNo=\${communityReplyVO.comProfileNo}" class="text-dark text-decoration-none fw-bold">\${communityReplyVO.comNm}</a>`;
	                        
                if(communityReplyVO.communityProfileVO.membershipYn=='Y'){
                  	 str+=`<span class="badge bg-primary texet-white ms-1 align-middle"
   						title="멤버십 회원"><i class="fa-solid fa-gem"></i></span>`;
                   }
                
                if(communityReplyVO.comAuth=='ROLE_ART'){
                    str+=`<span class="badge-star">🎵</span>`;        
                            }
	             str+=`     </strong>
	             
	             			  <div class="position-absolute top-1 end-0">
	                          <div class="dropdown">
	                          <button class="btn btn-light border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
	                              ⋮ 
	                          </button>`;
	                if(communityReplyVO.memNo==userNo){
	                 str+=`   <ul class="dropdown-menu shadow-sm border-0" aria-labelledby="dropdownMenuButton">
	                              <li>
	                                  <a class="dropdown-item d-flex align-items-center text-danger" onclick="fn_delete_reply(\${communityReplyVO.replyNo},\${boardNo})">
	                                      <span class="me-2">🗑️삭제하기</span>
	                                  </a>
	                              </li>
	                          </ul>`;
	                }else if(communityReplyVO.comAuth=='ROLE_MEM'){
	                	
	     str+=`	  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	     			<li>
        				<a class="dropdown-item d-flex align-items-center aReport" href="#" data-bs-toggle="modal"
        					data-bs-target="#reportModal" data-report-gubun="댓글" data-report-board-no="\${communityReplyVO.replyNo}"
        						data-mem-no="\${communityReplyVO.memNo}">
        					<span class="me-2">🔔</span> 신고하기
        				</a>
        			</li>
        		  </ul>`;
	                }
	                else if(communityReplyVO.comAuth=='ROLE_ART'){
	         str+=`    	<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	                		<sapn class="me-2">신고가 불가한 댓글</span>
	                	</ul>`;
	                }
	          str+=`        </div>
	                      </div>
	                  	 <p id="repCreateDt">\${communityReplyVO.repCreateDate}</p>
	                        <p class="mb-1 card-reply" data-original="\${communityReplyVO.replyContent}">\${communityReplyVO.replyContent}</p>
	                        <button class="reply-translate-btn" onclick="commuReplyTrans()" data-lang="en" data-status="original">번역하기</button>
	                        <button class="btn btn-outline-danger" id="replyLikeBtn\${communityReplyVO.replyNo}" onclick="fn_reply_likeYn(\${boardNo}, \${communityReplyVO.replyNo})"><i id="heartIcon\${communityReplyVO.replyNo}" class="bi bi-heart"></i><span id="replyLikeCnt\${communityReplyVO.replyNo}">\${communityReplyVO.replyLikeCnt}</span></button>
	                    </div>
	                </div></div></div>
				`;
			
			});//end each
			
			//모달은 id="replyList"
			$("#replyList").html(str);
			
		    new bootstrap.Modal(document.getElementById('replyModal')).show();
		}
	});
    
}
//게시물 리스트 ajax 
function fn_board_list(currentPage,keyword){
	if(currentPage==""||currentPage==null||currentPage== undefined){
	      currentPage = "1";
	   }
	   //확장성 키워드 검색
  if(keyword==""||keyword==null||keyword== undefined){
        keyword = "";
  }
  //게시글 리스트 아작스로 받기
let data ={
		"artGroupNo":artGroupNo,
		"currentPage":currentPage,
		"keyword":keyword
	};
	let url = "/oho/community/artistBoardListPost?currentPage=" + currentPage;
	console.log("data : ",data);
	 $.ajax({
			url:url,
			contentType:"application/json; charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json"
       , success: function(boardPage) {
    	    console.log("boardPage:", boardPage);
    	    console.log("boardPage.content:", boardPage.content);
    	    let boardListVO = boardPage.content;
    	    isLastPage = boardPage.isLastPage;
            if (isLastPage) {
                $('#endMessage').show();  // 마지막 페이지 도달 시 메시지 표시
            }
    	    console.log("boardListVO:", boardListVO);

    	    // 바로 fn_page()로 데이터 전달하여 출력
    	    fn_page(boardListVO);
    	},
		error : function() {
            alert('error');
      },
     complete : function() {       
    	 	
    	  }
	 }); //ajax
     
}
//div에 뿌려주는 부분
function fn_page(boardListVO){
    
    // 데이터 구조 확인
    console.log("userNo:",userNo);
	console.log("fn_page->boardListVO : ", boardListVO);
/* 댓글 좋아요 버튼, 게시글 좋아요 버튼 누르는 펑션 만듬 ( 처리해야함 )
    좋아요 누른 게시글 - > 버튼 다르고 취소하면 또 다르게 해야함
    */
    let str = "";
    
    /* element
    {
    "boardNo": 3,
    "boardTitle": "테스트3",
    "boardContent": "user->4",
    "boardOnlyMembership": "N",
    "boardDelyn": "N",
    "boardCreateDt": "2025-04-01T06:05:07.000+00:00",
    "boardOnlyFan": "N",
    "urlCategory": null,
    "comProfileNo": 4,
    "memNo": 3,
    "comNm": "IU테스트용계정",
    "fileGroupNo": 0,
    "fileGroupVO": {{...
    }
    */
     if(boardListVO.length==0&&currentPage==1){
        str+=`
        <div class="col-md-8 mx-auto " id="divBoards" style="transform: translateX(100px);" >
        	  <div class="card text-center border-0 shadow-sm py-5" style="background-color: #f9fafb; border-radius: 1rem;">
            <div class="card-body">
              <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#adb5bd" class="mb-3" viewBox="0 0 16 16">
                <path d="M8 1a7 7 0 1 0 7 7A7.01 7.01 0 0 0 8 1zm0 13A6 6 0 1 1 14 8a6.01 6.01 0 0 1-6 6zm-.75-3.25h1.5v1.5h-1.5zm0-6.5h1.5v5h-1.5z"/>
              </svg>
              <h5 class="text-muted mb-2">아직 게시글이 없어요</h5>
            </div>
          </div>
        </div>
        `;
        } 
    
    $.each(boardListVO, function(i, element) {
        
     	console.log("check : ",element);
    	console.log("권한 체크 : ",element.boardOnlyMembership);
		if(element.boardDelyn == 'N'&&element.comAuth=='ROLE_ART'){
        str += `

        <div>`;
        
        str+=` <div class="card shadow-sm rounded`;
        		if(element.boardOnlyMembership == 'Y' && 
        			    (boardOnlyMembership == 'N' || myComProfileNo == 0)&&authNm=='ROLE_MEM'){
        			str+=` blind-card`;
        		}else if(element.boardOnlyMembership == 'Y' && (boardOnlyMembership == 'Y' && myComProfileNo != 0)&&authNm=='ROLE_MEM'){
        			str+=` onlyMemberhsip`;
        		}
        str+=`	">
                <div class="card-header bg-white d-flex align-items-center">`;

                    
        if(    element.fileGroupVO2 &&
     		   element.fileGroupVO2.fileDetailVOList &&
     		   element.fileGroupVO2.fileDetailVOList.length > 0 &&
     		   element.fileGroupVO2.fileDetailVOList[0].fileSaveLocate){             
        str+=`     <img src="/upload\${element.fileGroupVO2.fileDetailVOList[0].fileSaveLocate}" class="profile-img" onclick="openImageModal(this.src)">`;
        }else{
     	   str+=`     <img src="/images/defaultProfile.jpg" class="profile-img" onclick="openImageModal(this.src)">`;
        }
                   		
       str+=`       <div style="display: flex; gap: 20px;">
                    <a href="/oho/community/profileDetail?comProfileNo=\${element.comProfileNo}&from=artistBoardList" class="text-dark text-decoration-none fw-bold"><h5 class="card-title fw-bold"><strong>\${element.comNm}`;
               
        if(element.comAuth=='ROLE_ART'){
            str+=`<span class="badge-star">🎵</span>`;        
                    }
                    
         str+=`     </strong></h5></a>
                    <p><h3 class="post-title" data-original="\${element.boardTitle}">       \${element.boardTitle}</h3></p>
                    </div>`;
        if(element.memNo==userNo){

        	
            str+=`                
            		<div class="position-absolute top-1 end-0">
                    <div class="dropdown">
                    
                    <button class="btn btn-light border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        &#x22EE; 
                    </button>
                    
                    
                    <ul class="dropdown-menu shadow-sm border-0" aria-labelledby="dropdownMenuButton">
                        <li>
                            <a class="dropdown-item d-flex align-items-center" onclick="fn_post_edit(\${element.boardNo})" data-bs-toggle="modal" data-bs-target="#postEditModal">
                                <span class="me-2">✏️수정하기</span> 
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center text-danger" href="/oho/community/deleteBoard?boardNo=\${element.boardNo}&comProfileNo=\${myComProfileNo}">
                                <span class="me-2">🗑️삭제하기</span> 
                            </a>
                        </li>
                    </ul>
                </div>
                </div>
            			
            	`;
            	
            }
        else{
        	str+=`
        		<div class="position-absolute top-1 end-0">

                

            
        	</div>		
        	`;
        }

          str+=`     </div>
                <div class="card-body">
                <p id="boardCreateDt">\${element.boardCreateDate}</p>
                `;

                
                    
                if(element.fileGroupVO?.fileDetailVOList?.length > 0){
                      str+=`<div class="grid">`;
					$.each(element.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){
                        str += `<img src="/upload\${fileDetailVO.fileSaveLocate}" class="post-image" onclick="openImageModal(this.src)" />`;
					});
                     str+=`</div> `;  
            	}else{       	
                	str += ``;
                };
                
                str += `<p class="card-text" data-original="\${element.boardContent}">\${element.boardContent}</p>
                	<div class="translate-btn-box">
                	<button class="weverse-btn" onclick="commuPostTrans()" data-lang="en" data-status="original">번역하기</button>
                	</div>
                </div>
                <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                    <button class="btn btn-outline-danger" id="boardLikeBtn\${element.boardNo}" onclick="fn_board_likeYn(\${element.boardNo})">`;
                 str+=`<i id="heartIcon\${element.boardNo}" class="bi bi-heart`;
                $.each(element.boardLikeList,function(idx,boardLike){
                	if(boardLike.memNo==memNo){
                		str+=`-fill`;
                		
                		} 
                });
               str+=`"></i>`;
                   
                    
              str+=`<span id="boardLikeCnt\${element.boardNo}">\${element.boardLikeCnt}</span>
                    </button>`;

            //댓글 모달 스타트        
            str+= ` 
                    <button class="btn btn-light" onclick="fn_load_replies(\${element.boardNo})">
                    💬 댓글(<span id="repCnt\${element.boardNo}">\${element.replyList.length}</span>)
                    </button>
                	`;    
                    
        	str+=`  </div>
                <div class="comment-section p-3 bg-light rounded" id="\${element.boardNo}" style="display: none;">
                    <div class="input-group">`;
                    if(myComProfileNo != 0 && userNo==memNo){
           str+=`       <input type="text" id="replyContent\${element.boardNo}" class="form-control" placeholder="댓글을 입력하세요" onkeyup="if(event.key === 'Enter') fn_add_replies(\${element.boardNo})">
                        <button class="btn btn-primary" onclick="fn_add_replies(\${element.boardNo})">등록</button>`;
                    }else{
           str+=`       <input type="text" id="replyContent\${element.boardNo}" class="form-control" placeholder="커뮤니티 가입 후 이용하세요" readonly>
        	   			`;
                    	}
                    
            str+=`  </div>
                    <div id="replyList\${element.boardNo}" class="mt-3">`;
                    
                    if (!element.replyList || element.replyList.length <= 0) {
                        str += `<p class="text-muted text-center">댓글이 없습니다.</p>
                        		<div id="replyContainer"></div>
                        		`;
                    } else {
                        element.replyList.forEach(reply => {
                        	
                        	if(reply.replyDelyn=='N'){
                            str += `
                            <div id="replyContainer">	
                            <div id="replyNumber\${reply.replyNo}">
                            <div class="d-flex align-items-start mb-2">
                            	 <img src="/upload\${reply.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" class="profile-img" onclick="openImageModal(this.src)">    
                                <div>
                                    <strong><a href="/oho/community/profileDetail?comProfileNo=\${reply.comProfileNo}" class="text-dark text-decoration-none fw-bold">\${reply.comNm}</a>`;
                            if(reply.comAuth=='ROLE_ART'){
                                str+=`<span class="badge-star">🎵</span>`;        
                                        }  
                              str+=`</strong>`;
                             
                              /* 여기 */
                              if(reply.memNo==userNo){

                              	
                              	str+=`               
                              		<div class="position-absolute top-1 end-0">
                                      <div class="dropdown">
                                      
                                      <button class="btn btn-light border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                          &#x22EE; 
                                      </button>
                                      
                                      
                                      <ul class="dropdown-menu shadow-sm border-0" aria-labelledby="dropdownMenuButton">
                                          <li>
                                              <a class="dropdown-item d-flex align-items-center text-danger" onclick="fn_delete_reply(\${reply.replyNo},\${element.boardNo})">
                                                  <span class="me-2">🗑️삭제하기</span>
                                              </a>
                                          </li>
                                      </ul>
                                  </div>
                                  </div>
                              	</div>	
                              	`;
                              	
                              }
                              else{
                              	str+=`
                              		<div class="position-absolute top-1 end-0">
                              		<div class="dropdown">
                                      
                                      <button class="btn btn-light border rounded-circle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                          &#x22EE; 
                                      </button>
                                      
                                    
                                      <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                          <li>
                                              <a class="dropdown-item d-flex align-items-center" href="#">
                                                  <span class="me-2">🔔</span> 신고하기
                                              </a>
                                          </li>
                                      </ul>
                                  </div>
                              	</div>		
                              	`;
                              } 
                              
                              str+=` <p id="repCreateDt">\${reply.repCreateDate}</p>
                                    <p class="mb-1 card-reply" data-original="\${reply.replyContent}">\${reply.replyContent}</p>
                                    <button class="reply-translate-btn" onclick="commuReplyTrans()" data-lang="en" data-status="original">번역하기</button>
                                    <button class="btn btn-outline-danger" id="replyLikeBtn\${reply.replyNo}" onclick="fn_reply_likeYn(\${reply.boardNo}, \${reply.replyNo})">`;
                                    str+=`<i id="heartIcon\${reply.replyNo}" class="bi bi-heart`;
                                        $.each(reply.replyLikeList,function(idx,replyLike){
                                        	if(replyLike.memNo==memNo){
                                        		str+=`-fill`;
                                        		
                                        		} 
                                        });
                                       str+=`"></i>`;
                                    
                     str+=`       <span id="replyLikeCnt\${reply.replyNo}">\${reply.replyLikeCnt}</span></button>
                                </div>
                            </div></div>`;
                        	}});
                    }
      
                    

                    
                    
        str += `</div></div></div></div>`;
		}
    });
//본문 목록

$("#divBoards").append(str);

}


$(function(){
	fn_board_list();

});	

//스크롤 바닥 감지
window.onscroll = function(e) {	
    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        if (!isLastPage) {  // 마지막 페이지가 아니면 페이지 증가
            currentPage += 1;
            console.log("currentPage:", currentPage);
            fn_board_list(currentPage, "");
        } else {
            console.log("모든 데이터를 불러왔습니다.");
        }
    }
};


function toggleReplyButton() {
    const textArea = $('input[name=plusReply]');
    console.log("textArea val",textArea);
    const subBtn = document.getElementById("subBtn");
    if (textArea.val().trim() !== "" ) {
        subBtn.disabled = false;
    } else {
        subBtn.disabled = true;
    }
}

function readFile(input) {
    const editImgDiv = document.querySelector("#editImg");
    editImgDiv.innerHTML = ""; // 기존 이미지 제거

    const files = input.files;

    if (!files || files.length === 0) return;

    Array.from(files).forEach(file => {
        const reader = new FileReader();

        reader.onload = function(e) {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.style.cursor = "pointer";
            img.style.borderRadius = "10px";
            img.style.objectFit = "cover";
            img.style.width = "100%";
            img.style.height = "100%";
            editImgDiv.appendChild(img);
        };

        reader.readAsDataURL(file);
    });
}

function readBoardFile(input) {
    const editImgDiv = document.querySelector("#editBoardImg");
    editImgDiv.innerHTML = ""; // 기존 이미지 제거

    const files = input.files;
    const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];

    console.log("files===", files);
    if (!files || files.length === 0 || files.length > 3) return;

    Array.from(files).forEach(file => {
        const fileExtension = file.name.split('.').pop().toLowerCase(); // ✅ 수정된 부분
        if (!allowedExtensions.includes(fileExtension)) {
            alert("이미지만 등록해주세요");
            input.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.style.cursor = "pointer";
            img.style.borderRadius = "10px";
            img.style.objectFit = "cover";
            img.style.width = "100%";
            img.style.height = "100%";
            editImgDiv.appendChild(img);
        };

        reader.readAsDataURL(file);
    });
}


const slideCount = document.querySelectorAll('.swiper-slide').length;

const swiper = new Swiper('.mySwiper', {
    slidesPerView: 3,
    spaceBetween: 20,
    loop: slideCount >= 3,
    
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev'
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true
    },
    breakpoints: {
      768: {
        slidesPerView: 3
      },
      576: {
        slidesPerView: 1
      }
    },
    autoplay: {
    	  delay: 1500,
    	  disableOnInteraction: false
    	}
  });
	var grid = new Masonry('.grid', {
	  itemSelector: '.grid-item',
	  columnWidth: '.grid-item',
	  gutter: 10
	});
	//모달 강제종료
	function cleanUpModal() {
	    document.querySelectorAll('.modal-backdrop').forEach(el => el.remove()); // 오버레이 제거
	    document.body.classList.remove('modal-open'); // 스크롤 잠금 해제
	    document.body.style = ''; // inline style 제거
	}
	const replyModal = document.getElementById('replyModal');
	replyModal.addEventListener('hidden.bs.modal', cleanUpModal);

	
	document.getElementById("formBoardFile").addEventListener("change", function () {
	    const maxFiles = 3; // 최대 파일 개수
	    if (this.files.length > maxFiles) {
	        alert(`최대 ${maxFiles}개까지만 업로드할 수 있어요.`);
	        this.value = ""; // 파일 초기화
	        
	    }
	});

 window.addEventListener('DOMContentLoaded', () => {
  const urlParams = new URLSearchParams(window.location.search);
  const postNo = urlParams.get("notiOrgNo");

  const isAlarmScroll = !!postNo; // 알림 클릭 진입 여부 플래그

  // 무한스크롤 함수 (예시)
  // const infiniteScrollHandler = () => {
  //   // 스크롤 하단 감지
  //   if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 300) {
  //     console.log("📥 무한 스크롤 발동!");
  //   }
  // };

  // 무한스크롤은 알림 클릭이 아닐 경우에만 작동
  // if (!isAlarmScroll) {
  //   window.addEventListener("scroll", infiniteScrollHandler);
  // }

  // 알림 클릭으로 진입한 경우 → 특정 게시글로 스크롤
  if (postNo) {

    const container = document.querySelector("#divBoards"); // 게시글 부모 요소
    if (!container) return;

    let attempt = 0;
    const MAX_ATTEMPTS = 20;

      const tryScrollToPost = () => {
        attempt++;
        const postElement = document.querySelector(`#boardLikeBtn\${postNo}`);
        
        if (postElement) {
          const cardElement = postElement.closest(".card");
          if (cardElement) {
            cardElement.style.border = "3px solid #007bff";
            cardElement.style.borderRadius = "12px";
            cardElement.style.boxShadow = "0 0 15px rgba(0, 123, 255, 0.4)";
          }
          postElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
  
          console.log("게시글 위치로 스크롤 완료!");
          // 스크롤 완료 후 URL에서 notiOrgNo 제거 (옵션)
          urlParams.delete('notiOrgNo');
          window.history.replaceState({}, '', `${location.pathname}?\${urlParams}`);
          return;
        }
  
        // 아직 못 찾았고 시도 횟수 초과 전이면 다시 시도
        if (attempt < MAX_ATTEMPTS) {
          // 너무 많은 scrollBy 방지 → 스크롤 하단이 아닌 경우만
          if (window.scrollY < document.body.scrollHeight - 1500) {
            window.scrollBy(0, 800); // 부드러운 스크롤 유도
          }
          setTimeout(tryScrollToPost, 200);
        } else {
          console.warn("게시글 위치 찾지 못함");
          urlParams.delete('notiOrgNo');
          window.history.replaceState({}, '', `${location.pathname}?\${urlParams}`);
          observer.disconnect(); // 감지 중지
        }
      };
    const observer = new MutationObserver(() => {
      console.log("무한스크롤에 의한 게시글 추가 감지");
      tryScrollToPost(); // DOM 바뀔 때도 시도
    });

    observer.observe(container, { childList: true, subtree: true });
    
    tryScrollToPost();
  }
});

window.onload = function() {
    const replyNo = sessionStorage.getItem("replyNo");

    if (replyNo) {
        fn_load_replies(parseInt(replyNo));
        sessionStorage.removeItem("replyNo");  // 사용 후 삭제 (안하면 새로고침 시 재실행)
    }
};


	  function checkLength(input, maxLength, counterId) {
	    const currentLength = input.value.length;
	    const counter = document.getElementById(counterId);

	    if (currentLength > maxLength) {
	      alert(`최대 \${maxLength}자까지 입력할 수 있습니다.`);
	      input.value = input.value.substring(0, maxLength); // 초과된 부분 자름
	      counter.textContent = maxLength;
	    } else {
	      counter.textContent = currentLength;
	    }
	  }
	
	//멤버십 핸들러
	function handleMembership() {
	    const isMember = ${communityProfileVO.comProfileNo != 0}; // JSTL 값 가져옴 (0이면 false, 0 아니면 true)

	    if (!isMember) {
	        alert('가입한 회원만 구매가 가능합니다');
	    }
	    
	    document.getElementById('membershipForm').submit();
	}
	document.getElementById("boardTitle").addEventListener("keydown", function(event) {
		  if (event.key === "Enter") {
		    event.preventDefault(); // 기본 폼 제출 방지
		  }
		});
	
	document.addEventListener("contextmenu", function(e) {
	    if (e.target.closest(".onlyMemberhsip")) {
	        e.preventDefault();
	        alert("이 영역에서는 우클릭이 비활성화되어 있습니다.");
	    }
	});
</script> 

	<!-- ///// 신고하기 모달 끝 ///// -->
<%@ include file="../footer.jsp" %>
	<!-- Scroll Top -->
	<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	<!-- 	<i class="bi bi-arrow-up-short"></i> -->

<!-- Main JS File -->
<script src="/main/assets/js/main.js"></script>
<script src="/js/translate/translate.js"></script>
</body>
</html>