<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	
<style>
	#dmIcon {
	 line-height: 35px;
	 color: #F86D72;
	 position: fixed;
	 height:45px;
	 right: 70px;
	 bottom: 12px;
	 display: inline-flex;
	 align-items: center;
	 background: floralwhite;
	 border-radius: 50px;
	 padding: 3px 20px;
	 box-shadow: 0 2px 6px rgba(0,0,0,0.1);
	 font-family: sans-serif;
	 font-weight: bold;
	 border: 1px solid #e5e7eb;
	 z-index: 10;
	 cursor: pointer;
   }
   #dmList {
	   position: fixed;
	   overflow: hidden;
	   width:0;
	   height:0;
	   right: 70px;
	   bottom:11px;
	   background-color: white;
	   z-index: 5;
	   border-radius: 10px;
	   border: 1px solid #e5e7eb;
	   text-align: center;
	   color: #F86D72; 
	   transition: width 0.3s ease, height 0.3s ease;
   } 

   .dmIcon-circle {
	 width: 24px;
	 height: 24px;
	 background-color: #F86D72;
	 border-radius: 50%;
	 display: flex;
	 align-items: center;
	 justify-content: center;
	 margin-right: 8px;
   }
   .dmIcon-circle svg {
	 width: 14px;
	 height: 14px;
	 fill: white;
   }
   .dmIcon-text {
	 margin-right: 6px;
	 color: #F86D72;
   }


  .artist-name_dm {
    margin-top: 8px;
    font-size: 0.9rem;
    font-weight: 500;
  }


.artist-group_dm {
	margin-bottom: 30px;
}
.group-name_dm {
	font-size: 1.2em;
	font-weight: bold;
	color: #181818;
	margin-bottom: 10px;
	text-align: left;
}
.artist-list_dm {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	list-style: none;
	padding: 0;
}
#dmnotice li{
	font-size: 12px;
	color: rgba(165, 165, 165, 0.701);
}


</style>
</head>
<body>
	<c:if test="${not empty userVO}">
	</c:if>
	<div>
		<c:if test="${not empty userVO}">
			<div class="dm-button" id="dmIcon"  onclick="toggleDm()">
		</c:if>
		<c:if test="${empty userVO}">
			<div class="dm-button" id="dmIcon"  onclick="alert('로그인 후 이용가능한 서비스입니다')">
		</c:if>
            <div class="dmIcon-circle">
            <svg viewBox="0 0 24 24">
                <path d="M2 21l21-9L2 3v7l15 2-15 2v7z"/>
            </svg>
            </div>
            <div class="dmIcon-text"> Message</div>
        </div>
	</div>

	<!-- dm List-->
	<div id="dmList" class="card p-3">
	
			<div class=" d-flex align-items-normal gap-3 flex-wrap ">
				
				<div class="tab" id="msgMainTab" style="width: 99%; ">
					<div class="row" style="position: sticky; top: 0; background-color: white;">
					  <div class="col-md-10 d-flex align-items-start"><h5><b>메세지 </b></h5><i class="bi bi-chat-heart" style="font-size: 1.2rem;"></i></div> 
					  <div class="col-md-1"></div>
					  <div class="col-md-1" style="text-align: end;" onclick="toggleDm()">
						<h4><i class="bi bi-chevron-bar-down" style="margin-right: 8px;"></i></h4>
					  </div>
					</div>
				  
					<div style="background-color: white; height: 590px; display: flex; border: 1px solid #ccc; border-radius: 5px;">
						<!-- 왼쪽 박스 -->
						<div id="fanMsgList" style="flex: 3; margin: 5px; border: 3px solid darkgray;border-radius: 20px; height: 98%; overflow-y:auto; padding: 10px;" >
							<div style="text-align: center;  display: flex; flex-direction: column; align-items: center; ">
								<div style="margin-bottom: 10px; margin-top: 50%;  background-color: #f0f8ff; border:1px solid #F86D72;
											 border-radius: 20px 20px 20px 0px; padding: 5px; width:55%; color:gray;">
									💗 팬 메세지<br>&ensp;@건 도착 💗
								</div>
								<div><h6>말풍선 클릭해 팬에게 온<br> 메세지를 확인해보세요</h6></div>
							</div>
						</div>
						<!-- 오른쪽 박스 -->
						<div style="flex: 4; margin: 5px;" id="chatRoom">
							<input type="hidden" id="dmSubNo" name="dmSubNo" value="\${dmSubNo}">
							<input type="hidden" id="msgSndrNo" name="msgSndrNo" value="\${memNo}">
							<div style="height: 100%; overflow-y:auto; display: flex; flex-direction: column;" id="dmMsgContent"></div>
						</div>
						
					</div>
						<div style="margin-top: 10px; display: flex; gap: 10px;">
							<input type="text" name="msgContent" id="msgContent" style="width: 88%; " onkeypress="if(event.key === 'Enter') dmSendMsgBtn()" placeholder="메세지를 입력하세요"  >
							<button type="button" class="btn btn-warning" id="sendDmMsg" onclick="dmSendMsgBtn()" >&ensp;<i class="bi bi-send-fill"></i>&ensp;</button>
						</div>
				  </div>
			</div>
	</div>
 

