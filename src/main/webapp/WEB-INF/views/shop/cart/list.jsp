<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<link href="/bootstrap-5.3.3-dist/icon/bootstrap-icons.css" rel="stylesheet">
<title>oHoT Shop</title>
</head>
<style type="text/css">
/* 수량 조정 영역 스타일 */
.input-group input[type="button"] {
  width: 40px;
}

.input-group input[type="text"] {
  width: 60px;
}
</style>

<body>
  
  <!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../../shopHeader.jsp" %>
    
    <!-- ✅ content 시작 -->
    <div class="content">
	  <!-- Title -->
      <div class="container">
        <div class="card card-container-cart-title col-12">
          <h3 class="mt-5">장바구니</h3>
        </div>
      </div>
	
	  <div class="container">
	    <div class="card card-container col-12">
	      <c:if test="${ empty cartList}">
	        <div class="card-body d-flex justify-content-center align-items-center" style="min-height: 500px;">
	          장바구니에 담긴 상품이 없습니다.
	        </div>
	      </c:if>
	      
	      <c:if test="${ not empty cartList}">
	      <!-- card-header -->
          <div class="card-header card-header-container-cart border-bottom">
	        <div class="d-flex justify-content-between align-items-center">
		    <span><input class="form-check-input me-2" type="checkbox" id="selAll" checked>전체</span>
		    <input type="button" value="삭제" class="btn btn-outline-danger btn-sm" id="delBtn">
		  	</div>
    	  </div>
		  
		  <form action="/shop/ordersPost" id="goodsForm" method="post" onsubmit="fn_submit()">
		  <!-- card-body -->
          <c:set var="gramt" value="0"/>
		  <!-- 장바구니 List 출력 시작 -->
		  <input type="hidden" name="goodsVOList[0].gramt" value="" />
		  <!-- status: 상태변수 count: 1부터 시작 index: 0부터 시작 -->
		  <c:forEach var="cartVO" items="${cartList}" varStatus="status" step="1">
		    <!-- 총 합계 구하기 -->
		    <c:set var="gramt" value="${gramt + cartVO.amount}" />
			 <div class="card-body border-bottom">
			   <input type="hidden" name="goodsVOList[${status.index}].gdsNo" value="${cartVO.gdsNo}" />
               <input type="hidden" name="goodsVOList[${status.index}].unitPrice" value="${cartVO.goodsVO.unitPrice}" />
               <input type="hidden" name="goodsVOList[${status.index}].amount" value="${cartVO.amount}" />
               <input type="hidden" name="goodsVOList[${status.index}].fileSavePath" value="${cartVO.goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />
               <input type="hidden" name="goodsVOList[${status.index}].commCodeGrpNo" value="${cartVO.prodOption}" />
               <input type="hidden" name="goodsVOList[${status.index}].gdsNm" value="${cartVO.goodsVO.gdsNm}" />
               <input type="hidden" name="goodsVOList[${status.index}].gramt" value="${cartVO.goodsVO.gramt}" />
			   <div class="d-flex justify-content-between align-items-center p-3">
			     <!-- 왼쪽: 체크박스 + 이미지 + 제품 정보 -->
		         <div class="d-flex align-items-center">
		           <input class="form-check-input me-3" type="checkbox" checked>
		           <img src="/upload/${cartVO.goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" 
		             class="img-thumbnail" style="width: 180px; height: 200px;" alt="상품이미지">
		           <div class="ms-5">
		             <div class="fw-bold" style="font-size: 20px;">${cartVO.goodsVO.gdsNm}</div>
		             
		             <!-- 수량영역 -->
		             <div class="border mt-3 p-3 rounded" style="width: 400px;">
              	       <c:choose>
					     <c:when test="${cartVO.prodOption != 'X'}">
					       <span>${cartVO.prodOption}</span>
						 </c:when>
						 <c:otherwise>
						   <span class="fw-bold">수량</span>
						 </c:otherwise>
					   </c:choose>
              	       
                       <div class="input-group mt-2" style="width: 130px;">
		                 <button type="button" class="btn btn-light border ${cartVO.qty == 1 ? 'disabled' : '' }" >-</button>
		                 <input type="text" name="goodsVOList[${status.index}].qty" class="form-control text-center" value="${cartVO.qty}" 
		                 	onkeyup="changeQtyOn(this)" oninput="fn_numberCheck(this)">
		                 <button type="button" class="btn btn-light border">+</button>
		               </div>
                     </div>
		           </div>
		         </div>
			   
				 <!-- 오른쪽: 금액 + X버튼 -->
		         <div class="d-flex flex-column align-items-end">
		           <div class="fw-bold mb-2">
		             <span id="amount" name="ddd">₩<fmt:formatNumber value="${cartVO.amount}" pattern="#,###" /></span>
		             <!-- X자 표시 영역 -->
		             <button type="button" class="btn btn-link close-btn p-0">
		               <i class="bi bi-x fs-4"></i>
		              </button>
		           </div>
		         </div>
			   </div>
			 </div>
          </c:forEach>
          
          <!-- card-footer -->
          <div class="card-footer bg-white border-0">
		    <div class="d-flex justify-content-between align-items-center px-3 py-2">
		      <div class="fw-bold">
		        <span id="gramt">총 ₩<fmt:formatNumber value="${gramt}" pattern="#,###" />원</span>
		      </div>
		      <button class="btn btn-primary" type="submit" id="paymentBtn">${cartList.size()}개 상품 결제 진행</button>
		    </div>
		  </div>
		  </form>
		  </c:if>
        </div>
      </div>
    </div><!-- ✅ content 끝 -->

    <%@ include file="../../shopfooter.jsp" %>
  </div>
