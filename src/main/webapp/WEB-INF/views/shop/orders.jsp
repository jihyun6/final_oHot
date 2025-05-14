<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<script src="https://js.tosspayments.com/v2/standard"></script>
<title>oHoT Shop</title>
<style type="text/css">
.addr-ui {
	list-style: none;
	padding: 0;
}

.addr-li {
	display: flex;
	flex-direction: row;
	align-items: center;
	gap: 12px;
	padding: 10px;
	min-width: 160px;
}

.donut-outline {
	border: 1px solid #dee2e6;
	border-radius: 50%;
	padding: 5px;
	height: 20px;
}

.donut {
	width: 8px;
	height: 8px;
	background-color: #dee2e6;
	border-radius: 50%;
	position: relative;
	flex-shrink: 0;
}

.donut-selected {
	width: 8px;
	height: 8px;
	background-color: white;
	border-radius: 50%;
	position: relative;
	flex-shrink: 0;
}

.addr-selected {
	background-color: #F86D72;
}

hr {
	margin-bottom: 0px;
	margin-top: 0px;
}
</style>
</head>

<body>
  <!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../shopHeader.jsp" %>

    <!-- ✅ content 시작 -->
    <div class="content">
      <div class="d-flex justify-content-center">
        <div class="col-8">
          <h3 class="mt-5">주문서</h3>
        </div>
      </div>

      <div class="container">
        <div class="row">
          <!-- 왼쪽 영역 -->    
          <div class="col-12 col-sm-9 ps-0">
            <!-- 주문상품 -->
            <div class="card card-container">	
              <div class="card-body card-body-container">
                <div class="accordion accordion-flush" id="orderAccordion">
                  <!-- 주문 상품 -->
                  <button class="accordion-button collapsed collapsed-accordion-btn" type="button" 
                    data-bs-toggle="collapse" data-bs-target="#orderItemCollapse" aria-expanded="false" aria-controls="orderItemCollapse">
                    <div class="col-2 text-start">
                      <h5 class="card-title card-title-container">주문 상품</h5>
                    </div>
                    <div class="col-10 text-end">
                      <h5 class="card-title card-title-right">
                        <!-- 주문상품이 단건일경우 /다 건일경우 처리 -->
                        <c:choose>
                          <c:when test="${fn:length(artistGroupVO.goodsVOList) == 1}">
                            ${artistGroupVO.goodsVOList[0].gdsNm}
                          </c:when>
                          <c:otherwise>
                            ${artistGroupVO.goodsVOList[0].gdsNm} 외 ${fn:length(artistGroupVO.goodsVOList)-1} 건
                          </c:otherwise>
                        </c:choose>
                      </h5>
                    </div>
                  </button>

                  <!-- 주문상품 상세 화면 -->	    	
                  <div id="orderItemCollapse" class="accordion-collapse collapse" data-bs-parent="#orderAccordion" autofocus>	      
                    <div class="accordion-body">
                      <div class="card card-container-bottom-border p-2">
                        <div class="row g-0">
                          <!-- 왼쪽 이미지 -->
                          <div class="col-2 text-center">
                            <c:forEach var="goodsVO" items="${artistGroupVO.goodsVOList}">
                              <img src="/upload/${goodsVO.fileSavePath}" 
                                class="img-fluid rounded" alt="상품 이미지" style="width: 100px; height: 100px;">
                            </c:forEach>
                          </div>
                          <div class="col-10">
                            <div class="card-body p-2">
                              <c:forEach var="goodsVO" items="${artistGroupVO.goodsVOList}">
                                <h5 class="card-title mb-1">${goodsVO.gdsNm}</h5>
                                <p class="card-text mb-0">
                                <c:choose>
                          		  <c:when test="${goodsVO.commCodeGrpNo == 'X'}">
                                	${goodsVO.qty}개
                                  </c:when>
                                  <c:when test="${goodsVO.option2 !=null}">
                                     ${goodsVO.commCodeGrpNo} / ${fn:substring(ordersDetailsVO.option2, 6, fn:length(ordersDetailsVO.option2))}
                                  </c:when>
                                  <c:otherwise>
                                    ${goodsVO.commCodeGrpNo} / ${goodsVO.qty}개</p>
                                  </c:otherwise>
                                </c:choose>  
                                <p class="card-text"><fmt:formatNumber value="${goodsVO.unitPrice}" pattern="#,###" />원</p>
                              </c:forEach>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- 총합계 영역 -->
                      <div class="d-flex justify-content-between align-items-center mt-3">
                        <span class="fw-bold">총 상품 금액(${fn:length(artistGroupVO.goodsVOList)}개)</span>
                        <span class="text-end"><fmt:formatNumber value="${artistGroupVO.goodsVOList[0].gramt}" pattern="#,###" />원</span>
                      </div>
                    </div>       
                  </div>	     
                </div>
              </div>        
            </div> <!-- 주문 상품 끝 -->
            
            <!-- 주문자 -->
            <div class="card card-container">	
              <div class="card-body card-body-container">
                <div class="accordion accordion-flush" id="customerAccordion">
                  <!-- 주문자 -->
                  <button class="accordion-button collapsed collapsed-accordion-btn" type="button" 
                    data-bs-toggle="collapse" data-bs-target="#customerCollapse" aria-expanded="false" aria-controls="customerCollapse">
                    <div class="col-2 text-start">
                      <h5 class="card-title card-title-container">주문자</h5>
                    </div>
                    <div class="col-10 text-end">
                      <h5 class="card-title card-title-right">
                        ${memberVO.memFirstName} ${memberVO.memLastName}, ${memberVO.memEmail} 
                      </h5>
                    </div>
                  </button>	  

                  <!-- 주문자 상세 화면 -->	    	
                  <div id="customerCollapse" class="accordion-collapse collapse" data-bs-parent="#customerAccordion">
                    <div class="accordion-body">
                      <!-- 주문자 정보 영역 -->
                      <div class="d-flex justify-content-between align-items-center mt-3">
                        <div class="d-flex flex-column">
                          <span class="fw-bold">${memberVO.memFirstName} ${memberVO.memLastName}</span>
                          <span>${memberVO.memEmail}</span>
                          <span>${memberVO.memTelno}</span>
                        </div>
                        <div class="d-flex flex-column align-items-end">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>        
            </div>
			
			<!-- 배송 주소 -->
			<c:if test="${artistGroupVO.goodsVOList[0].gdsType != 'M' && artistGroupVO.goodsVOList[0].gdsNo != 98}">
            <div class="card card-container">	
              <div class="card-body card-body-container">
                <div class="accordion accordion-flush" id="addressAccordion">
                  <!-- 주문자 -->
                  <button class="accordion-button collapsed collapsed-accordion-btn" type="button" 
                    data-bs-toggle="collapse" data-bs-target="#addressCollapse" aria-expanded="false" aria-controls="addressCollapse">
                    <div class="col-2 text-start">
                      <h5 class="card-title card-title-container">배송주소</h5>
                    </div>
                    <div class="col-10 text-end">
                      <h5 class="card-title card-title-right" id="addressNm">
                        <c:if test="${not empty shippingInfoVOList}">
                          ${shippingInfoVOList[0].addressNm}${shippingInfoVOList[0].addressDetNm}
                        </c:if>
                        <c:if test="${empty shippingInfoVOList}">
                          등록된 배송 주소가 없습니다.
                        </c:if>
                      </h5>
                    </div>
                  </button>	  

                  <!-- 배송주소 상세 화면 -->	    	
                  <div id="addressCollapse" class="accordion-collapse collapse" data-bs-parent="#addressAccordion">
                    <input type="hidden" name="shippingInfoNo" id="shippingInfoNo" value="${shippingInfoVOList[0].shippingInfoNo}" />
                    <div class="accordion-body">
                      <!-- 주문자 정보 영역 -->
                      <div class="d-flex justify-content-between align-items-center mt-3">
                        <div class="d-flex flex-column">
                          <span class="fw-bold" id="addressNmDetail">${shippingInfoVOList[0].addressNm}${shippingInfoVOList[0].addressDetNm}</span>
                          <span id="addressCountry">${shippingInfoVOList[0].country}</span>
                          <span id="addressNmTelNo">${shippingInfoVOList[0].telNo}</span>
                        </div>
                        <div class="d-flex flex-column align-items-end">
                          <!-- 배송 주소 변경 -->
                          <c:if test="${not empty shippingInfoVOList}">
                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#addressModal">변경</button>
                          </c:if>
                          <c:if test="${empty shippingInfoVOList}">
                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#addressAddModal">추가</button>
                          </c:if>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>        
            </div>
			</c:if>
            <!-- 결제UI -->
            <div class="card card-container">	
              <div class="card-body card-body-container">
                <div class="accordion accordion-flush">
                  <!-- 결제수단 -->
                  <div class="accordion-button collapsed collapsed-accordion-btn col-2 text-start">
                    <h5 class="card-title card-title-container">결제수단</h5>
                  </div>

                  <div class="accordion-body">
                    <div id="payment-method"></div>
                  </div>
                </div>
              </div>        
            </div>
          </div>

          <!-- 결제금액 영역 -->
          <div class="col-12 col-sm-3 ps-0">
            <div class="card card-container">
              <div class="card-header card-header-container text-left">결제 금액</div>

              <div class="card-body">
                <!-- 상품 금액 -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <span class="fw-bold">상품 금액 :</span>
                  <span class="text-end">₩<fmt:formatNumber value="${artistGroupVO.goodsVOList[0].gramt}" pattern="#,###" />원</span>
                </div>
                <hr>

                <!-- 총 결제 금액 -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <span class="fw-bold">총 결제 금액 :</span>
                  <span class="text-end">₩<fmt:formatNumber value="${artistGroupVO.goodsVOList[0].gramt}" pattern="#,###" />원</span>
                </div>

                <!-- 동의 및 결제 버튼 영역 -->
                <div class="text-center mb-4 agreement" id="agreement"></div>

                <button type="button" class="btn btn-primary w-100" id="payment-button">
                  동의 후 ₩<fmt:formatNumber value="${artistGroupVO.goodsVOList[0].gramt}" /> 결제
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="../shopfooter.jsp" %>
  </div> <!-- wrapper 영역 종료 -->
