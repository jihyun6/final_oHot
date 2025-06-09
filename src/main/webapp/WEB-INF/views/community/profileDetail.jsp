<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@include file="../header.jsp" %>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <title>${communityProfileVO.comNm} - 프로필</title>
    <style>
    
    #endMessage {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
    padding: 10px;
    font-size: 16px;
    margin-top: 20px;
    text-align: center;
    font-weight: bold;
}
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
            cursor: pointer;
            
        }
        .profile-img2 {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto;
            border: 3px solid #ddd;
            cursor: pointer;
            
        }
        .follow-btn {
            background-color: #1c1c1c;
            color: white;
            width: 20%;
        }
        .follow-btn:hover {
            background-color: #333;
        }
        .count-box {
            text-align: center;
        }
        .count-box h4 {
            margin-bottom: 0;
        }
        .post-card {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
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
		.card-body h5 {
	    font-size: 1.25rem;
	    color: #222;
		}
		.card-body p {
		    line-height: 1.6;
		}
		
		<style>
  .pagination .page-link {
    border: none;
    background-color: #f0f2ff;
    color: #5a5a5a;
    transition: all 0.2s ease-in-out;
  }

  .pagination .page-link:hover {
    background-color: #dee2ff;
    color: #2d2d2d;
  }

  .pagination .active .page-link {
    background-color: #8c9eff;
    color: white;
    font-weight: bold;
  }

  .pagination .disabled .page-link {
    background-color: #e9ecef;
    color: #adb5bd;
  }
                  /* 모달 스타일 */
        .custom-modal .modal-content {
            border-radius: 20px;
            padding: 20px;
        }
        .custom-modal .modal-header {
            border-bottom: none;
            text-align: center;
            justify-content: center;
        }
        .custom-modal .modal-title {
            font-size: 20px;
            font-weight: bold;
        }
        .custom-modal .modal-body {
            text-align: center;
        }
        .custom-textarea1 {
            width: 100%;
            min-height: 50px;
            border: none;
            background-color: #f8f9fa;
            resize: none;
            padding: 15px;
            font-size: 16px;
            border-radius: 10px;
            outline: none;
        }
        .custom-textarea2 {
            width: 100%;
            min-height: 300px;
            border: none;
            background-color: #f8f9fa;
            resize: none;
            padding: 15px;
            font-size: 16px;
            border-radius: 10px;
            outline: none;
        }
        .custom-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-custom {
            background-color: #1c1c1c;
            color: white;
            border-radius: 8px;
            padding: 8px 20px;
        }
    .btn-weverse {
        background-color: white;
        color: #6d8f38;
        font-size: 16px;
        font-weight: bold;
        border: 2px solid #6d8f38;
        border-radius: 25px;
        padding: 12px;
        width: 100%;
        display: block;
        text-align: center;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .btn-weverse:hover {
        background-color: #6d8f38;
        color: white;
    }
        .btn-custom:disabled {
            background-color: #ccc;
        }
        .icon-btn {
            font-size: 24px;
            cursor: pointer;
            margin-right: 10px;
        }
        .dropdown-menu {
    border-radius: 12px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
}
.dropdown-item {
    font-size: 14px;
    font-weight: 500;
}
.badge-artist {
    display: inline-block;
    padding: 3px 8px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    background: linear-gradient(45deg, #FF1493, #FF69B4); /* 핑크 그라데이션 */
    border-radius: 8px;
}
.me-2{
	cursor:pointer;
}
/* 그리드,swiper 스타일 */
.card-body .grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 8px;
  margin-top: 10px;
}

.card-body .grid img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 10px;
  cursor: pointer;
}
#editImg {
  overflow: hidden;
  max-width: 100%;
}
.grid img {
  width: 100%;
  height: auto;
  max-width: 100%;
  border-radius: 10px;
  object-fit: cover;
  display: block;
}
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 8px;
  margin-top: 10px;
  overflow: hidden;
}
.post-image {
  max-width: 100%;
  max-height: 500px;
  height: auto;
  object-fit: cover; /* 필요시 이미지 잘라내기 */
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
a {
  color: inherit;
  text-decoration: none;
}
/* 헤더 네비 디자인 끝  */ 

</style>
<c:if test="${communityProfileVO.comAuth eq 'ROLE_ART'}">
  <style>
    .profile-container {
      background-image: url('/images/artBack.jpg');
      background-size: cover;
      background-position: center;
      padding: 2rem;
      border-radius: 1rem;
    }
    .profile-container-inner {
      background-color: white;
      border-radius: 1rem;
      padding: 2rem;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
  </style>
</c:if>
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
    <li class="nav-item ">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${communityProfileVO.artGroupNo}">
        Artist
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
         href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${communityProfileVO.artGroupNo}">
        Media
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link"
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


<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.usersVO" var="userVO"/>
</sec:authorize>
<!--  ${userVO} -->
<form id="userInfo" name="userInfo" >
<input type="hidden" id="userNo" name="userNo" value="${userVO.userNo }">
<input type="hidden" id="artGroupNo" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
<input type="hidden" id="comNm" name="comNm" value="${communityProfileVO.comNm }">
<input type="hidden" id="myFileSaveLocate" name="myFileSaveLocate" value="${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate }">

</form>

<div class="profile-container">
  <div class="profile-container-inner">
    <!-- 기존 코드 전부 여기에 그대로 위치 -->
  
	<c:if test="${communityProfileVO.comAuth eq 'ROLE_ART'}">
	  <div class="artist-bg-wrapper mb-3">
	    <div class="artist-bg" style="background-image: url('/images/artBack.jpg');"></div>
	  </div>
	</c:if>
    <div class="d-flex justify-content-between align-items-center mt-2">
    	<c:set var="fromPage" value="${param.from}" />
        <button type="button"  style="display: inline-block;" class="btn btn-secondary w-20 mt-2" onclick="fn_move_list();"><spring:message code="profile.detail.list" /> </button>
	<c:if test="${userVO.userNo == communityProfileVO.memNo && communityProfileVO.comAuth eq 'ROLE_MEM' }">
	    <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#withdrawModal">
	      <spring:message code="profile.leave.commu"/>
	    </button>
	  
	</c:if>
	</div>
    <div class="text-center">
			
		
      <c:set var="profileImgPath" value="/images/defaultProfile.jpg" />
		<c:if test="${not empty communityProfileVO.fileGroupVO.fileDetailVOList 
		             and not empty communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}">
		    <c:set var="profileImgPath" value="/upload${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />
		</c:if>
		
		<img src="${profileImgPath}" class="profile-img" onclick="openImageModal(this.src)">
		
	</div>
<!-- 팔로잉 리스트 모달 -->
<div class="modal fade" id="followingModal" tabindex="-1" aria-labelledby="followingModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4">
      <div class="modal-header border-0 text-center d-block">
        <h5 class="modal-title fw-bold" id="followingModalLabel">${communityProfileVO.comNm}님의 팔로잉</h5>
	      </div>
	
	
			<!-- 리스트 추가되는 곳 -->
		  <div id="followingList"></div>
		  
		  
	      <div class="modal-footer border-0 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary w-100 rounded-pill" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	<div class="text-center">
	  <label class="form-label fw-bold">${communityProfileVO.comNm}님의 프로필</label>
<c:if test="${userVO.userNo == communityProfileVO.memNo }">
	  <button type="button" onclick="alarmSettingModal(${communityProfileVO.comProfileNo })" class="btn btn-sm btn-outline-dark ms-2" data-bs-toggle="modal" data-bs-target="#settingsModal">
	    ⚙ 설정
	  </button>
</c:if>
	</div>
<div class="row mt-4 text-center">
  <!-- 팔로워 박스 -->
  <div class="col-6">
    <div class="card shadow-sm border-0 rounded-3">
      <div class="card-body">
        <h4 class="fw-bold mb-1" id="followerCnt">${followerCnt}</h4>
        <p class="text-muted mb-0">팔로워</p>
      </div>
    </div>
  </div>

  <!-- 팔로잉 박스 -->
  <div class="col-6">
    <div class="card shadow-sm border-0 rounded-3">
      <div class="card-body">
		<c:choose>
		  <c:when test="${userVO.userNo == communityProfileVO.memNo}">
		    <h4 class="fw-bold mb-1">${followingCnt}</h4>
		    <a id="followMemberList"
		       style="cursor: pointer;"
		       class="text-muted text-decoration-none d-block"
		       onclick="openFollowingModal(); return false;">팔로잉</a>
		  </c:when>
		
		  <c:otherwise>
		    <button class="btn btn-outline-primary w-100" id="followY"
		            onclick="followYn(${communityProfileVO.comProfileNo}, ${userVO.userNo}, ${communityProfileVO.artGroupNo})">
		      팔로우 하기
		    </button>
		    <button class="btn btn-outline-primary w-100" id="followN"
		            onclick="followYn(${communityProfileVO.comProfileNo}, ${userVO.userNo}, ${communityProfileVO.artGroupNo})">
		      팔로우 취소하기
		    </button>
		  </c:otherwise>
		</c:choose>
      </div>
    </div>
   </div>
  </div>
</div>
    <c:if test="${userVO.userNo == communityProfileVO.memNo }">
    <div class="mt-4">
       <button type="submit" class="btn btn-custom" onclick="fn_edit_profile()" style="background-color: rgb(71, 223, 172);"><spring:message code="profile.edit"/> </button>
    </div>
    </c:if>
</div>
<div class="modal fade" id="imageModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body text-center">
        <img id="modalImage" src="" class="img-fluid">
      </div>
    </div>
  </div>
</div>

<div class="container mt-5">
  <!-- 게시글/댓글 전환 버튼 -->
  <div class="d-flex justify-content-center gap-3 mb-4">
    <button id="showPostsBtn" class="btn btn-outline-dark rounded-pill px-4 fw-bold" onclick="myPostList()"><spring:message code="profile.mypost"/> </button>
    <button id="showRepliesBtn" class="btn btn-outline-secondary rounded-pill px-4 fw-bold"><spring:message code="profile.reply"/> </button>
  </div>

  <div class="d-flex justify-content-end mb-3">
    <select class="form-select w-auto" id="sortSelect" onchange="sortPosts()">
      <option value="new"><spring:message code="profile.latest"/> </option>
      <option value="old"><spring:message code="profile.old"/> </option>
    </select>
  </div>
  <!-- 게시글 목록 -->
  <div id="postList">
    <!-- 게시글 데이터 들어가는 곳 -->


  </div>
    <!-- 댓글 모달 -->
    <div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="replyModalLabel">댓글</h5>
                    
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="modal_close" onclick="fn_reply_modal_close()" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="replyList"></div>
                </div>

            </div>
        </div>
    </div>
    <!-- 뎃글 모달 끝 -->
  <!-- 댓글 목록 -->
  <div id="myReplyList" style="display: none;">

  </div>
</div>

<!-- 게시글 수정 모달 -->
<div class="modal fade custom-modal" id="postEditModal" tabindex="-1" aria-labelledby="postModalLabel" aria-hidden="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- 모달 헤더 -->
			
            <div class="modal-header">
                <h5 class="modal-title" id="postModalLabel">포스트 쓰기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
            <!-- 모달 바디 -->
            
            	<form name="boardEditForm" action="/oho/community/editBoard2" method="post" enctype="multipart/form-data">

				<input type="hidden" id="artGroupNo" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
				<input type="hidden" id="memNo" name="memNo" value="${communityProfileVO.memNo }">
				<input type="hidden" id="comProfileNo" name="comProfileNo" value="${communityProfileVO.comProfileNo }">
				<input type="hidden" id="comProfileVo" name="comProfileVO" value="${communityProfileVO }">
				<input type="hidden" id="editBoardNo" name="boardNo">
				

				
				
	            <div class="modal-body">
	            	<input type="text" class="form-control mb-3" id="boardEditTitle" name="boardTitle" placeholder="제목을 입력해주세요" />
	                <input type="text" class="custom-textarea2" id="boardEditContent" name="boardContent" placeholder="위버스에 남겨보세요..."></input>
	                <div id="editImg">
                	</div>
	            </div>
				
	            <!-- 모달 푸터 -->
	            <div class="modal-footer custom-footer">
                <div>
                      <label for="formFile" class="form-label"></label>
 					  <input class="form-control" type="file" id="formFile" onchange="readFile(this)" onclick="fn_edit_img_remove()" multiple  name="uploadFile">
                </div>

                <div>
                <input type="checkbox" name="boardOnlyFan"  value="Y" />Hide from Artists
                </div>
                <button type="button" class="btn btn-custom" id="submitBtn" onclick="fn_board_edit_submit()" >등록</button>
                </div>
                </form>
            
        </div>
    </div>
</div>

<!-- 설정 모달 -->
<div class="modal fade" id="settingsModal" tabindex="-1" aria-labelledby="settingsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 shadow-sm">
	<form id="settingFrmAlarm">
      <div class="modal-header border-0 text-center d-block">
        <h5 class="modal-title fw-bold" id="settingsModalLabel">알림 설정</h5>
      </div>

      <div class="modal-body px-4">
        <!-- 알림 항목 리스트 -->
        <ul class="list-group list-group-flush">
          <!-- 알림 항목 반복 -->
<!--           <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0 border-bottom">
            <div>
              <div class="fw-semibold">DM 알림</div>
              <small class="text-muted">DM이 와도 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="dmToggle" checked>
            </div>
          </li> -->
          <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0 border-bottom">
            <div>
              <div class="fw-semibold">게시글 알림</div>
              <small class="text-muted">게시글 업로드 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="bdStngYn" name="bdStngYn" checked>
            </div>
          </li>

          <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0 border-bottom">
            <div>
              <div class="fw-semibold">댓글 알림</div>
              <small class="text-muted">댓글 업로드 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="lpStngYn" name="lpStngYn" checked>
            </div>
          </li>

<!--           <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0 border-bottom">
            <div>
              <div class="fw-semibold">좋아요 알림</div>
              <small class="text-muted">좋아요 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="lkStngYn"  name="lkStngYn" checked>
            </div>
          </li> -->

          <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0 border-bottom">
            <div>
              <div class="fw-semibold">라이브 알림</div>
              <small class="text-muted">라이브 시작 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="lvStngYn" name="lvStngYn"  checked>
            </div>
          </li>

          <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3 border-0">
            <div>
              <div class="fw-semibold">미디어 알림</div>
              <small class="text-muted">미디어 업로드 알림을 받지 않습니다.</small>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" id="meStngYn" name="meStngYn"  checked>
            </div>
          </li>
        </ul>
      </div>
      <!-- 회원 가입 시 설정 디폴트 밸류 필요. 설정 테이블 생성 하면 communityServiceImpl->Join에서 comProfileNo만들어 진 다음 설정 초기 값 Insert -->
      <!-- community는 이동 시 artGroupNo 필수(리다이렉트 시 꼭 model로 같이 넘겨줘야함) , memNo은 principle 의 user정보로 불러옴(서버에서 처리) -->
      <!-- 좋아요,댓글,게시글 -> comProfileNo으로 조회 가능 -->
      <!-- 디엠 알림은 DM에서 하는게 어떤지.. 논의 필요 , artGroup에 대한 프로필이기에 off 하면 특정 artist 해제가 애모모호함(dm은 artist별이기 때문) - 동의! 주석처리함 -->
	  <input type="hidden" class="form-check-input" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
      <div class="modal-footer border-0 d-flex justify-content-center">
        <button type="submit" onclick="setting(${communityProfileVO.comProfileNo })" class="btn btn-secondary w-100 rounded-pill" data-bs-dismiss="modal" >저장</button>
      </div>
	</form>
    </div>
  </div>
</div>
<!-- 탈퇴 모달  -->
<div class="modal fade" id="withdrawModal" tabindex="-1" aria-labelledby="withdrawModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4">
      <div class="modal-header border-0">
        <h5 class="modal-title fw-bold" id="withdrawModalLabel">정말 탈퇴하시겠어요?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <p class="text-muted mb-0">탈퇴 시 게시글, 댓글, 팔로잉 정보가 모두 삭제됩니다.<br/>이 작업은 되돌릴 수 없습니다.</p>
      </div>
	  <div class="modal-footer border-0 d-flex justify-content-center gap-3">
		 <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">취소</button>
		 <!-- 회원 탈퇴  -->
		 <form action="/oho/community/deleteProfile" method="post">
		 <input type="hidden" name="comProfileNo" value="${communityProfileVO.comProfileNo }">
		 <input type="hidden" name="artGroupNo" value="${communityProfileVO.artGroupNo }">
		 <input type="hidden" name="memNo" value="${communityProfileVO.memNo }">
		 <button type="submit" class="btn btn-danger px-4" >탈퇴하기</button>
		 </form>
	  </div>
    </div>
  </div>
</div>
<div id="endMessage" style="display:none; text-align: center; font-size: 16px; color: black;">
    <strong>마지막 게시글 입니다</strong>
</div>
<!-- ///// 신고하기 모달 시작 ///// -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow rounded-4 border-0">

      <!-- 모달 헤더 -->
      <div class="modal-header border-0">
        <h5 class="modal-title w-100 text-center fw-bold" id="reportModalLabel">🚨 신고하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디 -->
      <div class="modal-body px-4 py-3">

        <!-- 유저 정보 (숨겨진 유저 번호 포함) -->
        <input type="hidden" name="memNo" id="userNoModal" value="${userVO.userNo}" />
        <div class="mb-4">
          <label class="form-label fw-semibold">📧 신고 대상 이메일</label>
          <input type="text" readonly class="form-control-plaintext text-body fw-bold" id="memEmailModal"
            value="${userVO.userMail}" />
        </div>

        <!-- 신고 사유 -->
        <div class="mb-4">
          <label class="form-label fw-semibold fs-5">🚫 신고 사유</label>
          <div class="row row-cols-2 g-2">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle1" value="영리적인/흥보성" />
              <label class="form-check-label" for="reportTitle1">영리적인/홍보성</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle2" value="음란물" />
              <label class="form-check-label" for="reportTitle2">음란물</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle3" value="불법정보" />
              <label class="form-check-label" for="reportTitle3">불법정보</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle4" value="음란성/선정성" />
              <label class="form-check-label" for="reportTitle4">음란성/선정성</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle5" value="욕설/인신공격" />
              <label class="form-check-label" for="reportTitle5">욕설/인신공격</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle6" value="아이디/DB거래" />
              <label class="form-check-label" for="reportTitle6">아이디/DB거래</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle7"
                value="같은 내용 반복(도배)" />
              <label class="form-check-label" for="reportTitle7">같은 내용 반복(도배)</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle8" value="운영규칙 위반" />
              <label class="form-check-label" for="reportTitle8">운영규칙 위반</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="reportTitle" id="reportTitle9" value="기타" />
              <label class="form-check-label" for="reportTitle9">기타</label>
            </div>
          </div>
        </div>

        <!-- 상세내용 -->
        <div class="mb-4">
          <label for="reportCn" class="form-label fw-semibold fs-5">📝 상세내용</label>
          <textarea id="reportCn" name="reportCn" class="form-control" rows="5"
            placeholder="ex) 부적절한 게시글입니다."></textarea>
        </div>

        <!-- 신고 사진 업로드 -->
        <div class="mb-4">
          <label for="uploadFile" class="form-label fw-semibold fs-5">📷 신고 관련 이미지</label>
          <input type="file" class="form-control" id="uploadFile" name="uploadFile" multiple />
        </div>

      </div>

      <!-- 모달 푸터 -->
      <div class="modal-footer border-0 justify-content-between px-4 pb-4">
        <button type="button" class="btn btn-outline-secondary" id="btnModalClose" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary px-4" id="btnModalSubmit"
          data-mem-no="${userVO.userNo}">신고 제출</button>
      </div>

    </div>
  </div>
</div>
<%@ include file="../footer.jsp" %>
</body>

<script type="text/javascript">
<!-- 팔로잉 버튼 클릭 시 모달 열기 -->
let userNo =  $("form[name='userInfo']").find('#userNo').val();
let artGroupNo =  $("form[name='userInfo']").find('#artGroupNo').val();
let targetComProfileNo = ${communityProfileVO.comProfileNo};
let myFileSaveLocate = $("form[name='userInfo']").find('#myFileSaveLocate').val();
let comNm = $("form[name='userInfo']").find('#comNm').val();
let currentPage =1;
let currentReplyPage =1;
let isLastPage = "";
let isReplyLastPage="";
const fromPage = "${fromPage}";
//먼저 실행되는 함수들
$(function(){
	followingList();
});

function alarmSettingModal(comProfileNo){

	// alert("여기오니? "+comProfileNo);

	//모달 열릴때
	axios.post('/oho/alarm/personalStng?comProfileNo='+comProfileNo).then(resp=>{
		const perAlarmStng = resp.data;
		console.log("알림설정사항: "+JSON.stringify(perAlarmStng));

		if(perAlarmStng.bdStngYn =='N') document.querySelector('#bdStngYn').checked= false;
		if(perAlarmStng.lpStngYn =='N') document.querySelector('#lpStngYn').checked= false;
		if(perAlarmStng.lvStngYn =='N') document.querySelector('#lvStngYn').checked= false;
		if(perAlarmStng.lkStngYn =='N') document.querySelector('#lkStngYn').checked= false;
		if(perAlarmStng.meStngYn =='N') document.querySelector('#meStngYn').checked= false;

	});

}

function setting(comProfileNo){
	event.preventDefault();
	const settingFrmAlarm = document.querySelector('#settingFrmAlarm');
	const settingFramData = new FormData(settingFrmAlarm);

	//FormData.get('bdStngYn')은 체크되면 값이 나옴(ex: "on"), 체크 안 됐으면 null 나옴.
	const alarmSettings = {
	comProfileNo: comProfileNo,
    bdStngYn: settingFramData.get('bdStngYn') ? 'Y' : 'N',
    lpStngYn: settingFramData.get('lpStngYn') ? 'Y' : 'N',
    lvStngYn: settingFramData.get('lvStngYn') ? 'Y' : 'N',
    lkStngYn: settingFramData.get('lkStngYn') ? 'Y' : 'N',
    meStngYn: settingFramData.get('meStngYn') ? 'Y' : 'N'
  };

//   console.log('최종 저장할 알림 설정:', alarmSettings);
  axios.post('/oho/alarm/savePersonalStng',alarmSettings).then(resp=>{
	console.log("알림설정성공: "+resp.data);

  })
  
    

}

function sortPosts(){
	keyword = $("#sortSelect").val();
	console.log("sortVal:::",keyword);
    $("#postList").empty();
    $("#myReplyList").empty();
    currentPage = 1;
    currentReplyPage = 1;
    myPostList(currentPage, keyword);
    myReplyList(currentReplyPage, keyword);
}

function fn_board_edit_submit(){
	$("form[name='boardEditForm']").submit();
}	

$(document).ready(function () {
	  $('#showPostsBtn').on('click', function () {
		  currentPage=1;
		  $('#postList').empty();
	    $('#postList').show();
	    $('#myReplyList').hide();
	    $('#showPostsBtn').removeClass('btn-outline-secondary').addClass('btn-dark text-white');
	    $('#showRepliesBtn').removeClass('btn-dark text-white').addClass('btn-outline-secondary');
	    //myPostList(); // 게시글 목록 불러오기 함수
	  });

	  $('#showRepliesBtn').on('click', function () {
		  currentReplyPage=1;
		  $("#myReplyList").empty();
	    $('#myReplyList').show();
	    $('#postList').hide();
	    $('#showRepliesBtn').removeClass('btn-outline-secondary').addClass('btn-dark text-white');
	    $('#showPostsBtn').removeClass('btn-dark text-white').addClass('btn-outline-secondary');
	    myReplyList(); // 댓글 목록 불러오기 함수
	  });

	  // 페이지 최초 로드시 게시글 보여주기
	  $('#showPostsBtn').click();
});//end ready

//사진 클릭 시 크게 보이게하는 기능
function openImageModal(src) {
    document.getElementById("modalImage").src = src;
    new bootstrap.Modal(document.getElementById('imageModal')).show();
  }
  
function myReplyList(currentReplyPage,keyword){
	if(currentReplyPage==""||currentReplyPage==null||currentReplyPage== undefined){
	      currentReplyPage = "1";
	   }
	   //확장성 키워드 검색
	if(keyword==""||keyword==null||keyword== undefined){
	      keyword = "";
	}

	console.log("reply-> currentReplyPage = ",currentReplyPage);
	   axios.post("/oho/community/myReplyList",{
			comProfileNo : targetComProfileNo,
			artGroupNo : artGroupNo,
			currentReplyPage : currentReplyPage,
			keyword : keyword
	   })
	   .then(function(res){
			let communityReplyVOList = res.data.content;
			let str ="";
			console.log("communityReplyVOList ::::::::: ",communityReplyVOList);
 			
			$.each(communityReplyVOList,function(idx,communityReplyVO){
				str += `

					  <div class="card border-0 shadow-sm rounded-4 px-3 py-2 position-relative mb-3" id="replyNumber\${communityReplyVO.replyNo}">
					    <div class="d-flex align-items-start">`;
             if(myFileSaveLocate != null && myFileSaveLocate != ""){             
              str+=`     <img src="/upload\${myFileSaveLocate}" class="rounded-circle me-2" width="40" height="40" onclick="openImageModal(this.src)">`;
              }else{
           	   str+=`     <img src="/images/defaultProfile.jpg" class="rounded-circle me-2" width="40" height="40" onclick="openImageModal(this.src)">`;
              }     
			str+=`	      <div class="flex-grow-1">
					        <div class="d-flex justify-content-between align-items-center">
					          <div>
					            <strong>
					              <a href="/oho/community/profileDetail?comProfileNo=\${communityReplyVO.comProfileNo}" 
					                 class="text-dark text-decoration-none">
					                 \${comNm}
					              </a>`;
	                if(communityReplyVO.comAuth=='ROLE_ART'){
	                  str  +=`<span class="badge-star">🎵</span>`;        
	                            } 
					  str+=`  </strong>
					            <p class="mb-1 text-muted small">\${communityReplyVO.repCreateDate}</p>
					          </div>`;
					   if(communityReplyVO.memNo == userNo){
						   str+=` <div class="dropdown">
						            <button class="btn btn-light btn-sm border-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
						              <i class="bi bi-three-dots-vertical"></i>
						            </button>
						            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
						              <li >
						                <a class="dropdown-item text-danger d-flex align-items-center"  
						                   onclick="fn_delete_reply(\${communityReplyVO.replyNo}, \${communityReplyVO.boardNo})">
						                  🗑️ <span class="ms-2" style="cursor:pointer;"  >삭제하기</span>
						                </a>
						              </li>
						            </ul>
						          </div>`;
						          }
						          else{
				                str+=`<div class="dropdown">
				                        <!-- 점 3개 버튼 -->
				                        <button class="btn btn-light border rounded-circle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
				                            &#x22EE; <!-- 점 3개 아이콘 (수직) -->
				                        </button>
				                        
				                        <!-- 드롭다운 메뉴 -->
				                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				                            <li>
						                    	 <a class="dropdown-item d-flex align-items-center aReport" href="#" data-bs-toggle="modal"
					        						 data-bs-target="#reportModal" data-report-board-no="\${communityReplyVO.boardNo}"
					        						 data-mem-no="\${communityReplyVO.memNo}">
						                        <span class="me-2" style="cursor:pointer;">🔔</span> 신고하기
						                   		 </a>                	
				                            </li>
				                        </ul>
				                    </div>`;
						          }
					          
					str+=`  </div>
					        <p class="mb-2">\${communityReplyVO.replyContent}</p>
					        <button class="btn btn-sm btn-outline-danger rounded-pill px-2 py-1" 
					                id="replyLikeBtn\${communityReplyVO.replyNo}" 
					                onclick="fn_reply_likeYn(\${communityReplyVO.boardNo}, \${communityReplyVO.replyNo})">
					          <i id="heartIcon\${communityReplyVO.replyNo}" class="bi bi-heart"></i>
					          <span id="replyLikeCnt\${communityReplyVO.replyNo}" class="ms-1">\${communityReplyVO.replyLikeCnt}</span>
					        </button>
					      </div>
					    </div>
					  </div>
					`;
			
			   });//end each
			  isReplyLastPage = res.data.isReplyLastPage;
	           if (isReplyLastPage) {
	        	   $('#endMessage').show();
	           }
	        console.log("reply::::::::::",res.data);
			$("#myReplyList").append(str);
	   })
	   .catch(function(err){
		   console.log("에러발생");
	   })
}

function myPostList(currentPage,keyword){
	console.log("myPostList->currentPage : ", currentPage);
	console.log("myPostList->keyword : ", keyword);
	
	if(currentPage==""||currentPage==null||currentPage== undefined){
	      currentPage = "1";
	   }
	
/* 	let data = {
			"comProfileNo":targetComProfileNo,
			"artGroupNo":artGroupNo,
			"currentPage":currentPage,
			"keyword": keyword
	}; */
	
	/*
	{
	    "comProfileNo": 8,
	    "artGroupNo": "1",
	    "currentPage": 2,
	    "keyword": ""
	}
	*/
	console.log("myPostList->data : ");
	
	   //확장성 키워드 검색
	if(keyword==""||keyword==null||keyword== undefined){
	      keyword = "";
	}
	axios.post("/oho/community/myPostList",{
			comProfileNo:targetComProfileNo,
			artGroupNo:artGroupNo,
			currentPage:currentPage,
			keyword: keyword
	})
	.then(function(res){
		let boardPage = res.data.content;
		let str ="";
		console.log("boardPage ::::::::: ",boardPage);
		
		$.each(boardPage,function(i,element){
			str+=` 
				<input type="hidden" name="boardNo" id="board\${element.boardNo}" value="\${element.boardNo}"/>
				 <div class="row justify-content-center" id="boardNo\${element.boardNo}">
				 	<div >
		          		<div class="card shadow-sm rounded-4 border-0">
		          			<div class="card-header bg-white d-flex align-items-center border-0">`;
		                        if(myFileSaveLocate != null && myFileSaveLocate != ""){             
		        	                str+=`     <img src="/upload\${myFileSaveLocate}" class="rounded-circle me-2" width="40" height="40" onclick="openImageModal(this.src)">`;
		        	                }else{
		        	             	   str+=`     <img src="/images/defaultProfile.jpg" class="rounded-circle me-2" width="40" height="40" onclick="openImageModal(this.src)">`;
		        	                }     
			str+=`	              	<div>
					                	<a href="#" class="text-dark text-decoration-none fw-bold">\${element.comNm}</a><br>`;
		       if(element.memNo==userNo){

		        	
		            str+=`                <!-- 드롭다운 컨테이너 -->
		            		<div class="position-absolute top-1 end-0">
		                    <div class="dropdown">
		                    <!-- 점 3개 버튼 -->
		                    <button class="btn btn-light border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
		                        &#x22EE; <!-- 점 3개 아이콘 (세로) -->
		                    </button>
		                    
		                    <!-- 드롭다운 메뉴 -->
		                    <ul class="dropdown-menu shadow-sm border-0" aria-labelledby="dropdownMenuButton">
		                        <li>
		                            <a class="dropdown-item d-flex align-items-center" onclick="fn_post_edit(\${element.boardNo})" data-bs-toggle="modal" data-bs-target="#postEditModal">
		                                <span class="me-2">✏️수정하기</span> 
		                            </a>
		                        </li>
		                        <li>
		                            <a class="dropdown-item d-flex align-items-center text-danger" href="/oho/community/deleteBoard?boardNo=\${element.boardNo}&comProfileNo=\${element.comProfileNo}">
		                                <span class="me-2">🗑️삭제하기</span> 
		                            </a>
		                        </li>
		                    </ul>
		                </div>
		                </div>
		            			
		            	`;
		            	
		            }
		        else{
		        	str+=`
		        		<div class="position-absolute top-1 end-0">
		        		<div class="dropdown">
		                <!-- 점 3개 버튼 -->
		                <button class="btn btn-light border rounded-circle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
		                    &#x22EE; <!-- 점 3개 아이콘 (수직) -->
		                </button>
		                
		                <!-- 드롭다운 메뉴 -->
		                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		                    <li>
		                    	<a class="dropdown-item d-flex align-items-center aReport" href="#" data-bs-toggle="modal"
	        						data-bs-target="#reportModal" data-report-board-no="\${element.boardNo}"
	        						data-mem-no="\${element.memNo}">
		                            <span class="me-2">🔔</span> 신고하기
		                        </a>
		                    </li>
		                </ul>
		            </div>
		        	</div>		
		        	`;
		        }
				                str+=`<small class="text-muted">\${element.boardCreateDate}</small>
				              	</div>
		          			</div>
		          			
		          			<div class="card-body">
				            	<h5 class="fw-bold mb-2">\${element.boardTitle}</h5>`;
								if(element.fileGroupVO?.fileDetailVOList?.length>0){

									$.each(element.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){
				                    
				        	                str+=`     <img src="/upload\${fileDetailVO.fileSaveLocate}" class="img-fluid rounded mb-3 post-image" onclick="openImageModal(this.src)">`;

							           
									});
								}
				            /* 			                <div class="card-footer bg-white d-flex justify-content-between align-items-center">
		                    <button class="btn btn-outline-danger" id="boardLikeBtn\${element.boardNo}" onclick="fn_board_likeYn(\${element.boardNo})">`;
		                 str+=`<i id="heartIcon\${element.boardNo}" class="bi bi-heart`;
		                $.each(element.boardLikeList,function(idx,boardLike){
		                	if(boardLike.memNo==memNo){
		                		str+=`-fill`;
		                		
		                		} 
		                });
		               str+=`"></i>`; */	
				            	
				            	
				         str+=`	<p class="card-text">
				              		\${element.boardContent}
				              	</p>
				            </div>
		          			
				            
				            <div class="card-footer bg-white border-0 d-flex justify-content-between align-items-center">
				            <button class="btn btn-outline-danger" id="boardLikeBtn\${element.boardNo}" onclick="fn_board_likeYn(\${element.boardNo})">`;
				            
				          str+=`<i id="heartIcon\${element.boardNo}" class="bi bi-heart`;
			                $.each(element.boardLikeList,function(idx,boardLike){
			                	if(boardLike.memNo==userNo){
			                		str+=`-fill`;
			                		
			                		} 
			                });
				          str+=`"></i> <span  id="boardLikeCnt\${element.boardNo}">\${element.boardLikeList.length}</span>
				            	</button>
								<button class="btn btn-sm btn-outline-danger rounded-pill px-3" id="repCnt\${element.boardNo}" onclick="fn_load_replies(\${element.boardNo})">
									💬 댓글 <span>\${element.replyList.length}</span>
				            	</button>
				            </div>
		          		</div>
		          	</div>
				 </div>
			`;
			
			
		})

		console.log("post::::::::::",res.data);
		   isLastPage = res.data.isLastPage;
           if (isLastPage) {
        	   $('#endMessage').show();
           }
		
		$("#postList").append(str);
	})
	.catch(function(error){
		console.log("내 포스트 리스트 불러오기 실패");
	})
}

