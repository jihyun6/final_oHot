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
<title>oHoT Shop</title>
<style type="text/css">
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
	height: 280px; /* card Img 높이 조절 */
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

/* 아티스트 그룹명 */
.artist-Procuct {
	font-size: 20px;
	font-weight: bold;
	/* color: #333; */
}

.multiline-ellipsis {
	display: -webkit-box; /* 플렉스박스처럼 동작하게 만듦 (세로 방향으로) */
	-webkit-line-clamp: 2;  /* 몇 줄까지 보이게 할지 설정 (여기선 2줄) */
	-webkit-box-orient: vertical;  /* 위에서 지정한 줄 수만큼 박스를 세로로 제한함 */
	overflow: hidden; /* 넘치는 텍스트는 숨김 처리 */
	text-overflow: ellipsis;  /* 넘치는 부분은 말줄임표(...)로 표시 */
}

.carousel-inner img {
	margin: 10px 20px 10px 0px;
	object-fit: cover; /* 이미지를 부모 요소 크기에 맞추어 비율 유지 */
}

.aNotice {
  color: black !important;
  text-decoration: none;
  transition: 0.3s;
}

</style>


</head>
<body>
  <!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../shopHeader.jsp" %>
    
    <!-- ✅ content 시작 -->
    <div class="content">
      <div class="container">
        <div class="row d-flex justify-content-center mt-3">
      	  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		    <div class="carousel-indicators">
		      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    </div>
		    
  			<div class="carousel-inner">
		      <div class="carousel-item active">
		      	<div class="d-flex">
		          <img src="/images/banner4.png" class="w-50 h-100" alt="">
		          <img src="/images/banner5.png" class="w-50 h-100" alt="">
		        </div>
		      </div>
		    </div>