</body>


<!-- Modal -->
<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	  <!-- model header -->
	  <div class="modal-header">
	    <h1 class="modal-title fs-5" id="exampleModalLabel">배송주소 조회</h1>
	    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	   <!-- modal body -->
	   <div class="modal-body" id="modalBody">
	    <ul class="addr-ui d-flex flex-column">
	      <c:forEach var="shippingInfoVO" items="${shippingInfoVOList}" varStatus="status">
	        <li class="addr-li d-flex flex-column">
	          <div class="d-flex justify-content-center">
	            <div class="donut-outline ${status.index == 0 ? 'addr-selected':''}">
	              <div class="${status.index == 0 ? 'donut-selected':'donut'}"></div>
	            </div>
	            
	            <div class="addr-body" style="width: 400px;">
	              <h6 class="card-title ms-3">${shippingInfoVO.addressNm}${shippingInfoVO.addressDetNm}</h6>
	              <h6 class="card-title ms-3">${shippingInfoVO.country}</h6>
	              <h6 class="card-title ms-3">${shippingInfoVO.telNo}</h6>
	            </div>
			  </div>
            </li>
            <c:if test="${status.index != fn:length(shippingInfoVOList)-1}">
              <hr/>
            </c:if>
          </c:forEach>
        </ul>
	  </div>
          
      <!-- 모달 푸터 -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="addrSave">저장</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal(추가) -->
