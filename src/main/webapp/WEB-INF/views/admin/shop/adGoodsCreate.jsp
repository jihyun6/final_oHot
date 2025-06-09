<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<link rel="stylesheet" href="/shop/main.css" />
<!-- https://github.com/SortableJS/jquery-sortablejs -->
<style type="text/css">
.adThumbnailDiv-image {
	border-radius: 10px; 
	width: 1000px; 
	height: 770px; 
	/* border: 1px solid #a0a0a0;  #a0a0a0 */
}

.adThumbnail-image {
	width:1000px !important; 
	height: 600px !important; 
	border-radius: 10px;
	object-fit: cover; /* 이미지를 부모 요소 크기에 맞추어 비율 유지 */
}

.product-image-thumb {
	margin-right: 16px;
}

</style>


</head>
<body class="sidebar-mini layout-fixed" style="height: auto;">
  <div class="wrapper">	
  <!-- 관리자 헤더네비바  -->
  <%@ include file="../adminHeader.jsp"%>
	
  <!-- 관리자 사이드바 -->
  <%@ include file="../adminSidebar.jsp"%>
	
	<!-- sec 영역 -->
    <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal.usersVO" var="userVO" />
    </sec:authorize>
	
    <div class="content-wrapper">
	  <!-- 상품 등록 페이지 메인 컨테이너 -->
	  <div class="d-flex justify-content-left m-3">
	    <!-- form 영역 -->
	    <form action="/admin/shop/adGoodsCreatePost" id="goodsForm" method="post" enctype="multipart/form-data" onsubmit="fetchAjax()">
	      <div class="row">
	        <!-- [좌측] 상품 이미지 대표 영역 -->
	        <div class="col-12 col-sm-6 adThumbnailDiv-image" id="thumbnailImg">
	          <img src="/images/imageAppend.png" class="product-image border adThumbnail-image" alt="Product Thumbnail">
	        
	          <!-- 미니 이미지 영역 -->
	          <div class="col-12 product-image-thumbs justify-content-center" id="thumbImg">
	            <div class="product-image-thumb border border-secondary">
		          <img src="/images/imageAppend.png" class="product-image" alt="Product Thumbnail">
 		        </div>
 		        <div class="product-image-thumb border border-secondary">
		          <img src="/images/imageAppend.png" class="product-image" alt="Product Thumbnail">
 		        </div>
 		        <div class="product-image-thumb border border-secondary">
		          <img src="/images/imageAppend.png" class="product-image" alt="Product Thumbnail">
 		        </div>
	          </div>
	        </div>
	      
	        <!-- [우측] 상품 등록 Form 영역 -->
	        <div class="col-12 col-sm-6">
	          <div class="p-4 bg-light rounded border ms-3" style="min-height: 730px;">
	            <h5 class="fw-bold mb-4">상품 정보 입력</h5>

	          	<!-- 상품번호 -->
      		    <div class="mb-3">
      		      <label for="gdsNo" class="form-label">상품번호</label>
      		      <input type="text" class="form-control" id="gdsNo" name="gdsNo" value="0" readonly="readonly">
    		    </div>
	          	
	          	<!-- 그룹명 -->
    		    <div class="mb-3">
      		      <label for="artGroupNo" class="form-label">그룹명</label>
      		      <select class="form-select select2bs4" style="width: 100%;" name="artGroupNo" id="artGroupNo">
      		        <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
      		            <option value="${artistGroupVO.artGroupNo}">
      		           	  ${artistGroupVO.artGroupNm}</option>
      		        </c:forEach>
      		      </select>
      		    </div>
	          	<!-- 상품유형 -->
    		    <div class="mb-3">
      		      <label for="gdsType" class="form-label">상품유형</label>
      		      <select class="form-select" name="gdsType" id="gdsType">
      		        <c:forEach var="commonDetailCodeVO" items="${commonCodeGroupVOGdsType.commonDetailCodeVOList}">  
      		          <c:choose>
      		            <c:when test="${commonDetailCodeVO.commDetCodeNm != 'I' and commonDetailCodeVO.commDetCodeNm != 'GD02'}">
      		          	  <option value="${commonDetailCodeVO.commDetCodeNm}" 
      		          	    <c:if test="${commonDetailCodeVO.commDetCodeNm == 'G' ? 'selected=selected' : ''}"></c:if>>
      		            
      		            	<!-- 상품유형에 따른 분기 -->
      		                <c:if test="${commonDetailCodeVO.commDetCodeNm == 'G'}">Group</c:if>
      		            	<c:if test="${commonDetailCodeVO.commDetCodeNm == 'M'}">MemberShip</c:if>
      		            	<c:if test="${commonDetailCodeVO.commDetCodeNm == 'A'}">Album</c:if>
      		          	  </option>
      		            </c:when>
      		          </c:choose>
      		        </c:forEach>
      		      </select>
      		    </div>
	          	
	            <!-- 상품명 -->
    		    <div class="mb-3">
      		      <label for="gdsNm" class="form-label">상품명</label>
      			  <input type="text" class="form-control" id="gdsNm" name="gdsNm" placeholder="예: 핑크 토끼 인형">
    		    </div>
      		    
      		    <!-- 판매가격(원) -->
      		    <div class="mb-3">
      		      <label for="unitPrice" class="form-label">판매가격(원)</label>
      		      <input type="text" class="form-control" id="unitPrice" name="unitPrice" placeholder="15000" oninput="fn_numberCheck(this)">
    		    </div>
    		    
    		    <!-- 옵션 -->
    		    <div class="mb-3">
      		      <label for="expln" class="form-label">옵션여부</label>
      		        <select class="form-select" name="commCodeGrpNo" id="commCodeGrpNo">
      		      	  <option value="GD01">Y</option>
      		      	  <option selected="selected" value="${commonDetailCodeVO.commDetCodeNm}">N</option>
      		        </select>
    		    </div>
    		    
    		    <div class="mb-3">
      		      <label for="expln" class="form-label">설명</label>
      		      <input type="text" class="form-control" id="expln" name="expln" placeholder="예: 핑크 토끼 인형">
    		    </div>
    		    <div class="mb-3">
      		      <label for="pic" class="form-label">담당자</label>
      		      <input type="text" class="form-control" id="pic" name="pic" readonly value="${userVO.employeeVO.empNm}" placeholder="예: 핑크 토끼 인형">
    		    </div>
    		    
    		    <div class="mb-3">
				  <label for="uploadFile" class="form-label fw-semibold">파일 첨부</label>
				  <input class="form-control" type="file" id="uploadFile" name="uploadFile" multiple>
				  <div class="form-text">여러 파일을 선택할 수 있어요.</div>
				</div>
    		    
    		    <div class="d-flex justify-content-end mb-3" id="btnDiv">
