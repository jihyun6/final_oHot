<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>oHot Live Studio</title>
  <link rel="stylesheet" href="/css/media-live/media-live.css">
  <link rel="stylesheet" href="/css/media-live/media-live-detail.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <script src="/js/translate/translate.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/livekit-client/dist/livekit-client.umd.min.js"></script>
  <link rel="styleSheet" href="/css/media-live/live-hearder.css">
<style>
.comment-body {
 height: 600px;
 overflow-y: auto;
 overflow-x: hidden;
 min-height: 0px;
 display: block;
 row-gap: 12px;
 padding-bottom: 80px;
}

.comment-item {
  margin: 0 !important; /* 기존 margin 무효화 */
  border-radius: 8px;
  padding: 5px;
}

.comment-content {
  margin-left: 15%;
  margin-right: 5%;
}

.comment-item,
.comment-content-container,
.comment-content {
  max-width: 100%;
  word-wrap: break-word;
  word-break: break-word;
  overflow-wrap: break-word;
}

.comment-content-container.row {
  margin-left: 0 !important;
  margin-right: 0 !important;
}

.comment-footer {
  flex-shrink: 0;
  padding: 10px;
}

.system-message {
  text-align: center;
  color: #aaa;
  margin: 5px 0;
  font-size: 0.9rem;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
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
        <a class="nav-link "
           href="${pageContext.request.contextPath}/oho/community/media?artGroupNo=${param.artGroupNo}">
          Media
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active"
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

<sec:authorize access="isAuthenticated()">
  <sec:authentication property="principal.usersVO" var="usersVO" />
</sec:authorize>
<div class="media-container container-fluid py-4" style="min-height: 1000px;">
  <div class="row" style="height: 100%;">
  	<div class="col-1"></div>
    <div class="col-8">
      <div class="row mb-3 align-items-center" style="height: 5%;">
        <div class="col-md-3">
          <i class="bi bi-circle-fill text-danger" id="streamStatIcon"></i> <span class="text-white" id="streamStat">방송 OFF</span>
        </div>
        <div class="col-md-9 ms-auto text-end">
          <button class="btn btn-primary me-2" id="saveSettingBtn">방송 설정 저장</button>
          <button class="btn btn-danger" id="streamOnOffBtn">방송 시작</button>
        </div>>
      </div>

      <div class="row mb-3" style="height: 60%;">
        <video id="preview" autoplay muted playsinline style="width: 100%; height: 100%; background-color: black;"></video>
      </div>

      <div class="row" style="height: 35%;">
        <div class="col-7">
          <div class="mb-3">
            <label for="streamTitle" class="form-label text-white">방송 제목📌</label>
            
            <input type="text" class="form-control" id="streamTitle" placeholder="방송 제목을 입력해주세요.">
        
          </div>
          <div class="mb-3">
            <label for="streamExpln" class="form-label text-white">방송 설명📌</label>
            <textarea id="streamExpln" class="form-control" rows="5" placeholder="방송 설명을 입력해주세요."></textarea>
          </div>
        </div>
        <div class="col-5">
          <div class="mb-3">
            <label for="camSelect" class="form-label text-white">카메라</label>
            <select class="form-select" id="camSelect"></select>
          </div>
          <div class="mb-3">
            <label for="micSelect" class="form-label text-white">마이크</label>
            <select class="form-select" id="micSelect"></select>
          </div>
          <div class="mb-3">
            <label for="streamQty" class="form-label text-white">해상도</label>
            <select class="form-select" id="streamQty">
              <option value="FHD">Full HD (1080p)</option>
              <option value="HD">HD (720p)</option>
              <option value="SD">SD (480p)</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <div class="comment-container col-3 flex">
      <!-- 채팅 헤더 영역 -->
      <div class="comment-header row row-1 fw-bold" style="padding-left: 10px;">
        <div class="col-12">
          <span >채팅창</span>
        </div>
      </div>
      
      <!-- 채팅 본문 영역 -->
      <div id="comment-body" class="comment-body" style="height: 600px;">
          
      </div>
      
      <!-- 채팅 입력 영역 -->
      <div class="comment-footer row-md-1 d-flex">
          <input id="inputReply" type="text" class="form-control comment-input" placeholder="채팅을 입력하세요.">
          <button id="inputReplyBtn" class="btn text-white ms-1" style="padding: 0%;">
              <i class="bi bi-arrow-up-circle" style="font-size: x-large;"></i>
          </button>
      </div>
      </div>
  </div>
</div>

<!-- Scroll Top -->
<a href="#" id="scroll-top"
class="scroll-top d-flex align-items-center justify-content-center active">
<i class="bi bi-arrow-up-short"></i>
</a>

<div id="app-data"
  data-art-group-no="${param.artGroupNo}"
  data-mem-no="${communityProfileVO.memNo}"
  data-com-nm="${communityProfileVO.comNm}"
  data-com-profile-save-locate="${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
  data-com-prifile-no="${communityProfileVO.comProfileNo}"
  data-com-auth="${communityProfileVO.comAuth}">
</div>

<script>
  /////////////전역변수 영역////////////////////
  let isStreaming = false;
  let room;
  let isSettingEdit = false; // 설정이 저장되었는지 여부
  let isSettingSave = false; // 수정 모드 활성화 여부
  const livekitServerUrl = "${serverUrl}";

  // querySellector말고 getElementById 사용해보기
  const streamOnOffBtn = document.getElementById("streamOnOffBtn");
  const streamStat = document.getElementById("streamStat");
  const streamStatIcon = document.getElementById("streamStatIcon");
  const preview = document.getElementById("preview");
  // 방송 설정 저장 버튼
  const saveSettingBtn = document.getElementById("saveSettingBtn");
  saveSettingBtn.addEventListener("click", changeSettingMode);

  /////////////전역변수 영역 끝/////////////////
  	// WebSocket 접근 가능 여부 확인
	console.log("WebSocket 상태:", "WebSocket" in window ? "지원됨" : "지원되지 않음");

	// LiveKit 버전 확인
	console.log("LiveKit 버전:", LivekitClient.version);

	// 네트워크 연결 확인
	console.log("온라인 상태:", navigator.onLine);

  // 디바이스 목록 가져오기
  async function getDevice(){
    try {
      // 디바이스
      const device = await navigator.mediaDevices.enumerateDevices();
      console.log("디바이스 정보: ", device);
      
      const videoDevice = device.filter(device => device.kind === 'videoinput');
      const audioDevice = device.filter(device => device.kind === 'audioinput');

      // 디바이스 설정 정보
      const camSelect = document.getElementById("camSelect");
      const micSelect = document.getElementById("micSelect");

      // 선택 초기화
      camSelect.innerHTML = '';
      micSelect.innerHTML = '';

      // 카메라 옵션 할당
      videoDevice.forEach(device => {
        const option = document.createElement("option"); // 옵셥태그 생성
        option.value = device.deviceId;
        option.text = device.label || `카메라 ${camSelect.length}`;
        camSelect.appendChild(option);
      });

      // 오디오 옵션 할당
      audioDevice.forEach(device => {
        const option = document.createElement('option');
        option.value = device.deviceId;
        option.text = device.label || `마이크 ${micSelect.length}`;
        micSelect.appendChild(option);
     });
    } catch (error) {
      console.error("디바이스 목록 가져오기 실패: ", error);
    }
  }

  // 페이지 로드 시 디바이스 목록 가져오기ㅏ
document.addEventListener('DOMContentLoaded', async () => {
	  try {
		    // 먼저 미디어 장치 접근 권한 요청
		    console.log("미디어 접근 권한 요청 중...");
		    const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: true });
		    console.log("미디어 접근 권한 획득 성공!");
		    
		    // 미리보기에 카메라 화면 표시
		    preview.srcObject = stream;
		    
		    // 권한을 얻은 후 디바이스 목록 가져오기
		    await getDevice();
		  } catch (error) {
		    console.error("미디어 접근 권한 오류:", error);
		    Swal.fire({
		      title: "카메라/마이크 접근 오류",
		      text: "방송을 위해 카메라와 마이크 접근 권한이 필요합니다. 브라우저 설정에서 권한을 허용해주세요.",
		      icon: "error"
		    });
		  }
		});