<script type="text/javascript">
const memNoDm = '${userVO.memberVO.memNo}';
const artNoDm = '${userVO.memberVO.artistVO.artNo}';
const sndrActNm= '${userVO.memberVO.artistVO.artActNm}';
const sndrProfileImg ='${userVO.memberVO.artistVO.fileSaveLocate}';
let stompClient = null;
let myFanRoomList=[];
let dmMsgContentContainer = document.querySelector("#dmMsgContent");

let isDmOpen = false;

myFanListDm(); //팬리스트 가져오기

function toggleDm() {
	if (isDmOpen) {
		// 닫기
		dmList.style.width = "0px";
		dmList.style.height = "0px";
		document.querySelector('#dmIcon').style.zIndex = 10;
		isDmOpen = false;
	} else {
		// 열기
		dmList.style.width = "700px";
		dmList.style.height = "700px";
		document.querySelector('#dmIcon').style.zIndex = 3;
		myLastChatList(); //마지막 대화 가져오기
		connect(); //웹소켓 연결
		isDmOpen = true;


	}
}

let groupedFanMsgs = [];  // 팬 메시지 임시 그룹
let groupedMsgList = [];  // 모든 팬 메시지 그룹 저장
let groupedBalloonExists = false;  // 말풍선 존재 여부
let currentOpenGroupIndex = null;
let lastFanMsgTime=null;
let page_dm = 0;
const size_dm = 50;
let isLoading_dm = false;
let noMoreData_dm = false;

