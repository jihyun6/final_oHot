<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<!-- 등록 시작 -->
			<div class="container mt-4">
				<h2 class="mb-4">아티스트 상세</h2>
				<form action="/admin/artist/registerPost" method="post"
					enctype="multipart/form-data" name="newArtistGroup">
					<div class="form-group row" style="padding:10px;">
						<label class="col-sm-2">아티스트 활동명</label>
						<div class="col-sm-3">
							<input type="text" id="artGroupDebutYmd" name="artGroupDebutYmd"
								class="form-control"
								value="${artistVODetail.artActNm }" readonly />
							<code>* ex) 20250317</code>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">아티스트 소개</label>
						<div class="col-sm-3">
							<input type="text" id="artGroupNm" name="artGroupNm"
								class="form-control" value="${artistVODetail.artExpln }"
								readonly />
						</div>
					</div>


					<div class="form-group row">
						<label class="col-sm-2">아티스트 프로필 사진</label>
						<div class="col-sm-5">
							<img
								src="/upload${artistVODetail.fileGroupVO.fileDetailVOList[0].fileSaveLocate }"
								alt="Artist Group Image" style="width: 400px; height: 400px;" />
						</div>
					</div>
					
					
					
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<a
								href="/admin/artist/artistEdit?artNo=${artistVODetail.artNo }"
								class="btn btn-primary">수정</a> <a
								href="/admin/artist/artistList" class="btn btn-info">목록보기</a>
						</div>
					</div>
				</form>
			</div>
		</div>


		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>

	</div>
	
	
</body>
</html>