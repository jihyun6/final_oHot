<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHot Media</title>
<link rel="styleSheet" href="/css/media-live/media-live.css">
<link rel="styleSheet" href="/css/media-live/media-live-detail.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link rel="styleSheet" href="/css/media-live/media-live.css">
<link rel="styleSheet" href="/css/media-live/live-hearder.css">
<!--axios js는 헤더에 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<!-- 번역 js -->
<script src="/js/translate/translate.js"></script>
</head>
<body>
<!-- header.jsp 시작 -->
<%@ include file="../header.jsp" %>
<!-- 커뮤니티페이지 네비, 탭-->

  <div class="weverse-tabs d-flex justify-content-center" style="margin-top: 0; padding-top: 1;">
    <ul class="nav nav-pills nav-fill">
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/fanBoardList?artGroupNo=${param.artGroupNo}">
          Fan
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/artistBoardList?artGroupNo=${param.artGroupNo}">
          Artist
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active"
           href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">
          Media
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/oho/community/live?artGroupNo=${param.artGroupNo}">
          Live
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link"
           href="${pageContext.request.contextPath}/shop/artistGroup?artGroupNo=${param.artGroupNo}"
           target="_blank">
          Shop
        </a>
      </li>
    </ul>
  </div>

<!--네비탭 끝 -->
<!-- 본문 영역  -->
<!-- 넘어오는 객체들 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<!-- SELECT  U.USER_NO, U.USER_MAIL, USER_PSWD, A.AUTH_NM -->
<!-- ${usersVO} -->
<!-- 본문 영역 -->

<div class="media-container container-fruid px-6" style="height:1000px;">
 <div class="row py-4" style="height:100%;">
	<div class="col col-md-9">
		 <c:choose>
       	 <%-- 유튜브 영상인 경우 --%>
        <c:when test="${mediaPostVO.mediaMebershipYn eq 'N'}">
          <iframe 
            width="100%" 
            height="70%" 
            src="https://www.youtube.com/embed/${mediaPostVO.mediaVideoUrl}?si=EXH1kqCMF0PLhEeh" 
            title="YouTube video player" 
            frameborder="0" 
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
            referrerpolicy="strict-origin-when-cross-origin" 
            allowfullscreen>
          </iframe>
        </c:when>
       	 <%-- 로컬 동영상 파일인 경우 --%>
        <c:otherwise>
          <video width="100%" height="70%" controls preload="auto" playsinline crossorigin="anonymous">
            <source src="/upload${mediaPostVO.mediaVideoUrl}" type="video/mp4">
            멤버쉽 영상 영역
          </video>
        </c:otherwise>
      </c:choose>
        <div style="height: 7%; display: flex; align-items: self-end;">
        	<h2 class="fw-bold" style="color:white;">${mediaPostVO.mediaPostTitle}</h2>
        </div>
		<div class="border-bottom" style="border-bottom-width:3px !important; height: 7%;display: flex; align-items: center;">
			<img src="/upload${mediaPostVO.fileLogoSaveLocate}" alt="아티스트 프로필" class="rounded-circle me-3" style="width: 50px; height: 50px; display: inline-block;">
			<div class="col col-md-12">
				<h4 class="fw-bold" style="color:white;">${mediaPostVO.artistGroupVO.artGroupNm}</h4>
				<span style="color:white;"><fmt:formatDate value="${mediaPostVO.mediaRegDt}" pattern="yyyy.MM.dd"/></span>
			</div>
		</div>
		<div style="height: 15%; padding-top: 20px">
      <div class="" style="color:white; white-space: pre-line;">${mediaPostVO.mediaPostCn}</div>
  </div>
	</div>
	
	<!-- 댓글 창 영역 -->
<div class="comment-container col col-3 flex">
    <!-- 댓글 헤더 영역 -->
    <div class="comment-header row row-1 fw-bold">
        <div class="comment-count col col-12">
            <span id="comment-count-span"></span>
            <button class="comment-reset"><i class="fa-solid fa-rotate"></i></button>
        </div>
    </div>
    
    <!-- 댓글 본문 영역 -->
    <div id="comment-body" class="comment-body row row-md-10">
        
    </div>
    
    <!-- 댓글 입력 영역 -->
    <div class="comment-footer row-md-1 d-flex">
        <input id="inputReply" type="text" class="form-control comment-input" placeholder="댓글을 입력하세요.">
        <button id="inputReplyBtn" class="btn text-white ms-1" style="padding: 0%;">
            <i class="bi bi-arrow-up-circle" style="font-size: x-large;"></i>
        </button>
    </div>
    </div>
  </div>
