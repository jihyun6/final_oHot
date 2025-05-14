<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@include file="../header.jsp" %>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>커뮤니티 프로필 수정</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            max-width: 600px;
            background: white;
            border-radius: 50px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: auto;
            margin-top: 50px;
        }
        .profile-img {
            width: 300px;
            height: 300px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto;
            border: 3px solid #ddd;
        }
        .upload-btn {
            display: block;
            width: 100%;
            text-align: center;
            margin-top: 10px;
        }
        .form-control {
            font-size: 16px;
        }
        .btn-custom {
            background-color: #1c1c1c;
            color: white;
            width: 100%;
            font-size: 16px;
        }
        .btn-custom:hover {
            background-color: #333;
        }
        /* 헤더 네비 디자인 */
  .weverse-tabs {
    background: linear-gradient(90deg, #0f0f2f, #1a1a40); /* 어두운 배경 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    padding: 0.75rem 0;
  }

  .weverse-tabs .nav {
    gap: 1.5rem;
  }

  .weverse-tabs .nav-link {
    color: #ccc;
    font-weight: 500;
    font-size: 0.95rem;
    border: none;
    background: transparent;
    border-radius: 2rem;
    padding: 0.4rem 1.2rem;
    transition: all 0.3s ease;
  }

  .weverse-tabs .nav-link:hover {
    color: #fff;
    background-color: rgba(255, 192, 203, 0.1); /* 연한 핑크 호버 효과 */
  }

  .weverse-tabs .nav-link.active {
    background-color: #ff69b4; /* 핫핑크 배경 */
    color: #fff;
    font-weight: 700;
    border-radius: 999px;
    box-shadow: 0 0 10px rgba(255, 105, 180, 0.3);
  }

  @media (max-width: 576px) {
    .weverse-tabs .nav {
      flex-wrap: nowrap;
      overflow-x: auto;
      -webkit-overflow-scrolling: touch;
    }

    .weverse-tabs .nav-link {
      white-space: nowrap;
    }
  }

/* 헤더 네비 디자인 끝  */
    </style>
</head>
<body>
<div class="weverse-tabs d-flex justify-content-center">
  <ul class="nav nav-pills nav-fill">
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${communityProfileVO.artGroupNo}">
        Fan
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${communityProfileVO.artGroupNo}">
        Artist
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${communityProfileVO.artGroupNo}">
        Media
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link "
         href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${communityProfileVO.artGroupNo}">
        Live
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${communityProfileVO.artGroupNo}"
         target="_blank">
        Shop
      </a>
    </li>
  </ul>
</div>



<div class="profile-container">
    <div>
        <button type="button"  style="text-align: center; display: inline-block;" class="btn btn-secondary w-20 mt-2" onclick="history.back();"><spring:message code="edit.profile.back" /> </button>
    </div>
    <form action="/oho/community/editProfilePost" method="post" enctype="multipart/form-data">
        <input type="hidden" name="comProfileNo" value="${communityProfileVO.comProfileNo}">
        <input type="hidden" name="memNo" value="${communityProfileVO.memNo}">
        <input type="hidden" id="fileGroupNo" name="comFileGroupNo" value="${communityProfileVO.fileGroupVO.fileGroupNo}">
		<!-- 기존 이미지 삭제 여부를 위한 hidden input -->
		<input type="hidden" name="deleteImg" id="deleteImg" value="false">

		<!-- 기존 이미지 출력 -->
		<div class="text-center position-relative">
	      <c:set var="profileImgPath" value="/images/defaultProfile.jpg" />
			<c:if test="${not empty communityProfileVO.fileGroupVO.fileDetailVOList 
			             and not empty communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
			    <c:set var="profileImgPath" value="/upload${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />
			</c:if>
			
			<img id ="profileImg" src="${profileImgPath}" class="profile-img" onclick="openImageModal(this.src)">

			<!-- 초기화 버튼 -->
			<button type="button"
			        class="btn btn-outline-light btn-sm position-absolute top-0 end-0 shadow"
			        onclick="removeImage()"
			        style="border-radius: 50%; background-color: #ff69b4; color: white; border: none; width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; font-weight: bold; box-shadow: 0 0 6px rgba(255, 105, 180, 0.5); transition: all 0.3s ease;">
			    &times;
			</button>
		</div>

<input type="file" name="uploadFile" onchange="readFile(this)" class="form-control mt-2">

        <!-- 닉네임 수정 -->
        <div class="mt-4">
            <label class="form-label fw-bold"><spring:message code="edit.profile.nickname"/> </label>
            <input class="form-control" type="text" value="${communityProfileVO.comNm}" name="comNm">
        </div>

        <!-- 버튼 -->
        <div class="mt-4">
            <button type="submit" class="btn btn-custom" style="background-color: tomato;"><spring:message code="edit.profile.modify"/> </button>
        </div>
    </form>
</div>

<script type="text/javascript">
function readFile(input){
    var reader = new FileReader();
    if (input.files && input.files[0]) {
        reader.onload = function(e){
            $("#profileImg").attr("src", e.target.result);
            $("#deleteImg").val("false"); // 새 이미지 선택 시 삭제 안 함
        };
        reader.readAsDataURL(input.files[0]);
    }
}

//이미지 제거 시 기본 이미지로 변경 + 삭제 플래그 설정
function removeImage(){
    // 기본 이미지로 변경
    $("#profileImg").attr("src", "/images/defaultProfile.jpg");

    // 파일 input 초기화
    $("input[name='uploadFile']").val("");

    // 서버에 삭제 요청 여부 전달
    $("#deleteImg").val("true");
    
    $("#fileGroupNo").val("");
}
</script>
<%@ include file="../footer.jsp" %>
</body>
</html>