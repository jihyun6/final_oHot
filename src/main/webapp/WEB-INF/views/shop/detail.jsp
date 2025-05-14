<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<link rel="stylesheet" href="/shop/main.css" />
<link>
<title>oHoT Shop</title>
</head>

<body>
 <!-- wrapper 시작 -->
 <div class="wrapper">
 <%@ include file="../shopHeader.jsp" %>
  
  <!-- ✅ content 시작 -->
  <div class="content">
    <!-- 상품 상세 페이지 메인 컨테이너 -->
    <div class="d-flex justify-content-center m-3">
      <div class="card card-detail col-8">
        <div class="card-body">
          <div class="row">
            <!-- [좌측] 상품 이미지 영역 -->
            <div class="col-12 col-sm-6">
              <!-- 대표 상품 이미지 -->
              <c:choose>
	            <c:when test="${ not empty goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
	              <img src="/upload${goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" 
	                class="product-image" alt="Product Thumbnail" onerror=this.src='/images/noImage.png'>
	            </c:when>
	            <c:otherwise>
	              <img class="product-image" src="/images/noImage.png" alt="Card image cap">
	            </c:otherwise>
	          </c:choose>
            
              <!-- 상품 썸네일 리스트 -->
              <div class="col-12 product-image-thumbs justify-content-center">
			    <c:if test="${ not empty goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
			      <c:forEach var="i" begin="0" end="${goodsVO.fileGroupVO.fileDetailVOList.size()-1}" step="1">
		            <div class="product-image-thumb">
		              <img src="/upload${goodsVO.fileGroupVO.fileDetailVOList[i].fileSaveLocate}" onerror=this.src='/images/noImage.png' alt="Product Image">
		            </div>
           	      </c:forEach>
			    </c:if>
              </div>
            </div>
          	<!-- [좌측] 상품 이미지 영역 종료 -->
              
            <!-- [우측] 상품 정보 및 주문 영역 -->
            <div class="col-12 col-sm-6">
          	  <form class="col-10" action="/shop/ordersPost" id="goodsForm" method="post">
          	    <input type="hidden" name="goodsVOList[0].gdsNo" value="${goodsVO.gdsNo}" />
              	<input type="hidden" name="goodsVOList[0].gdsNm" value="${goodsVO.gdsNm}" />
                <input type="hidden" name="goodsVOList[0].unitPrice" value="${goodsVO.unitPrice}" />
                <input type="hidden" name="goodsVOList[0].amount" value="${goodsVO.amount}" />
                <input type="hidden" name="goodsVOList[0].gramt" value="${goodsVO.gramt}" />
          	    <input type="hidden" name="goodsVOList[0].fileSavePath" value="${goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />	
          	    <input type="hidden" name="goodsVOList[0].artGroupNo" value="${goodsVO.artGroupNo}" />
          	    <input type="hidden" name="goodsVOList[0].gdsType" value="${goodsVO.gdsType}" />
          	  
                <!-- 아티스트 그룹명 & 상품명 -->
            	<h6 class="artGroupNm-detail">${goodsVO.artGroupNm}</h6>
            	<p>${goodsVO.gdsNm}</p>
            	  
            	<!-- 가격 정보 -->
            	<span class="unitPrice-detail">₩<fmt:formatNumber value="${goodsVO.unitPrice}" pattern="#,###" /></span>
            	<p><p><p>
   		 		  
   		 		<!-- 사이즈 선택 (상품에 사이즈 옵션이 있을 경우만 노출) -->
            	<c:choose>
	            <c:when test="${goodsVO.commCodeGrpNo==null}">
	              <input type="hidden" name="goodsVOList[0].commCodeGrpNo" autocomplete="off" value="X">
	            </c:when>
	              <c:otherwise>
	                <span>Option</span>
	          	    <c:forEach var="commonDetailCodeVO" items="${commonCodeGroupVO.commonDetailCodeVOList}" varStatus="stat">
		       	      <div class="btn-group btn-group-toggle size" data-toggle="buttons">
		          	    <label class="btn btn-default text-center">
		                  <input type="radio" name="goodsVOList[0].commCodeGrpNo" autocomplete="off" value="${commonDetailCodeVO.commDetCodeNm}">
		                  <span>${commonDetailCodeVO.commDetCodeNm}</span>
		          	    </label>
		        	  </div>
	          	    </c:forEach>
	              </c:otherwise>
	            </c:choose>
	            <!-- 사이즈 선택 영역 종료 -->
                <!-- 수량 선택 영역 -->
                <div class="border mt-3 p-3 rounded">
              	  <span class="fw-bold">수량</span>
              	  <div class="d-flex align-items-center justify-content-between mt-2">
                    <div class="input-group" style="width: 120px;">
                      <button class="btn btn-light border disabled"  name="btn" type="button" onclick="changeQty(-1)" id="subBtn">-</button>
                      <input type="text" class="form-control text-center" id="quantity" name="goodsVOList[0].qty" onkeyup="changeQtyOn(this)" oninput="fn_numberCheck(this)" value="1">
                      <button class="btn btn-light border" type="button" name="btn" onclick="changeQty(1)" id="addBtn">+</button>
                    </div>
                    <span class="fw-bold text-dark" id="amount"></span>
                  </div>
                </div>
            	<!-- 수량 선택 영역 종료 -->
            	
            	<!-- 장바구니 & 구매 버튼 -->
	            <div class="d-flex justify-content-center mt-4 gap-3">
	              <c:if test="${goodsVO.gdsType != 'M'}">
	                <button class="btn-add-to-cart" name="btn" id="cartAdd" type="button">장바구니 추가</button>
	              </c:if>
	              <button class="btn-buy-now" name="btn" type="submit">구매하기</button>
	            </div>
              </form> <!-- form 영역 종료 -->
            </div> <!-- 우측 영역 종료 -->
          </div> <!-- row 영역 종료 -->
        </div> <!-- card body 영역 종료 -->
      </div> <!-- card 영역 종료 -->
    </div> <!-- 메인 컨테이너 영역 종료 -->
  </div> <!-- content 영역 종료 -->
  
  <%@ include file="../shopfooter.jsp" %>
  </div>  <!-- wrapper 영역 종료 -->