<!--   			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev"> -->
<!--     		  <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->
<!--     		  <span class="visually-hidden">Previous</span> -->
<!--   			</button> -->
<!--   			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next"> -->
<!--     		  <span class="carousel-control-next-icon" aria-hidden="true"></span> -->
<!--     		  <span class="visually-hidden">Next</span> -->
<!--   			</button> -->
		  </div>
    
	      <!-- 왼쪽 영역 -->    
          <div class="col-12 col-sm-9 ps-0 mt-3">
            <!-- 주문상품 -->
            <div class="card card-container" >	
              <div class="card-header card-header-container">
                <h4 class="artist-Procuct text-left p-3">Products</h4>
              </div>
              <div class="card-body card-body-container" style="min-height: 370px;">
                <!-- button 영역 -->
                <div style="padding-left: 16px;">
                  <button class="card-artistNm active" value="">ALL</button>
                  <input type="hidden" name="artGroupNo" id="artGroupNo" value="${artistGroupVOList[0].artGroupNo}" />
				  <c:forEach var="commonCodeGroupVO" items="${commonCodeGroupVOGdsType.commonDetailCodeVOList}">
			        <c:choose>
		              <c:when test="${commonCodeGroupVO.commDetCodeNm == 'G'}">
		                <button class="card-artistNm" value="${commonCodeGroupVO.commDetCodeNm}">Goods</button>
		              </c:when>
		              <c:when test="${commonCodeGroupVO.commDetCodeNm == 'A'}">
		                <button class="card-artistNm" value="${commonCodeGroupVO.commDetCodeNm}">ALBUM</button>
		              </c:when>
		              <c:when test="${commonCodeGroupVO.commDetCodeNm == 'M'}">
		                <button class="card-artistNm" value="${commonCodeGroupVO.commDetCodeNm}">MEMBERSHIP</button>
		              </c:when>
		              <c:when test="${commonCodeGroupVO.commDetCodeNm == 'GD02'}">
		                <button class="card-artistNm" value="${commonCodeGroupVO.commDetCodeNm}">TICKET</button>
		              </c:when>
		            </c:choose>	
				  </c:forEach>
                </div>
                
                <c:choose>
                  <c:when test="${ empty artistGroupVOList}">
                    <div class="card card-header-container-cart" style="min-height: 300px;">
			          <div class="card-body d-flex justify-content-center align-items-center">
			            <div class="d-flex flex-wrap gap-3 pt-3">
			        	  <h5>상품 목록이 존재하지 않습니다.</h5>
			        	</div>
			          </div>
			    	</div>
                  </c:when>
				  
				  <c:otherwise>
			        <div class="card card-header-container-cart" style="min-height: 300px;" id="artistGroupContainer">
				      <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
			            <div class="card-body">
				          <div class="d-flex flex-wrap gap-3 pt-3" id="productList">
			                <c:forEach var="goodsVO" items="${goodsList}">
			                  <div class="custom-card">
			                     <!-- 상품이 티켓일 경우 -->
								<c:choose>
									<c:when test="${goodsVO.commCodeGrpNo eq 'GD02'}">
										<a href="/shop/ticket/ticketDetail?gdsNo=${goodsVO.gdsNo}">
											<c:choose>
												<c:when test="${ not empty goodsVO.ticketVO.tkFileSaveLocate}">
													
												<img class="card-img-top img-fluid" src="/upload${goodsVO.ticketVO.tkFileSaveLocate}" 
												  onerror=this.src='/images/noImage.png' alt="포스터 이미지">
												</c:when>
												<c:otherwise>
												<img class="card-img-top img-fluid" src="/images/noImage.png" alt="이미지 없음">
												</c:otherwise>
											</c:choose>
										</a>
									</c:when>
									<c:otherwise>
										<!-- 이미지 -->
										<a href="/shop/artistGroup/${goodsVO.artGroupNo}/detail/${goodsVO.gdsNo}">
											<c:choose>
											<c:when test="${ not empty goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
												<img class="card-img-top img-fluid" src="/upload/${goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" 
												  onerror=this.src='/images/noImage.png' alt="굿즈 이미지">
											</c:when>
											<c:otherwise>
												<img class="card-img-top img-fluid" src="/images/noImage.png" alt="이미지 없음">
											</c:otherwise>
											</c:choose>
										</a>
									</c:otherwise>
								</c:choose>
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
			          </c:forEach>
			        </div>
				  </c:otherwise>
                </c:choose>
                </div>
              </div> 
            </div>   
              
            <!-- 우측영역 영역 -->
            <div class="col-12 col-sm-3 ps-0 mt-3">
              <div class="card card-container">
                <div class="d-flex justify-content-between align-items-center">
                  <h4 class="artist-Procuct text-left pt-3 ps-3">Notice</h4>
                  <a href="/oho/community/notice?artGroupNo=${artistGroupVOList[0].artGroupNo}" class="text-right pt-3 pe-3 aNotice" style="">
                    <span>더보기</span>
                  </a>
                </div>
                <div class="card-body">
                   <!-- Notice -->
                   <c:if test="${empty recentNoticeList}">
          	  	     <div class="card mb-3">
			           <div class="card-body">
			             <div>
          	  	  	       <span class="multiline-ellipsis1">등록된 공지사항이 없습니다.</span>
			             </div>
          	  	  	   </div>
          	  		 </div>              
                   </c:if>
                  
                   <a href="/oho/community/notice?artGroupNo=${artistGroupVOList[0].artGroupNo}">
            	     <c:forEach var="ArtistGroupNoticeVO" items="${recentNoticeList}">
            	       <div class="card mb-3">
          	  		     <div class="card-body">
          	  	  	       <span class="multiline-ellipsis">${ArtistGroupNoticeVO.bbsTitle}</span>
          	  	  		   <span style="font-size: 13px;">${ArtistGroupNoticeVO.bbsRegDt2}</span>
          	  		     </div>
          	  	      </div>
            	    </c:forEach>
            	  </a>
            	</div>
              </div>
              
              <!-- Notice -->
              <div class="card card-container">
                <h4 class="artist-Procuct text-left pt-3 ps-3">Event</h4>
                <div class="card-body">
            	  <div class="card mb-3">
            	  	<div class="card-body">
            	  	  <span class="multiline-ellipsis">[Weverse Global] 2025 LE SSERAFIM TOUR 'EASY CRAZY HOT' 공식 상품 2차 예약 판매 안내</span>
            	  	  <span style="font-size: 13px;">2025.01.01</span>
            	  	</div>
            	  </div>
            	  <div class="card mb-3">
            	  	<div class="card-body">
            	  		<span class="multiline-ellipsis">[Weverse Global] 2025 LE SSERAFIM TOUR 'EASY CRAZY HOT' 공식 상품 2차 예약 판매 안내</span>
            	  		<span style="font-size: 13px;">2025.01.01</span>
            	  	</div>
            	  </div>
            	  <div class="card mb-3">
            	  	<div class="card-body">
            	  		<span class="multiline-ellipsis">[Weverse Global] 2025 LE SSERAFIM TOUR 'EASY CRAZY HOT' 공식 상품 2차 예약 판매 안내</span>
            	  		<span style="font-size: 13px;">2025.01.01</span>
            	  	</div>
            	  </div>
            	</div>
              </div>
          </div>    
		</div>
	  </div>
	</div>
  </div>
    
  <%@ include file="../shopfooter.jsp" %>