function fn_load_replies(boardNo) {
    //토글 방식으로 댓글 보였다 안보였다 하기
/* 	$(`#\${boardNo}`).toggle();
	$(`#repCnt\${boardNo}`).toggle(); */
	console.log("오고있니?",boardNo)
   document.getElementById("replyModalLabel").textContent = `게시글\${boardNo}`;
   
   
   //boardNo에 작성된 댓글 목록 불러오기
	$.ajax({
		url:"/oho/community/replyList",
		data:{"boardNo":boardNo},
		type:"post",
		dataType:"json",
		success:function(communityReplyVOList){
			let str = "";
			console.log("communityReplyVOList-> ",communityReplyVOList);
			/*
			{
			    "replyNo": 18,
			    "replyContent": "333",
			    "replyDelyn": "N",
			    "replyCreateDt": null,
			    "boardNo": 19,
			    "artNo": 0,
			    "memNo": 8,
			    "mediaPostNo": 0,
			    "comProfileNo": 1,
			    "repCreateDate": "2025-04-07 12:14:47",
			    "replyLikeCnt": 0,
			    "comNm": "오세인",
			    "comAuth": "ROLE_MEM",
			    "fileSaveLocate": "/2025/04/04/81334eac-5514-4589-8d10-78c637b48be4_0a487495-399b-40c4-bbcf-1ac3c312757e_img2.jpg",
			    "profileFileNo": 0,
			    "fileGroupNo": 0,
			    "communityProfileVO": null,
			    "replyLikeList": null,
			    "fileGroupVO": {
			        "fileGroupNo": 0,
			        "fileRegdate": null,
			        "fileDetailVOList": [
			            {
			                "fileSn": 0,
			                "fileGroupNo": 0,
			                "fileOriginalName": null,
			                "fileSaveName": null,
			                "fileSaveLocate": "/2025/04/04/81334eac-5514-4589-8d10-78c637b48be4_0a487495-399b-40c4-bbcf-1ac3c312757e_img2.jpg",
			                "fileSize": 0,
			                "fileExt": null,
			                "fileMime": null,
			                "fileFancysize": null,
			                "fileSaveDate": null,
			                "fileDowncount": 0
			            }
			        ]
			    },
			    "uploadFile": null
			}
			*/	
			
			$.each(communityReplyVOList,function(idx,communityReplyVO){
			
		
				str += `

					  <div class="card border-0 shadow-sm rounded-4 px-3 py-2 position-relative mb-3" id="replyNumber\${communityReplyVO.replyNo}">
					    <div class="d-flex align-items-start">`;
					      
               if(communityReplyVO.fileSaveLocate != null && communityReplyVO.fileSaveLocate != ""){             
                str+=`     <img src="/upload\${communityReplyVO.fileSaveLocate}" class="rounded-circle me-3" width="40" height="40" onclick="openImageModal(this.src)" style="object-fit: cover; cursor: pointer;">`;
                }else{
             	   str+=`     <img src="/images/defaultProfile.jpg" class="rounded-circle me-3" width="40" height="40" onclick="openImageModal(this.src)" style="object-fit: cover; cursor: pointer;">`;
                }           
				str+=`     <div class="flex-grow-1">
					        <div class="d-flex justify-content-between align-items-center">
					          <div>
					            <strong>
					              <a href="/oho/community/profileDetail?comProfileNo=\${communityReplyVO.comProfileNo}" 
					                 class="text-dark text-decoration-none">
					                 \${communityReplyVO.comNm}
					              </a>`;
	                	if(communityReplyVO.comAuth=='ROLE_ART'){
	                   str+=`  <span class="badge-star">🎵</span>`;        
	                            }
					   str+=` </strong>
					            <p class="mb-1 text-muted small">\${communityReplyVO.repCreateDate}</p>
					          </div>`;
					   if(communityReplyVO.memNo == userNo){
					   str+=` <div class="dropdown">
					            <button class="btn btn-light btn-sm border-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					              <i class="bi bi-three-dots-vertical"></i>
					            </button>
					            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
					              <li >
					                <a class="dropdown-item text-danger d-flex align-items-center"  
					                   onclick="fn_delete_reply(\${communityReplyVO.replyNo}, \${boardNo})">
					                  🗑️ <span class="ms-2" style="cursor:pointer;"  >삭제하기</span>
					                </a>
					              </li>
					            </ul>
					          </div>`;
					          }
					          else{
			                str+=`<div class="dropdown">
			                        <!-- 점 3개 버튼 -->
			                        <button class="btn btn-light border rounded-circle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
			                            &#x22EE; <!-- 점 3개 아이콘 (수직) -->
			                        </button>
			                        
			                        <!-- 드롭다운 메뉴 -->
			                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			                            <li>
				                    		 <a class="dropdown-item d-flex align-items-center aReport" href="#" data-bs-toggle="modal"
			        						 			data-bs-target="#reportModal" data-report-board-no="\${communityReplyVO.boardNo}"
			        						 			data-mem-no="\${communityReplyVO.memNo}">
					                        <span class="me-2" style="cursor:pointer;">🔔</span> 신고하기
					                   		 </a>                	
			                            </li>
			                        </ul>
			                    </div>`;
					          }
					          
				str+=`      </div>
					        <p class="mb-2">\${communityReplyVO.replyContent}</p>				        
					        <button class="btn btn-sm btn-outline-danger rounded-pill px-2 py-1" 
					                id="replyLikeBtn\${communityReplyVO.replyNo}" 
					                onclick="fn_reply_likeYn(\${boardNo}, \${communityReplyVO.replyNo})">
					          <i id="heartIcon\${communityReplyVO.replyNo}" class="bi bi-heart"></i>
					          <span id="replyLikeCnt\${communityReplyVO.replyNo}" class="ms-1">\${communityReplyVO.replyLikeCnt}</span>
					        </button>
					      </div>
					    </div>
					  </div>
					`;
			
			   });//end each
			
			
			$("#replyList").html(str);
			
		    new bootstrap.Modal(document.getElementById('replyModal')).show();
		}
	});
}