<!--       		      <button class="btn btn-primary action-btn" name="CreatePost" type="submit">저장하기</button> -->
<!--       		      <button class="action-btn" name="" type="button">목록보기</button> -->
<!--       		      <button class="action-btn" name="UpdatePost" type="submit">수정하기</button> -->
<!--       		      <button class="action-btn" name="DeletePost" type="submit">삭제하기</button> -->
    		    </div>
	          </div>
	  	    </div>
	      </div>
	    </form>
	  </div>
    </div>
  </div>
  
  <!-- 관리자 풋터 -->
  <%@ include file="../adminFooter.jsp"%>
</body>

<script type="text/javascript">
$(function(){
	//file이 등록되었을 때 이미지를 읽어들이기
	$("input[name='uploadFile']").on("change", fn_handleImgFileSelect);
	
	//JSP 시작 초기화 함수
	initPage();
	
	$(".product-image-thumbs").sortable({
		//정렬이 완료되었을 경우.. 
		stop: function( event, ui){
			console.log("정렬 완료!")
			sortFileSnList();
			
		}
	});
})

function initPage(){
	
	//$('.action-btn').hide();
	//form data 가져오기
	const formData = new FormData($("#goodsForm")[0]);
	
	//URL의 QueryString을 검사하여 ?뒤에 gdsNo값이 있는지 확인
	let fullPath = $(location).attr('search');
	let goodsVO = ${jsonStr};
	
	//목록버튼
	$('#btnDiv').append(`<a href="/admin/shop/adGoodsList" class="btn btn-info action-btn mr-2 ">목록</button> `);
	
	if(fullPath){
		console.log(goodsVO);
		//Controller에서 가져온 json 데이터를 form 데이터에 매핑
		for(const key of formData.keys()){
			if(key == 'artGroupNo'){
				let optionList = $('#artGroupNo option');
// 				optionList.find(`value=\${artGroupNo}`).prop('selected', true)
				
				optionList.map( (idx, item) => {
					if(item.value == goodsVO[key]){
						//trigger: 강제 이벤트 발생						
						$('#artGroupNo').val(goodsVO[key]).trigger('change');
					}
				})
				
			}else{
				$("#" + key).val(goodsVO[key]);
			}
		}
		
		//이미지 요소 설정하기
		let fileDetailVOList = goodsVO.fileGroupVO.fileDetailVOList;
		
		$("#thumbnailImg > img").remove();	//대표 썸네일 Div 요소 초기화
		$("#thumbImg > div").remove();  //미니 이미지 Div 요소 초기화
		
		if(fileDetailVOList[0].fileSaveLocate == null){
			$("#thumbnailImg").prepend( `<img src="/images/noImage.png"
			  class="product-image border adThumbnail-image" alt="Product Thumbnail" />`);
			
			$("#thumbImg").append(
			  `<div class="product-image-thumb"> 
			     <img src="/images/noImage.png" class="product-image" alt="Product Thumbnail" /> 
			   </div>
			  `);
		}else {
			fileDetailVOList.forEach((item, idx)=> {
				
				if(idx == 0){
					$("#thumbnailImg").prepend( `<img src="/upload/\${item.fileSaveLocate}"
					  onerror=this.src='/images/noImage.png'
					  class="product-image border adThumbnail-image" alt="Product Thumbnail" />`);
				}
				
				$("#thumbImg").append(
				  `<div class="product-image-thumb"> 
				     <img src="/upload/\${item.fileSaveLocate}" onerror=this.src='/images/noImage.png' 
				       class="product-image" alt="Product Thumbnail" /> 
				     <input type='hidden' class="fileSn" name='fileGroupVO.fileDetailVOList[\${idx}].fileSn' value='\${item.fileSn}'/>
				     <input type='hidden' name='fileGroupVO.fileDetailVOList[\${idx}].fileGroupNo' value='\${item.fileGroupNo}'/>
				     <input type='hidden' name='fileGroupVO.fileDetailVOList[\${idx}].fileSaveName' value='\${item.fileSaveName}'/>
				   </div>
				  `);
			})
		}
		
		
		
		//상품 Detail 화면인 경우 저장버튼, 삭제버튼 보이게 하기
		$('#btnDiv').append(`<button class="btn btn-primary action-btn mr-2" name="UpdatePost" type="submit">저장</button>`);
		$('#btnDiv').append(`<button class="btn btn btn-danger action-btn mr-2" name="DeletePost" type="submit">삭제</button>`);
	}
	
	//상품 등록인경우 버튼 보이기
	else {
		$("#gdsNo").val(goodsVO["gdsNo"]);
		
		$('#btnDiv').append(`<button class="btn btn-primary action-btn mr-2" name="CreatePost" type="submit">저장</button>`);
	}
}