</body>

<script type="text/javascript">
$(function(){
	
	let shopArtGroup = document.getElementById('shopArtGroup')
	
	let optionList = shopArtGroup.querySelectorAll('option');
	let artGroupNo = document.getElementById("artGroupNo");
	
	console.log(artGroupNo);
	
	let optionListArr = Array.from(optionList);
	
	optionListArr.forEach( (item, idx) => {
		if(item.value == artGroupNo.value) {
			item.setAttribute("selected", "selected");
			return;
		}
	})
})

$('.card-artistNm').on('click', function(){
	
	//기존 선택된 버튼의 active를 제거하고 선택된 버튼에 active 클래스 적용
	$('.card-artistNm.active').removeClass('active');
	$(this).addClass('active');
	
	let gdsType = $(this).val();
	let artGroupNo = $("#artGroupNo").val();
	
	console.log(artGroupNo);
	
	GoodsVO = {
	  "artGroupNo" : artGroupNo,
	  "gdsType" : gdsType
	}
	
	//topArtistAjax를 통해 선택된 그룹명의 상품리스트를 받고 화면에 출력 함.
	fetch('/shop/artistGroup/gdsTypeAjax', {
		
		method: "post",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		body: JSON.stringify(GoodsVO)
	}).then( (resp) => {
		resp.json().then( (rslt) => {
			console.log("rslt : " , rslt);
			console.log("rslt[0] : ", rslt[0]);
			let productList = document.getElementById("productList");
			
			console.log(rslt.length);
			
			if(rslt.length > 0){
				let cardList = rslt.map( (item, idx) => {
					console.log("item : " , item);
					
					 if(item.commCodeGrpNo == "GD02"){
						 return `<div class="custom-card">
				 		  <a href="/shop/ticket/ticketDetail?gdsNo=\${item.gdsNo}">
						    <img class="card-img-top img-fluid" 
		          		     src="/upload/\${item.ticketVO.tkFileSaveLocate}" onerror=this.src='/images/noImage.png' alt="굿즈 이미지">
		          		  </a>
						  <div class="custom-card-text">
						    <h5 class="card-title multiline-ellipsis-line1">\${item.gdsNm}</h5><br>
						    <p class="card-price text-left">
						      ₩ \${item.unitPrice.toLocaleString()}
						  </p>
						  </div>
						</div>
				      `
					 } 
					 
					 else{
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
					}
				})
				
				let str= "";
				cardList.forEach( ( card ) => {
					str += card;
				})
				
				console.log("str : " + str);
				productList.innerHTML = str;
				
			}
			
			else {
				let str= `
				<div class="card card-header-container-cart" style="min-height: 300px;">
		          <div class="card-body d-flex justify-content-center align-items-center">
		        	<h5>상품 목록이 존재하지 않습니다.</h5>
		          </div>
		    	</div>`
		    	
				console.log("str : " + str);
		    	let productList = document.getElementById("productList");
		    	productList.innerHTML = str;
		    	
			}
		})
	})
})
</script>   


</html>