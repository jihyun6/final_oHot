<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>oHot Live Streaming</title>
<link rel="stylesheet" href="/css/media-live/media-live.css">
<link rel="stylesheet" href="/css/media-live/media-live-detail.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/js/translate/translate.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/livekit-client/dist/livekit-client.umd.min.js"></script>
<link rel="styleSheet" href="/css/media-live/live-hearder.css">
</head>
<!-- 채팅 css -->
 <style>
  .comment-body {
   height: 600px;
  overflow-y: auto;
  overflow-x: hidden;
  display: flex;
  flex-direction: column;
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

 </style>
<body>
	<%@ include file="../header.jsp"%>
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
 <!--  ${artistGroupVO} -->
  <!-- ${liveStreamVO} -->
	<div class="media-container container-fluid py-4"
		style="min-height: 1000px;">
    
		<div class="row" style="height: 100%;">
			<div class="col-1"></div>
			<div class="col-8">
				<div class="row mb-3 align-items-center" style="height: 5%;">
					<div class="col-md-9">
						<i class="bi bi-circle-fill text-danger"></i> <span
							class="text-white">LIVE</span>
					</div>
         
				</div>

				<div class="row mb-3" style="height: 70%;">
					<div id="videoContainer"
						style="width: 100%; height: 100%; background-color: black; position: relative;">
						<video id="videoElement" autoplay playsinline
							style="width: 100%; height: 100%;"></video>
						<div id="loadingOverlay"
							style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
							<div class="spinner-border text-light" role="status">
								<span class="visually-hidden">Loading...</span>
							</div>
						</div>
					</div>
				</div>

				<div class="row" style="height: 25%;">
					<div class="col-12">
						<div class="card bg-dark text-white">
							<div class="card-header d-flex flex-column bg-dark">
                <div class="d-flex align-items-center mb-2">
                  <img src="/upload/${artistGroupVO.fileLogoSaveLocate}" alt="아티스트 프로필" 
                       class="rounded-circle me-3" style="width: 48px; height: 48px; object-fit: cover;">
                  <div class="artist-info">
                    <h5 class="fw-bold mb-0" style="color:white;">${artistGroupVO.artGroupNm}</h5>
                    <span style="color:#aaa; font-size: 0.9rem;">
                      <fmt:formatDate value="${liveStreamVO.streamStartDt}" pattern="yyyy.MM.dd"/>
                    </span>
                  </div>
                </div>
                <div class="stream-title-container">
                  <h4 class="text-white fw-bold mb-0">${liveStreamVO.streamTitle}</h4>
                </div>
              </div>
							<div class="card-body">
								<p class="card-text">${liveStreamVO.streamExpln}</p>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="comment-container col-3 flex">
				<!-- 채팅 헤더 영역 -->
				<div class="comment-header row row-1 fw-bold"
					style="padding-left: 10px;">
          <div class="col-12">
            <span >채팅창</span>
          </div>
				</div>

				<!-- 채팅 본문 영역 -->
				<div id="comment-body" class="comment-body"
					style="height: 600px; overflow-y: auto;"></div>

				<!-- 채팅 입력 영역 -->
				<div class="comment-footer row-md-1 d-flex">
					<input id="inputReply" type="text"
						class="form-control comment-input" placeholder="채팅을 입력하세요.">
					<button id="inputReplyBtn" class="btn text-white ms-1"
						style="padding: 0%;">
						<i class="bi bi-arrow-up-circle" style="font-size: x-large;"></i>
					</button>
				</div>
			</div>
		</div>
	</div>

	<div id="app-data" data-art-group-no="${param.artGroupNo}"
		data-stream-no="${liveStreamVO.streamNo}"
		data-mem-no="${communityProfileVO.memNo}"
		data-com-nm="${communityProfileVO.comNm}"
		data-com-profile-save-locate="${communityProfileVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}"
		data-com-profile-no="${communityProfileVO.comProfileNo}"
		data-com-auth="${communityProfileVO.comAuth}"></div>

	<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center active">
		<i class="bi bi-arrow-up-short"></i>
	</a>

<script>
//전역 변수
let room;
let isConnected = false;
const liveKitServerUrl = "${serverUrl}";

// DOM 요소
const videoElement = document.getElementById('videoElement');
const loadingOverlay = document.getElementById('loadingOverlay');
const appData = document.getElementById('app-data');
const commentBody = document.getElementById('comment-body');
const inputReply = document.getElementById('inputReply');
const inputReplyBtn = document.getElementById('inputReplyBtn');
const currentViewers = document.getElementById('currentViewers');
const viewerCount = document.getElementById('viewerCount');

// 페이지 로드 시 스트림 연결
document.addEventListener('DOMContentLoaded', connectToStream);

// 오디오 컨텍스트 활성화
document.addEventListener('click', () => {
  const tempAudioContext = new (window.AudioContext || window.webkitAudioContext)();
  tempAudioContext.resume().then(() => {
    console.log('오디오 컨텍스트 활성화됨');
  });
}, { once: true });

// 연결 진단 함수
function diagnoseConnection() {
  if (!room) {
    console.log('룸 객체가 생성되지 않았습니다');
    return;
  }

  console.log('현재 룸 상태:', room.state);
  
  if (room.participants) {
    console.log('연결된 참가자 수:', room.participants.size);
  } else {
    console.log('room.participants가 아직 초기화되지 않았습니다');
    return; // 추가 진단 중단
  }
  
  if (room.engine) {
    if (room.engine.client) {
      console.log('시그널링 상태:', room.engine.client.isConnected ? '연결됨' : '연결 안됨');
    }
    
    if (room.engine.publisher && room.engine.publisher.pc) {
      const pc = room.engine.publisher.pc;
      console.log('퍼블리셔 ICE 상태:', pc.iceConnectionState);
      console.log('퍼블리셔 시그널 상태:', pc.signalingState);
    }
  }
}

// 트랙 정보 
function logParticipantsAndTracks() {
  console.log('---------- 현재 방 참가자 및 트랙 상세 정보 ----------');
  if (!room) {
    console.log('룸 객체가 없습니다');
    return;
  }
  
  if (!room.participants) {
    console.log('room.participants가 아직 초기화되지 않았습니다');
    return;
  }
  
  if (room.participants.size === 0) {
    console.log('현재 참가자가 없습니다');
    return;
  }
  
  room.participants.forEach((participant, id) => {
    console.log(`참가자 ID: ${id}, 이름: ${participant.identity}`);
    
    // 각 참가자의 트랙 확인
    console.log(`  트랙 수: ${participant.tracks.size}`);
    if (participant.tracks.size === 0) {
      console.log('  트랙이 없습니다');
    } else {
      participant.tracks.forEach((publication, trackSid) => {
        console.log(`    트랙 ID: ${trackSid}, 종류: ${publication.kind}, 구독됨: ${publication.isSubscribed}`);
        
        // 구독된 트랙의 활성 상태 확인
        if (publication.isSubscribed && publication.track) {
          console.log(`      활성 트랙: ${publication.track.sid}, 음소거됨: ${publication.track.isMuted}`);
        }
      });
    }
  });
  console.log('---------- 트랙 정보 끝 ----------');
}

// 직접 모든 트랙 연결 시도 함수
function connectAllTracks() {
  console.log('모든 트랙 직접 연결 시도...');
  
  //participants가 존재하는지 확인
  if (!room || !room.participants) {
    console.log('room.participants가 아직 초기화되지 않았습니다');
    return;
  }
  
  let foundAnyTracks = false;
  
  room.participants.forEach(participant => {
    console.log(`참가자 ${participant.identity}의 트랙 연결 시도`);
    
    participant.tracks.forEach(publication => {
      console.log(`트랙 ${publication.trackSid}, 종류: ${publication.kind}`);
      
      if (publication.kind === 'video') {
        foundAnyTracks = true;
        console.log('비디오 트랙 발견, 직접 연결 시도:', publication.trackSid);
        
        // 구독 상태 설정
        if (!publication.isSubscribed) {
          console.log('트랙 구독 활성화');
          publication.setSubscribed(true);
        }
        
        // 트랙이 이미 있는 경우
        if (publication.track) {
          console.log('트랙 객체 존재, 연결 시도');
          publication.track.attach(videoElement);
          console.log('비디오 요소에 연결됨');
        } else {
          // 트랙이 아직 없는 경우 이벤트 리스너 추가
          console.log('트랙 객체 없음, 이벤트 리스너 추가');
          publication.on('subscribed', track => {
            console.log('트랙 구독됨, 연결 시도');
            track.attach(videoElement);
            console.log('비디오 요소에 연결됨');
          });
        }
      } else if (publication.kind === 'audio') {
        foundAnyTracks = true;
        console.log('오디오 트랙 발견, 연결 시도:', publication.trackSid);
        
        // 구독 상태 설정
        if (!publication.isSubscribed) {
          console.log('오디오 트랙 구독 활성화');
          publication.setSubscribed(true);
        }
        
        // 트랙이 이미 있는 경우
        if (publication.track) {
          console.log('오디오 트랙 객체 존재, 연결 시도');
          const audioEl = new Audio();
          document.body.appendChild(audioEl);
          publication.track.attach(audioEl);
          audioEl.play().catch(e => console.error('오디오 재생 실패:', e));
        } else {
          // 트랙이 아직 없는 경우 이벤트 리스너 추가
          console.log('오디오 트랙 객체 없음, 이벤트 리스너 추가');
          publication.on('subscribed', track => {
            console.log('오디오 트랙 구독됨, 연결 시도');
            const audioEl = new Audio();
            document.body.appendChild(audioEl);
            track.attach(audioEl);
            audioEl.play().catch(e => console.error('오디오 재생 실패:', e));
          });
        }
      }
    });
  });
  
  if (!foundAnyTracks) {
    console.log('연결 가능한 트랙이 없습니다');
  }
}

async function connectToStream() {
  try {
    const streamNo = appData.dataset.streamNo;
    const artGroupNo = appData.dataset.artGroupNo;
    const comProfileNo = appData.dataset.comProfileNo;
    if (!streamNo || !comProfileNo) {
      showError('필요한 정보가 없습니다.');
      return;
    }
    
    // 시청자 토큰 가져오기
    const response = await axios.get('/api/live/token/viewer', {
      params: {
        streamNo: streamNo,
        comProfileNo: comProfileNo
      }
    });
    
    if (!response.data.success) {
      showError('토큰을 가져오는데 실패했습니다.');
      return;
    }

    // 시청자 토큰 확인
    console.log("시청자토큰: ", response);
    
    // 구조분해로 가져옴
    const { viewerToken } = response.data;
    
    // LiveKit 룸 생성 및 로그 레벨 설정
    LivekitClient.setLogLevel('debug');
    
    // LiveKit room 객체 생성 시 ICE 설정 변경
    room = new LivekitClient.Room({
      rtcConfig: {
        iceTransportPolicy: 'relay', // 또는 'all'
        iceServers: []  // 빈 배열로 설정하여 외부 STUN/TURN 서버 사용 안 함
      }
    });

    console.log("Room 객체 생성 확인: ", room);
    console.log("WebSocket 상태:", "WebSocket" in window ? "지원됨" : "지원되지 않음");
    console.log("네트워크 연결:", navigator.onLine);
    
    // ICE 연결 상태 추적
    room.on('connectionStateChanged', (state) => {
      console.log('WebRTC 연결 상태 변경:', state);
    });
    
    // 성공 이벤트 추가
    room.on(LivekitClient.RoomEvent.Connected, () => {
      console.log('방에 성공적으로 연결되었습니다!');
      isConnected = true;
      loadingOverlay.style.display = 'none';

      // 진단 및 재연결 시도는 성공 이벤트 내에서 실행
      setTimeout(() => {
        if (room.participants) {
          console.log('연결 성공 후 참가자 목록:', Array.from(room.participants.values()).map(p => p.identity));
          
          // 방송자 검색 및 구독
          const broadcaster = Array.from(room.participants.values()).find(p => 
            p.identity.startsWith('artistGroup_')
          );

          if (broadcaster) {
            console.log('방송자 발견:', broadcaster.identity);
            subscribeToParticipant(broadcaster);
          } else {
            console.warn('방송자를 찾을 수 없음. 현재 참가자:', Array.from(room.participants.values()).map(p => p.identity));
            
            // 참가자 없는 경우 
            setTimeout(() => {
              if (room.participants) {
                console.log('2차 방송자 검색...');
                const retryBroadcaster = Array.from(room.participants.values()).find(p => 
                  p.identity.startsWith('artistGroup_')
                );
                
                if (retryBroadcaster) {
                  console.log('방송자 발견(2차):', retryBroadcaster.identity);
                  subscribeToParticipant(retryBroadcaster);
                } else {
                  console.warn('방송자를 찾을 수 없음(2차). 현재 참가자:', Array.from(room.participants.values()).map(p => p.identity));
                }
              }
            }, 2000);
          }
          
          // 시청자 수 업데이트
          updateViewerCount();
        } else {
          console.log('room.participants가 아직 초기화되지 않았습니다');
        }
      }, 1000);
    });
   

    // 참가자 입장 이벤트 처리
    room.on(LivekitClient.RoomEvent.ParticipantConnected, (participant) => {
      console.log('[ParticipantConnected] 참가자:', participant);
      console.log('[ParticipantConnected] 참가자 ID:', participant.identity);

   
      if (room.participants) {
        console.log('[ParticipantConnected] 현재 연결된 참가자 목록:', Array.from(room.participants.values()).map(p => p.identity));
      }
      
      handleParticipantConnected(participant);
      
      // 참가자가 방송자인지 확인하고 구독
      if (participant.identity.startsWith('artistGroup_')) {
        console.log('방송자 참가자 감지됨, 구독 시작...');
        subscribeToParticipant(participant);
      }
    });

    // 참가자 퇴장 이벤트 처리
    room.on(LivekitClient.RoomEvent.ParticipantDisconnected, (participant) => {
      console.log('[ParticipantDisconnected] 퇴장한 참가자:', participant);
      console.log('[ParticipantDisconnected] 참가자 ID:', participant.identity);
      
      if (room.participants) {
        console.log('[ParticipantDisconnected] 현재 연결된 참가자 목록:', Array.from(room.participants.values()).map(p => p.identity));
      }

      handleParticipantDisconnected(participant);

         // 방송자가 퇴장한 경우 방송 종료 알림
    if (participant.identity.startsWith('artistGroup_')) {
      console.log('방송자 퇴장 감지!');
      setTimeout(() => {
        Swal.fire({
          title: "방송 종료",
          text: "방송자가 방송을 종료했습니다.",
          icon: "info",
          confirmButtonText: "확인"
        });
      }, 100);
    }
  });

    // 데이터 수신 처리
    room.on(LivekitClient.RoomEvent.DataReceived, (payload, participant) => {
      console.log('[DataReceived] 데이터 수신됨');
      handleDataReceived(payload, participant);
    });

    // 트랙 구독 상태 변화 감지
    room.on(LivekitClient.RoomEvent.TrackSubscribed, (track, publication, participant) => {
      console.log(`트랙 구독됨: ${track.sid}, 종류: ${track.kind}, 참가자: ${participant.identity}`);
      
      if (track.kind === 'video') {
        console.log('비디오 트랙 구독됨, videoElement에 연결');
        track.attach(videoElement);
        loadingOverlay.style.display = 'none'; // 비디오 트랙이 연결되면 로딩 숨김
      } else if (track.kind === 'audio') {
        console.log('오디오 트랙 구독됨, 오디오 엘리먼트 생성하여 연결');
        const audioEl = new Audio();
        track.attach(audioEl);
        audioEl.play().catch(e => console.error('오디오 재생 실패:', e));
      }
    });

    // 연결 시도 정보 출력
    console.log('연결 서버 url: ', liveKitServerUrl);
    const modifiedServerUrl = liveKitServerUrl.replace('localhost', '127.0.0.1');
    console.log('수정된 연결 서버 url (만약 localhost였다면): ', modifiedServerUrl);
    console.log('연결 시도 토큰:', viewerToken);
    console.log('Room 객체 상태 (연결 전):', room.state);

    // 서버에 연결 시도
    try {
      // 로컬호스트에서 연결 시도
      await room.connect(modifiedServerUrl, viewerToken, {
        autoSubscribe: true,
        wsTimeout: 20000,
        peerConnectionTimeout: 30000,
        rtcConfig: {
          iceServers: [
            { urls: 'stun:stun.l.google.com:19302' },
            { urls: 'stun:stun1.l.google.com:19302' }
          ],
          iceCandidatePoolSize: 10
        }
      });
      
      console.log('서버 연결 성공!');
    } catch (connectError) {
      console.error('첫 번째 연결 시도 실패:', connectError);
      console.log('대체 URL로 다시 시도합니다...');
      
      // 첫 번째 시도 실패 시 원래 URL로 다시 시도
      await room.connect(liveKitServerUrl, viewerToken, {
        autoSubscribe: true,
        wsTimeout: 20000
      });
    }
    
    console.log('Room 객체 상태 (연결 후):', room.state);
    
    // ICE 상태 확인
    setTimeout(() => {
      if (room.engine && room.engine.publisher && room.engine.publisher.pc) {
        const pc = room.engine.publisher.pc;
        console.log('ICE 연결 상태:', pc.iceConnectionState);
        console.log('ICE 수집 상태:', pc.iceGatheringState);
        console.log('시그널링 상태:', pc.signalingState);
      } else {
        console.log('아직 PeerConnection이 생성되지 않았습니다');
      }
    }, 1000);

    // 진단 작업은 성공 이벤트 핸들러 내부로 옮겼습니다
    console.log('스트림 연결 프로세스 완료');
  } catch (error) {
    console.error('스트림 연결 오류:', error);
    showError('라이브 스트림 연결 실패: ' + error.message);
  }
}
 
// 참가자 연결 이벤트 처리
function handleParticipantConnected(participant) {
  console.log('참가자 입장:', participant.identity);
  
  // 시청자 수 업데이트
  updateViewerCount();
  
  // 입장 메시지 표시
  addSystemMessage(`${participant.identity.replace('member_', '')} 님이 입장했습니다.`);
}
 
// 참가자 연결 해제 이벤트 처리
function handleParticipantDisconnected(participant) {
  console.log('참가자 퇴장:', participant.identity);
  
  // 시청자 수 업데이트
  updateViewerCount();
  
  // 퇴장 메시지 표시
  addSystemMessage(`${participant.identity.replace('member_', '')} 님이 퇴장했습니다.`);
}
 
// 데이터 수신 이벤트 처리 (채팅 등)
function handleDataReceived(payload, participant) {
  try {
    const data = JSON.parse(new TextDecoder().decode(payload));
    console.log('디코딩된 데이터:', data);
    
    if (data.type === 'chat') {
      // 채팅 메시지 표시 - 프로필 이미지와 시간 정보 활용
      addChatMessage(
        data.sender, 
        data.message, 
        data.comProfileSaveLocate, 
        data.viewTimefomat, 
        false
      );
        // 새로운 채팅 받으면 스크롤 생성
    commentBody.scrollTop = commentBody.scrollHeight;
    }
  
  } catch (error) {
    console.error('데이터 파싱 오류:', error);
  }
}
 
// 참가자 트랙 구독
function subscribeToParticipant(participant) {
  console.log(`${participant.identity} 구독 시도`);
  
  // 트랙 게시 이벤트 리스너
  participant.on(LivekitClient.ParticipantEvent.TrackPublished, (publication, participant) => {
    console.log(`트랙 게시됨:`, publication.trackSid, publication.kind);
    
    // 트랙 구독
    publication.setSubscribed(true);
    console.log(`트랙 구독 설정됨:`, publication.trackSid);

    if (!participant) {
      console.error("참가자 확인 불가능");
      return;
    }
    
    // 구독 이벤트 리스너
    publication.on(LivekitClient.TrackEvent.Subscribed, (track) => {
      console.log(`트랙 구독됨:`, track.sid, track.kind);
      
      if (track.kind === 'video') {
        console.log('비디오 트랙을 videoElement에 연결 시도');
        track.attach(videoElement);
        console.log('비디오 트랙 연결 완료');
        
        // 로딩 오버레이 숨기기
        loadingOverlay.style.display = 'none';
      } else if (track.kind === 'audio') {
        console.log('오디오 트랙 감지됨');
        const audioEl = new Audio();
        document.body.appendChild(audioEl);
        track.attach(audioEl);
        audioEl.play().catch(e => console.error('오디오 재생 실패:', e));
        console.log('오디오 트랙 연결 완료');
      }
    });
  });
  
  // 이미 게시된 트랙 처리
  console.log(`이미 게시된 트랙 확인: ${participant.tracks.size}개`);
  participant.tracks.forEach(publication => {
    console.log(`기존 트랙:`, publication.trackSid, publication.kind, '구독 상태:', publication.isSubscribed);
    
    if (publication.isSubscribed && publication.track) {
      console.log(`이미 구독된 트랙 처리:`, publication.track.sid, publication.track.kind);
      if (publication.track.kind === 'video') {
        publication.track.attach(videoElement);
        console.log('기존 비디오 트랙 연결 완료');
        
        // 로딩 오버레이 숨기기
        loadingOverlay.style.display = 'none';
      } else if (publication.track.kind === 'audio') {
        const audioEl = new Audio();
        document.body.appendChild(audioEl);
        publication.track.attach(audioEl);
        audioEl.play().catch(e => console.error('오디오 재생 실패:', e));
        console.log('기존 오디오 트랙 연결 완료');
      }
    } else {
      console.log(`트랙 구독 시작:`, publication.trackSid);
      publication.setSubscribed(true);
    }
  });
}
 
// 시청자 수 업데이트
function updateViewerCount() {
  if (room && room.participants) {
    // 방송자를 제외한 시청자 수
    const viewers = room.participants.size;
    currentViewers.textContent = viewers;
    viewerCount.textContent = viewers;
    console.log('시청자 수 업데이트:', viewers);
  }
}
 
// 오류 표시
function showError(message) {
  console.error('오류 발생:', message);
  loadingOverlay.innerHTML = `
    <div class="alert alert-danger" role="alert">
      <h4 class="alert-heading">연결 오류</h4>
      <p>${message}</p>
      <hr>
      <p class="mb-0">연결 오류</p>
    </div>
  `;
}
 
// 채팅 메시지 추가 함수 - 댓글 형식과 동일하게 구현
function addChatMessage(sender, message, profileImage, timeString, isMe = false) {
  const messageElement = document.createElement('div');
  messageElement.className = "comment-item";

  console.log("profileImage: ", profileImage);
  if(!profileImage || profileImage === ''){
    profileImage = "/images/default-profile.png";
  }

  // 현재 시간 (타임스탬프가 없는 경우)
  const currentTime = timeString || new Date().toLocaleTimeString('ko-KR', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  });
  
  // 메시지 HTML 구성
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
  setTimeout(() => {
  commentBody.scrollTop = commentBody.scrollHeight;
}, 0);
}

