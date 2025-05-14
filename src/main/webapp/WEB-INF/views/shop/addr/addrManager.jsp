<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<title>Insert title here</title>
<style>
.btn-basic {
	color: #F86D72 !important;
	border-color: #F86D72 !important;
}

.btn:hover {
	background-color: #dee2e6 !important;
}

.required {
  color: red;
  font-weight: bold;
}
</style>

</head>
<body>
<!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../../shopHeader.jsp" %>
    
    <!-- ✅ content 시작 -->
    <div class="content">
      <!-- Title -->
      <div class="container">
        <div class="card card-container-cart-title col-12">
          <h3 class="mt-5 mb-3">배송주소</h3>
        </div>
      </div>
        
      <div class="container">
	    <div class="row">
          <div class="card card-container">	
            <!-- card body --> 
            <div class="card-body card-body-container p-3">
              <div class="col-12 text-start">
                <!-- 배송 목록 출력 -->
                <c:if test="${ empty shippingInfoVOList}">
	        	  <div class="card-body d-flex justify-content-center align-items-center" style="min-height: 200px;">
	          	    등록된 배송지 주소가 없습니다.
	        	  </div>
	      		</c:if>
                
                <c:if test="${ not empty shippingInfoVOList}">
                <c:forEach var="shippingInfoVO" items="${shippingInfoVOList}" >
                  <div class="d-flex justify-content-between align-items-center">
                    <h5 class="card-title fw-bold">${shippingInfoVO.farstNm}${shippingInfoVO.lastNm}</h5>
                    <!-- 버튼 묶기 -->
    			    <div class="d-flex gap-2">
                  	  <input type="hidden" value="${shippingInfoVO.shippingInfoNo}">
                      <button type="button" class="btn btn-outline-primary btn-basic btn-single-row">
				  		수정
					  </button>
                      <button type="button" class="btn btn-outline-primary btn-basic delete">
				  	    삭제
					  </button>
                    </div>
                  </div>
                  <h6 class="card-title">${shippingInfoVO.addressNm}${shippingInfoVO.addressDetNm}</h6>
                  <h6 class="card-title">${shippingInfoVO.country}</h6>
                  <h6 class="card-title">${shippingInfoVO.telNo}</h6>
			      <hr/>
			    </c:forEach>
			    </c:if>
              <!-- footer 영역 영역 -->
              <div class="d-flex justify-content-between align-items-center mt-3">
                <span>배송 주소는 최대 10개까지 등록할 수 있습니다.</span>
                <!-- Button trigger modal -->
				<button type="button" class="btn btn-outline-primary btn-basic" id="add">
				  등록
				</button>
              </div>	
            </div>
          </div>
	    </div>
        </div>
      </div>
    
    </div><!-- content 종료 --> 
    <%@ include file="../../shopfooter.jsp" %>
  </div><!-- wrapper 영역 종료 -->
  
<!-- Modal -->
<div class="modal fade" id="addrAddModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
	    <h1 class="modal-title fs-5" id="exampleModalLabel">배송 주소</h1>
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
            <input type="text" class="form-control" id="telNo" name="telNo" placeholder="010-1234-1234" required value="">
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
</body>

<!-- JS 영역 -->
<script type="text/javascript">

$("#add").on('click', function(){
	const formData = new FormData($("#addr")[0]);
	
	for(const key of formData.keys()){
		if( key != 'country' && key != 'countryCd' ){
			$("#" + key).val("");
		}
	}
	
	$('#addrAddModal').modal('show');
})

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