</div>

<!-- 본문 영역 끝 -->
<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>
	
<!-- ///// 신고하기 모달 시작 ///// -->
<div class="modal fade" id="reportModal" tabindex="-1"
    aria-labelledby="reportModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- 모달 헤더 -->
            <div class="modal-header">
                <h5 id="reportModalLabel" style="text-align: center;">신고하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>

            <!-- /// 모달 바디 시작 /// -->
            <div class="modal-body">
                <!-- 유저정보 -->
                <input
                    style="font-weight: bold; font-size: 18px; border: none; background: transparent;"
                    type="hidden" name="memNo" id="userNoModal"
                    value="유저NO : ${usersVO.userNo}" /> <input
                    style="font-weight: bold; font-size: 18px; border: none; background: transparent; width: 100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
                    type="text" name="memEmail" id="memEmailModal"
                    value="유저EMAIL : ${usersVO.userMail}" />

                <!-- 신고 사유 -->
                <div class="form-group row">
                    <label class="col-sm-4 col-form-label"><h5>신고사유</h5></label>
                    <div class="col-sm-9">
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle1" name="reportTitle"
                                value="영리적인/흥보성" /> <label for="reportTitle1">영리적인/흥보성</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle2" name="reportTitle"
                                value="음란물" /> <label for="reportTitle2">음란물</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle3" name="reportTitle"
                                value="불법정보" /> <label for="reportTitle3">불법정보</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle4" name="reportTitle"
                                value="음란성/선정성" /> <label for="reportTitle4">음란성/선정성</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle5" name="reportTitle"
                                value="욕설/인신공격" /> <label for="reportTitle5">욕설/인신공격</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle6" name="reportTitle"
                                value="아이디/DB거래" /> <label for="reportTitle6">아이디/DB거래</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle7" name="reportTitle"
                                value="같은 내용 반복(도배)" /> <label for="reportTitle7">같은
                                내용 반복(도배)</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle8" name="reportTitle"
                                value="운영규칙 위반" /> <label for="reportTitle8">운영규칙 위반</label>
                        </div>
                        <div>
                            <input type="radio" id="reportTitle9" name="reportTitle"
                                value="기타" /> <label for="reportTitle9">기타</label>
                        </div>
                    </div>
                </div>
                <br>

                <div class="form-group row">
                    <h4>상세내용</h4>
                    <div class="col-sm-8">
                        <textarea id="reportCn" name="reportCn" cols="60" rows="10"
                            class="form-control" style="text-align: left;"></textarea>
                        <code>* ex) 부적절한 게시글</code>
                    </div>
                </div>

                <div class="form-group row">
                    <h4>신고사진</h4>
                    <div class="col-sm-8">
                        <input type="file" class="form-control" id="uploadFile"
                            name="uploadFile" multiple />
                    </div>
                </div>
            </div>
            <!-- /// 모달 바디 끝 /// -->

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnModalClose"
                    data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="btnModalSubmit"
                    data-mem-no="${usersVO.userNo}">전송</button>
            </div>
        </div>
    </div>
</div>
<!-- ///// 신고하기 모달 끝 ///// -->

<!-- data 속성으로 js와 el표현식 분리하는 방법 -->
<!-- 간단한 식별에 사용되는 파라미터 정도 넘길때만 사용 -->
<div id="app-data"
	data-media-post-no = ${mediaPostVO.mediaPostNo}
	data-mem-no = ${communityProfileVO.memNo}
	data-com-nm = "${communityProfileVO.comNm}"
	data-com-profile-save-locate = "${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
  data-art-group-no = ${mediaPostVO.artGroupNo}
  data-com-prifile-no = ${communityProfileVO.comProfileNo}
  data-com-auth = ${communityProfileVO.comAuth}
>
</div> 



<script src="/main/assets/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<%@ include file="../footer.jsp" %>
<script type="text/javascript">
  // 다른 스크립트랑 충돌 최소화를 위한 즉시실행함수 방식
 