//댓글 삭제하기
function fn_delete_reply(replyNo,boardNo){
	
	let data = {
		"replyNo":replyNo,
		"boardNo":boardNo

	};
	let url="/oho/community/deleteReply?replyNo="+replyNo+"&boardNo="+boardNo;
	$.ajax({
		url:url,
		contentType:"aplication/json; charset=utf-8",
		type:"get",
		dataType:"json",
		success: function(replyCnt){
			console.log("성공햇니?",replyCnt,replyNo);
			let str = `💬 댓글 <span>\${replyCnt}</span>`;
			$(`#repCnt\${boardNo}`).html((str));
			$(`#replyNumber\${replyNo}`).remove();
		},
		error : function(){
			alert('error');
		}
		
		})
	
}

function followingList(){
	  axios.get("/oho/community/followingList", {
		  params:{
		    memNo : userNo,
		    artGroupNo : artGroupNo
		  }
		  })
		  .then(function(res) {
			  let followingList = res.data;
			  console.log("followingList :::::" , followingList);
			  
		    // 요청 성공 시 처리: 예를 들어, 버튼 텍스트를 변경하거나 알림 표시
				if (followingList.length > 0) {
				  let isFollowing = false;
				
				  $.each(followingList, function(idx, followMember) {
				    if (targetComProfileNo == followMember.comProfileNo) {
				      isFollowing = true;
				      return false; // break
				    }
				  });
				
				  if (isFollowing) {
				    $("#followY").hide();
				    $("#followN").show();
				  } else {
				    $("#followY").show();
				    $("#followN").hide();
				  }
				} else {
				  $("#followY").show();
				  $("#followN").hide();
				}
		  })
		  .catch(function(error) {
		    console.error("팔로우 실패:", error);
		    alert("팔로우에 실패했습니다. 잠시 후 다시 시도해주세요.");
		  });
}