// 채팅 메시지 번역 함수
function chatMessageTrans(btnElement) {
  // 번역 상태와 언어 확인
  const status = btnElement.getAttribute('data-status');
  const targetLang = btnElement.getAttribute('data-lang');
  
  // 번역할 메시지 요소
  const messageElement = btnElement.parentElement.querySelector('.card-reply');
  const originalText = messageElement.getAttribute('data-original');
  
  if (status === 'original') {
    // 원본 -> 번역
    translateText(originalText, targetLang)
      .then(translatedText => {
        // 번역된 텍스트 표시
        messageElement.innerText = translatedText;
        // 버튼 상태 변경
        btnElement.innerText = '원문보기';
        btnElement.setAttribute('data-status', 'translated');
      })
      .catch(error => {
        console.error('번역 오류:', error);
        alert('번역에 실패했습니다.');
      });
  } else {
    // 번역 -> 원본
    messageElement.innerText = originalText;
    btnElement.innerText = '번역하기';
    btnElement.setAttribute('data-status', 'original');
  }
}

// 시스템 메시지 추가 함수
function addSystemMessage(message) {
  const messageElement = document.createElement('div');
  messageElement.className = 'system-message';
  messageElement.innerHTML = `<em>${message}</em>`;
  commentBody.appendChild(messageElement);
  commentBody.scrollTop = commentBody.scrollHeight;
}
 
