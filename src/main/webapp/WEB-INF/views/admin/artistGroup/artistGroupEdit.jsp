<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<style>
	.artist-group-container {
		display: flex;
		justify-content: space-between;
		gap: 2rem;
		margin-top: 2rem;
	}
	
	.artist-info-left {
		flex: 1;
		padding-right: 2rem;
		border-right: 1px solid #ddd;
	}
	
	.artist-card-container {
		flex: 1;
		padding-left: 2rem;
	}
	
	#artGroupExpln {
		height: 200px;
		resize: vertical;
	}
	
	#selectedArtistList {
		max-height: 400px;
		overflow-y: auto;
		padding-right: 1rem;
	}
	
	.artist-card {
		position: relative;
		width: 100px;
		text-align: center;
		border: 1px solid #ddd;
		border-radius: 0.75rem;
		padding: 0.5rem;
		box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		background-color: #fff;
	}

	.artist-card img {
		width: 60px;
		height: 60px;
		border-radius: 50%;
		object-fit: cover;
		margin-bottom: 0.5rem;
	}

	.artist-card .artist-remove-btn {
		position: absolute;
		top: 5px;
		right: 5px;
		border: none;
		background: transparent;
		color: red;
		font-size: 1rem;
		cursor: pointer;
	}
	label {
	  white-space: nowrap;
	}