/* sample Code: https://developer.mozilla.org/en-US/docs/Web/API/FileReader/readAsDataURL */
/* 이미지 영역이 변화가 있을 때 실행되는 메소드 */
function fn_handleImgFileSelect(e) {
	let files = e.target.files;
	
	const maxFiles = 4;
	if(this.files.length > maxFiles){
		alert(`최대 \${maxFiles}개 까지만 업로드 할수 있습니다.`);
		this.value="";
		return false;
	}
	
	//reader.onload는 비동기 함수로, 첫 번째 파일이 idx가 0이라는 부분을 보장할 수 없음.
	// 따라서 remove 함수가 reader.onload() 안에서 실행 될 시 랜덤하게 출력되는 것을 알 수 있음..(ex 4개 올렸는데 3개만 미리보기 나오는 현상)
	// 해당 remove를 함수를 로직에서 분리하여 실행.
	$("#thumbnailImg > img").remove();	//직계자식 찾아서 요소를 비움
	//미니 이미지 영역 요소 삭제
	$("#thumbImg > div").remove();
	
	function readAndPreView(file, idx){
		//match 정규표현식과 일치하는 결과리턴
		//f,type: MIME 표현형식("image/png", "image.jpeg")
		if(file.type.match("image.*")){
			//파일 읽어오기
			const reader = new FileReader();
			
			reader.onload = function(e){
				if(idx == 0){
					//대표이미지 영역
					$("#thumbnailImg").prepend( `<img src="\${e.target.result}" 
			          class="product-image border adThumbnail-image" alt="Product Thumbnail"/>`);
				}
				
				$("#thumbImg").append(`<div class="product-image-thumb"> <img src="\${e.target.result}" 
          	  	  class="product-image" alt="Product Thumbnail" style="width: 100px; height:100px;"/> </div>`);
			}
			
			reader.readAsDataURL(file);
		}
	}
	
	if(files){
		Array.prototype.forEach.call(files, readAndPreView);
	}else {	//이미지 파일이 아닐 때 끝내기
		return;	
	}
}