<div class="modal fade" id="addressAddModal" tabindex="-1" aria-labelledby="addressAddModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
	    <h1 class="modal-title fs-5" id="addressAddModalLabel">배송 주소 등록</h1>
	    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	
	  <form id="addr">
        <div class="modal-body" id="modalBody">
          <div class="mb-3">
            <label for="recipient-name" class="form-label">성<span class="required">*</span></label>
            <input type="text" class="form-control" id="farstNm" name="farstNm" placeholder="성 입력" required value="">
          </div>
        
          <div class="mb-3">
            <label for="recipient-name" class="form-label">이름<span class="required">*</span></label>
            <input type="text" class="form-control" id="lastNm" name="lastNm" placeholder="이름 입력" required value="">
          </div>
        
          <div class="mb-3">
            <label for="recipient-name" class="form-label">전화번호<span class="required">*</span></label>
            <input type="text" class="form-control" id="telNo" name="telNo" placeholder="전화번호 입력" required value="">
          </div>
      
          <div class="mb-3">
            <label for="recipient-name" class="form-label">배송국가<span class="required">*</span></label>
            <input type="text" class="form-control" id="country" name="country" placeholder="배송국가지역" required value="대한민국">
          </div>
        
          <div class="mb-3">
            <label for="recipient-name" class="form-label">배송국가코드<span class="required">*</span></label>
            <input type="text" class="form-control" id="countryCd" name="countryCd" placeholder="배송국가코드" required value="82">
          </div>
        
          <div class="mb-3">
            <label for="recipient-name" class="form-label">우편번호<span class="required">*</span></label>
            <input type="text" class="form-control" id="zipCd" name="zipCd" placeholder="우편번호" required value="">
          </div>
      
           <div class="mb-3">
            <label for="recipient-name" class="form-label">기본주소<span class="required">*</span></label>
            <input type="text" class="form-control" id="addressNm" name="addressNm" placeholder="기본주소" required value="">
          </div>
      
          <div class="mb-3">
            <label for="recipient-name" class="form-label">상세주소<span class="required">*</span></label>
            <input type="text" class="form-control" id="addressDetNm" name="addressDetNm" placeholder="상세주소" required value="">
          </div>
          
          <div class="mb-3">
            <input class="form-check-input me-3" type="checkbox" value="Y" name="isDefault" checked>기본 배송지 설정
          </div>
          
          <!-- 모달 푸터 -->
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" id="save">저장</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- JS 영역 -->
<script>
$("#save").on('click', function(){
	
	const formData = $("#addr")[0];
	
	//reportValidity(): 유효성 체크로 checkValidity()와 다르게 에러표시
	if(!formData.reportValidity()){
		return false;
	}
	
	//comfrim 
	Swal.fire({
    	title: "배송지를 등록 합니다. 계속하시겠습니까?",
    	icon: "success",
    	showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
    	confirmButtonText: '저장', // confirm 버튼 텍스트 지정
    	cancelButtonText: '취소', // cancel 버튼 텍스트 지정
    }).then( result => {
    	if(result.isConfirmed){
    		fetch('/shop/addrManagerPost', {
    			method: "post",
    			headers: {
    				"Content-Type": "application/x-www-form-urlencoded",
    			},
    			body: $("#addr").serialize()
    		}).then( (resp)=> {
    			resp.text().then( ( rslt )=> {
    				if(rslt == "success"){
    					Swal.fire({
      					  title: "정상 처리되었습니다.",
      					  icon: "success",
      					  draggable: true
      					}).then(result => {
      						if(result.isConfirmed){
      							location.reload();
      						}
      					})
    				}
    			})	
    		})  		
    	}
    })
})


