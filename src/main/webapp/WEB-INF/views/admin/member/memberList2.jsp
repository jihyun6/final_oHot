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
</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
		<!-- 관리자 헤더네비바  -->
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper">
			${boardPage }
			<div class="container mt-4">
				<h2>회원 목록</h2>
				<div class="row">
					<div class="col-md-4">
						<label for="search" class="form-label">검색:</label> <input
							type="text" id="search" class="form-control"
							placeholder="이름, 전화번호 검색">
					</div>
					<div class="col-md-2">
						<label for="gender" class="form-label">성별:</label> <select
							id="gender" class="form-select">
							<option value="">전체</option>
							<option value="남">남</option>
							<option value="여">여</option>
						</select>
					</div>
					<div class="col-md-2">
						<label for="age" class="form-label">나이:</label> <select id="age"
							class="form-select">
							<option value="">전체</option>
							<option value="20대">20대</option>
							<option value="30대">30대</option>
							<option value="40대">40대</option>
						</select>
					</div>
					<div class="col-md-2 align-self-end">
						<button class="btn btn-primary">검색</button>
					</div>
				</div>


				<!-- 탭 시작 -->
				<div class="nav nav-tabs">
					<a class="nav-link ${empty param.memberType ? 'active' : ''}" aria-selected="${empty param.memberType? 'true' : 'false' }" 
						href="/admin/member/memberList?memberType=">전체</a>
					<a class="nav-link ${param.memberType eq 'M01' ? 'active' : ''}" aria-selected="${param.memberType eq 'M01' ? 'true' : 'false' }" 
						href="/admin/member/memberList?memberType=M01">일반 회원</a>
					<a class="nav-link ${param.memberType eq 'M02' ? 'active' : ''}" aria-selected="${param.memberType eq 'M02' ? 'true' : 'false' }" 
						href="/admin/member/memberList?memberType=M02">아티스트 회원</a>
				</div>
			

				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="all" role="tabpanel"
						aria-labelledby="all-tab">
						<table class="table table-hover mt-3">
							<thead class="table-dark">
								<tr>
									<th>No</th>
									<th>이름</th>
									<th>이메일</th>
									<th>전화번호</th>
									<th>생년월일</th>
									<th>가입일자</th>
									<th>탈퇴일자</th>
									<th>회원상태</th>
									<th>회원구분</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="memberVO" items="${boardPage.content}">
									<tr>
										<td>${memberVO.rnum }</td>
										<td>${memberVO.memLastName }${memberVO.memFirstName }</td>
										<td>${memberVO.memEmail }</td>
										<td>${memberVO.memTelno }</td>
										<td>${memberVO.memBirth }</td>
										<td>${memberVO.joinYmd }</td>
										<td>${memberVO.secsnYmd }</td>
										<td>${memberVO.memStatSecCodeNo }</td>
										<td>${memberVO.memSecCodeNo }</td>
										<td>
											<button type="button" class="btn btn-secondary"
												data-toggle="modal" data-target="#updateModal"
												id="updateMember" onclick="updateMember(${memberVO.memNo})">수정</button>
										</td>
										<td>
											<button type="button" class="btn btn-danger"
												data-toggle="modal" id="deleteMember"
												onclick="deleteMember(${memberVO.memNo})">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 전체회원 탭 끝  -->


					<div class="d-flex justify-content-center mt-3">
						<ul class="pagination">
							<li
								class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a
								href="/admin/member/memberList?currentPage=1&keyword=${param.keyword}&mode=${param.mode}"
								class="page-link"><<</a>
							</li>
							<li
								class="paginate_button page-item <c:if test='${boardPage.startPage lt (boardPage.blockSize + 1)}'>disabled</c:if>">
								<a
								href="/admin/member/memberList?currentPage=${boardPage.startPage - 1}&keyword=${param.keyword}&mode=${param.mode}"
								class="page-link"><</a>
							</li>

							<c:forEach var="pNo" begin="${boardPage.startPage}"
								end="${boardPage.endPage}" step="1">
								<li
									class="paginate_button page-item <c:if test='${param.currentPage == pNo}'>active</c:if>">
									<a
									href="/admin/member/memberList?currentPage=${pNo}&keyword=${param.keyword}&mode=${param.mode}"
									class="page-link">${pNo}</a>
								</li>
							</c:forEach>

							<li
								class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a
								href="/admin/member/memberList?currentPage=${boardPage.startPage + boardPage.blockSize}&keyword=${param.keyword}&mode=${param.mode}"
								class="page-link">></a>
							</li>
							<li
								class="paginate_button page-item next <c:if test='${boardPage.endPage ge boardPage.totalPages}'>disabled</c:if>">
								<a
								href="/admin/member/memberList?currentPage=${boardPage.totalPages}&keyword=${param.keyword}&mode=${param.mode}"
								class="page-link">>></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 모달 -->
		<form id="editForm" name="editForm">
			<div class="modal" id="updateModal">
				<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">회원 정보 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<input type="hidden" id="memNo" name="memNo" /> <input
								type="hidden" id="fileGroupNo" name="fileGroupNo" />

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원 성씨</label>
								<div class="col-sm-8">
									<input type="text" id="memLastName" name="memLastName"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원 이름</label>
								<div class="col-sm-8">
									<input type="text" id="memFirstName" name="memFirstName"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">이메일</label>
								<div class="col-sm-8">
									<input type="text" id="memEmail" name="memEmail"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">전화번호</label>
								<div class="col-sm-8">
									<input type="text" id="memTelno" name="memTelno"
										class="form-control" />
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">생년월일</label>
								<div class="col-sm-8">
									<input type="text" id="memBirth" name="memBirth"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">가입일자</label>
								<div class="col-sm-8">
									<input type="text" id="joinYmd" name="joinYmd"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">탈퇴일자</label>
								<div class="col-sm-8">
									<input type="text" id="secsnYmd" name="secsnYmd"
										class="form-control" />
									<code>* ex) 20250317</code>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원상태</label>
								<div class="col-sm-8">
									<select class="form-select" aria-label="Default select example"
										name="memStatSecCodeNo">
										<option value="001">활동</option>
										<option value="002">탈퇴</option>
										<option value="003">휴면</option>
										<option value="004">활동정지(7일)</option>
										<option value="005">활동정지(14일)</option>
									</select>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-4 col-form-label">회원구분</label>
								<div class="col-sm-8">
									<select class="form-select" aria-label="Default select example"
										name="memSecCodeNo" onchange="checkMemSecCodeNo()">
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
										<div id="artImgPrev"></div>
										<input type="file" id="uploadFile" name="uploadFile"
											class="form-control" onChange="readFile(this)" required />
									</div>
								</div>
							</div>


						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
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
				
				document.querySelector('[name="memNo"]').value = data.memNo;
				document.querySelector('[name="fileGroupNo"]').value = data.artistVO.fileGroupNo;
				document.querySelector('[name="artNo"]').value = data.artistVO.artNo;
	            document.querySelector('[name="memLastName"]').value = data.memLastName;
	            document.querySelector('[name="memFirstName"]').value = data.memFirstName;
	            document.querySelector('[name="memEmail"]').value = data.memEmail;
	            document.querySelector('[name="memTelno"]').value = data.memTelno;
	            document.querySelector('[name="memBirth"]').value = data.memBirth;
	            document.querySelector('[name="joinYmd"]').value = data.joinYmd;
	            document.querySelector('[name="secsnYmd"]').value = data.secsnYmd;
	            document.querySelector('[name="memStatSecCodeNo"]').value = data.memStatSecCodeNo;
	            document.querySelector('[name="memSecCodeNo"]').value = data.memSecCodeNo;
				
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
	             		console.log("18");
	                	let str = `<img src="" style="width:50%;" id="artImg"  />`;
	                	$("#uploadFile").before(str);
	                }
		            
				}else{//일반 회원
					document.querySelector("#artistForm").style.display = "none";
				}
				
			})
		})
		
	}

	function editPost(){
		
		/* const editData = {
				"memNo" : editForm.memNo.value,
				"memLastName" : editForm.memLastName.value,
				"memFirstName" : editForm.memFirstName.value,
				"memEmail" : editForm.memEmail.value,
				"memTelno" : editForm.memTelno.value,
				"memBirth" : editForm.memBirth.value,
				"joinYmd" : editForm.joinYmd.value,
				"secsnYmd" : editForm.secsnYmd.value,
				"memStatSecCodeNo" : editForm.memStatSecCodeNo.value,
				"memSecCodeNo" : editForm.memSecCodeNo.value
				
		} */
		
		console.log("왔나용");
		for(let i=0; i< document.querySelector("#editForm").elements.length; i++){
			let elem = document.querySelector("#editForm").elements[i];
			console.log("name",elem.name, "value",elem.value);
		}

		//가상의 form : <form></form>
		let formData = new FormData(document.querySelector("#editForm"));  // encType 무조건 Multipart/form-data
		
		console.log("폼데이타"+ formData);
		
		let memSecCodeNo = $("select[name='memSecCodeNo']").val();
		//memSecCodeNo :  M02
		console.log("memSecCodeNo : ",memSecCodeNo);
		
		//회원구분이 아티스트일 경우 실행
		if(memSecCodeNo=="M02"){
			let files = $("#uploadFile")[0].files;
			
			formData.append("artistVO.artActNm",$("#artActNm").val());//활동명
			formData.append("artistVO.artExpln",$("#artExpln").val());//아티스트 소개
			formData.append("artistVO.fileGroupNo",$("#fileGroupNo").val());//아티스트 소개
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
				alert("됐나");
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
		let selectedValue = document.querySelector('[name="memSecCodeNo"]').value;
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
	    	$("#artImgPrev img").remove(); // 이미지 초기화
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
	        	var imgPrev=document.querySelector("#artImg")
	            imgPrev.setAttribute("src",e.target.result);
	        };
	        console.log("dddd",reader);
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	
</script>
</body>
</html>