</body>

<!-- JS 영역 -->
<script>
$(function(){
  //상품 값 계산하기
  let unitPrice = ${goodsVO.unitPrice};
  $("#amount").text("₩" + unitPrice.toLocaleString());
  $("input[name='goodsVOList[0].amount']").val(unitPrice);
  $("input[name='goodsVOList[0].gramt']").val(unitPrice);
	
  //상품 썸네일 선택 이벤트
  $('.product-image-thumb').eq(0).addClass('active-thumb');
	
  //옵션 기본 선택
  $('.btn-group-toggle').eq(0).addClass('size-active');
  $("input[type='radio']").eq(0).prop('checked', true);
  
  
  let gdsType = $("input[name='goodsVOList[0].gdsType']");
  
  if(gdsType.val() == "M") {
	  $("#quantity").prop("readonly", true);
	  $("#subBtn").prop("disabled", true);
	  $("#addBtn").prop("disabled", true);
  }
})

// 상품 썸네일 이미지를 클릭했을 때 발생하는 이벤트
$('.product-image-thumb').on('click', function(){
  // 클릭된 썸네일 이미지 요소
  let $thumbnailImage = $(this).find('img');

  // 썸네일 이미지의 src 경로 가져오기
  let thumbnailSrc = $thumbnailImage.attr('src');

  // 대표 이미지의 src를 클릭한 썸네일 이미지의 src로 변경
  $('.product-image').prop('src', thumbnailSrc);
	    
  // 이미 활성화된 썸네일에서 active-thumb 클래스 제거
  $('.product-image-thumb.active-thumb').removeClass('active-thumb');

  // 클릭된 썸네일에 active 클래스 추가
  $(this).addClass('active-thumb');
});

//상품 사이즈를 클릭했을 때 발생하는 이벤트
$('.btn-group.btn-group-toggle').on('click', function(){
  // 이미 활성화된 썸네일에서 active-thumb 클래스 제거
  $('.btn-group.btn-group-toggle.size-active').removeClass('size-active');
  // 클릭된 썸네일에 active 클래스 추가
  $(this).addClass('size-active');
});