function openFollowingModal() {
    $.ajax({
      url: "/oho/community/followingList",
      contentType:"application/json; charset=utf-8",
      type: "GET",
      data: { "comProfileNo": ${communityProfileVO.comProfileNo} },
      success: function(data) {
    	  console.log("data",data);
        let followingList = "";
        data.forEach(communityProfile => {
        	console.log("communityProfile",communityProfile);
          followingList += `
              <div class="modal-body p-4" style="max-height: 400px; overflow-y: auto;">
              <ul class="list-group list-group-flush">
                  <li class="list-group-item d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">`;
                    	
						if(communityProfile.fileGroupVO?.fileDetailVOList?.length>0){
							
							$.each(communityProfile.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){
					           followingList += `<img src="/upload\${fileDetailVO.fileSaveLocate}" class="profile-img2" onclick="openImageModal(this.src)">`;
							});
							
						}
		                
        followingList+=`<a href="/oho/community/profileDetail?comProfileNo=\${communityProfile.comProfileNo}" style="text-decoration: none;"><span class="ms-3 fw-bold">\${communityProfile.comNm}`;
          if(communityProfile.comAuth=='ROLE_ART'){
    followingList+=`<span class="badge-star">🎵</span>`;        
                      }
followingList+=`    </span></a>
                    </div>
                    
                    <button class="btn btn-outline-secondary btn-sm" >팔로잉</button>
                   
                  </li>
              </ul>
            </div>`;
        });
        $("#followingList").html(followingList);
        var modal = new bootstrap.Modal(document.getElementById('followingModal'));
        modal.show();
      },
      error: function() {
        alert("팔로잉 목록을 불러오는데 실패했습니다.");
      }
    });
  }
  
