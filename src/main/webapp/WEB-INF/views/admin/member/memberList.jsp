<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<style type="text/css">
.table td, .table th{
	padding: .35rem !important;
	vertical-align: middle !important;
}
</style>
</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
		<c:set var="title" value="회원 관리"></c:set>
		<!-- 관리자 헤더네비바  -->
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper">
			<!-- 검색 옵션 영역 -->
			<div class="col-md-12" style="padding: 10px 20px 0px 20px">
			  <div class="card card-secondary" style="margin-bottom: 8px;">
			    <div class="card-header">
			    </div>
			    <form onsubmit="return false;">
			      <div class="card-body" style="padding: 10px 10px 0px;">
					  <div class="row mb-4" style="margin-bottom: 0px !important">
					
					    <!-- 이름 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="fullName" class="small">이름</label>
					      <input type="text" id="fullName" name="fullName" class="form-control form-control-sm" placeholder="이름" />
					    </div>
					
					    <!-- 생년월일 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="memBirth" class="small">생년월일</label>
					      <input type="text" id="memBirth" name="memBirth" class="form-control form-control-sm" placeholder="YYYYMMDD" />
					    </div>
					
					    <!-- 전화번호 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="memTelNo" class="small">전화번호</label>
					      <input type="text" id="memTelno" name="memTelno" class="form-control form-control-sm" placeholder="전화번호" />
					    </div>
					
					    <!-- 이메일 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="memEmail" class="small">이메일</label>
					      <input type="text" id="memEmail" name="memEmail" class="form-control form-control-sm" placeholder="이메일" />
					    </div>
					
					    <!-- 간편 로그인 회원 여부 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="snsMemYn" class="small">간편 로그인 회원 여부</label>
					      <select id="snsMemYn" name="snsMemYn" class="form-control form-control-sm">
					        <option value="all">전체</option>
					        <option value="Y">Y</option>
					        <option value="N">N</option>
					      </select>
					    </div>
					</div>
					
					<!-- 검색 옵션 2행  -->
					<div class="row mb-4" style="margin-bottom: 0px !important; margin-top: 0px !important">
					
					    <!-- 회원 구분 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="memSecCodeNo" class="small">회원 구분</label>
					      <select id="memSecCodeNo" name="memSecCodeNo" class="form-control form-control-sm">
					        <option value="all">전체</option>
					        <option value="M01">일반회원</option>
					        <option value="M02">아티스트</option>
					      </select>
					    </div>
					
					    <!-- 회원 상태 -->
					    <div class="col-md-2 form-group gap-5 mb-1">
					      <label for="memStatSecCodeNo" class="small">회원 상태</label>
					      <select id="memStatSecCodeNo" name="memStatSecCodeNo" class="form-control form-control-sm">
					        <option value="all">전체</option>
					        <option value="001">활동</option>
					        <option value="002">탈퇴</option>
					        <option value="003">휴면</option>
					        <option value="004">활동정지(3일)</option>
					        <option value="005">활동정지(7일)</option>
					      </select>
					    </div>
					
					    <!-- 검색 시작일 -->
					    <div class="col-md-3 form-group gap-5 mb-1">
					      <label for="startDate" class="small">가입 일자</label>
					      <div class="input-group date" data-target-input="nearest">
					        <input id="startDate" name="startDate" type="text" class="form-control form-control-sm datetimepicker-input" data-target="#startDate" />
					        <div class="input-group-append" data-target="#startDate" data-toggle="datetimepicker">
					          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					        </div>
					        <span class="mx-2 align-self-center">~</span>
					        <input id="endDate" name="endDate" type="text" class="form-control form-control-sm datetimepicker-input" data-target="#endDate" />
					        <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
					          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					        </div>
					      </div>
					    </div>
					
					    <!-- 검색 종료일 -->
					    <!-- <div class="col-md-2 form-group gap-5 mb-1">
					      <div class="input-group date" data-target-input="nearest">
					        <input id="endDate" name="endDate" type="text" class="form-control form-control-sm datetimepicker-input" data-target="#endDate" />
					        <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
					          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					        </div>
					      </div>
					    </div> -->
					    <div class="col-md-3" ></div>
					    <div class="col-md-1 form-group gap-5 mb-0">
							<label for="search-title" class="small">&ensp;</label>
							<p>
								<button type="button" class="btn btn-outline-dark col-md-12 " id="btnReset">초기화</button>
							</p>
						</div>
						<div class="col-md-1 form-group gap-5 mb-0">
							<label for="search-title" class="small">&ensp;</label>
							<p>
								<a type="button" id="btnSearch" class="btn btn-outline-primary col-md-12 ">검색</a>
							</p>
						</div>
					</div>	
					
				</div>
			
		
			    </form>
			  </div>
			</div>
			<!-- 검색옵션 끝 -->
			
			<div class="row text-center" style="padding: 0px 40px 0px 40px">
				<div class="card-body table-responsive p-0" style="text-align: center;">
					<table class="table table-hover text-nowrap" style="table-layout: auto; ">
						<thead>
							<tr>
								<th>순번</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화 번호</th>
								<th>생년월일</th>
								<th>가입 일자</th>
								<th>탈퇴 일자</th>
								<th>회원 상태</th>
								<th>회원 구분</th>
								<th>간편 로그인 회원 여부</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="listBody">

						</tbody>
					</table>
				</div>
				<!-- 페이징이 들어갈 영역 -->
				<div id="pagination-container" class="d-flex justify-content-center mt-3"></div>
			</div>
		</div>

		<!-- 모달 -->
		<form id="editForm" name="editForm">
			<div class="modal" id="updateModal">
				<div
					class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">회원 정보 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<input type="hidden" id="memNoModal" name="memNo" />
							<input type="hidden" id="fileGroupNo" name="fileGroupNo" />

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원 성씨</label>
								<div class="col-sm-8">
									<input type="text" id="memLastNameModal" name="memLastName"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원 이름</label>
								<div class="col-sm-8">
									<input type="text" id="memFirstNameModal" name="memFirstName"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">이메일</label>
								<div class="col-sm-8">
									<input type="text" id="memEmailModal" name="memEmail"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">전화번호</label>
								<div class="col-sm-8">
									<input type="text" id="memTelnoModal" name="memTelno"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">생년월일</label>
								<div class="col-sm-8">
									<input type="text" id="memBirthModal" name="memBirth"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">가입일자</label>
								<div class="col-sm-8">
									<input type="text" id="joinYmdModal" name="joinYmd"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">탈퇴일자</label>
								<div class="col-sm-8">
									<input type="text" id="secsnYmdModal" name="secsnYmd"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원상태</label>
								<div class="col-sm-8">
									<select class="form-select" aria-label="Default select example" id="memStatSecCodeNoModal"
										name="memStatSecCodeNo">
										<option value="001">활동</option>
										<option value="002">탈퇴</option>
										<option value="004">활동정지(3일)</option>
									</select>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원구분</label>
								<div class="col-sm-8">
									<select class="form-select" aria-label="Default select example"
										name="memSecCodeNo" id="memSecCodeNoModal" onchange="checkMemSecCodeNo()">
										<option value="M01">일반회원</option>
										<option value="M02">아티스트</option>
									</select>
								</div>
							</div>

							<!-- 아티스트 정보 입력 폼  -->
							<div id="artistForm" style="display: none;">
								<input type="hidden" id="artNo" name="artNo" />
								<div class="form-group row">
									<label class="col-sm-4 col-form-label">활동명</label>
									<div class="col-sm-8">
										<input type="text" id="artActNm" name="artActNm"
											class="form-control" required />
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-4 col-form-label">아티스트 소개</label>
									<div class="col-sm-8">
										<input type="text" id="artExpln" name="artExpln"
											class="form-control" required />
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-4 col-form-label">아티스트 프로필 사진</label>
									<div class="col-sm-8">
										<img id="artImgPrev" src="" style="width: 50%"/>
										<input type="file" id="uploadFile" name="uploadFile"
											class="form-control" onChange="readFile(this)" required />
									</div>
								</div>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" id="testBtn">시연용</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal" onclick="editPost()">저장</button>
						</div>  
					</div>
				</div>
			</div>
		</form>


		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>

	</div>
	<script type="text/javascript">
	function updateMember(memNo){
		fetch("/admin/member/memberEdit?memNo="+memNo).then(resp=>{
			console.log(resp);
			resp.json().then(data=>{
				console.log("회원수정모달 : ", data);
				
				document.querySelector('#memNoModal').value = data.memNo;
				document.querySelector('[name="fileGroupNo"]').value = data.artistVO.fileGroupNo;
				document.querySelector('[name="artNo"]').value = data.artistVO.artNo;
	            document.querySelector('#memLastNameModal').value = data.memLastName;
	            document.querySelector('#memFirstNameModal').value = data.memFirstName;
	            document.querySelector('#memEmailModal').value = data.memEmail;
	            document.querySelector('#memTelnoModal').value = data.memTelno;
	            document.querySelector('#memBirthModal').value = data.memBirth;
	            document.querySelector('#joinYmdModal').value = data.joinYmd;
	            document.querySelector('#secsnYmdModal').value = data.secsnYmd;
	            document.querySelector('#memStatSecCodeNoModal').value = data.memStatSecCodeNo;
	            document.querySelector('#memSecCodeNoModal').value = data.memSecCodeNo;
				
	            console.log("data.memSecCodeNo : ", data.memSecCodeNo);
	            //data : MemberVO
	            //data.artistVO : ArtistVO
				if(data.memSecCodeNo === "M02"){//아티스트 회원
					console.log("data.artistVO : ", data.artistVO);
				
					document.querySelector("#artistForm").style.display = "block";
					
					document.querySelector('[name="artActNm"]').value = data.artistVO.artActNm;//활동명artisartActNm
	                document.querySelector('[name="artExpln"]').value = data.artistVO.artExpln;//아티스트 소개artExpln
	                document.querySelector('[name="uploadFile"]').value = data.artistVO.uploadFile;//아티스트 프로필 사진
	                //아티스트 프로필 사진 보이기
	                if(data.artistVO && data.artistVO.fileGroupVO && data.artistVO.fileGroupVO.fileDetailVOList && data.artistVO.fileGroupVO.fileDetailVOList.length > 0){
	                	
	                	let fileDetailVOList = data.artistVO.fileGroupVO.fileDetailVOList;
	                	let str = '';
	                	
	                	fileDetailVOList.forEach(file =>{
			                str += `
			                	<img src="/upload\${file.fileSaveLocate}" style="width:50%;" id="artImg"  />
			                `;
	                	});
	                	
	                	//대상엘리먼트.bofore()
		                /*
		                부모
		                	형           : 나.before()
		                	나(대상엘리먼트) : 달러("샵uploadFile")
		                	동생			: 나.after()
		                */
	                		
						$("#uploadFile").before(str);
	                	
						
		                	
	                }else{
	             		
	             		/* //모달창의 회원구분을 [일반회원]로 선택
						$("select[name='memSecCodeNo']").val("M01"); */
	             		
	                	let str = `<img src="" style="width:50%;" id="artImg"  />`;
	                	$("#uploadFile").before(str);
	                }
		            
				}else{//일반 회원
					document.querySelector("#artistForm").style.display = "none";
				
					//일반 회원은 활동명이 없음
					$("#artActNm").val("");
					
					//일반 회원은 아티스트 소개가 없음
					$("#artExpln").val("");
				}
	            
				//모달창의 회원구분을 [아티스트]로 선택
				//document.querySelector('#memSecCodeNoModal').value = data.memSecCodeNo;
				
				// 시연용 버튼 시작
				document.getElementById("testBtn").addEventListener("click", ()=>{
					console.log("시연용");
					document.getElementById("artExpln").value="최고의 아티스트이자 최고의 선생님!";
					document.getElementById("artActNm").value="송중호";
				});
				// 시연용 버튼 끝
		
			})
		})
		
	}

	function editPost(){
				
		console.log("왔나용");
		for(let i=0; i< document.querySelector("#editForm").elements.length; i++){
			let elem = document.querySelector("#editForm").elements[i];
			console.log("name",elem.name, "value",elem.value);
		}

		//가상의 form : <form></form>
		let formData = new FormData(document.querySelector("#editForm"));  // encType 무조건 Multipart/form-data
		
		console.log("폼데이타"+ formData);
		
		let memSecCodeNo = document.querySelector('#memSecCodeNoModal').value;
		//memSecCodeNo :  M02
		console.log("memSecCodeNo : ",memSecCodeNo);
		
		//회원구분이 아티스트일 경우 실행
		if(memSecCodeNo=="M02"){
			let files = $("#uploadFile")[0].files;
			
			formData.append("artistVO.artActNm",$("#artActNm").val());//활동명
			formData.append("artistVO.artExpln",$("#artExpln").val());//아티스트 소개
			formData.append("artistVO.artNo",$("#artNo").val());
			formData.append("artistVO.fileGroupNo",$("#fileGroupNo").val());
			
			for(let i=0; i<files.length; i++){
				formData.append("artistVO.uploadFile",files[i]);//아티스트 프로필 사진
			}
		}
		
		fetch("/admin/member/memberEditPost", {
				method : "post",
				body : formData
				
		}).then(resp=>{
			console.log("resp :", resp);
			
			resp.json().then(data=>{
				console.log("회원정보업뎃 : ", data);
				//alert("됐나");
				location.href = location.href;
				
			})
		})
	}
	
	function deleteMember(memNo){
		fetch("/admin/member/memberDelete?memNo="+memNo, {
			method : "post"
		}).then(resp=>{
			console.log(resp);
			resp.text().then(data=>{
				console.log("회원정보삭제 : ", data);
				
				let trs = document.querySelectorAll("table > tbody > tr ")
				console.log("새로 고침",trs);
				

				if(trs.length == 1){
					 let queryString = location.href.split("?")[1];
					 let startIndex = queryString.indexOf("currentPage=")+12;
					 let endIndex = queryString.indexOf("&",startIndex);
					 console.log("페이지 넘버",queryString.substring(startIndex,endIndex));
					 let pageNum = queryString.substring(startIndex,endIndex);
					 
					 // 1페이지 일 때  마지막 멤버 삭제 시 0이 되어버림
					 // 방지하기 위해 최솟값 1로 유지
					 pageNum = Math.max(1, pageNum-1);
					
					 queryString = queryString.substring(0,startIndex) + pageNum + queryString.substring(endIndex);		 
					 //alert(queryString);
					 location.href = location.href.split("?")[0]+"?"+queryString;
					
				}else {
					
					location.href = location.href;					
				}
				
				
			})
		})
	}
	
	function checkMemSecCodeNo(){
		let selectedValue = document.querySelector('#memSecCodeNoModal').value;
		let artistForm = document.querySelector("#artistForm");
		
		if(selectedValue === "M02"){
			artistForm.style.display = "block";
		}else{
			artistForm.style.display = "none";
		}
	}
	
	// 파일 미리보기 모달창 초기화
	$(document).ready(function () {
	    $("#updateModal").on("hide.bs.modal", function () {
	    	$("#artImgPrev").remove(); // 이미지 초기화
	    	$("#artImg").remove(); // 이미지 초기화
 	        $("#uploadFile").val(""); 
	    });
	});
	
	function readFile(input){
	    var reader;
	        console.log("input : ",input);
	    for(var file of input.files){
	        reader= new FileReader();
	        reader.onload = function(e){
	        	console.log(e);
	        	var imgPrev=document.querySelector("#artImgPrev")
	            imgPrev.setAttribute("src",e.target.result);
	        };
	        console.log("dddd",reader);
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
</script>
	<script src="/js/member/memberList.js?a=2"></script>
</body>
</html>