/////////////////위까지 기능 동작 확인 04.23///////////////////////////

// 방송 시작,종료 이벤트
streamOnOffBtn.addEventListener("click", async () => {
  if (!isStreaming) {
    // 세팅 저장 확인
    if (!isSettingEdit) {
      Swal.fire({
        title: "방송 설정 필요",
        text: "방송을 시작하기 전에 방송 설정을 저장해주세요.",
        icon: "warning"
      });
      return;
    }

     // 수정 중인 경우 적용부터 하도록
     if (isSettingSave) {
      Swal.fire({
        title: "설정 적용 필요",
        text: "수정 중인 설정을 먼저 적용해주세요.",
        icon: "warning"
      });
      return;
    }

    // 방송 시작
    const streamTitle = document.getElementById("streamTitle").value;
    const streamExpln = document.getElementById("streamExpln").value;
    const streamQty = document.getElementById("streamQty").value;
    const artGroupNo = document.getElementById("app-data").dataset.artGroupNo;

    try {
      // 먼저 방송 정보를 서버에 저장하고 streamNo를 받아옴
      const createStreamResponse = await axios.post('/api/live/stream/create', {
        artGroupNo: artGroupNo,
        streamTitle: streamTitle,
        streamExpln: streamExpln,
        streamQty: streamQty,
        streamStat: 'start'
      });
      
      const streamNo = createStreamResponse.data.streamNo;
      
      // 방송자 토큰 발급 요청
      const tokenResponse = await axios.get(`/api/live/token/streamer`, {
        params: {
          streamNo: streamNo,
          artGroupNo: artGroupNo
        }
      });
      
      const { streamerToken, success } = tokenResponse.data;
      
      if (!success) {
        throw new Error("토큰 발급에 실패했습니다.");
      }
      
      // LiveKit room객체생성
      room = new LivekitClient.Room();
      console.log("LiveKit 서버 URL:", livekitServerUrl);
      console.log("토큰:", streamerToken);  
      
      // application.properties에서 설정한 livekit.server.url 사용 
   //await room.connect(livekitServerUrl, streamerToken);
    // 데이터 수신 이벤트
    room.on(LivekitClient.RoomEvent.DataReceived, (payload, participant) => {
      console.log('[DataReceived] 데이터 수신됨');
      try {
        const data = JSON.parse(new TextDecoder().decode(payload));
        console.log('디코딩된 데이터:', data);
        
        if (data.type === 'chat') {
          // 내가 보낸 메시지가 아닌 경우
          const comNm = document.getElementById("app-data").dataset.comNm;
          if (data.sender !== comNm) {
            // 채팅 메시지 표시
            addChatMessage(
              data.sender, 
              data.message, 
              data.comProfileSaveLocate, 
              data.viewTimefomat, 
              false
            );
            scrollChatToBottom();
          }
        }
      } catch (error) {
        console.error('데이터 파싱 오류:', error);
      }
    });

   /////////////디버깅용//////////////////////
	room.on('disconnected', () => {
	  console.log("방 연결이 끊어졌습니다");
	});
	
	room.on('connected', () => {
	  console.log("방에 성공적으로 연결되었습니다!");
	});
	
	room.on('connectionStateChanged', (state) => {
	  console.log("연결 상태 변경:", state);
	});
	
	// 디버깅을 위한 연결 시도
	LivekitClient.setLogLevel('debug');

	try {
	  console.log("LiveKit 연결 시도:", livekitServerUrl);
	  // 더 긴 타임아웃 설정
	  await room.connect(livekitServerUrl, streamerToken, {
	    autoSubscribe: true,
	    wsTimeout: 20000  // 20초로 타임아웃 증가
	  });
	  console.log("LiveKit 연결 성공!");
	} catch (err) {
	  console.error("LiveKit 연결 실패:", err);
	  
	  // 로그에 더 많은 정보 기록
	  console.error("연결 URL:", livekitServerUrl);
	  console.error("토큰:", streamerToken.substring(0, 20) + "...");
	  console.error("상세 오류:", err.message, err.stack);
	}

//////////////////////////////////디버깅용 끝///////////////////////////////
      
      // 선택한 디바이스로 로컬 트랙 생성
      const camSelect = document.getElementById("camSelect");
      const micSelect = document.getElementById("micSelect");
      
      const trackOption = {
        video: {
          deviceId: camSelect.value ? { exact: camSelect.value } : undefined,
          resolution: streamQty === 'FHD' ? { width: 1920, height: 1080 } : 
                      streamQty === 'HD' ? { width: 1280, height: 720 } : 
                      { width: 854, height: 480 }
        },
        audio: {
          deviceId: micSelect.value ? { exact: micSelect.value } : undefined
        }
      };
      
      const trackList = await LivekitClient.createLocalTracks(trackOption);
      
      for (const track of trackList) {
        // 방 참여자 정보 트랙에 설정
        await room.localParticipant.publishTrack(track);
        if (track.kind === 'video') {
          track.attach(preview);
        }
      }
      
      // UI 업데이트
      isStreaming = true;
      streamOnOffBtn.textContent = "방송 종료";
      streamStat.textContent = "방송 ON AIR";
      streamStatIcon.classList.remove("text-muted");
      streamStatIcon.classList.add("text-danger");
      
      console.log("방송 송출 시작됨: 스트림 번호 " + streamNo);
      
    } catch (err) {
      console.error("방송 시작 오류:", err);
      alert("방송 시작에 실패했습니다: " + (err.response?.data?.message || err.message));
    }
  } else {
    // 방송 종료 확인 
    Swal.fire({
      title: "방송 종료",
      text: "정말 방송을 종료하시겠습니까?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "종료",
      cancelButtonText: "취소"
    }).then(async (result) => {
      if (result.isConfirmed) {
        try {
          // LiveKit 연결 종료
          if (room) {
            await room.disconnect();
          }
          
          // 서버에 방송 종료 알림
          const artGroupNo = document.getElementById("app-data").dataset.artGroupNo;
          await axios.post('/api/live/stream/end', {
            artGroupNo: artGroupNo
          });
          
          // UI 업데이트
          isStreaming = false;
          streamOnOffBtn.textContent = "방송 시작";
          streamStat.textContent = "방송 OFF";
          streamStatIcon.classList.remove("text-danger");
          streamStatIcon.classList.add("text-muted");
          
          // 비디오 프리뷰 초기화
          preview.srcObject = null;
          
          console.log("방송 종료됨");
          
          // 종료 성공 메시지
          Swal.fire({
            title: "방송 종료",
            text: "방송을 종료했습니다.",
            icon: "success",
            timer: 1000,
            showConfirmButton: false
          });
        } catch (err) {
          console.error("방송 종료 오류:", err);
          Swal.fire({
            title: "방송 종료 실패",
            text: "방송 종료에 실패했습니다: " + (err.response?.data?.message || err.message),
            icon: "error"
          });
        }
      }
    });
  }
});