/* 결제 이후 팝업창을 출력하는 메소드*/
function fn_popupPrint(resp) {
	//paymentKey: 'tgen_20250412161132ZWLJ1', orderId: 'dc57954b-14c1-4993-8baa-f16af1d9b4ce', 
	//amount: e{curreny, 54500}, paymentType: 'NORMAL'
	
	// 화면 정중앙 좌표 계산
	const popupWidth=450;	//팝업창 가로길이
	const popupHeight=400;	//팝업창 세로길이
	const popupTop = window.screenY + (window.outerHeight - popupHeight) / 2;	//창 우측 좌표 위치 + 창의 세로 길이 - 팝업창 세로길이
	const popupLeft = window.screenX + (window.outerWidth - popupWidth) / 2;	//창 X좌표 위치 + 창의 가로길이 - 팝업창 가로길이
	
	//서버로부터 결제가 승인되었다면.. 팝업창 출력
	let url = "/payment/success";
	let name = "paymentResult";
	let option = `width=\${popupWidth}, height=\${popupHeight}, top=\${popupTop}, left=\${popupLeft}, directories=no`;
	
	const paymentKey = 'test';
	window.open(url, name,option);
}

/* 결제 이후 팝업창을 출력하는 메소드*/
function fn_popupPrintFail(error) {
	//paymentKey: 'tgen_20250412161132ZWLJ1', orderId: 'dc57954b-14c1-4993-8baa-f16af1d9b4ce', 
	//amount: e{curreny, 54500}, paymentType: 'NORMAL'
	
	// 화면 정중앙 좌표 계산
	const popupWidth=450;	//팝업창 가로길이
	const popupHeight=400;	//팝업창 세로길이
	const popupTop = window.screenY + (window.outerHeight - popupHeight) / 2;	//창 우측 좌표 위치 + 창의 세로 길이 - 팝업창 세로길이
	const popupLeft = window.screenX + (window.outerWidth - popupWidth) / 2;	//창 X좌표 위치 + 창의 가로길이 - 팝업창 가로길이
	
	//서버로부터 결제가 승인되었다면.. 팝업창 출력
	let url = "/payment/fail";
	let name = "paymentResult";
	let option = `width=\${popupWidth}, height=\${popupHeight}, top=\${popupTop}, left=\${popupLeft}, directories=no`;
	
	const paymentKey = 'test';
	window.open(url+`?error=\${error}`, name,option);
}

//save 버튼 선택 시 실행
$("#addrSave").on('click', function(){
	let addr = $(".addr-selected").closest('li').find('.addr-body').find('.card-title');
	
	addr.map( (idx, item) => {
		if(idx == 0) {
			$('#addressNm').text($(item).text());
			$('#addressNmDetail').text($(item).text());
		}
		else if(idx == 1){
			$('#addressCountry').text($(item).text());
		}else if(idx == 2) {
			$('#addressNmTelNo').text($(item).text());
		}
	})
	
	$("#addressModal").modal('hide');
	
})