</style>
</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
		<c:set var="title" value="아티스트 그룹 관리"></c:set>
		<!-- 관리자 헤더네비바  -->
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>
		
		<!-- 컨텐츠-->
		<div class="content-wrapper">
			<div class="container">
				<h2 class="mb-4">아티스트 그룹 수정</h2>
				<form action="/admin/artistGroup/artistGroupEditPost" method="post"
					enctype="multipart/form-data" name="editArtistGroupForm">
					<input type="hidden" value="${artistGroupDetail.artGroupNo}" name="artGroupNo" />
					<input type="hidden" value="${artistGroupDetail.fileGroupNo}" name="fileGroupNo" />

					<div class="artist-group-container">
						<!-- 왼쪽: 그룹 정보 입력 -->
						<div class="artist-info-left">
							<div class="form-group row">
								<label class="col-sm-3">데뷔일자</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupDebutYmd" name="artGroupDebutYmd"
										class="form-control" value="${artistGroupDetail.artGroupDebutYmd }" />
									<code>* ex) 20250317</code>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹명(영어)</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupNm" name="artGroupNm"
										class="form-control" value="${artistGroupDetail.artGroupNm }"  />
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹명(한글)</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupNmKo" name="artGroupNmKo"
										class="form-control" value="${artistGroupDetail.artGroupNmKo }"  />
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 소개</label>
								<div class="col-sm-9">
									<textarea id="artGroupExpln" name="artGroupExpln" class="form-control">${artistGroupDetail.artGroupExpln }</textarea>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 로고 사진</label>
								<div class="col-sm-9">
									<div id="logo">
										<c:choose>
											<c:when test="${not empty artistGroupDetail.fileLogoSaveLocate}">
												<img src="/upload${artistGroupDetail.fileLogoSaveLocate}" alt="logoFile" style="width: 100px; height: 100px;border-radius: 50%;" />
												<input type="hidden" name="logoFileGroupNo" value="${artistGroupDetail.logoFileGroupNo }"> 
												<div class="mt-2">
													<button type="button" class="btn btn-sm btn-secondary me-2" onclick="triggerLogoUpload()">로고 수정</button>
													<button type="button" class="btn btn-sm btn-danger" onclick="setDefaultLogo()">삭제</button>
												</div>
											</c:when>
											<c:otherwise>
												<img alt="logoFile" class="preview-img" src="/images/nofile.png" style="width:100px;height:100px;border-radius: 50%;">
												<button type="button" id="logoFileBtn" class="btn btn-sm btn-secondary" onclick="triggerLogoUpload()">로고 등록</button>
											</c:otherwise>
										</c:choose>
									</div>
									
									<input type="file" id="uploadFileLogo" name="uploadFileLogo" class="form-control profile-img d-none" onchange="logoImg();" />
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 프로필 사진</label>
								<div class="col-sm-9">
									<img src="/upload${artistGroupDetail.fileGroupVO.fileDetailVOList[0].fileSaveLocate }"
										alt="" style="width: 100%; max-width: 400px;" id="profileImg" />
									<input type="file" id="uploadFile" name="uploadFile" class="form-control mt-2"
										onchange="readFile(this, '#profileImg')" />
								</div>
							</div>
							
						</div>
					
						<!-- 오른쪽: 아티스트 추가 및 목록 -->
						<div class="artist-card-container">
							<div class="form-group">
								<label>아티스트 추가</label>
								<input type="text" id="artistSearch" class="form-control"
									autocomplete="off" placeholder="아티스트 활동명을 검색하세요" />
								<ul id="autocompleteList" class="list-group position-absolute w-100" style="z-index: 999; display: none;"></ul>
							</div>
					
							<div class="form-group mt-3">
								<label>그룹 아티스트 목록</label>
								<div id="selectedArtistList" class="d-flex flex-wrap gap-3 mt-4" style="max-height: 400px; overflow-y: auto;">
									<!-- 선택된 아티스트 카드가 여기에 추가됨 -->
									<c:choose>
										<c:when test="${not empty artistVOList}">
											<c:forEach var="artistVO" items="${artistVOList }">
												<div class="artist-card" data-artno="${artistVO.artNo }" data-memno="${artistVO.memNo }">
													<button type="button" class="artist-remove-btn">&minus;</button>
													<c:choose>
														<c:when test="${not empty artistVO.fileGroupVO.fileDetailVOList}">
															<img alt="프로필" src="/upload${artistVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" style="width:50px">
														</c:when>
														<c:otherwise>
															<img alt="기본 프로필" src="/images/defaultProfile.jpg" style="width:50px">
														</c:otherwise>
													</c:choose>
													<div class="mt-2">${artistVO.artActNm }</div> 
												</div>
											</c:forEach> 
										</c:when>
										<c:otherwise>
											<div id="emptyArtistMsg" class="d-flex align-items-center justify-content-center text-center text-muted bg-light border border-secondary rounded p-4 w-100" style="border-style: dashed; min-height: 300px;">
											  <div>
											    <div style="font-size: 2.0rem;">➕</div>
											    <p class="mt-3 h6">아티스트를 추가해주세요</p>
											    <p class="text-secondary small">검색란에서 아티스트를 클릭하면 이 영역에 표시됩니다.</p>
											  </div>
											</div>
										</c:otherwise>									
									</c:choose>
								</div>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<div class="col-12 d-flex justify-content-end">
							<c:choose>
								<c:when test="${artistGroupDetail.artGroupDelYn == 'N'}">
									<a href="/admin/artistGroup/artistGroupDelete?artGroupNo=${artistGroupDetail.artGroupNo}" class="btn btn-warning mr-2">서비스 중단</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/artistGroup/artistGroupActive?artGroupNo=${artistGroupDetail.artGroupNo}" class="btn btn-success mr-2">서비스 활성화</a>
								</c:otherwise>
							</c:choose>
							<a href="/admin/artistGroup/artistGroupList" class="btn btn-info mr-2">목록</a>
							<input type="button" class="btn btn-primary" value="저장" onclick="confirmEditArtistGroup()" />
						</div>
					</div>
				</form>
			</div>

		</div>

		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>

	</div>
	<script type="text/javascript">
		const input = document.querySelector("#artistSearch");
		const autocompleteList = document.querySelector("#autocompleteList");
		const selectedList = document.querySelector("#selectedArtistList");

		document.addEventListener("DOMContentLoaded", () =>{
			document.querySelectorAll(".artist-card").forEach(card=>{
				const artNo = card.getAttribute("data-artno");
				const memNo = card.getAttribute("data-memno");
				const removeBtn = card.querySelector(".artist-remove-btn");

				const artistData = {
					artNo : artNo,
					memNo : memNo
				};
				
				if(removeBtn){
					removeBtn.addEventListener("click", ()=>{
						removeArtistGroup(artistData, card);
					})
				}
			});
		});

		
		function confirmEditArtistGroup() {
			Swal.fire({
				title: '정말 수정하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					editArtistGroup();
				}
			});
		} 
		

		function editArtistGroup() {
			$("form[name='editArtistGroupForm']").submit();
		}
		
		function readFile(input, targetImgSelector){
		    if(input.files && input.files[0]){
				let reader = new FileReader();
				reader.onload = function(e){
					console.log(e);
					document.querySelector(targetImgSelector).setAttribute("src",e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		input.addEventListener("input", ()=>{
			const keyword = input.value.trim();
			
			if (keyword.length === 0){
				autocompleteList.style.display = "none";
				return;
			}

			fetch('/admin/artistGroup/artistSearch?keyword='+keyword)
				.then(resp => {
					console.log("resp: ", resp);
					return resp.json();
				}).then(data=>{
					console.log("data", data)
					autocompleteList.innerHTML = "";
					if(data.length === 0){
						autocompleteList.style.display = "none";
						return;
					}
					data.forEach(artist =>{
						const li = document.createElement("li");
						li.className = "list-group-item";
						li.style = "width:510px;"
						li.innerHTML = `<strong>\${artist.artActNm}</strong>(\${artist.memVO.memLastName}\${artist.memVO.memFirstName})`;
						li.addEventListener("click", ()=> addArtistToGroup(artist));
						autocompleteList.appendChild(li); 
							
					}); 
					autocompleteList.style.display = "block";
				})
			});

		 	document.addEventListener("click", e=>{
			if(!autocompleteList.contains(e.target) && e.target !== input){
				autocompleteList.style.display = "none";
			} 
		})

		function addArtistToGroup(artist){

			artist.artGroupNo = document.querySelector("input[name='artGroupNo']").value;

			fetch(`/admin/artistGroup/updateGroup`,{
				method : "POST",
				headers : {
					"Content-Type" : "application/json"
				},
				body:JSON.stringify(artist)
			}).then(resp =>{
				console.log("아티스트 추가 : ", resp);
				return resp.text();
			}).then(result=>{
				if(result.includes("success")){
					
					const emptyMsg = document.querySelector("#emptyArtistMsg");
					if(emptyMsg){
						emptyMsg.remove();
					}
					
					const fileList = artist.fileGroupVO?.fileDetailVOList;
					const filePath = (fileList && fileList.length > 0) ? `/upload\${fileList[0].fileSaveLocate}` : '/images/defaultProfile.jpg';
					
					const card = document.createElement("div");
					
					
					card.className = "artist-card";
					card.setAttribute("data-artno", artist.artNo);
					card.innerHTML = `
						<button type="button" class="artist-remove-btn">&minus;</button>
						<img src="\${filePath}" alt="프로필" style="width:50px"/>
						<div class="mt-2">\${artist.artActNm}</div>
					`;
					card.querySelector(".artist-remove-btn").addEventListener("click", ()=>{
						console.log("바뀌었낭 1?",artist);
						removeArtistGroup(artist, card);
					})
					selectedList.appendChild(card);
					input.value = "";
					autocompleteList.style.display = "none";
				}
			});	
		}

		function removeArtistGroup(artist, cardElement){
			console.log("영신 미웡:",artist, " cardElement",cardElement);
			fetch(`/admin/artistGroup/removeGroup`,{
				method:"POST",
				headers:{
					"Content-Type": "application/json"
				},
				body:JSON.stringify(artist)
			}).then(resp=> {
				console.log("그룹 삭제");
				return resp.text();	
			}).then(result=>{
				if(result.includes("success")){
					cardElement.remove();
					
					const cardList = document.querySelectorAll(".artist-card");
					if(cardList.length === 0){
						const container = document.querySelector("#selectedArtistList");
						container.innerHTML = getEmptyArtistMessageHTML();
					}
				}
			});

		}

		function getEmptyArtistMessageHTML(){
			return `
				<div id="emptyArtistMsg" class="d-flex align-items-center justify-content-center text-center text-muted bg-light border border-secondary rounded p-4 w-100" style="border-style: dashed; min-height: 300px;">
				  <div>
				    <div style="font-size: 2.0rem;">➕</div>
				    <p class="mt-3 h6">아티스트를 추가해주세요</p>
				    <p class="text-secondary small">검색란에서 아티스트를 클릭하면 이 영역에 표시됩니다.</p>
				  </div>
				</div>
			`;
		}
		
		function logoImg(){
			
			
			let fileInput = document.querySelector("#uploadFileLogo");
			let formData = new FormData();

			formData.append("uploadFileLogo", fileInput.files[0]);

			fetch("/admin/artistGroup/logoFilePost",{
				method:"post",
				body : formData

			}).then(resp=>resp.json())
			  .then(data=>{
					console.log("파일로공:", data);
					
					const defaultLogo = document.querySelector("img[alt='logoFile']");
					const logoFileBtn = document.querySelector("button[id='logoFileBtn']");
					if (defaultLogo) {
					  defaultLogo.remove();
					 
					}
					if(logoFileBtn){
						
					  logoFileBtn.remove();
					}
					
					const oldInput = document.querySelector("input[name='logoFileGroupNo']");
					if(oldInput){
						oldInput.remove();
					}
					
					
					const logoDiv = document.querySelector("#logo");
					logoDiv.innerHTML = ""; // 이미지, input 제거
					
					let img = document.createElement("img");
					img.src = data?.fileSaveLocate ? "/upload"+data.fileSaveLocate : "/images/nofile.png";
					img.style = "width:100px;height:100px;border-radius: 50%;";
					img.id = "logoFile";
					logoDiv.appendChild(img);
					
					readFile(fileInput, "#logoFile");

					let input = document.createElement("input");
					input.name = "logoFileGroupNo";
					input.value = data.fileGroupNo;
					input.type = "hidden";
					logoDiv.appendChild(input);

					let btnGroup= document.createElement("div");
					btnGroup.className = "mt-2"
					
					// 다시 업로드 버튼 생성
					let reuploadBtn = document.createElement("button");
					reuploadBtn.type = "button";
					reuploadBtn.className = "btn btn-sm btn-secondary me-2";
					reuploadBtn.innerText = "로고 수정";
					reuploadBtn.addEventListener("click", ()=>{

						logoDiv.innerHTML = "";
						triggerLogoUpload();

					});
					btnGroup.appendChild(reuploadBtn);

					let deleteBtn = document.createElement("button");
					deleteBtn.type = "button";
					deleteBtn.className = "btn btn-sm btn-danger";
					deleteBtn.innerText = "삭제";
					deleteBtn.addEventListener("click", ()=>{
						logoDiv.innerHTML = "";
						setDefaultLogo();

					});
					btnGroup.appendChild(deleteBtn);

					logoDiv.appendChild(btnGroup);
				}
				
		)};
		
		function triggerLogoUpload(){
			document.querySelector("#uploadFileLogo").click();
		}

		function setDefaultLogo() {
			const logoDiv = document.querySelector("#logo");
			logoDiv.innerHTML = `
			    <img alt="logoFile" class="preview-img" src="/images/nofile.png" style="width:100px;height:100px;">
				<button type="button" id="logoFileBtn" class="btn btn-sm btn-secondary" onclick="triggerLogoUpload()">로고 등록</button>
			`;
		}

		
	</script>
</body>
</html>