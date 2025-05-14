<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<link rel="icon" href="/images/oHoT_logo.png">
<title>oHoT Shop</title>
<style>

/* 헤더에 배경 넣기 */
.artist-group-header {
	/*   padding: 1rem 1.5rem; */
	border-radius: 12px;
	/*   background: linear-gradient(90deg, #00c4b4, #27e2d1); */
	color: white;
	/*   display: flex; */
	align-items: center;
	/*   gap: 10px; */
	/*   margin-bottom: 1.5rem; */
	padding: 0px 0px 0px 0px !important;
}

.artist-group-header .header-badge {
	background: #ffbb00;
	color: #fff;
	font-size: 0.8rem;
	padding: 2px 8px;
	border-radius: 12px;
	font-weight: 600;
}

/* 그룹 전체를 감싸는 카드 스타일 */
.artist-group-card {
	background-color: #ffffff;
	border-radius: 20px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
	padding: 2rem;
	margin-bottom: 3rem;
	transition: box-shadow 0.3s ease;
}

.artist-group-card:hover {
	box-shadow: 0 10px 28px rgba(0, 0, 0, 0.08);
}

/* 그룹 헤더 */
.artist-group-header {
	display: flex;
	align-items: center;
	margin-bottom: 2.0rem;
}

.header-badge {
	background: #ffa500;
	color: #fff;
	padding: 5px 12px;
	font-size: 0.75rem;
	border-radius: 999px;
	/* 	font-weight: 600; */
	margin-right: 10px;
	width: fit-content; /* 뱃지 크기를 텍스트 길이에 딱 맞게 자동 조절 */
}

.artist-group-name {
	font-size: 1.5rem;
	font-weight: 700;
	color: #333;
	margin: 0;
}

/* 개별 굿즈 카드 */
.custom-card {
	width: 200px;
	border: none;
	border-radius: 15px;
	overflow: hidden;
	background-color: transparent;
	text-align: center;
	transition: transform 0.2s ease;
}

.custom-card:hover {
	transform: translateY(-5px);
}

/* 이미지 스타일 */
.custom-card img {
	width: 100%;
	height: 220px; /* card Img 높이 조절 */
	object-fit: cover;
	border-radius: 15px;
}

/* 텍스트 부분 */
.custom-card-text {
	text-align: left;
	padding: 10px;
	/* 	background-color: #f5f5f5; */
	/* 	border-bottom-left-radius: 15px; */
	/* 	border-bottom-right-radius: 15px; */
}

.custom-card-text .card-title {
	font-size: 1rem;
	font-weight: 600;
	margin-bottom: 4px;
}

.custom-card-text .card-price {
	font-size: 0.95rem;
	color: #333;
}

.card-img-top {
	object-fit: cover; /* 이미지 비율 유지하면서 채우기 */
	margin-bottom: 15px;
}

/* wevers common*/
.pretty-sky {
	/*   background: linear-gradient(to bottom, #0b1f66 0%, #0d2cdb 100%); */
	background-image: url("/images/stardust.png"); /* 또는 custom star bg */
	color: white;
	position: relative;
	padding: 1.25rem;
	border-top-left-radius: 1rem;
	border-top-right-radius: 1rem;
	overflow: hidden;
	font-weight: bold;
}

.pretty-sky::before {
	content: "";
	position: absolute;
	width: 100%;
	height: 100%;
	background-image: /static/images/stradust.png; /* 또는 custom star bg */
	opacity: 0.2;
	z-index: 0;
}

.pretty-sky>* {
	position: relative;
	z-index: 1;
}

.btn {
	border: none !important;
}

</style>