// modal 창 버튼이 새로 생성되었을 떄 동적으로바인딩!
$('#modalBody').on('click', '#update' ,function(){
	
	const formData = $("#addr")[0];
	
	//reportValidity(): 유효성 체크로 checkValidity()와 다르게 에러표시
	if(!formData.reportValidity()){
		return false;
	}
	
	//comfrim 
	Swal.fire({
    	title: "배송지를 수정 합니다. 계속하시겠습니까?",
    	icon: "success",
    	showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
    	confirmButtonText: '저장', // confirm 버튼 텍스트 지정
    	cancelButtonText: '취소', // cancel 버튼 텍스트 지정
    }).then( result => {
    	if(result.isConfirmed){
    		fetch('/shop/addrManagerUpdatePost', {
    			method: "POST",
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

$('.delete').on('click', function(){
	let shippingInfoNo = $(this).closest('div').find('input').eq(0).val();
	console.log(shippingInfoNo);
	
	
	shippingInfoVO = {
	  "shippingInfoNo" : shippingInfoNo
	}
	
	//comfrim 
	Swal.fire({
    	title: "배송지를 삭제 합니다. 계속하시겠습니까?",
    	icon: "success",
    	showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
    	confirmButtonText: '저장', // confirm 버튼 텍스트 지정
    	cancelButtonText: '취소', // cancel 버튼 텍스트 지정
    }).then( result => {
    	if(result.isConfirmed){
    		fetch('/shop/addrManagerDeletePost', {
    			method: "POST",
    			headers: {
    				"Content-Type": "application/json;charset=UTF-8",
    			},
    			body: JSON.stringify(shippingInfoVO)
    		}).then( (resp)=> {
    			resp.text().then( ( rslt )=> {
    				if(rslt == "success"){
    					Swal.fire({
      					  title: "정상 삭제되었습니다.",
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

$(".btn-single-row").on('click', function(){
	
	let shippingInfoNo = $(this).closest('div').find('input').eq(0).val();
	
	console.log(shippingInfoNo);
	
	shippingInfoVO = {
	  "shippingInfoNo" : shippingInfoNo
	}
	
	fetch('/shop/addrManagerUpdateForm', {
		method: "POST",
		headers: {
			"Content-Type": "application/json;charset=UTF-8",
		},
		body: JSON.stringify(shippingInfoVO)
	}).then( (resp)=> {
		resp.json().then( (rslt)=> {
			console.log(rslt)
			
			let modalbody = document.getElementById('modalBody');
			
			console.log(modalbody);
			
			modalbody.innerHTML = "";
			
			modalbody.innerHTML = `
			  <input type="hidden" name="shippingInfoNo" value="\${shippingInfoVO.shippingInfoNo}">
			  <div class="mb-3">
	            <label for="recipient-name" class="form-label">성<span class="required">*</span></label>
	            <input type="text" class="form-control" id="farstNm" name="farstNm" placeholder="성 입력" required value="\${rslt.farstNm}">
	          </div>
	        
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">이름<span class="required">*</span></label>
	            <input type="text" class="form-control" id="lastNm" name="lastNm" placeholder="이름 입력" required value="\${rslt.lastNm}">
	          </div>
	        
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">전화번호<span class="required">*</span></label>
	            <input type="text" class="form-control" id="telNo" name="telNo" placeholder="전화번호 입력" required value="\${rslt.telNo}">
	          </div>
	      
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">배송국가<span class="required">*</span></label>
	            <input type="text" class="form-control" id="country" name="country" placeholder="배송국가지역" required value="\${rslt.country}">
	          </div>
	        
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">배송국가코드<span class="required">*</span></label>
	            <input type="text" class="form-control" id="countryCd" name="countryCd" placeholder="배송국가코드" required value="82">
	          </div>
	        
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">우편번호<span class="required">*</span></label>
	            <input type="text" class="form-control" id="zipCd" name="zipCd" placeholder="우편번호" required value="\${rslt.zipCd}">
	          </div>
	      
	           <div class="mb-3">
	            <label for="recipient-name" class="form-label">기본주소<span class="required">*</span></label>
	            <input type="text" class="form-control" id="addressNm" name="addressNm" placeholder="기본주소" required value="\${rslt.addressNm}">
	          </div>
	      
	          <div class="mb-3">
	            <label for="recipient-name" class="form-label">상세주소<span class="required">*</span></label>
	            <input type="text" class="form-control" id="addressDetNm" name="addressDetNm" placeholder="상세주소" required value="\${rslt.addressDetNm}">
	          </div>
	          
	          <div class="mb-3">
	            <input class="form-check-input me-3" type="checkbox" value="Y" name="isDefault">기본 배송지 설정
	          </div>
	          
	          <!-- 모달 푸터 -->
	          <div class="modal-footer">
	            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	            <button type="button" class="btn btn-primary" id="update">저장</button>
	          </div>
			`
			
			$('#addrAddModal').modal('show');
			
		})	
	})
})


</script>


</html>