//장바구니에 상품을 추가하는 함수
$("#cartAdd").on('click', function() {
  fetch("/shop/cart/addAjax", {
    method: "post",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: $("#goodsForm").serialize()
  }).then(resp => {  // return: nologin, success, fail
    resp.text().then((rslt) => {
      if (rslt == "noLogin") {
        alert("로그인 후 이용해주세요!");
        return;
      }
      else if(rslt == "success") {
      	Swal.fire({
    		title: "<strong>장바구니 추가 완료!</strong>",
    		icon: "success",
    		showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
    		confirmButtonText: '장바구니 보기', // confirm 버튼 텍스트 지정
    		cancelButtonText: '계속 쇼핑하기', // cancel 버튼 텍스트 지정
    	}).then( (result) => {
    		if(result.isConfirmed){	//confirm 버튼 선택
    			location.href = "/shop/cart/list";
    		}
    	})
      }
      else if(rslt == "fail") {
        Swal.fire({
      		title: "장바구니 추가 실패!",
      		icon: "error"
      	})
      }
      
      else {
    	  Swal.fire({
        		title: "구매가능 수량을 초과했습니다.\n 잔여수량" + rslt,
        		icon: "error"
        	})
      }
    })
  })
});

const changeQtyOn = ( item ) => {
	let qty = $(item).val();
	changeQty(0);
}

//수량 변경 함수
const changeQty = (qty) => {
  // 현재 수량 가져오기
  let currentQuantity = parseInt($("#quantity").val());
  
  if(!currentQuantity || currentQuantity > 100) {
	  alert("잘못된 값을 입력했습니다. 최대수량은 100개 입니다.");
	  currentQuantity = 1;
  }
  
  //버튼 클릭에 따라 수량 변경
  currentQuantity += qty;
  
  console.log("currentQuantity : ", currentQuantity);
  
  // 변경된 수량을 input 필드에 반영
  $("#quantity").val(currentQuantity);

  // 수량이 1일 경우 - 감소 버튼 비활성화
  if (currentQuantity === 1) {
    $("#subBtn").addClass("disabled");
  } else {
	$("#subBtn").removeClass("disabled");
  }
	
  // 가격 계산하기
  let amount = currentQuantity * ${goodsVO.unitPrice};
	
  //가격 저장하기
  $("input[name='goodsVOList[0].amount']").val(amount);
  $("input[name='goodsVOList[0].gramt']").val(amount);
	
  // 가격을 세자리마다 쉼표 추가하여 포맷팅
  amount = amount.toLocaleString();

  // 가격을 화면에 반영
  $("#amount").text("₩" + amount);
}

/* ordersPostAjax: 미사용 코드(참조용) */
function ordersPostAjax(event) {
	
	event.preventDefault();
	
	console.log("ordersPostAjax");
	
	let elems =  $("#goodsForm")[0].elements;
	let goodsVOList = [];
	let goodsVO = {};
	
	let str = "";
	
	for(let i=0; i<elems.length; i++){
		let elem = elems[i];
		if(elem.type=="button" || elem.type=="submit" || elem.type=="radio" ) continue;
		//console.log("체킁:",elem,"타입" ,elem.type, "이름" ,elem.name, "값" ,elem.value);
		goodsVO[elem.name]=elem.value;
		
	}
	
	goodsVOList.push(goodsVO);
	
	
	fetch("/shop/ordersPostAiax" , {
		method: "post",
		headers: {
        	"Content-Type": "application/json;charset=UTF-8",
      	},
		body: JSON.stringify(data)
	}).then( resp => {
		resp.json().then( (rslt)=>{
			console.log(rslt);
			$("#goodsForm")[0].submit();
		})
	})
}

function fn_numberCheck( item ){
	
	console.log(event.currentTarget);	//이벤트 리스너가 연결된 요소
	console.log(event.target);	//이벤트를 트리거한 요소
	
	let regex = /^[0-9]+$/g		//
	let result = regex.test($(item).val());
	
	if(!result){
		let str = $(item).val();
		str = str.replace(/[^0-9]/g, '');
		$(item).val(str);
	}	
}

</script> 

</html>
