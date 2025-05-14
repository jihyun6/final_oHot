<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="false" %>
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
				<h2 class="mb-4">아티스트 그룹 상세</h2>
					<input type="hidden" value="${artistGroupDetail.artGroupNo}" name="artGroupNo" />
					<input type="hidden" value="${artistGroupDetail.fileGroupNo}" name="fileGroupNo" />

					<div class="artist-group-container">
						<!-- 왼쪽: 그룹 정보 입력 -->
						<div class="artist-info-left">
							<div class="form-group row">
								<label class="col-sm-3">데뷔일자</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupDebutYmd" name="artGroupDebutYmd"
										class="form-control" value="${artistGroupDetail.artGroupDebutYmd }" readonly />
									<code>* ex) 20250317</code>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹명(영어)</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupNm" name="artGroupNm"
										class="form-control" value="${artistGroupDetail.artGroupNm }" readonly />
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹명(한글)</label>
								<div class="col-sm-9">
									<input type="text" id="artGroupNmKo" name="artGroupNmKo"
										class="form-control" value="${artistGroupDetail.artGroupNmKo }" readonly />
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 소개</label>
								<div class="col-sm-9">
									<textarea id="artGroupExpln" name="artGroupExpln" class="form-control" readonly>${artistGroupDetail.artGroupExpln }</textarea>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 로고 사진</label>
								<div class="col-sm-9">
									<c:choose>
										<c:when test="${not empty artistGroupDetail.fileLogoSaveLocate}">
											<img src="/upload${artistGroupDetail.fileLogoSaveLocate}" alt="logoFile" style="width: 100px; height: 100px; border-radius: 50%;" />
										</c:when>
										<c:otherwise>
											<img alt="logoFile" class="preview-img" src="/images/nofile.png" style="width:100px;height:100px;">
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3">그룹 프로필 사진</label>
								<div class="col-sm-9">
									<img src="/upload${artistGroupDetail.fileGroupVO.fileDetailVOList[0].fileSaveLocate }"
										alt="Artist Group Profile Image" style="width: 100%; max-width: 400px;" id="profileImg" />
								</div>
							</div>
						</div>
					
						<!-- 오른쪽: 아티스트 추가 및 목록 -->
						<div class="artist-card-container">
							<div class="form-group mt-3">
								<label>그룹 아티스트 목록</label>
								<div id="selectedArtistList" class="d-flex flex-wrap gap-3 mt-4" style="max-height: 500px; overflow-y: auto;">
									<!-- 선택된 아티스트 카드가 여기에 추가됨 -->
									<c:choose>
										<c:when test="${not empty artistVOList}">
											<c:forEach var="artistVO" items="${artistVOList }">
												<div class="artist-card" data-artno="${artistVO.artNo }">
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
											<div class="d-flex align-items-center justify-content-center text-center text-muted bg-light border border-secondary rounded p-4 w-100" style="border-style: dashed; min-height: 300px;">
											  <div>
											    <div style="font-size: 2.0rem;">➕</div>
											    <p class="mt-3 h6">수정 버튼을 눌러 아티스트를 추가해주세요</p>
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
							<a href="/admin/artistGroup/artistGroupEdit?artGroupNo=${artistGroupDetail.artGroupNo}"
								class="btn btn-primary mr-2">수정</a>
						</div>
					</div>
			</div>

		</div>

		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>

	</div>
<c:if test="${not empty registerSuccess}">
<script>
Swal.fire({
    icon: 'success',
    title: '등록 완료!',
    text: '아티스트 그룹이 성공적으로 등록되었습니다.',
    timer : 1000
});
</script>
</c:if>
</body>
</html>