function myLastChatList() {
    if (isLoading_dm || noMoreData_dm) return;
    isLoading_dm = true;

    console.log(`[불러오기 시작] page: \${page_dm}, size: \${size_dm}`);

    axios.post('/dm/lastChat?artNo=' + artNoDm + '&dmSubNo=0&page=' + page_dm + '&size=' + size_dm)
    .then(resp => {
        const msgList = resp.data;
        const myMsgList = document.querySelector('#dmMsgContent');

        if (msgList.length === 0) {
            noMoreData_dm = true;
            showNoMoreData();
            console.log("[모든 데이터 불러옴]");
            return;
        }

        const previousScrollHeight = myMsgList.scrollHeight;
		msgList.sort((a, b) => new Date(a.msgDt) - new Date(b.msgDt));

        // 최근 메세지가 아래로 가야 하니까 역순 처리
        msgList.reverse().forEach(chat => {
            if (chat.msgSndrNo == memNoDm) {
                // 팬 그룹이 있으면 먼저 저장
                if (groupedFanMsgs.length > 0) {
                    saveFanGroup(myMsgList, true);
                }

                const wrapper = document.createElement('div');
                wrapper.style.display = 'flex';
                wrapper.style.flexDirection = 'column';
                wrapper.style.alignItems = 'flex-end';
                wrapper.style.marginBottom = '8px';

                const lastChatDiv = document.createElement('div');
                lastChatDiv.style.textAlign = 'left';
                lastChatDiv.style.alignSelf = 'flex-end';
                lastChatDiv.style.marginLeft = '10%';
                lastChatDiv.style.border = '1px solid #F86D72';
                lastChatDiv.style.borderRadius = '20px 20px 0px 20px';
                lastChatDiv.style.maxWidth = '70%';
                lastChatDiv.style.padding = '8px 12px';
                lastChatDiv.style.backgroundColor = 'floralwhite';
                lastChatDiv.innerText = chat.msgContent;

                const lastChatTime = document.createElement('div');
                lastChatTime.style.color = 'gray';
                lastChatTime.style.fontSize = '12px';
                lastChatTime.style.marginTop = '2px';
                lastChatTime.innerText = chat.msgDtStr;

                wrapper.appendChild(lastChatDiv);
                wrapper.appendChild(lastChatTime);

                myMsgList.prepend(wrapper);

                lastFanMsgTime = null;
            } else {
                // 팬 메시지
                if (lastFanMsgTime) {
                    const diffSec = (new Date(chat.msgDt) - new Date(lastFanMsgTime)) / 1000;
                    if (diffSec > 300) {
                        saveFanGroup(myMsgList, true);
                    }
                }
                groupedFanMsgs.unshift(chat);
                lastFanMsgTime = chat.msgDt;
            }
        });

        if (groupedFanMsgs.length > 0) {
            saveFanGroup(myMsgList, true);
        }

        const newScrollHeight = myMsgList.scrollHeight;
        dmMsgContentContainer.scrollTop = newScrollHeight - previousScrollHeight;

        page_dm++;
    })
    .catch(error => {
        console.error("Error lastChatList:", error);
    })
    .finally(() => {
        isLoading_dm = false;
    });
}


function showNoMoreData() {
    const endDiv = document.createElement('div');
    endDiv.style.textAlign = 'center';
    endDiv.style.margin = '20px 0';
    endDiv.style.color = 'gray';
    endDiv.style.fontSize = '14px';
    endDiv.innerText = '마지막 메세지입니다';

    const myMsgList = document.querySelector('#dmMsgContent');
    myMsgList.prepend(endDiv);
}


function saveFanGroup(myMsgList, isPrepend = false) {
	groupedFanMsgs.sort((a, b) => new Date(a.msgDt) - new Date(b.msgDt));
	groupedMsgList.push([...groupedFanMsgs]);
	const groupIndex = groupedMsgList.length - 1;

	const fanNewBubbleDiv = document.createElement('div');
	fanNewBubbleDiv.innerHTML = `
		<div class="groupBalloon" id="clickedBalloon\${groupIndex}" 
			style="text-align:center; cursor:pointer; background-color: #f0f8ff; 
			border:1px solid #F86D72; border-radius: 20px 20px 20px 0px; padding:8px 12px; max-width:45%; box-shadow:0 2px 4px rgba(0,0,0,0.1);"
			onclick="showGroupedMessages(\${groupIndex})">
			💗 팬 메시지<br>&ensp;\${groupedFanMsgs.length}건 도착 💗
		</div>
		<div style="color:gray; text-align: left; font-size:12px; margin-bottom:10px;">
			\${groupedFanMsgs[groupedFanMsgs.length - 1].msgDtStr}
		</div>
	`;

	if (isPrepend) {
		myMsgList.prepend(fanNewBubbleDiv);
	} else {
		myMsgList.appendChild(fanNewBubbleDiv);
	}

	groupedFanMsgs = [];
}

// "더 이상 데이터 없음" 표시
function showNoMoreData() {
	const myMsgList = document.querySelector('#dmMsgContent');
	const notice = document.createElement('div');
	notice.style.textAlign = 'center';
	notice.style.color = 'gray';
	notice.style.margin = '10px 0';
	notice.style.fontSize = '14px';
	notice.innerText = '마지막 메세지입니다';
	myMsgList.prepend(notice);
}

//  스크롤 리스너
dmMsgContentContainer.addEventListener('scroll', () => {
    if (dmMsgContentContainer.scrollTop === 0) {
        myLastChatList(); // 스크롤 최상단이면 추가 호출
    }
});