</head>
<body>
	<%@ include file="../shopHeader.jsp" %>
	
	<!-- banner 영역 -->
	<div id="banner" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-indicators">
	  	<!-- carousl button 제어 status.index: 현재 List 번호 -->
	    <c:forEach varStatus="status" items="${bannerFileVOList}">
	    	<button type="button" data-bs-target="#banner" data-bs-slide-to="${status.index}" 
	    	  class="${status.index == 0 ? 'active' : ''}" aria-current="true" aria-label="Slide ${status.index}"></button>
	    </c:forEach>
	  </div>
	  
	  <div class="carousel-inner" style="background: #dee2e6;">
	    <!-- banner List 출력 -->
	    <c:set var="count" value="0"></c:set>
	    <c:forEach var="bannerFileVO" items="${bannerFileVOList}">
	      <c:forEach var="fileDetailVO" items="${bannerFileVO.fileGroupVO.fileDetailVOList}">
	        <!-- 캐러셀 시작 시간조정: data-bs-interval="1000" -->
	        <div class="carousel-item ${count == 0 ? 'active' : ''}">
	          <div class="row" style="background: #dee2e6;">
	            <!-- 하나의 col 안에 이미지 + 텍스트 정렬 -->
	             <div class="col-12 d-flex align-items-center">
	               <!-- 왼쪽: 이미지 -->
	               <img src="/upload${fileDetailVO.fileSaveLocate}" class="img-fluid" alt="banner image" />
	               <!-- 오른쪽: 텍스트 -->
	               <div>
	                 <c:choose>
					   <c:when test="${count == 0}">
					     <h2 class="fw-bold">2025 RIIZE WE LITTLE RIIZE</h2>
	                     <p>POP UP 2차 공식 상품 예약 판매</p>
					   </c:when>
					   <c:when test="${count == 1}">
					     <h2 class="fw-bold">2025 NCT WISH The 2nd Mini Album</h2>
	                     <p>[poppop] 공식 상품 예약 판매</p>
					   </c:when>
					   <c:when test="${count == 2}">
					     <h2 class="fw-bold">WOW MEMBERSHIP RENEWAL!</h2>
	                     <p>지금 바로 확인하세요</p>
					   </c:when>
					 </c:choose>
	               </div>
	            </div>
	          </div>
	        </div>
	        <c:set var="count" value="${count + 1}" />
	      </c:forEach>
	    </c:forEach>
	  </div> 
	  
	  <!-- pre Button -->
	  <button class="carousel-control-prev" type="button" data-bs-target="#banner" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		<span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#banner" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		<span class="visually-hidden">Next</span>
	  </button>
	</div>
  	
  	<p><p><p>
  	
	<!-- My Artist -->
	<!-- row: 수평 정렬 -->
	<div class="row d-flex justify-content-center">
	  <div class="col-8 rounded-shadow">
	    <!-- header 영역 -->
	    <div class="artist-title">
	      ${title}
	    </div>
	  	<div class="card-group">
	  	  
	   	  <!-- forEach 시작 -->
	      <div class="d-flex justify-content-start" id="artistTitle">
	        <c:forEach var="communityProfileVO" items="${communityProfileVOList}">
	          <!-- 수평 배치 -->
	          <div class="card artist-card">
	            <a href="/shop/artistGroup?artGroupNo=${communityProfileVO.artGroupNo}">
	              <img src="/upload${communityProfileVO.artistGroupVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" 
		   	        class="img-fluid artist-avatar" style="width: 100px; height: 100px; object-fit: cover;" alt="${communityProfileVO.artistGroupVO.fileGroupVO.fileDetailVOList[0].fileOriginalName}"/>
	            </a>
	            <div class="card-body text-center p-1">
	              <h5 class="card-title card-title-home multiline-ellipsis-line1 mt-3">${communityProfileVO.artistGroupVO.artGroupNm}</h5>
	            </div>
	          </div>
	        </c:forEach>
	      </div>
	    </div>
	    
	    <!-- Arist Page 영역 -->
	    <div class="d-flex justify-content-center">
	      <input type="hidden" id="totalPage" value="${totalPage}">
	      <button id="prev" type="button" value="${currentPage}" class="btn btn-sm disabled" style="background-color: white">&lt;</button>
	      <span id="currentPage" class="mx-3">${currentPage} / ${totalPage}</span>
	      <button id="next" type="button" value="${currentPage}" class="btn btn-sm" style="background-color: white">&gt;</button>
	    </div>
	  </div>
	</div>
  	
  	<p><p><p>
  	
  	<div class="d-flex justify-content-center">
	  <div class="col-8">
	    <div class="card rounded-shadow shadow-lg">
	      <!-- 🔹 카드 헤더 (탭 버튼 포함) -->
	      <div class="card-header p-0">
	        <ul class="nav nav-tabs d-flex w-100" id="myTab" role="tablist">
	          <li class="nav-item flex-fill text-center" role="presentation">
	            <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home"
	                    type="button" role="tab" aria-controls="home" aria-selected="true">
	              굿즈샵
	            </button>
	          </li>
	          <li class="nav-item flex-fill text-center" role="presentation">
	            <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile"
	                    type="button" role="tab" aria-controls="profile" aria-selected="false">
	              공연/예매티켓
	            </button>
	          </li>
	        </ul>
	      </div>
	
	      <!-- 카드 바디 (탭 콘텐츠 포함) -->
	      <div class="card-body">
	        <div class="tab-content" id="myTabContent">
	        
	        <!-- 굿즈샵 탭 -->
	        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			  <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
			    <div class="card">
			      <div class="card-header" style="background-color: #dee2e6;">
			        <!-- 그룹 헤더 -->
			        <div class="d-flex flex-column">
			          <a href="/shop/artistGroup?artGroupNo=${artistGroupVO.artGroupNo}">
					    <span class="header-badge mb-2">Now</span>
					    <h3 class="artist-groupName text-left">${artistGroupVO.artGroupNm}</h3>
					  </a>
					</div>
			      </div>
			      
			      <div class="card-body">
				    <div class="d-flex flex-wrap gap-3 pt-3">
			          <c:forEach var="goodsVO" items="${artistGroupVO.goodsVOList}">
			            <div class="custom-card">
			              <!-- 이미지 -->
			              <a href="/shop/artistGroup/${artistGroupVO.artGroupNo}/detail/${goodsVO.gdsNo}">
			                <c:choose>
			                  <c:when test="${ not empty goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
			                    <img class="card-img-top img-fluid" src="/upload/${goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" onerror=this.src='/images/noImage.png' alt="굿즈 이미지">
			                  </c:when>
			                  <c:otherwise>
			                    <img class="card-img-top img-fluid" src="/images/noImage.png" alt="이미지 없음">
			                  </c:otherwise>
			                </c:choose>
			              </a>
			              <!-- 텍스트 -->
						  <div class="custom-card-text">
						    <h5 class="card-title multiline-ellipsis-line1">${goodsVO.gdsNm}</h5><br>
						    <p class="card-price text-left">
						      ₩ <fmt:formatNumber value="${goodsVO.unitPrice}" pattern="#,###" />
						    </p>
						  </div>
			            </div>
			          </c:forEach>
			        </div>
			      </div>
			    </div>
			    </c:forEach>
	          </div>
			  
	          <!-- 공연/예매/티켓 탭 -->
	          <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
	           <%@ include file="ticketList.jsp" %>
	          </div>
	        </div>
	        
	        <!-- Weverse by Fans 영역 -->
	        <div class="card">
			  <div class="card-header pretty-sky">
			    <!-- 그룹 헤더 -->
			    <div class="d-flex flex-column">
				  <h4 class="text-left" style="color: white;">Weverse</h4>
				  <h5 class="text-left" style="color: white;">by Fans</h5>
				  <h6 class="text-left" style="color: white;">Make your own offcial merch!</h6>
				</div>
			  </div>
			  
			  <!-- card Body -->    
			  <div class="card-body">
			    <!-- button 영역 -->
	          	<c:forEach var="artistGroupVO" items="${topArtistsList}">
	          	  <button class="card-artistNm ${artistGroupVO.rnum == 1 ? 'active' : ''}" value="${artistGroupVO.artGroupNo}">${artistGroupVO.artGroupNm}</button>
	          	</c:forEach>
				
				<div class="d-flex flex-wrap gap-3 pt-3" id="topArtistList">
				  <!-- topArtist가 비어있을 때 처리 -->
				  <c:choose>
				    <c:when test="${empty topArtist}">
				      <!-- 텍스트 -->
					  <div class="custom-card-text">
					    <h5 class="card-title">해당 상품이 존재 하지 않습니다.</h5><br>
					  </div>
				    </c:when>
				    
				    <c:otherwise>
				      <c:forEach var="artistGroupVO" items="${topArtist}">
				        <c:forEach var="goodsVO" items="${artistGroupVO.goodsVOList}">
				          <div class="custom-card">
				            <!-- 이미지 -->
				            <a href="/shop/artistGroup/${artistGroupVO.artGroupNo}/detail/${goodsVO.gdsNo}">
				              <img class="card-img-top img-fluid" 
				                src="/upload/${goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" onerror=this.src="/images/noImage.png" alt="굿즈 이미지">
				            </a>
				            <!-- 텍스트 -->
					        <div class="custom-card-text">
					          <h5 class="card-title multiline-ellipsis-line1">${goodsVO.gdsNm}</h5><br>
						      <p class="card-price text-left">
						        ₩ <fmt:formatNumber value="${goodsVO.unitPrice}" pattern="#,###" />
						      </p>
					        </div>
				          </div>
				        </c:forEach>
				      </c:forEach>
				    </c:otherwise>
				  </c:choose>
			    </div>
			  </div>
			</div>
	      </div> <!-- 카드 바디 끝 -->
	    </div> <!-- 카드 끝 -->
	  </div>
	</div>
	<p><p><p>
		<%@ include file="../shopfooter.jsp" %>
		
	<!-- Scroll Top -->
	<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>	