(function(){
    // 이건 바닐라js로만 구현해보기 키워드 =[axios, fetch, async/await]
   console.log("즉시실행 확인");
/////////////전역변수 영역////////////////////////
const appData = document.querySelector("#app-data");

// 현재 게시글번호 가져오기
const mediaPostNo = appData.dataset.mediaPostNo; //데이터셋으로 가져와보기
// 접속한 유저의 번호
const memNo = appData.getAttribute("data-mem-no"); // getAttribute로 접근하기, 브라우저 호환성 좋음
// 접속한 유저의 닉네임
const comNm = appData.getAttribute("data-com-cm");
// 접속한 유저의 프로필 이미지 경로
const comProfileSaveLocate = appData.getAttribute("data-com-profile-save-locate");
// 아티스트그룹 번호
const artGroupNo = appData.getAttribute("data-art-group-no");
// 접속한 유저의 프로필 번호
const comProfileNo = appData.getAttribute("data-com-prifile-no");
// 접속한 유저의 권한
const comAuth = appData.getAttribute("data-com-auth");

/////////////전역변수 영역 끝////////////////////////
// 댓글 테이블에서 해당 게시글no에 해당하는거 전체 조회
// 동적 쿼리로 단건, 다건 select 구현
function getReplyList(){ 
  // axios get방식이면 그냥 쿼리스트링에 파라미터 붙여서 보내도 무관. 
  //근데 파라미터 담는 객체 만들어서 보내는게 권장되는 방법!
  axios.get("/api/media/getReplyList", {
    params: {
      mediaPostNo : mediaPostNo,
      artGroupNo : artGroupNo
    }
  })
  .then((response) => {
    // 응답성공
    console.log("getReplyList 응답성공 : ", response);
    // 댓글 리스트 정보
    const replyList = response.data; // 객체가 담긴 배열임
    
    // 댓글 카운트 수
    const commentCount = replyList.length;
    const commentCountSpan = document.querySelector("#comment-count-span");
    
    // 댓글 카운트 할당
    commentCountSpan.textContent = commentCount + " Comments";

    // 댓글 영역 초기화
    const commentBody = document.querySelector("#comment-body");
    commentBody.innerHTML = "";

    // null처리 댓글 없을때
    if(replyList.length === 0){
      commentBody.innerHTML = `
          <div class="text-center py-4">
              <p style="color: white;">등록된 댓글이 없습니다.</p>
          </div>
      `;
      return ;
    }

    // 불러온 댓글 렌더링
    replyList.forEach(reply => { // reply는 객체임, key:value
        // 댓글 작성자 여부 변수
        const isReplyWriter = memNo == reply.memNo;
        console.log(isReplyWriter);
        // 댓글 작성자의 프로필 이미지 경로
        const replyWriterProfileImgPath = "/upload" + reply.fileSaveLocate;
        // 댓글 작성자의 멤버넘버
        const replyWriterMemNo = reply.memNo;
        // 댓글 작성자의 닉네임
        const replyWriterProfileName = reply.comNm;
        // 땟글 작성자의 프로필 넘버 = 
        const replyWriterProfileNo = reply.comProfileNo;
        // 댓글 작성자의 권한
        const replyWriterAuth = reply.comAuth;
        // 댓글의 작성일자, 일시
        const replyRegDate = reply.replyCreateDt; // "2025-04-15 17:19" 문자열임
        // 해당 댓글 넘버
        const replyNo = reply.replyNo;

        console.log("replyNo: ", replyNo);

        // 댓글 본문 영역 html
        // jsp페이지에서만 템플릿 리터럴 쓸때 백슬래시 붙여야함, js파일 따로 빼면 백슬래시 빼고
        let commentHtml = `
            <div class="comment-item" data-reply-no="\${replyNo}">
                <!-- 댓글 정보 영역 -->
                <div class="comment-info d-flex align-items-center row">
                    <div class="col-2">
                        <img class="comment-profile-img rounded-circle" src="\${replyWriterProfileImgPath}" alt="\${replyWriterProfileName}의 프로필">
                    </div>
                    <div class="col-8">
                        <div class="comment-prfile-info">
                            <span class="comment-nickname fw-bold" style="color:white;">\${replyWriterProfileName}</span>
                            <span class="comment-regdate" style="color:#aaa; font-size:0.8rem;">\${replyRegDate}</span>
                        </div>
                    </div>
                    <!-- 드롭다운 케밥아이콘 버튼 -->
                    <div class="col-2 d-flex justify-content-end">
                        <div class="comment-dropdown d-flex justify-content-end">
                            <button class="btn btn-link text-white" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots-vertical"></i>
                            </button>
                            <ul class="dropdown-menu">`;
                              if(isReplyWriter){
                                commentHtml += `<li><a class="dropdown-item update-reply" href="#" data-reply-no="\${replyNo}">✏️ 수정하기</a></li>`;
                                commentHtml += `<li><a class="dropdown-item delete-reply" href="#" data-reply-no="\${replyNo}">🗑️ 삭제하기</a></li>`;
                              }
                              else{
                                commentHtml += `<li><a class="dropdown-item aReport" href="#" data-bs-toggle="modal" 
                                                    data-bs-target="#reportModal" data-report-gubun="댓글" 
                                                    data-report-board-no="\${replyNo}" data-mem-no="\${memNo}">🔔 신고하기</a></li>`;
                              }
        commentHtml += `</ul>
                      </div>
                    </div>
                  </div>
                  
                   <div class="row comment-content-container mb-4">
                <div class="col comment-content">
                  <div class="multiline-truncate card-reply" style="color:white; max-width: 100%; white-space: pre-line" data-original="\${reply.replyContent}">\${reply.replyContent}</div>
                  <button class="reply-translate-btn" onclick="commuReplyTrans()" data-lang="en" data-status="original">번역하기</button>
              </div>
            </div>
        </div>
        `;


      // 댓글 본문 탯그에 등록
      commentBody.innerHTML += commentHtml;
    });// 반복문 끝

    // 댓글 옵션버튼 이벤트 할당
    addCommentEventListener();

  }).catch((err) => {
    // 응답실패
  }).finally(()=>{
    console.log("/api/media/getReplyList 요청 확인")
  });
  
}

// 댓글 등록
function createReply(){
  console.log("댓글 등록 진입");
  // 댓글입력 태그
  const inputReply = document.querySelector("#inputReply");
  // 댓글 입력 내영
  const replyContent = inputReply.value;
  // db에 입력하는 text내용들은 앵간하면 trim
  replyContent.trim();

  // null체크
  if(!replyContent){
    // sweetalert써보기
    Swal.fire({
      icon : "warning",
      title : "댓글을 입력해주세요.",
      confirmButtonText : '확인'
       });
       return ;
  }

  // 어차피 인증된회원이랑, 멤버쉽 멤버만 접근할건데 댓글입력할때 권한체크 필요한가?? => 나중에 필요하면 할거

  // 전송할 댓글 데이터
  const replyData = {
    mediaPostNo : mediaPostNo,
    memNo : memNo,
    replyContent : replyContent,
    artGroupNo : artGroupNo,
    comProfileNo : comProfileNo,
    urlCategory : comAuth
  };
  
  console.log("replyData : ", replyData);
  // 등록api요청
  axios.post("/api/media/createReply", replyData)
  .then(response => {
    // 전송 성공하면 댓글 입력창 초기화
    inputReply.value = ""; // inputReply.textContent = ""; 랑 무슨 차이지?

    // 등록하면 댓글리스트 리렌더링 => Get함수 만들면 적용하기
    getReplyList();

    Swal.fire({
      icon: "success",
      title: " 댓글을 등록했습니다.",
      showConfirmButton: false,
      timer : 1000
    });
  })
  .catch(error => {
    console.error("댓글 등록 실패", error);
    Swal.fire({
      icon: 'error',
      title: "댓글 등록을 실패했습니다.",
      text: "다시 시도해주세요.",
      confirmButtonText : "확인"
    })
    .finally(()=>{
      console.log("axios요청 확인");
    })
  });
}

// 댓글 수정
async function updateReply(replyNo, replyContent){
  console.log("댓글 수정 함수 진입");
  console.log("updateReply->replyNo: ", replyNo);
  console.log("updateReply->replyContent: ", replyContent);
  
  const result = await Swal.fire({
    title: "댓글 수정",
    input: "text",
    inputValue: replyContent.trim(),
    inputPlaceholder: "댓글을 수정해주세요.",
    showCancelButton: true,
    confirmButtonText: "저장",
    cancelButtonText: "취소",
    inputValidator: (input) => 
    {
      if(!input) {
        return "댓들을 반드시 입력해주세요.";
      }
    }
  });

  console.log("Swal result: ", result);

  // 수정 버튼 클릭시 api호출
  if(result.isConfirmed){
    const newReplyContent = result.value;
    console.log("수정api호출 진입");

    axios.post("/api/media/updateReply", {
        replyNo : replyNo,
        replyContent : newReplyContent
    })
    .then(function (response){ // 자동으로 응답코드 200처리(ok)
      console.log("axios response: ", response);

      Swal.fire({
      icon: "success",
      title: " 댓글을 수정했습니다.",
      showConfirmButton: false,
      timer : 1000,
      position : "top-end"
    });

    // 수정 후 댓글리스트 리렌더링
    getReplyList();
    })
    .catch(error => { // 자동으로 응답코드 400처리(badRequest)
      console.log("댓글 수정 실패: ", error);
      Swal.fire({
      icon: "error",
      title: "댓글 수정에 실패했습니다.",
      text: "다시 시도해주세요.",
      confirmButtonText: "확인"
    });
    })
    .finally(()=>{
      console.log("수정 요청 확인");
    })
  }
}

// 댓글 삭제
async function deleteReply(replyNo){
  console.log("댓글 삭제 진입");

  const delReplyNo = replyNo;
  
  const result = await Swal.fire({
    icon: "warning",
    title: "댓글을 삭제하시겠습니까?",
    showCancelButton: true,
    confirmButtonText: "삭제",
    cancelButtonText: "취소"
  });// 즉시 실행

  if(result.isConfirmed){
    //댓글 삭제 수락시
    axios.post("/api/media/deleteReply", {
      replyNo: delReplyNo
    }).then((response) => {
      console.log("댓글 삭제 성공 : ", response);
      
      Swal.fire({
        icon:"success",
        text:"댓글 삭제 성공",
        showConfirmButton: false,
        timer : 1000,
        position : "top-end"
      });

      // 댓글 리스트 다시 그리기
      getReplyList();
    })
    .catch((error) => {
      console.log("댓글 삭제 실패: ", error);
    })
  }
}



////////// 이벤트 추가///////////////

// 동적으로 생성된 버튼 이벤트 연결
function addCommentEventListener() {
    // 댓글 수정 버튼 이벤트
    document.querySelectorAll('.update-reply').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            console.log("댓글 수정 이벤트 발동");
            console.log("2: ", e.target);
            console.log("3: ", e.target.getAttribute("data-reply-no"));
            console.log("4: ", e.target.dataset);
            //수정할 댓글 넘버
            const replyNo = e.target.getAttribute("data-reply-no");
            console.log("OOOO: ", replyNo);
            // 수정할 댓글 넘버에 해당하는 댓글 
            const commentItem = document.querySelector(`.comment-item`);
            console.log("***: ", commentItem);
            // 수정할 댓글 내용
            let replyContent = commentItem.querySelector('.multiline-truncate').textContent;
            console.log("###: ", replyContent);
            updateReply(replyNo, replyContent);
        });
    });
    
    // 댓글 삭제 버튼 이벤트
    document.querySelectorAll('.delete-reply').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            //삭제할 댓글 넘버
            const replyNo = e.target.getAttribute("data-reply-no");
           
            deleteReply(replyNo);
        });
    });
}

//////////첫 렌더링 시 실행 함수들////////////////
document.addEventListener("DOMContentLoaded", () => {
  // 댓글리스트 불러오기
  getReplyList();

  // 댓글 리스트 새로고침
  const resetReply = document.querySelector(".comment-reset");
  resetReply.addEventListener("click", () => {
    console.log("댓글 새로고침");
    getReplyList();
  })

  // 댓글 등록 버튼
  const inputReplyBtn = document.querySelector("#inputReplyBtn");
  inputReplyBtn.addEventListener("click", () => {
	  createReply();
  });
  
})

})(); // 즉시실행함수 닫는 위치에 함수실행 괄호 꼭 넣어주기!!
</script>
</body>
</html>