// 팬 그룹 클릭시 메시지 보여주는 함수
function showGroupedMessages(groupIndex) {
    const fanListBox = document.getElementById("fanMsgList");
    fanListBox.innerHTML = '';

    // 모든 말풍선 색 초기화
    document.querySelectorAll('.groupBalloon').forEach(el => {
        el.style.backgroundColor = "#f0f8ff";
    });

    // 선택된 말풍선 색 변경
    const selectedBalloon = document.getElementById('clickedBalloon' + groupIndex);
    if (selectedBalloon) {
        selectedBalloon.style.backgroundColor = "lightsteelblue";
    }

    const msgs = [...groupedMsgList[groupIndex]];
    msgs.sort((a, b) => new Date(a.msgDt) - new Date(b.msgDt));

    msgs.forEach(msg => {
        const fanListBox = document.getElementById("fanMsgList");
		console.log(msg)
		const wrapper = document.createElement('div');
		wrapper.style.display = 'flex';
		wrapper.style.alignItems = 'flex-start'; 
		
		const senderDiv = document.createElement('div');
		senderDiv.style.minWidth = '30px';  
		senderDiv.style.textAlign = 'left';
		senderDiv.style.color = '#F86D72';
		senderDiv.style.fontWeight = 'bold';
		senderDiv.style.fontSize = '14px';
		senderDiv.style.marginTop = '6%';
		senderDiv.style.marginRight = '3px';
		senderDiv.innerText =`\${msg.memFirstName}`;  // 이름띄우기기
		
		const msgDiv = document.createElement('div');
		msgDiv.style.backgroundColor = 'lightsteelblue';
		msgDiv.style.color = 'white';
		msgDiv.style.border = '1px solid #F86D72';
		msgDiv.style.borderRadius = '20px 10px 10px 0px';
		msgDiv.style.padding = '8px 12px';
		msgDiv.style.maxWidth = '90%';
		msgDiv.style.wordBreak = 'break-word'; 
		msgDiv.style.textAlign = 'left'; 
		msgDiv.innerText = `\${msg.msgContent}`;
		
		const timeDiv = document.createElement('div');
		timeDiv.style.color = 'gray';
		timeDiv.style.marginBottom = '10px';
		timeDiv.style.textAlign = 'right';
		timeDiv.style.fontSize = '12px';
		timeDiv.innerText = msg.msgDtStr;

		wrapper.appendChild(senderDiv);
		wrapper.appendChild(msgDiv);
		fanListBox.appendChild(wrapper);
		fanListBox.appendChild(timeDiv);

    });

	currentOpenGroupIndex = groupIndex;
    fanListBox.scrollTop = fanListBox.scrollHeight;
}

// function myLastChatList(){
// 	axios.post('/dm/lastChat?artNo='+artNoDm+'&dmSubNo=0').then(resp=>{
// 		console.log("마지막 대화"+JSON.stringify(resp.data));

// 		const msgList = resp.data;
// 		const myMsgList = document.querySelector('#dmMsgContent');
// 		const fanMsgList = document.querySelector('#fanMsgList');

// 		resp.data.forEach(chat => {
// 			const li = document.createElement('li');
// 			if(chat.msgSndrNo == memNo){
// 				li.style = "text-align: right; margin-bottom: 5px";
// 				li.innerHTML = chat.msgContent;
// 			}else{
// 				li.style = "text-align: left; margin-bottom: 5px";
// 				li.innerHTML = chat.msgSndrNo+" : "+chat.msgContent;
// 				// fanMsgList.appendChild(li);
// 			}
			
// 			myMsgList.appendChild(li);
			
// 			dmMsgContentContainer.scrollTop = dmMsgContentContainer.scrollHeight;
// 		});
// 	})
// 	.catch(error => {
// 		console.error("Error lastchatlist:", error);
// 	});

// }



function myFanListDm(){
	axios.post('/dm/myFanList?artNo='+artNoDm).then(resp=>{
		console.log("나를 구독한 팬리스트"+JSON.stringify(resp.data));

		myFanRoomList = resp.data;

	})
}