// 방송 설정 저장/수정 기능
function changeSettingMode() {
  // 저장이 안 된 상태
  if (!isSettingEdit) {
    saveSetting();
  } 
  // 저장된 상태 - 수정 모드로 전환
  else {
    // 이미 수정 중이면 적용
    if (isSettingSave) {
      applySetting();
      isSettingSave = false;
    } 
    // 수정 모드로 변경
    else {
      // 버튼 텍스트 변경
      saveSettingBtn.textContent = "수정 완료";
      saveSettingBtn.classList.remove("btn-warning");
      saveSettingBtn.classList.add("btn-success");
      
      // 입력 필드 활성화
      document.getElementById("streamTitle").disabled = false;
      document.getElementById("streamExpln").disabled = false;
      document.getElementById("camSelect").disabled = false;
      document.getElementById("micSelect").disabled = false;
      document.getElementById("streamQty").disabled = false;
      
      isSettingSave = true;
      
      // 알림
      Swal.fire({
        title: "수정 모드",
        text: "방송 설정을 수정할 수 있습니다.",
        icon: "info",
        timer: 1500,
        showConfirmButton: true
      });
    }
  }
}


// 방송 설정 저장
function saveSetting() {
  const streamTitle = document.getElementById("streamTitle").value;
  const streamExpln = document.getElementById("streamExpln").value;
  
  // 필수 입력값 확인
  if (!streamTitle || !streamExpln) {
    Swal.fire({
      title: "설정 저장 실패",
      text: "방송 제목과 설명을 모두 입력해주세요.",
      icon: "warning"
    });
    return;
  }
  
  // 설정 저장 확인
  Swal.fire({
    title: "방송 설정 저장",
    text: "저장 후에 방송 정보는 수정 가능합니다.",
    icon: "question",
    showCancelButton: true,
    confirmButtonText: "저장",
    cancelButtonText: "취소"
  }).then((result) => {
    if (result.isConfirmed) {
      // 입력 필드 비활성화
      document.getElementById("streamTitle").disabled = true;
      document.getElementById("streamExpln").disabled = true;
      document.getElementById("camSelect").disabled = true;
      document.getElementById("micSelect").disabled = true;
      document.getElementById("streamQty").disabled = true;
      
      // 저장 버튼 상태변경
      saveSettingBtn.textContent = "설정 수정";
      saveSettingBtn.classList.replace("btn-primary", "btn-warning");
      
      // 설정 저장 상태 변경
      isSettingEdit = true;
      
      // 성공 메시지
      Swal.fire({
        title: "설정 저장 완료",
        text: "방송 설정이 저장되었습니다. 이제 방송을 시작할 수 있습니다.",
        icon: "success",
        timer: 1000,
        showConfirmButton: true
      });
    }
  });
}

