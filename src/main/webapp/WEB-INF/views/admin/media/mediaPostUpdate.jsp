<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>미디어 게시글 수정</title>
<script src="/adminlte/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
</head>
<c:set var="title" value="미디어 게시글 수정"></c:set>	
<!-- 관리자 헤더네비바  -->
<%@ include file="../adminHeader.jsp"%>

<!-- 관리자 사이드바 -->
<%@ include file="../adminSidebar.jsp"%>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">
    <!-- 컨텐츠-->
    <div class="content-wrapper" style="padding: 20px">
        <div class="card card-secondary">
            <div class="card-header">
                <h3 class="card-title">미디어 게시글 수정 정보</h3>
            </div>
            
            <!-- 폼 시작 -->
            <form id="updatePostForm" action="/admin/media/update" method="post" enctype="multipart/form-data">
                <!-- 원본 데이터 보존용 hidden 필드 -->
                <input type="hidden" id="original-thumbnail-path" value="${mediaPostVO.thumNailPath}">
                <input type="hidden" id="original-video-path" value="${mediaPostVO.mediaVideoUrl}">
                <input type="hidden" id="original-media-type" value="${mediaPostVO.mediaMebershipYn}">
                <input type="hidden" name="mediaPostNo" value="${mediaPostVO.mediaPostNo}">
                
                <div class="card-body">
                    <div class="row">
                        <!-- 커뮤니티 선택 -->
                        <div class="col-md-5 mr-5">
                            <div class="form-group">
                                <label for="community-select">커뮤니티 선택 <span class="text-danger">*</span></label>
                                <select id="community-select" name="artGroupNo" class="form-control select2bs4" required>
                                    <option value="${mediaPostVO.artistGroupVO.artGroupNo}" selected="selected">${mediaPostVO.artistGroupVO.artGroupNm}</option>
                                    <c:forEach var="artistGroupVO" items="${artistGroupVOList}">
                                        <c:if test="${artistGroupVO.artGroupNo ne mediaPostVO.artistGroupVO.artGroupNo}">
                                            <option value="${artistGroupVO.artGroupNo}">${artistGroupVO.artGroupNm}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <!-- 게시글 유형 선택 (일반:N, 멤버쉽:Y, 라이브: L 값으로 저장됨) -->
                        <div class="col-md-5 ml-5">
                            <div class="form-group">
                                <label>게시글 유형 <span class="text-danger">*</span></label>
                                <div class="d-flex gap-5">
                                    <div class="form-check mr-3">
                                        <input class="form-check-input" type="radio" name="mediaMebershipYn" id="normalMedia" value="N" ${mediaPostVO.mediaMebershipYn eq "N" ? 'checked' : ''}>
                                        <label class="form-check-label" for="normalMedia">일반 미디어</label>
                                    </div>
                                    <div class="form-check mr-3">
                                        <input class="form-check-input" type="radio" name="mediaMebershipYn" id="membershipMedia" value="Y" ${mediaPostVO.mediaMebershipYn eq "Y" ? 'checked' : ''}>
                                        <label class="form-check-label" for="membershipMedia">멤버십 미디어</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="mediaMebershipYn" id="liveMedia" value="L" ${mediaPostVO.mediaMebershipYn eq "L" ? 'checked' : ''}>
                                        <label class="form-check-label" for="liveMedia">지난 라이브</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 미디어 URL (일반 미디어일 때만 표시) -->
					<c:if test="${mediaPostVO.mediaMebershipYn eq 'N'}">
					    <div class="form-group normal-media-field">
					        <label for="media-url">미디어 URL</label>
					        <input type="text" class="form-control" id="media-url" name="mediaVideoUrl" value="https://www.youtube.com/watch?v=${mediaPostVO.mediaVideoUrl}">
					        
					        <!-- YouTube 영상 미리보기 -->
					        <div class="mt-3" id="youtube-preview-container" style="width: 50%;">
					            <label>YouTube 영상 미리보기</label>
					            <div class="border rounded p-2 bg-light">
					                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
					                    <iframe id="youtube-preview" src="https://www.youtube.com/embed/${mediaPostVO.mediaVideoUrl}" 
					                        frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
					                        allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe>
					                </div>
					            </div>
					        </div>
					    </div>
					</c:if>
                    
                    <!-- 멤버십/라이브 미디어 파일 업로드 영역 -->
                    <div class="membership-media-field" style="display: none;">
                        <!-- 썸네일 이미지 업로드 -->
                        <div class="form-group">
                            <label for="thumbnail-upload">썸네일 이미지 <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="thumbnail-upload" name="thumbnailFile" accept="image/*">
                                    <label class="custom-file-label" for="thumbnail-upload">썸네일 이미지 선택</label>
                                </div>
                            </div>
                            <small class="form-text text-muted">권장 크기: ?? x ??</small>
                            
                            <!-- 썸네일 미리보기 영역 -->
                            <div class="mt-3" id="thumbnail-preview-container" style="display: none;">
                                <label>썸네일 미리보기</label>
                                <div class="border rounded p-2 bg-light">
                                    <img id="thumbnail-preview" src="${mediaPostVO.mediaMebershipYn ne 'N' ? '/upload'.concat(mediaPostVO.thumNailPath) : '#'}" 
                                         alt="썸네일 미리보기" style="max-width: 100%; max-height: 200px;">
                                </div>
                            </div>
                        </div>
                        
                        <!-- 비디오 파일 업로드 -->
                        <div class="form-group">
                            <label for="video-upload">비디오 파일 <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="video-upload" name="videoFile" accept="video/*">
                                    <label class="custom-file-label" for="video-upload">비디오 파일 선택</label>
                                </div>
                            </div>
                            <small class="form-text text-muted">지원 형식: MP4, MOV</small>
                            
                            <!-- 비디오 미리보기 영역 -->
                            <div class="mt-3" id="video-preview-container" style="display: none;">
                                <label>비디오 미리보기</label>
                                <div class="border rounded p-2 bg-light">
                                    <video id="video-preview" controls style="max-width: 100%; max-height: 400px;">
                                        <source src="${mediaPostVO.mediaMebershipYn ne 'N' ? '/upload'.concat(mediaPostVO.mediaVideoUrl) : ''}" type="video/mp4">
                                        브라우저가 비디오 태그를 지원하지 않습니다.
                                    </video>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 게시글 제목 -->
                    <div class="form-group">
                        <label for="post-title">게시글 제목 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="post-title" name="mediaPostTitle" value="${mediaPostVO.mediaPostTitle}" required>
                    </div>
                    
                    <!-- 게시글 내용 -->
                    <div class="form-group">
                        <label for="post-content">게시글 내용 <span class="text-danger">*</span></label>
                        <textarea class="form-control" rows="10" id="post-content" name="mediaPostCn" required>${mediaPostVO.mediaPostCn}</textarea>
                    </div>
                    
                    <!-- 배너 등록 여부 -->
                    <div class="form-group">
                        <label>배너 등록 여부</label>
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="banner-switch" name="isbannerYn" value="Y" ${mediaPostVO.isbannerYn eq "Y" ? 'checked' : ''}>
                            <label class="custom-control-label" for="banner-switch">배너로 등록</label>
                        </div>
                        <small class="form-text text-muted">배너로 등록 시 커뮤니티 메인 페이지 상단에 표시됩니다.</small>
                    </div>
                </div>
                
                <!-- 버튼 영역 -->
                <div class="card-footer">
                    <a href="/admin/media" class="btn btn-danger float-right ml-2">취소</a>
                    <button type="submit" class="btn btn-primary float-right" id="submitBtn">저장</button>
                </div>
            </form>
            <!-- 폼 끝 -->
        </div>
    </div>
    
    <!-- 관리자 풋터 -->
    <%@ include file="../adminFooter.jsp"%>
</div>

<!-- 페이지 자바스크립트 -->
<script src="/js/media-live/admin-media-detail.js"></script>
<script>
	document.getElementById("submitBtn").addEventListener("click", function() {
		const content = document.getElementById("post-content").value;
		console.log("내용 확인:", content);
	});
  </script>
</body>
</html>