//li click Evnet
$(".donut-outline").on('click', function(){
	$(this).closest('ul').find('div').removeClass('addr-selected donut-selected');
	$('.donut-outline').find('div').addClass('donut');
	
	$(this).addClass('addr-selected');
	$(this).find('div').removeClass('donut').addClass('donut-selected');
})

//------  결제위젯 초기화 ------
const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
const tossPayments = TossPayments(clientKey);

// 회원 결제
const customerKey = "H57frYJIlpWdgTeb0IqwG";

const widgets = tossPayments.widgets({
	customerKey,
});

$(function(){
	
	main();
	
	let gdsType = `${artistGroupVO.goodsVOList[0].gdsType}`;
	let gdsNo = `${artistGroupVO.goodsVOList[0].gdsNo}`;
	
	if(gdsType != 'M' && gdsNo != 98){
		alert("암호화된 키값" + ${jwtString} );	
	}
	
	let jwtString = ${jwtString};
	
	jwtPayment = {
		"jwtString" : jwtString
	}
	
	console.log(jwtPayment);
	
  	fetch("/payment/decrypterPayment" , {
		method: "post",
		headers: {
        	"Content-Type": "application/json;charset=UTF-8",
      	},
		body: JSON.stringify(jwtPayment)
	}).then( resp => {
		resp.text().then( (rslt)=>{
			widgets.setAmount({
			    currency: "KRW",
			    value: parseInt(rslt),
			});
		}).catch( (error) => {
		     console.log("error : " + error);
		     fn_popupPrintFail(error);
	    })
	})
});

async function main() {
  const payMentBtn = $("#payment-button");
  
  //------ 주문의 결제 금액 설정 ------
  await widgets.setAmount({
    currency: "KRW",
    value: 0,
  });
  
  await Promise.all([
    // ------  결제 UI 렌더링 ------
    widgets.renderPaymentMethods({
	  selector: "#payment-method",
	  variantKey: "DEFAULT",
	}),
	// ------  이용약관 UI 렌더링 ------
	  widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
	]);
  
  // http://localhost:28080/payment/success?paymentType=NORMAL&orderId=X3cmhewbyeyf9a5PSdIRR&paymentKey=tgen_20250404174709KUbX5&amount=50000
  payMentBtn.on("click", async function () {	  
	  let res = fn_payment();
	  
	  if(res){
	  	  await widgets.requestPayment({
			  orderId: `${seqGeneratorVO.uuid}`,	//Random 생성;
			  orderName: `${memberVO.memEmail}`,
			      
			  //결제가 완료 된 후 이동되는 URL 설정
			  //successUrl: window.location.origin + "/payment/confirm",
			  //failUrl: window.location.origin + "/payment/fail",
			}).then( (resp) => { //paymentKey: 'tgen_20250412161132ZWLJ1', orderId: 'dc57954b-14c1-4993-8baa-f16af1d9b4ce', 
		       //amount: _currency: 'KRW', _value: 58000, paymentType: 'NORMAL'
			   console.log("resp paymentKey: " , resp.paymentKey);
			   console.log("resp amount : " , resp.amount._value);
			   
			   fetch(`/payment/completeUpdate?paymentKey=\${resp.paymentKey}&gramt=\${resp.amount._value}` , {
				   method: 'get'
			   }).then( (resp) => {
			   		resp.text().then( (rslt)=>{
						if(rslt == "payment/fail"){
							location.href = "/" + rslt;
							fn_popupPrintFail("에러가 발생했습니다.");
						}else if(rslt == "payment/success"){
							location.href = "/" + "payment/completeForm";
							fn_popupPrint(resp);
						}
					})		
			  	})
			  }).catch( (error) => {
			     console.log("error : " + error);
			     fn_popupPrintFail(error);
		    })
	  }else{
		  fn_popupPrintFail("에러 발생!");
	  }
  });
}

async function fn_payment(){
	try{
		
		let shippingInfoNo = $("#shippingInfoNo").val();
		
		if(!shippingInfoNo){
			shippingInfoNo = 0;
		}
		
		const response = await fetch(`/payment/complete?shippingInfoNo=\${shippingInfoNo}`);
		const result = await response.text();
		console.log("Success:" , result);
		
		if(result == "complete"){
			return "complete";
		}
		
		else {
			return "";
		}
		
	} catch (error) {
		console.log("Error : " + error);
	}
}

</script>
</html>