//이미지 요소의 위치가 변경되었을 때 실행
function sortFileSnList(){
	//thumbImg안의 요소 중 fileSn 클래스를 찾아옴.
	let fileSnList = document.getElementById("thumbImg").getElementsByClassName("fileSn");
	
	let arrfileSnList = Array.from(fileSnList)
	
	arrfileSnList.forEach( (item, idx) => {
		if(idx == 0) {
			let imgPath = $(item).closest('div').find('img').attr('src');
			$("#thumbnailImg > img").remove();	//직계자식 찾아서 요소를 비움
			$("#thumbnailImg").prepend( `<img src="\${imgPath}" 
	            	  					    class="product-image border adThumbnail-image" alt="Product Thumbnail"/>`);
		}
		
		let arrfileSnListSize = arrfileSnList.length;
		$(item).prop('value', parseInt(arrfileSnListSize) - parseInt(`\${idx}`));
	})
}

//선택한 버튼에 따라 Form action 값 변경 메소드
$(document).on('click', '.action-btn', function(){
	console.log("클릭한 버튼의 이름 값은 : " + $(this).attr("name"));
	
	let urlLink = $(this).attr("name");
	
	$("#goodsForm").prop("action" , "/admin/shop/adGoods" + urlLink);
	
})

/* form submit 버튼 눌렀을 때 발생 */
function fetchAjax() {
	event.preventDefault();
	const formData = new FormData(event.currentTarget);
	
	let actionLink = $("#goodsForm").attr("action");
	
	actionLinkSplit = actionLink.split("/");
	
	console.log(actionLinkSplit);
	
	let titleStr = "";
	if(actionLinkSplit[3] == "adGoodsCreatePost"){
		titleStr = "<strong>상품 추가를 진행합니다. 계속하시겠습니까?</strong>";
	}
	
	else if(actionLinkSplit[3] == "adGoodsUpdatePost"){
		titleStr = "<strong>상품 수정를 진행합니다. 계속하시겠습니까?</strong>";
	}
	
	else if(actionLinkSplit[3] == "adGoodsDeletePost"){
		titleStr = "<strong>상품 삭제를 진행합니다. 계속하시겠습니까?</strong>";
	}
	
	
	//comfrim
	Swal.fire({
    		title: titleStr,
    		icon: "success",
    		showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
    		confirmButtonText: '저장', // confirm 버튼 텍스트 지정
    		cancelButtonText: '취소', // cancel 버튼 텍스트 지정
    }).then( result => {
    	if(result.isConfirmed){
    		
			console.log("actionLink : " + actionLink);			
    		fetch(actionLink, {
    		    method: "post",
    		    body: formData
    		  }).then(resp => {
    			resp.json().then( (rslt) => {
    				console.log(rslt);
        			if(actionLink == "/admin/shop/adGoodsCreatePost"){
        				location.href = '/admin/shop/adGoodsList';
        			}
        			
        			else if(actionLink == "/admin/shop/adGoodsUpdatePost" && rslt > 0){
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
        			else if(actionLink == "/admin/shop/adGoodsDeletePost" && rslt > 0){
        				Swal.fire({
        					  title: "정상 처리되었습니다.",
        					  icon: "success",
        					  draggable: true
        				}).then(result => {
        					if(result.isConfirmed){
        						location.href = '/admin/shop/adGoodsList';
        					}
        				})
        			}
    			})  
    		})
    	}
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
<script src="/js/sortable/jquery-ui.min.js"></script>
<!-- https://www.tutorialspoint.com/jqueryui/jqueryui_sortable.htm -->
<!-- https://api.jqueryui.com/sortable/#event-activate -->
<!-- https://github.com/SortableJS/jquery-sortablejs -->
<script src="/js/sortable/Sortable.js"></script>
</html>