function fn_post_edit(boardNo){
	let data ={
			"boardNo":boardNo
	}
	let url="/oho/community/editFanBoardAjax2?boardNo="+boardNo;
	$.ajax({
		url:url,
		contentType:"application/json; charset=utf-8",
		dataType:"json",
		type:"get",
		success: function(communityPostVO){
			
			$("#boardEditTitle").val(communityPostVO.boardTitle);
			$("#boardEditContent").val(communityPostVO.boardContent);
			
			let str="";
			
			if(communityPostVO.fileGroupVO?.fileDetailVOList?.length>0){
				str+=`<div class="grid">`;
				$.each(communityPostVO.fileGroupVO.fileDetailVOList,function(idx,fileDetailVO){
		            str += `<img src="/upload\${fileDetailVO.fileSaveLocate}"/>`;
				});
				str+=`</div>`
			}
			console.log("str : ",str);
			$("#editImg").html(str);
			$("#editBoardNo").val(boardNo);
		}
	})
}

  function fn_edit_profile(){
      location.href="/oho/community/editProfile?comProfileNo=${communityProfileVO.comProfileNo}";
  }
  function fn_move_list() {
      if (fromPage === 'artistBoardList') {
          location.href = "/oho/community/artistBoardList?artGroupNo=${communityProfileVO.artGroupNo}";
      } else {
          // 기본은 fanBoardList
          location.href = "/oho/community/fanBoardList?artGroupNo=${communityProfileVO.artGroupNo}";
      }
  }
  function followYn(comProfileNo,userNo,artGroupNo) {
	  console.log("들어오니?::::::::::::::",comProfileNo,userNo,artGroupNo);
	  axios.post("/oho/community/followYn", {
		followProfileNo : comProfileNo,
	    memNo : userNo,
	    artGroupNo : artGroupNo
	  })
	  .then(function(followerCnt) {
	    // 요청 성공 시 처리: 예를 들어, 버튼 텍스트를 변경하거나 알림 표시

	    let cnt = followerCnt.data;
	    // 필요하면 UI 업데이트 (예: 팔로워 수 증가)
	    if ($("#followY").is(":visible")) {
			    $("#followY").hide();
			    $("#followN").show();
			} else {
			    $("#followY").show();
			    $("#followN").hide();
			}
	    $("#followerCnt").html(cnt);
	  })
	  .catch(function(error) {
	    console.error("팔로우 실패:", error);
	    alert("팔로우에 실패했습니다. 잠시 후 다시 시도해주세요.");
	  });
	}
  function fn_reply_likeYn(boardNo,replyNo){
		let data = {
				"memNo":userNo,
				"artGroupNo":artGroupNo,
				"replyNo":replyNo,
				"boardNo":boardNo
	            
		};
		let url="/oho/community/replyLikeYnAjax?"+$.param(data);
		console.log("data : ",data);
		
		 $.ajax({
				url:url,
				contentType:"application/json; charset=utf-8",
				type:"get",
				dataType:"json"
	    , success: function(replyLikeCnt) {
	 	    console.log("replyLikeCnt 성공했습니다 ", replyLikeCnt);
	 	   
	 	    let str =`\${replyLikeCnt}`;
	 	  $(`#replyLikeCnt\${replyNo}`).html(str);
	 	},
			error : function() {
	         alert('error');
	   },
	   complete : function() {       
		 	replyToggleLike(boardNo,replyNo);
	 	  }
		 }); //ajax
	}
	//댓글 좋아요 토글
	function replyToggleLike(boardNo,replyNo) {
	    let replyLikeBtn = document.getElementById(`replyLikeBtn\${replyNo}`);
	    let heartIcon = document.getElementById(`heartIcon\${replyNo}`);
	    console.log(heartIcon);
		console.log("들어오고 있니?",replyNo);
	    let isLiked = heartIcon.classList.contains("bi-heart-fill");

	    if (isLiked) {
	        heartIcon.classList.remove("bi-heart-fill");
	        heartIcon.classList.add("bi-heart");
	        replyLikeBtn.classList.remove("btn-danger");
	        replyLikeBtn.classList.add("btn-outline-danger");

	    } else {
	        heartIcon.classList.remove("bi-heart");
	        heartIcon.classList.add("bi-heart-fill");
	        replyLikeBtn.classList.remove("btn-outline-danger");
	        replyLikeBtn.classList.add("btn-danger");

	    }
	}
	//게시물 좋아요 토글
	function fn_board_likeYn(boardNo){
		

		
		
		let data = {
				"memNo":userNo,
				"artGroupNo":artGroupNo,
				"boardNo":boardNo

		};
		let url="/oho/community/boardLikeYnAjax?"+$.param(data);
		console.log("data : ",data);
		
		 $.ajax({
				url:url,
				contentType:"application/json; charset=utf-8",
				type:"get",
				dataType:"json"
	    , success: function(boardLikeCnt) {
	 	    console.log("boardLikeCnt 성공했습니다 ", boardLikeCnt);
	 	   
	 	    let str =`\${boardLikeCnt}`;
	 	  $(`#boardLikeCnt\${boardNo}`).html(str);
	 	  
	 	},
			error : function() {
	         alert('error');
	   },
	   complete : function() {       
		 	toggleLike(boardNo);
	  	  }
		 }); //ajax
	}
	//토글 정의 -> 빈하트 하트 유무 체크해서 변화 ( 부트스트랩 5 기능 )
	function toggleLike(boardNo) {
	    let boardLikeBtn = document.getElementById(`boardLikeBtn\${boardNo}`);
	    let heartIcon = document.getElementById(`heartIcon\${boardNo}`);
	    console.log(heartIcon);
		console.log("들어오고 있니?",boardNo);
	    let isLiked = heartIcon.classList.contains("bi-heart-fill");

	    if (isLiked) {
	        heartIcon.classList.remove("bi-heart-fill");
	        heartIcon.classList.add("bi-heart");
	        boardLikeBtn.classList.remove("btn-danger");
	        boardLikeBtn.classList.add("btn-outline-danger");

	    } else {
	        heartIcon.classList.remove("bi-heart");
	        heartIcon.classList.add("bi-heart-fill");
	        boardLikeBtn.classList.remove("btn-outline-danger");
	        boardLikeBtn.classList.add("btn-danger");

	    }
	}	
  
  function readFile(input) {
	    const editImgDiv = document.querySelector("#editImg .grid");
	    editImgDiv.innerHTML = ""; // 기존 이미지 제거

	    const files = input.files;

	    if (!files || files.length === 0) return;

	    Array.from(files).forEach(file => {
	        const reader = new FileReader();

	        reader.onload = function(e) {
	            const img = document.createElement("img");
	            img.src = e.target.result;
	            img.style.cursor = "pointer";
	            img.style.borderRadius = "10px";
	            img.style.objectFit = "cover";
	            img.style.width = "100%";
	            img.style.height = "100%";
	            editImgDiv.appendChild(img);
	        };

	        reader.readAsDataURL(file);
	    });
	}
  
//스크롤 바닥 감지
  window.onscroll = function(e) {	
      if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    	  if(isLastPage!=null){
          if (!isLastPage) {  // 마지막 페이지가 아니면 페이지 증가
              currentPage +=1;
              console.log("currentPage:", currentPage);
              myPostList(currentPage, "");
             
				
          } else if(isLastPage) {
              console.log("모든 데이터를 불러왔습니다.");
          }
    	  }
    	  if(isReplyLastPage!=null){
          if(!isReplyLastPage){
        	  currentReplyPage += 1;
        	  myReplyList(currentReplyPage,"");
          }
          else if(isReplyLastPage){
        	  console.log("댓글 데이터를 다 불러왔습니다");
          }
    	  }
      }
  };
  
</script>

	<!-- Scroll Top -->
	<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>

</html>