// 수정 모드 활성화
function settingEditOn() {
  // 입력 필드 활성화
  document.getElementById("streamTitle").disabled = false;
  document.getElementById("streamExpln").disabled = false;
  document.getElementById("camSelect").disabled = false;
  document.getElementById("micSelect").disabled = false;
  document.getElementById("streamQty").disabled = false;
  
  // 버튼 텍스트 변경
  saveSettingBtn.textContent = "설정 적용";
  saveSettingBtn.classList.replace("btn-warning", "btn-success");
  
  // 수정 모드 활성화
  isEditMode = true;
  
  // 알림
  Swal.fire({
    title: "방송 정보 수정",
    text: "방송 정보를 수정해주세요.",
    icon: "info",
    timer: 2000,
    showConfirmButton: false
  });
}

// 수정 모드 비활성화
function settingEditOff() {
  // 입력 필드 비활성화
  document.getElementById("streamTitle").disabled = true;
  document.getElementById("streamExpln").disabled = true;
  document.getElementById("camSelect").disabled = true;
  document.getElementById("micSelect").disabled = true;
  document.getElementById("streamQty").disabled = true;
  
  // 수정 모드 비활성화
  isEditMode = false;
}

// 수정된 설정 적용
function applySetting() {
  const streamTitle = document.getElementById("streamTitle").value;
  const streamExpln = document.getElementById("streamExpln").value;
  
  // 필수 입력값 확인
  if (!streamTitle || !streamExpln) {
    Swal.fire({
      title: "설정 적용 실패",
      text: "방송 제목과 설명을 모두 입력해주세요.",
      icon: "warning"
    });
    return;
  }
  
   
  // 입력 필드 비활성화
  document.getElementById("streamTitle").disabled = true;
  document.getElementById("streamExpln").disabled = true;
  document.getElementById("camSelect").disabled = true;
  document.getElementById("micSelect").disabled = true;
  document.getElementById("streamQty").disabled = true;
  
  // 버튼 상태 변경
  saveSettingBtn.textContent = "설정 수정";
  saveSettingBtn.classList.remove("btn-success");
  saveSettingBtn.classList.add("btn-warning");
  
  // 성공 메시지
  Swal.fire({
    title: "설정 적용 완료",
    text: "방송 정보를 변경했습니다.",
    icon: "success",
    timer: 1500,
    showConfirmButton: false
  });
}