function connect() {
	const socket = new SockJS("/ws/dm");
	stompClient = Stomp.over(socket);

    stompClient.connect({}, (frame) => {
		console.log("Connected: " + JSON.stringify(frame));

		myFanRoomList.forEach(fanRoom => {
			stompClient.subscribe('/toArtist/dmRoom/' + fanRoom.dmSubNo, (message) => {
				const msg = JSON.parse(message.body);
				console.log("메세지 수신: " + JSON.stringify(msg));

				let fromOther = document.querySelector('#dmMsgContent');

				let balloon = document.querySelector('.pendingBalloon');
				let groupIndex;

				const now = new Date(msg.msgDt);

				// ⭐ 새 풍선을 만들어야 할 조건
				let needNewBalloon = false;

				if (!balloon) {
					// 풍선이 아예 없으면 새로 만들어야 함
					needNewBalloon = true;
				} else if (lastFanMsgTime) {
					const diffSec = (now - new Date(lastFanMsgTime)) / 1000;
					if (diffSec > 300) { // 5분 이상이면 새 그룹
						needNewBalloon = true;
					}
				}

				if (needNewBalloon) {
					// 새 팬 그룹 시작
					groupedFanMsgs = [];
					groupedFanMsgs.push(msg);

					groupedMsgList.push([...groupedFanMsgs]);
					groupIndex = groupedMsgList.length - 1;

					// 풍선 새로 만들기
					balloon = document.createElement('div');
					balloon.innerHTML = `<div style="text-align: center; margin-bottom: 5px; cursor: pointer; background-color: #f0f8ff;
											border: 1px solid #F86D72; border-radius: 20px 20px 20px 0px; padding: 5px; width: 45%;"
											 class="groupBalloon pendingBalloon" id="clickedBalloon\${groupIndex}">
											💗 팬 메시지<br>&ensp;\${groupedFanMsgs.length}건 도착 💗</div>
										<div style="color:gray; text-align: left; font-size:12px; margin-bottom:10px;">
											\${msg.msgDtStr}
										</div>`;

					balloon.onclick = () => showGroupedMessages(groupIndex);

					fromOther.appendChild(balloon);
				} else {
					// 기존 pendingBalloon이 있으면 기존 그룹에 추가
					groupIndex = parseInt(balloon.id.replace('clickedBalloon', ''));

					groupedFanMsgs.push(msg);
					groupedMsgList[groupIndex] = [...groupedFanMsgs];

					// 풍선 텍스트 업데이트
					balloon.innerHTML = `💗 팬 메시지<br>&ensp;\${groupedFanMsgs.length}건 도착 💗`
					balloon.onclick = () => showGroupedMessages(groupIndex);										
				}

				// 현재 열린 풍선이라면 왼쪽 fanMsgList에도 즉시 추가
                if (currentOpenGroupIndex === groupIndex) {
                    appendFanMsg(msg);
                }

				// 마지막 팬 메시지 시간 기록
				lastFanMsgTime = now;

				dmMsgContentContainer.scrollTop = dmMsgContentContainer.scrollHeight;
			});
		});
    });
}

// function appendFanMsg(msg) {
//     const fanListBox = document.getElementById("fanMsgList");

//     const msgDiv = document.createElement('div');
//     msgDiv.style.textAlign = 'left';
//     msgDiv.style.backgroundColor = 'lightsteelblue';
//     msgDiv.style.color = 'white';
//     msgDiv.style.border = '1px solid #F86D72';
//     msgDiv.style.borderRadius = '20px 10px 10px 0px';
//     msgDiv.style.padding = '8px 12px';
//     msgDiv.style.maxWidth = '95%';
//     msgDiv.style.cursor = 'pointer';
//     msgDiv.innerText = `\${msg.msgSndrNo} : \${msg.msgContent}`;

//     const timeDiv = document.createElement('div');
//     timeDiv.style.color = 'gray';
//     timeDiv.style.textAlign = 'left';
//     timeDiv.style.fontSize = '12px';
//     timeDiv.innerText = msg.msgDtStr;

//     fanListBox.appendChild(msgDiv);
//     fanListBox.appendChild(timeDiv);