// 채팅 전송 함수
function sendChat() {
  const chatMsg = inputReply.value.trim();
  // 채팅 전송자 정보 다 있어야 됨
  if (!chatMsg || !room || !isConnected) return;
  
  const comNm = appData.dataset.comNm;
  const comProfileNo = appData.dataset.comProfileNo;
  const streamNo = appData.dataset.streamNo;
  const memNo = appData.dataset.memNo;
  const comProfileSaveLocate = appData.getAttribute("data-com-profile-save-locate");

  try {
    // 채팅 전송시간 포멧, 라이브킷에서 바로 받을 시간
    const chatTime = new Date();
    const viewTimefomat = chatTime.toLocaleTimeString('ko-KR', {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false
    });

    const chatMsgData = {
      type: 'chat',
      sender: comNm,
      message: chatMsg,
      timestamp: chatTime.toISOString(),
      viewTimefomat: viewTimefomat,
      comProfileSaveLocate: comProfileSaveLocate,
      comProfileNo: comProfileNo
    };

    // LiveKit 데이터 채널을 통해 메시지 전송
    const encoder = new TextEncoder(); // 채팅데이터 인코딩
    const data = encoder.encode(JSON.stringify(chatMsgData)); // 라이브킷에서 받는 포멧
    room.localParticipant.publishData(data, {
      reliable: true
    });
    
   // DB에 채팅 메시지 저장
   axios.post('/api/live/chat/create', {
     streamNo: streamNo,
     artNo: null,           // 시청자는 artNo null
     memNo: memNo,          // 시청자는 memNo 설정
     chatCn: chatMsg,
     comProfileNo: comProfileNo // 커뮤니티 프로필 번호 추가
   }).catch(error => {
     console.error('채팅 저장 오류:', error);
   });
  
   // 채팅창에 내 메시지 추가
   addChatMessage(comNm, chatMsg, comProfileSaveLocate, viewTimefomat, true);
 } catch (error) {
   console.error('채팅 전송 오류:', error);
 }

 // 입력 필드 초기화
 inputReply.value = '';
}

// 채팅 전송 버튼 클릭 이벤트
inputReplyBtn.addEventListener('click', sendChat);

// 엔터 키 입력 이벤트
inputReply.addEventListener('keypress', (e) => {
 if (e.key === 'Enter') {
   sendChat();
 }
});

// 페이지 종료 시 연결 해제
window.addEventListener('beforeunload', () => {
 if (room) {
   room.disconnect();
 }
});
</script>

	<%@ include file="../footer.jsp"%>
	<script src="/main/assets/js/main.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</body>
</html>