</body>

<script type="text/javascript">

function fn_submit() {

	event.preventDefault();
	
	//check개수 세기
	let $cardBody = $('.card-body');
	
	$cardBody.map( (idx, item) => {
		if(!$(item).find("input[type='checkbox']").prop("checked")){
			$(item).remove();
		}
	})
	
	//item index 설정
	let cnt = 0;
	let $cardBody2 = $('.card-body');
	$cardBody2.map( (idx, item) => {
		let itemList = $(item).find("input[type='hidden']");
		itemList.map( (idx, item) => {
			let name = $(item).attr('name');
			let nameSplit = name.split('.');
			let str = `goodsVOList[\${cnt}].\${nameSplit[1]}`;			
			$(item).prop('name', str);
			//console.log(item);
		})
		
		cnt++;
	})
	
	cnt = 0;
	$cardBody2.map( (idx, item) => {
		let itemList = $(item).find("input[type='text']");
		itemList.map( (idx, item) => {
			let name = $(item).attr('name');
			let nameSplit = name.split('.');
			let str = `goodsVOList[\${cnt}].\${nameSplit[1]}`;			
			$(item).prop('name', str);
			console.log(item);
		})
		cnt++;
	})
	
	gramtPrice();
	console.log($("#goodsForm")[0]);
	
	$("#goodsForm")[0].submit();
	
}


$(function(){
	init();
	gramtPrice();
})

function init() {
	const formData = new FormData($("#goodsForm")[0]);
	for(const key of formData.keys()){
		if(key.includes("qty")){
			let qtyCheck = $(`input[name="\${key}"]`);
			if(qtyCheck.val() > 100) {
				changeQty(qtyCheck, 0);
			}
		}
	}
}

/* 전체 체크 박스 버튼 이벤트 */
$('#selAll').on('click', function(){
	let $cardBody = $('.card-body');
	
	$cardBody.map( (idx, item) => {
		$(item).find("input[type='checkbox']").prop('checked', $(this).prop("checked"));
	})
	
	gramtPrice();
})

/* 개별 체크 박스 버튼 이벤트 */
$(".card-body input[type='checkbox'").on('click', function(){
	
	let cnt = 0;
	
	//check개수 세기
	let $cardBody = $('.card-body');
	
	$cardBody.map( (idx, item) => {
		if($(item).find("input[type='checkbox']").prop("checked")){
			cnt++;
		}
	})
	
	if(cnt == $cardBody.length){
		$('#selAll').prop("checked",true);
	}else{
		$('#selAll').prop("checked",false);
	}
	
	gramtPrice();
	$('#paymentBtn').text(cnt + '개 상품 결제 진행');
})