//     fanListBox.scrollTop = fanListBox.scrollHeight;
// }

function appendFanMsg(msg) {
    const fanListBox = document.getElementById("fanMsgList");

    const wrapper = document.createElement('div');
    wrapper.style.display = 'flex';
    wrapper.style.alignItems = 'flex-start'; 
	
    const senderDiv = document.createElement('div');
    senderDiv.style.minWidth = '30px';  // 번호 칸 고정
    senderDiv.style.color = '#F86D72';
    senderDiv.style.fontWeight = 'bold';
    senderDiv.style.fontSize = '14px';
	senderDiv.style.marginTop = '6%';
	senderDiv.style.marginRight = '3px';
    senderDiv.innerText =`\${msg.memFirstName}`;
	
    const msgDiv = document.createElement('div');
    msgDiv.style.backgroundColor = 'lightsteelblue';
    msgDiv.style.textAlign ='left'; 
    msgDiv.style.color = 'white';
    msgDiv.style.border = '1px solid #F86D72';
    msgDiv.style.borderRadius = '20px 10px 10px 0px';
    msgDiv.style.padding = '8px 12px';
    msgDiv.style.maxWidth = '90%';
    msgDiv.style.wordBreak = 'break-word'; 
    msgDiv.innerText = `\${msg.msgContent}`;
	
    const timeDiv = document.createElement('div');
    timeDiv.style.color = 'gray';
    timeDiv.style.textAlign = 'right';
    timeDiv.style.marginBottom = '10px';
    timeDiv.style.fontSize = '12px';
    timeDiv.innerText = msg.msgDtStr;

    wrapper.appendChild(senderDiv);
    wrapper.appendChild(msgDiv);
    fanListBox.appendChild(wrapper);
    fanListBox.appendChild(timeDiv);

    fanListBox.scrollTop = fanListBox.scrollHeight;
}


function dmSendMsgBtn() {
	event.preventDefault();

	const msgContent = document.getElementById("msgContent").value.trim();

	if (!msgContent) {
		alert("메세지를 입력하세요.");
		return;
	}

	let currDate = new Date();
	// 04/29 09:35
	let sendtime =  (currDate.getMonth()+1).toString().padStart(2, "0") +"/"+ currDate.getDate() +" "+
					currDate.getHours() +":"+ currDate.getMinutes().toString().padStart(2, "0"); 

	myFanRoomList.forEach(fanRoom => {
		const message = {
			"dmSubNo": fanRoom.dmSubNo,
			"msgSndrNo": memNoDm,
			"msgContent": msgContent,
			"artNo": artNoDm,
			"msgDtStr": sendtime,
			"sndrActNm": sndrActNm,
			"sndrProfileImg":sndrProfileImg
		};
		stompClient.send("/app/dm/msgByArtist", {}, JSON.stringify(message));
	});

	// 아티스트 메시지 보낸 후 groupedFanMsgs 초기화
	groupedFanMsgs = [];
	lastFanMsgTime = null;

	// 화면에 아티스트 메시지 출력
	const dmContent = `
		<div style="text-align:left; align-self: flex-end; margin-left:10%; border:1px solid #F86D72; 
			border-radius: 20px 20px 0px 20px; max-width:70%; padding: 8px 12px; background-color: floralwhite;">
			\${msgContent}
		</div>
		<div style="color:gray; text-align: right; font-size:12px;">
			\${sendtime}
		</div>
	`;

	document.querySelector('#dmMsgContent').innerHTML += dmContent;
	dmMsgContentContainer.scrollTop = dmMsgContentContainer.scrollHeight;

	// 입력창 비우기
	document.getElementById("msgContent").value = "";

	// 기존 풍선들의 onclick 재설정
	document.querySelectorAll('.groupBalloon').forEach((balloon, idx) => {
		balloon.onclick = () => showGroupedMessages(idx);
	});
	// pendingBalloon 클래스 제거
document.querySelectorAll('.pendingBalloon').forEach(el => {
    el.classList.remove('pendingBalloon');
});

}




</script> 
</body>  
</html>