</body>

<script type="text/javascript">
$('#prev').on('click', function(){
	let currentPage = $(this).val();
	--currentPage;
	artistPageList(currentPage);
})


$('#next').on('click', function(){
	let totalPage = $("#totalPage").val();
	let currentPage = $(this).val();
	
	if(currentPage != totalPage){
		++currentPage;
		artistPageList(currentPage);
	}
})

function artistPageList(currentPage){
	const datas = {
		"currentPage" : currentPage,
		"blockSize" : 9
	}
	

	fetch('/shop/communityProfileListPage', {
		method: "post",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		 body: JSON.stringify(datas)
	}).then( resp => {
		resp.json().then( (rslt) => {
			console.log(rslt);
			
			let str = "";
			rslt.map( (item, idx) => {
				str += 
					`<div class="card artist-card">
					   <a href="/shop/artistGroup?artGroupNo=\${item.artGroupNo}">
					     <img src="/upload\${item.artistGroupVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
					    	 class="img-fluid artist-avatar" style="width: 100px; height: 100px; object-fit: cover;" 
					    	   alt="\${item.artistGroupVO.fileGroupVO.fileDetailVOList[0].fileOriginalName}"/>
					   </a>
	            	   <div class="card-body text-center p-1">
	              	     <h5 class="card-title card-title-home multiline-ellipsis-line1 mt-3">\${item.artistGroupVO.artGroupNm}</h5>
	            	   </div>
	          	     </div>
	          	    `
		  })
		  
		  let totalPage = $("#totalPage").val();
		  $("#artistTitle").empty();
		  $("#artistTitle").append(str);
		  $("#prev").val(currentPage);
		  $("#next").val(currentPage);
		  $("#currentPage").text(currentPage + "/" + totalPage);
		  
		  if(currentPage == 1) {
			$('#prev').addClass('disabled');
		  }else{
			$('#prev').removeClass('disabled');  
		  }
		  
		  
		  if(currentPage == totalPage){
			$('#next').addClass('disabled');
		  }else{
			$('#next').removeClass('disabled');  
		  }
	   })
	})
}