/* 삭제버튼 */
$('#delBtn').on('click', function(){
	
	gdsNoList = [];
	
	//check가 되어있는 항목을 가져옵니다.
	let $cardBody = $('.card-body');
	
	$cardBody.map( (idx, item) => {
		let status = $(item).find("input[type='checkbox']").prop('checked');
		
		//상품 번호 가져오기
		let gdsNo = $(item).find('input').eq(0).val();
		let prodOption = $(item).find('input').eq(4).val();
		
		goodsVO = {
			"gdsNo" : gdsNo,
			"commCodeGrpNo" : prodOption,
		}
		
		//체크가 되어있다면..
		if(status){
			gdsNoList.push(goodsVO);
		}
	})
	
	console.log(gdsNoList);
	
	fetch('/shop/cart/deleteList', {
		method: "post",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		body: JSON.stringify(gdsNoList)
	}).then( (resp) => {
		resp.text().then( (rslt) => {
			console.log(rslt);
			
			if(rslt == "success") {
				location.reload();
				//location.reaplce(location.href);
				/*
				$(this).closest('.card-body').remove();
				gramtPrice();
				$('#paymentBtn').text($('.card-body').length + '개 상품 결제 진행');
				*/
			}else {
				alert("상품 삭제를 실패했습니다.");
				gramtPrice();
			}
		})
	})
})

/* 수량 버튼을 눌렀을 때 발생되는 함수 */
$('.btn.btn-light.border').on('click', function(){
	
	//선택한 버튼에서 수량 태그 및 선택된 버튼이 operator 값 가져오기
	let $quantity = $(this).closest('div').find('input');
	let op = $(this).text();
	
	//수량 증가
	if(op === '+'){
		changeQty($quantity, 1);
	}
	
	//수량 감소
	else if(op === '-'){
		changeQty($quantity, -1);
	}
});

const changeQtyOn = ( item ) => {
	changeQty($(item), 0);
}

//수량 변경 함수
const changeQty = ($quantity, qty) => {
	//현재 수량 가져오기
	let currentQuantity = parseInt($quantity.val());
	
	//클릭한 버튼값에 따라 수량변경
	currentQuantity += qty;
	
	if(!currentQuantity || currentQuantity > 100) {
		alert("잘못된 값을 입력했습니다. 최대수량은 100개 입니다.");
		currentQuantity = 1;
	}
	
	//변경된 수량을 input 필드에 반영
	$quantity.val(currentQuantity);
	
	// 수량이 1일 경우 - 감소 버튼 비활성화
	if (currentQuantity === 1) {
		$quantity.prev().addClass("disabled");
	} else {
		$quantity.prev().removeClass("disabled");
	}
	
	//현재 상품의 단가를 조회
	let unitPrice = $quantity.closest('.card-body').find('input').eq(1).val();
	
	//가격 계산하기
	let amount = unitPrice * currentQuantity;
	
	//상품 가격 넣기
	$quantity.closest('.card-body').find('input').eq(2).val(amount);
	
	// 가격을 세자리마다 쉼표 추가하여 포맷팅
	amount = amount.toLocaleString();
	
	$quantity.closest('.card-body').find('i').closest('div').find('span').text("₩" + amount);
	
	//총합계 계산하기
	gramtPrice();
}

/* 현재 장바구니에 등록된 상품을 DB에서 삭제하고 해당 페이지내에서도 삭제  단일 상품 */
$('.btn.btn-link.close-btn').on('click', function(){
	let gdsNo = $(this).closest('.card-body').find('input').eq(0).val();
	let prodOption = $(this).closest('.card-body').find('input').eq(4).val();
	
	goodsVO = {
		"gdsNo" : gdsNo,
		"commCodeGrpNo" : prodOption,
	}
	
	fetch('/shop/cart/delete', {
		method: "post",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		body: JSON.stringify(goodsVO)
	}).then( (resp) => {
		resp.text().then( (rslt) => {
			console.log(rslt);
			
			if(rslt == "success") {
				$(this).closest('.card-body').remove();
				gramtPrice();
				$('#paymentBtn').text($('.card-body').length + '개 상품 결제 진행');
			}else {
				alert("상품 삭제를 실패했습니다.");
				gramtPrice();
			}
		})
	})
});

/* 상품의 총 합계를 계산하는 함수 */
function gramtPrice() {
	
	let $cardBody = $('.card-body');
	
	let amountList = [];
	
	$cardBody.map( (idx, item) => {
		let status = $(item).find("input[type='checkbox']").prop('checked');
		if(status){
			let amount = $(item).find('input').eq(2).val();
			amountList.push(amount);
		}
	})
	
	console.log("amountList : " + amountList);
	
	let gramt = 0;
	amountList.forEach( (element) => {
		gramt += parseInt(element);
	})
	
	console.log(gramt);
	
	$("input[name='goodsVOList[0].gramt']").val(gramt);
	
	// 가격을 세자리마다 쉼표 추가하여 포맷팅
	gramt = gramt.toLocaleString();
	
	//총 합계 반영
	$('#gramt').text("총 ₩" + gramt);
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