// 채팅
const inputReply = document.getElementById("inputReply");
const inputReplyBtn = document.getElementById("inputReplyBtn");

inputReplyBtn.addEventListener("click", sendChat);
inputReply.addEventListener("keypress", (e) => {
  if (e.key === "Enter") {
    sendChat();
  }
});

function sendChat() {
  const message = inputReply.value.trim();
  if (!message) return;
  
  if (room && isStreaming) {
    const comNm = document.getElementById("app-data").dataset.comNm;
    const comProfileSaveLocate = document.getElementById("app-data").dataset.comProfileSaveLocate || '';
    
    // 채팅 전송시간 포멧
    const chatTime = new Date();
    const viewTimefomat = chatTime.toLocaleTimeString('ko-KR', {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false
    });
    
    // LiveKit 데이터 채널을 통해 메시지 전송
    const chatMsgData = {
      type: 'chat',
      sender: comNm,
      message: message,
      timestamp: chatTime.toISOString(),
      viewTimefomat: viewTimefomat,
      comProfileSaveLocate: comProfileSaveLocate
    };
    
    // 데이터 인코딩
    const encoder = new TextEncoder();
    const data = encoder.encode(JSON.stringify(chatMsgData));
    
    room.localParticipant.publishData(data, {
      reliable: true
    });
    
    // 채팅창에 내 메시지 추가
    addChatMessage(comNm, message, comProfileSaveLocate, viewTimefomat, true);
  }
  
  inputReply.value = "";
}