$('.card-artistNm').on('click', function(){
	
	//기존 선택된 버튼의 active를 제거하고 선택된 버튼에 active 클래스 적용
	$('.card-artistNm.active').removeClass('active');
	$(this).addClass('active');
	
	let artGroupNo = $(this).val();
	
	console.log(artGroupNo);
	
	artistGroupVO = {
	  "artGroupNo" : artGroupNo
	}
	
	//topArtistAjax를 통해 선택된 그룹명의 상품리스트를 받고 화면에 출력 함.
	fetch('/shop/artistGroup/topArtistAjax', {
		method: "post",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		body: JSON.stringify(artistGroupVO)
	}).then( (resp) => {
		resp.json().then( (rslt) => {
			
			let topArtistList = document.getElementById("topArtistList");
			console.log("rslt[0] : " + rslt);
			
			if(rslt != ''){
				let goodsVOList = rslt[0].goodsVOList;
				
				let cardList = goodsVOList.map( (item, idx) => {
					console.log("item : " , item);
					
					return `<div class="custom-card">
					 		  <a href="/shop/artistGroup/\${rslt[0].artGroupNo}/detail/\${item.gdsNo}">
							    <img class="card-img-top img-fluid" 
			          		     src="/upload/\${item.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" onerror=this.src='/images/noImage.png' alt="굿즈 이미지">
			          		  </a>
							  <div class="custom-card-text">
							    <h5 class="card-title multiline-ellipsis-line1">\${item.gdsNm}</h5><br>
							    <p class="card-price text-left">
							      ₩ \${item.unitPrice.toLocaleString()}
							  </p>
							  </div>
							</div>
					      `
				})
				
				let str= "";
				cardList.forEach( ( card ) => {
					str += card;
				})
				
				console.log("str : " + str);
				topArtistList.innerHTML = str;
			}
			else{
				let str= "";
				str += `<div class="custom-card-text">
				    	  <h5 class="card-title">해당 상품이 존재 하지 않습니다.</h5><br>
				  		</div>`
				  		
				console.log("str : " + str);
				topArtistList.innerHTML = str;
			}
		})
	})
})

</script>
</html>