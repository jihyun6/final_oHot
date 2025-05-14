<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<script type="text/javascript" src="/js/jquery.min.js"></script>
<meta charset="UTF-8">
<title>ticketList</title>
<style>
.card-body p {
    margin-bottom: 2px; /* 문단 간격 줄이기 */
}

/* 배너 크기 조정 및 중앙 정렬 */
.carousel {
	width: 100%; /* 배너 너비를 100%로 줄임 */
    height: 300px; /* 배너 높이를 200px로 설정 */
    margin: 0 auto; /* 수평 중앙 정렬 */
	overflow: hidden; /* 이미지가 배너 영역을 벗어나지 않도록 숨김 */
}

.carousel-inner img {
	width: 15%; /* 이미지의 너비를 100%로 설정 */
    height: 250px; /* 이미지의 높이를 배너 높이에 맞추기 */
    margin: 10px 10px 10px 0px;
    border-radius: 15px;
}
.ellipsis-2-lines {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.4em;
    max-height: calc(1.4em * 2); /* 2줄 기준 */
  }
</style>
</head>
<body style="background-color: #FFFF;">

	<%@ include file="../shopHeader.jsp" %>
	<!-- /// 배너 시작 /// -->
	<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel" style="background-color:  #dee2e6;">
		<!-- 사진아래 ---를 의미 -->
	  <div class="carousel-indicators ">
		  <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		  <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
		  <!-- <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button> -->
		</div>
		
		<!-- Banner Image -->
		<div class="carousel-inner" style="background: #dee2e6;">
			<div class="carousel-item active">
				<div class="d-flex align-items-center justify-content-center">
					<img src="/upload/${goodsVOList[0].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;" class="mr-5">
					<img src="/upload/${goodsVOList[1].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;">
			  </div>
			</div>
			<div class="carousel-item active">
				<div class="d-flex align-items-center justify-content-center">
					<img src="/upload/${goodsVOList[2].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;"class="mr-5">
					<img src="/upload/${goodsVOList[3].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;">
			  </div>
			</div>
			<!-- <div class="carousel-item active">
				<div class="d-flex align-items-center justify-content-center">
				  <img src="/upload/${goodsVOList[4].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;"class="mr-5">
				  <img src="/upload/${goodsVOList[5].ticketVO.tkFileSaveLocate}" alt="P1234.jpg" style="object-fit: cover;">
			  </div>
			</div> -->
		</div>
		
		<!-- carousel left right button -->
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
		  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		  <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
		  <span class="carousel-control-next-icon" aria-hidden="true"></span>
		  <span class="visually-hidden">Next</span>
	  </button>
	</div>
	<!-- /// 배너 끝 /// -->
	<!-- /// 내용 시작 /// -->
	<div class="container">
		<!-- 행(row=tuple)별 처리. 내용을 중간 정렬 -->
				
		<div class="container mt-4">
			<nav class="nav nav-pills justify-content-center mb-4">
				<a class="nav-link ${empty param.tkCtgr ? 'text-danger fw-bold' : ''}" onclick="selectCtgr(this)">전체</a>
                <a class="nav-link " onclick="selectCtgr(this,'콘서트')">콘서트</a>
                <a class="nav-link " onclick="selectCtgr(this,'팬미팅')">팬미팅</a>
                <a class="nav-link " onclick="selectCtgr(this,'기타')">기타</a>
			</nav>
        <div class="row row-cols-1 row-cols-md-5 " id="ticketContainer">
            <c:forEach var="goodsVO" items="${goodsVOList}" varStatus="stat">
            <div class="col" style="margin-bottom: 20px;">
				<a href="/shop/ticket/ticketDetail?gdsNo=${goodsVO.gdsNo }">
					<div class="card h-55 w-80" style="width: 220px; margin-bottom: 0;">
						<div  style="height: 300px; overflow: hidden;">
							<img src="/upload${goodsVO.ticketVO.tkFileSaveLocate}" alt="포스터" class="card-img-top"  style="width: 100%; height: 100%; object-fit: cover;"  />
						</div>
					</div>
					<div class="card-body body p-1">
						<h5 class=" fw-bold ellipsis-2-lines" style="">${goodsVO.gdsNm}</h5>
						<p class="text-muted small">${goodsVO.ticketVO.tkLctn }</p>
						<p class="text-muted small">${goodsVO.artGroupNm }</p>
						<p class="text-muted small">${goodsVO.ticketVO.tkStartYmd } ~ ${goodsVO.ticketVO.tkFinishYmd }</p>
					</div>
				</a>
            </div>
            </c:forEach>
        </div>
    </div>

		<!-- /// 버튼 영역 시작 /// -->
		<div class="row text-center">
			<div class="col-sm-offset-2 col-sm-10">
			<!-- <p>${goodsVOList }</p> -->
			</div>
		</div>
		<!-- /// 버튼 영역 끝 /// -->
	</div>
	<!-- /// 내용 끝 /// -->
	<%@ include file="../shopfooter.jsp" %>

<script type="text/javascript">
    function selectCtgr(changeTitle,tkCtgr) {
        // alert("ctgr: " + tkCtgr);
        axios.post("/shop/ticket/ticketListPost", {
            tkCtgr: tkCtgr
        }).then(resp => {
            const list = resp.data;
            const container = document.querySelector("#ticketContainer");

            // 기존 내용 비우기
            container.innerHTML = ""; 
            document.querySelectorAll('.nav-link').forEach(nav => {
                nav.classList.remove('text-danger', 'fw-bold');
            });

            //카테고리 색상변경
            changeTitle.classList.add('text-danger', 'fw-bold');

            list.forEach(g => {
                container.innerHTML += `
                    <div class="col">
                        <a href="/shop/ticket/ticketDetail?gdsNo=\${g.gdsNo}">
                            <div class="card h-80 w-55">
                                <img src="/upload\${g.ticketVO.tkFileSaveLocate}" alt="포스터" class="card-img-top" style="object-fit: cover;" />
                            </div>
                            <div class="card-body body p-1">
                                <h5 class="fw-bold">\${g.gdsNm}</h5>
                                <p class="text-muted small">\${g.ticketVO.tkLctn}</p>
                                <p class="text-muted small">\${g.artGroupNm}</p>
                                <p class="text-muted small">\${g.ticketVO.tkStartYmd} ~ \${g.ticketVO.tkFinishYmd}</p>
                            </div>
                        </a>
                    </div>
                `;
            });
        });
    }


</script>
</body>
</html>