//임시 채팅 스크롤
function scrollChatToBottom() {
	  const commentBody = document.getElementById("comment-body");
	  setTimeout(() => {
		    commentBody.scrollTop = commentBody.scrollHeight;
		  }, 0);
	}
	
function addChatMessage(sender, message, profileImage, timeString, isMe = false) {
  const commentBody = document.getElementById("comment-body");
  const messageElement = document.createElement('div');
  messageElement.className = "comment-item";

  // 프로필 이미지 확인
  if (!profileImage || profileImage === '') {
    profileImage = "/images/default-profile.png";
  }


  const currentTime = timeString || new Date().toLocaleTimeString('ko-KR', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  });
  

  let chatHtml = `
    <div class="comment-info d-flex align-items-center row">
      <div class="col-2">
        <img class="comment-profile-img rounded-circle" src="/upload\${profileImage}" alt="\${sender}의 프로필">
      </div>
      <div class="col-8">
        <div class="comment-prfile-info" style="margin-top: 3px; margin-left: 3px;">
          <span class="comment-nickname fw-bold" style="color:white;">\${sender}</span>
          <span class="comment-regdate" style="color:#aaa; font-size:0.8rem;">\${currentTime}</span>
        </div>
      </div>
      <div class="col-2 d-flex justify-content-end">
        <div class="comment-dropdown d-flex justify-content-end">
  `;
  
  // 내 메세지 아닐때 신고
  if (!isMe) {
    chatHtml += ` <button class="btn btn-link text-white" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-three-dots-vertical"></i>
                  </button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item aReport" href="#" data-bs-toggle="modal" 
                    data-bs-target="#reportModal" data-report-gubun="채팅">🔔 신고하기</a></li>
                  </ul>
                  `;
  }
  
  chatHtml += `
        </div>
      </div>
    </div>

    <div class="row comment-content-container">
      <div class="col comment-content">
        <div class="multiline-truncate card-reply" style="color:white; max-width: 100%;" data-original="\${message}">\${message}</div>
        <button class="reply-translate-btn" onclick="commuReplyTrans()" data-lang="en" data-status="original">번역하기</button>
      </div>
    </div>
  `;
  
  messageElement.innerHTML = chatHtml;
  commentBody.appendChild(messageElement);
  
  // 즉시 스크롤 적용
  scrollChatToBottom();
}

// 시스템 메시지 추가 함수
function addSystemMessage(message) {
  const messageElement = document.createElement('div');
  messageElement.className = 'system-message';
  messageElement.innerHTML = `<em>${message}</em>`;
  const commentBody = document.getElementById("comment-body");
  commentBody.appendChild(messageElement);
  commentBody.scrollTop = commentBody.scrollHeight;
}


</script>

<%@ include file="../footer.jsp" %>
<script src="/main/assets/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</body>
</html>