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
	   text-align: right;
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
	 position: relative; 
   }
   .dmIcon-circle i {
	 color: white;
	 font-size: 14px;
	 line-height: 1;
   }
   .dmIcon-text {
	 margin-right: 6px;
	 color: #F86D72;
   }

   #dmTotalCnt {
  position: absolute;
  top: -8px;
  left: 90px;
  color: indianred;
  font-size: 11px;
  padding: 1px 5px;
  min-width: 16px;
  height: 16px;
  line-height: 14px;
  text-align: center;
  box-sizing: border-box;
  font-weight: bold;
}

  .artist-name_dm {
    margin-top: 8px;
    font-size: 0.9rem;
    font-weight: 500;
  }

  .badge-icon_dm {
    position: absolute;
    bottom: 5px;
    right: 5px;
    background: white;
    border-radius: 50%;
    padding: 3px;
    width: 20px;
    height: 20px;
  }

  .filter-buttons {
    overflow-x: auto;
    white-space: nowrap;
  }

  .filter-buttons::-webkit-scrollbar {
    display: none;
  }
  .tab{
		position: absolute;
		background-color: white;
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
.chatPicture_wrapper {
	position: relative;
	display: inline-block;
}

.notReadCntEach {
	position: absolute;
	top:10px;
	background-color: indianred;
	color: white;
	font-size: 14px;
	font-weight: bold;
	padding: 2px 6px;
	border-radius: 12px;
	min-width: 24px;
	text-align: center;
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
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
				<i class="bi bi-send-fill" id="dmFlight" ></i>
				<div id="dmTotalCnt"></div>
            </div>
            <div class="dmIcon-text"> Message</div>
        </div>
	</div>

	<!-- dm List-->
	<div id="dmList" class="card p-3">
		<div class="d-flex">
			<div class="d-flex flex-column align-items-center me-3"  style="position: sticky; top: 0; ">
				<a href="#" data-dm-num="0" onclick="subscribeSideTab(this)"><i class="bi bi-person-add" style="cursor:pointer; font-size: 1.8rem;"></i></i></a>
				<a href="#" data-dm-num="1" onclick="msgSideTab(this)" class="mt-2"><i class="bi bi-chat-heart" style="cursor:pointer; font-size: 1.8rem;"></i></a>
			</div>
	
			<div class=" d-flex align-items-normal gap-3 flex-wrap ">
				
				<div class="tab" id="subscribeMainTab" style="z-index:20; width: 90%;display: block;">
					<div class="row" style="position: sticky; top: 0; background-color: white;">
						<div class="col-md-3" onclick="myArtist()" style="cursor:pointer;"><h5 id="myArtistText"><b>나의 아티스트</b></h5></div> 
						<div class="col-md-3" onclick="recArtist()" style="cursor:pointer;"><h5 id="recArtistText"><b>추천 아티스트</b></h5></div>
						<div class="col-md-5" id="dmsearchToggle" style="text-align: end; ">
							<!-- 검색 입력창 -->
							<div class="custom-search-wrapper" id="dmsearchBox" style="display: none; position: relative; width: 260px; padding: 1px 6px;">
								<input type="text" id="dmsearchInput" class="custom-search-input" autofocus placeholder="검색어 입력" />
								<button class="clear-btn" id="dmclearSearch" type="button">
									<i class="bi bi-x-lg"></i>
								</button>
								<div id="dmsearchResults" class="dropdown-menu show p-0" style="position: absolute; top: 45px; left: 0; width: 100%; display: none; z-index: 999;">
									<!-- 결과 리스트 출력 div -->
								</div>
							</div>
							<div id="dmsearchIcon" style="cursor: pointer;"><h4><i class="bi bi-search "></i></h4></div>
						</div>
						<div class="col-md-1" style="text-align: end;" onclick="toggleDm()"><h4><i class="bi bi-chevron-bar-down" style="margin-right: 8px;"></i></h4></div>
					</div>
					<div>
						<div id="artistListDm" style="background-color: white; height: 630px; padding-left: 15px; overflow-y:auto; " ></div>
					</div>
				</div>

				<!-- // 채팅 탭 // -->
				<div class="tab" id="msgMainTab" style="width: 90%; display: none;">
					<div class="row" style="position: sticky; top: 0; background-color: white;">
					  <div class="col-md-10 d-flex align-items-start"><h5><b>메세지</b></h5></div> 
					  <div class="col-md-1"></div>
					  <div class="col-md-1" style="text-align: end;" onclick="toggleDm()">
						<h4><i class="bi bi-chevron-bar-down" style="margin-right: 8px;"></i></h4>
					  </div>
					</div>
				  
					<div style="background-color: white; height: 630px; display: flex; border: 1px solid #ccc; border-radius: 5px;">
						<!-- 왼쪽 박스 -->
						<div id="chatRoomList" class="dmScrollHidden" style="flex: 1; border-right:  8px solid rgb(246, 214, 246); margin: 5px;">
							
						</div>
					
						<!-- 오른쪽 박스 -->
						<div style="flex: 5; margin: 5px; text-align: center;" id="chatRoom">
							<b id="startDmInfo"><h3 style=" padding-top:30px;"><i class="bi bi-arrow-left-square"></i></h3> <h5>대화를 시작할 아티스트를 선택하세요</h5></b>
						</div>
					</div>
				</div>

				
			</div>
		</div>
	</div>

	<!-- dm 구독권 결제 -->
	<div class="modal" id="buyDmModal">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content" style="width: 450px;">
			<form method="post" action="/shop/ordersPost">
				<!-- Modal body -->
				<div class="modal-body">
					<input type="hidden" id="dmArtNoModal" name="goodsVOList[0].option2">
					<input type="hidden" id="dmGdsFileModal" name="goodsVOList[0].fileSavePath">
					<input type="hidden" id="dmGdsNmModal" name="goodsVOList[0].commCodeGrpNo">
					<input type="hidden"  name="goodsVOList[0].gdsNm" value="DM 월 구독권">
					<input type="hidden"  name="goodsVOList[0].gdsNo" value="98">
					<input type="hidden"  name="goodsVOList[0].qty" value="1">
					<input type="hidden"  name="goodsVOList[0].unitPrice" value="8000">
					<input type="hidden"  name="goodsVOList[0].amount" value="8000">
					<input type="hidden"  name="goodsVOList[0].gramt" value="8000">
					<div style="text-align: center; margin-bottom: 20px;">
						<img id="dmArtImgModal" src="" width="150" height="150" style="border-radius:50%;">
					</div>
					<div style="text-align: center;">
						<b id="dmArtActNmModal" style="margin-bottom: 10px;"></b><p>8,000원/30일</p>
					</div>
					<div id="dmnotice">
						<ul style="font-size: 12px; color:rgb(19, 19, 19); padding: 0; margin-bottom: 10px;">유의사항</ul>
						<li>OHoT DM을 구독하면 아래의 유의사항을 모두 읽고 동의한 것으로 간주합니다.</li>
						<li>구독 기간 동안 아티스트의 메시지를 수신하고, 아티스트에게 메시지를 보낼 수 있습니다.</li>
						<li> 이용권을 구매한 시점부터 매 24시간 경과 시 구독 기간 1일이 소진됩니다.</li>
						<li>아티스트의 메시지는 비정기적으로 발송되며, 구독 기간 내 메시지 발송 횟수는 보장되지 않습니다.(서비스 오류 외, 메시지 미수신을 사유로 한 환불은 불가합니다.)</li>
						<li>아티스트가 전송한 메시지 또는 콘텐츠는 DM 구독자에게 독점으로 제공됩니다. 관련 메시지 또는 콘텐츠를 OHoT 동의 없이 외부에 전송, 게시하는 경우 서비스 이용에 제재를 받거나 법적 책임을 질 수 있습니다.</li>
						<li>[청약 철회] 이용권 결제 후 7일 이내, 서비스 이용이 시작되지 않은 경우 환급 가능합니다.</li>
						<li>서비스 이용, 결제/환불에 관한 더 자세한 내용은 고객센터를 참고해 주시기 바랍니다.</li>
						<li>본 유의사항에서 정하지 않은 사항은 OHoT 서비스 이용약관 및 유료서비스 이용약관의 내용에 따릅니다. (*이용약관 및 유료서비스 이용약관: OHoT 설정 > 서비스 정보 및 약관 > 이용약관 및 유료서비스 이용약관)</li>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" >구독하기</button>
				</div>
			</form>
		  </div>
		</div>
	</div>
	  

<script type="text/javascript">
const dmTabs =document.querySelectorAll(".tab");
const memNoDm = '${userVO.memberVO.memNo}';
const memFirstNameDm = '${userVO.memberVO.memFirstName}';
let isDmOpen = false;


let pageMap = {}; // 각 채팅방별 페이지 상태
const size_dm = 30;
let isLoading_dm = false;
let noMoreDataMap = {}; // 채팅방별로 마지막 여부 관리

let previousSelectedImg = null; // 초기화 이전에 선택했던 이미지 요소를 기억해두기

let stompClientDm = null;
let isDmSocketConnected =false;
let currentOpenDmSubNo= null;
let chatRoomList_dm=[];
let countAllDm =0;
const dmTotalCnt =  document.querySelector('#dmTotalCnt');

connectToDm();

//웹소켓 연결	
function connectToDm(){
	const socket = new SockJS("/ws/dm");
	stompClientDm = Stomp.over(socket);
	if(isDmSocketConnected)return callback?.();

	stompClientDm.connect({}, (frame) => {
		console.log("연결성공 :"+JSON.stringify(frame));
		isDmSocketConnected =true;
		console.log('${userVO}')
		//각 채팅방 구독하기
		axios.post("/oho/dm/checkPurchaseDm?artNo=0&memNo="+memNoDm).then(resp=>{
			chatRoomList_dm= resp.data;
			console.log(JSON.stringify(chatRoomList_dm))

			chatRoomList_dm.forEach(room =>{

				//전체 안읽음 수 구하기
				countAllDm += room.notReadCnt;
				// console.log("안 읽은 메세지 수: "+countAllDm);
				
				stompClientDm.subscribe('/toFan/dmRoom/'+room.dmSubNo, (subsRooms)=>{
					const subsRoom =JSON.parse(subsRooms.body);
					console.log("아티스트에게서 온 메세지 "+JSON.stringify(subsRoom));

					if (isDmOpen && currentOpenDmSubNo == subsRoom.dmSubNo ) {
						// 현재 열려 있는 채팅방이면 화면에 표시
						newChatFromArt(subsRoom);

					} else if(isDmOpen && currentOpenDmSubNo != subsRoom.dmSubNo ){
						////////한번들어갓다오면 열려있는걸로 되어있는 거 고쳐야함
						// 다른 채팅방이면 알림만 표시 -토글은 열려있는경우
						const otherRoom = document.querySelector('#notReadCntEach'+subsRoom.dmSubNo);
						// console.log(room.dmSubNo+"어디어디");

						if (otherRoom) {
							const currentCount = parseInt(otherRoom.innerText) || 0;
							otherRoom.innerText = currentCount + 1;
						}
					}else {

						// 토글 닫혀있을때 화면 알림
						newMsgAlertCloseDm(subsRoom);
					}

				})
			})

			//전체 카운트
			if (countAllDm > 0 && countAllDm < 100) {
				dmTotalCnt.innerText=countAllDm;
			}else if(countAllDm>=100){
				dmTotalCnt.innerText="99+";
			}

		})
	});

}

function newMsgAlertCloseDm(subsRoom){
	console.log(JSON.stringify(subsRoom))

	//디엠 계속 보내도 한건만 노출
	// Swal.fire({
    //     toast: true,
    //     position: 'top-end',
    //     showConfirmButton: false,
    //     timer: 3000,
    //     timerProgressBar: false,
    //     background: 'floralwhite',
	// 	width:'400px',
    //     html: `
	// 		<div style="display: flex; align-items: center;">
	// 		<img src="/upload\${subsRoom.sndrProfileImg}" 
	// 			alt="💗" 
	// 			style="width: 50px; height: 50px; border-radius: 50%; margin-right: 10px;">
	// 			<div style="text-align:center;">
	// 				<strong>\${subsRoom.sndrActNm}</strong>님이 메시지를 보냈습니다 <br><b>DM을 확인해주세요💗</b>
	// 			</div>
	// 		</div>
	// 	`
	// 	});

	//디엠 보낼때마다 계속 쌓임
	Toastify({
		text: `
			<div style="display: flex; align-items: center;" onclick="toggleDm(msgSideTab(this))">
				<img src="/upload\${subsRoom.sndrProfileImg}" 
					alt="💗"  style="width: 50px; height: 50px; border-radius: 50%; margin-right: 10px;">
				<div style="text-align:center; color:black;">
					<strong>\${subsRoom.sndrActNm}</strong>님이 메시지를 보냈습니다 <br><b>DM을 확인해주세요💗</b>
				</div>
			</div>
		`,
		duration: 2000,
		gravity: "top", // Position: top or bottom
		position: "right", // Position: left, center, or right
		backgroundColor: "floralwhite",
		stopOnFocus: true, // Prevents dismissing on hover
		escapeMarkup: false, // Allows HTML content
	}).showToast();

	//숫자 카운트
	countAllDm++;
	if (countAllDm > 0 && countAllDm < 100) {
		dmTotalCnt.innerText=countAllDm;
	}else if(countAllDm>=100){
		dmTotalCnt.innerText="99+";
	}

}
let chatListCurrIdx = 0;
const chatListPageSize = 6;
//dm권 구매한 아티스트 리스트
function myChatRoomList(){
	const chatRoomListDiv= document.querySelector('#chatRoomList');
	chatRoomListDiv.innerHTML="";
			
	let chatPicture=``;
	const visibleList = chatRoomList_dm.slice(chatListCurrIdx, chatListCurrIdx + chatListPageSize);
	visibleList.forEach((art) => {
		chatPicture += `<div class="chatPicture_wrapper">`;

		if (art.notReadCnt == 0) {
			chatPicture += `
				<img src="/upload\${art.fileSaveLocate}" width="80" height="80" id="img\${art.dmSubNo}"
					onclick="enterChatRoom(\${art.dmSubNo}, \${art.artNo})"
					style="border-radius: 50px 0 0 50px; margin: 5px; object-fit: cover; cursor: pointer;">
			</div>`;
		} else {
			chatPicture += `
				<div class="notReadCntEach" id="notReadCntEach\${art.dmSubNo}">\${art.notReadCnt}</div>
				<img src="/upload\${art.fileSaveLocate}" width="80" height="80" id="img\${art.dmSubNo}"
					onclick="enterChatRoom(\${art.dmSubNo}, \${art.artNo})"
					style="border-radius: 50px 0 0 50px; margin: 5px; object-fit: cover; cursor: pointer;">
			</div>`;
		}
	});

	// ▲ ▼ 버튼 추가
	if (chatListCurrIdx > 0) {
		chatPicture = `<div style="text-align:center; font-size:25px;  cursor:pointer;" onclick="navigateChatRoomList('up')"><i class="bi bi-caret-up-square"></i></div>` + chatPicture;
	}
	if (chatListCurrIdx + chatListPageSize < chatRoomList_dm.length) {
		chatPicture += `<div style="text-align:center; font-size:25px; cursor:pointer;" onclick="navigateChatRoomList('down')"><i class="bi bi-caret-down-square"></i></div>`;
	}

	chatRoomListDiv.innerHTML = chatPicture;
}

function navigateChatRoomList(direction) {
	if (direction === 'down') {
		if (chatListCurrIdx + chatListPageSize < chatRoomList_dm.length) {
			chatListCurrIdx++;
			myChatRoomList();
		}
	} else if (direction === 'up') {
		if (chatListCurrIdx > 0) {
			chatListCurrIdx--;
			myChatRoomList();
		}
	}
}

//dm창 토글
function toggleDm(artNo) {
	if (isDmOpen) {
		// 닫기
		dmList.style.width = "0px";
		dmList.style.height = "0px";
		document.querySelector('#dmIcon').style.zIndex = 10;
		isDmOpen = false;
		const closeClearDm =document.querySelector('#chatRoom').innerHTML=`
		<b id="startDmInfo"><h3 style=" padding-top:30px;"><i class="bi bi-arrow-left-square"></i></h3> <h5>대화를 시작할 아티스트를 선택하세요</h5></b>`;

	} else {
		// 열기
		dmList.style.width = "700px";
		dmList.style.height = "700px";
		document.querySelector('#dmIcon').style.zIndex = 3;

		console.log("로그인했음:", '${not empty userVO.memberVO.memNo}');

		//홈에서 디엠 바로 접근할때 - 파라미터 값 있을때 
		if (artNo) {
			// 1. 탭 열기
			subscribeSideTab({ dataset: { dmNum: 0 } });

			// 2. 렌더링 타이밍 확보 후 검색 실행
			setTimeout(() => {
				dmsearchFilter(artNo);
			}, 100);
		}

		if (memNoDm!=0 || memNoDm!=null|| memNoDm!="") {
			myArtist();
		} else{
			recArtist();
		}
		isDmOpen = true;
	}
}

//아티스트 답장 받기
function newChatFromArt(subsRoom){
	
	const msg = subsRoom;
	let fromOther =document.querySelector('#dmMsgContent'+msg.dmSubNo)

	const li = document.createElement('div');
		li.style = "text-align:left; align-self: flex-start; margin-bottom:5px; background-color:#f0f8ff; border:1px solid #F86D72; border-radius:20px 20px 20px 0px; padding:5px; max-width:45%;";
		li.innerHTML = msg.msgContent;
	const liOfTime = document.createElement('div');
		liOfTime.style = "color:gray; text-align:left; font-size:12px;";
		liOfTime.innerHTML = msg.msgDtStr;
		fromOther.appendChild(li);
		fromOther.appendChild(liOfTime);

	let dmMsgContentContainer = document.querySelector("#dmMsgContent"+msg.dmSubNo);
	dmMsgContentContainer.scrollTop = dmMsgContentContainer.scrollHeight;

}



function enterChatRoom(dmSubNo, artNoDm){
	event.preventDefault();
	// alert("채팅방 "+dmSubNo);

	// 이전에 선택했던 이미지 테두리를 초기화
	if (previousSelectedImg) previousSelectedImg.style.outline = ""; // 원래대로 (없애기)
	
	// 현재 선택한 이미지에 테두리 추가
	const currentImg = document.querySelector(`#img\${dmSubNo}`);
	currentImg.style.outline = "6px solid rgb(246, 214, 246)";

	// 현재 선택한 이미지를 다음번 초기화를 위해 저장
	previousSelectedImg = currentImg;

	//채팅방 재입장을 위해 페이지 초기화
	pageMap[dmSubNo] =0;
	noMoreDataMap[dmSubNo]=false;

	document.querySelector('#chatRoom').innerHTML="";
	let dmMsgDiv=``;
	dmMsgDiv += ` 
			<input type="hidden" id="dmSubNo" name="dmSubNo" value="\${dmSubNo}">
			<input type="hidden" id="msgSndrNo" name="msgSndrNo" value="\${memNoDm}">
			<input type="hidden" id="artNo" name="artNo" value="\${artNoDm}">
			<div style="height: 93%; overflow-y:auto; display:flex; flex-direction: column;" id="dmMsgContent\${dmSubNo}"></div>
			<div style="position:sticky; bottom:5px;">
				<input type="text" name="msgContent" id="msgContent" style="width: 85%; height: 40px; border:3px solid gray; 
						border-radius: 10px; padding-bottom: 8px;" onkeypress="if(event.key === 'Enter') dmSendMsgBtn()" placeholder="메세지를 입력하세요" />
				<button type="button" class="btn btn-warning" id="sendDmMsg" onclick="dmSendMsgBtn()" >&ensp;<i class="bi bi-send-fill"></i>&ensp;</button>
			</div>
	`;

	document.querySelector('#chatRoom').innerHTML+=dmMsgDiv;
	currentOpenDmSubNo = dmSubNo;

	 // 스크롤 이벤트 동적 바인딩 (이 시점에 DOM이 존재함)
	 const msgContainer = document.querySelector("#dmMsgContent" + dmSubNo);
	 msgContainer.addEventListener("scroll", () => {
        // noMoreDataMap[dmSubNo]가 true면 바로 return 시켜버려
        if (noMoreDataMap[dmSubNo]) return;

        if (msgContainer.scrollTop === 0) {
            myLastChatList(dmSubNo);
        }
    });
	myLastChatList(dmSubNo); //마지막 대화 가져오기

	//읽으면 Y로 업데이트
	axios.post('/oho/dm/updateReadY?dmSubNo='+dmSubNo).then(resp=>{
		console.log("읽은 갯수: " +resp.data);

		const removeCnt = document.querySelector('#notReadCntEach'+dmSubNo);
		removeCnt.remove();

		// ② chatRoomList_dm에서도 값 갱신 (★ 중요!)
		const targetRoom = chatRoomList_dm.find(room => room.dmSubNo === dmSubNo);
		if (targetRoom) {
			targetRoom.notReadCnt = 0; // 다음에 목록 갱신해도 다시 안 뜨게
		}
	})

}

function myLastChatList(dmSubNo) {
    if (isLoading_dm || noMoreDataMap[dmSubNo]) return;

    if (!pageMap[dmSubNo]) pageMap[dmSubNo] = 0;
    isLoading_dm = true;

    const chatRoomList = document.querySelector('#dmMsgContent' + dmSubNo);
    const previousScrollHeight = chatRoomList.scrollHeight;

    axios.post('/dm/lastChat?artNo=0&dmSubNo=' + dmSubNo + '&page=' + pageMap[dmSubNo] + '&size=' + size_dm)
    .then(resp => {
        const msgList = resp.data;

        if (msgList.length === 0) {
            noMoreDataMap[dmSubNo] = true;
            showNoMoreData(dmSubNo);
            isLoading_dm = false;
            return;
        }
		msgList.sort((a, b) => new Date(a.msgDt) - new Date(b.msgDt));

        msgList.forEach(chat => {
            const li = document.createElement('div');
            const liOfTime = document.createElement('div');

            if (chat.msgSndrNo == memNoDm) {
                // 팬
                li.style = "text-align:left; align-self: flex-end; margin-left:10%; border:1px solid #F86D72; border-radius: 20px 20px 0px 20px; max-width:70%; padding:8px 12px; background-color: floralwhite;";
                li.innerHTML = chat.msgContent;
                liOfTime.style = "color:gray; text-align:right; font-size:12px;";
                liOfTime.innerHTML = chat.msgDtStr;
            } else {
                // 아티스트
                li.style = "text-align:left; align-self: flex-start; margin-bottom:5px; background-color:#f0f8ff; border:1px solid #F86D72; border-radius:20px 20px 20px 0px; padding:5px; max-width:45%;";
                li.innerHTML = chat.msgContent;
                liOfTime.style = "color:gray; text-align:left; font-size:12px;";
                liOfTime.innerHTML = chat.msgDtStr;
            }

            chatRoomList.prepend(liOfTime);
            chatRoomList.prepend(li);
        });

        const newScrollHeight = chatRoomList.scrollHeight;
        chatRoomList.scrollTop = newScrollHeight - previousScrollHeight;

        pageMap[dmSubNo]++;
        isLoading_dm = false;
    })
    .catch(error => {
        console.error("Error lastchatlist:", error);
        isLoading_dm = false;
    });
}

function showNoMoreData(dmSubNo) {

	const stopScroll= document.querySelector('#noMoreData'+dmSubNo);
	if(stopScroll) return;

    const endDiv = document.createElement('div');
    endDiv.style.textAlign = 'center';
    endDiv.style.margin = '20px 0';
    endDiv.style.color = 'gray';
    endDiv.style.fontSize = '14px';
	endDiv.id="noMoreData"+dmSubNo;
    endDiv.innerText = '마지막 메세지입니다';

    const myMsgList = document.querySelector('#dmMsgContent'+dmSubNo);
    myMsgList.prepend(endDiv);

	 // 여기서 반드시!
	 noMoreDataMap[dmSubNo] = true;
}


function dmSendMsgBtn(){
	event.preventDefault();

	let currDate = new Date();
	// 분에 05분 이렇게 처리
	let sendtime =  (currDate.getMonth()+1).toString().padStart(2, "0") +"/"+ currDate.getDate().toString().padStart(2, "0") +" "+
					currDate.getHours() +":"+ currDate.getMinutes().toString().padStart(2, "0"); 

	const dmSubNo = document.getElementById("dmSubNo").value;
    const msgContent = document.getElementById("msgContent").value;
    const artNoDm = document.getElementById("artNo").value;

    if (!msgContent.trim()) {
        alert("메세지를 입력하세요.");
        return;
    }

    // 보내는 메시지 객체 (DmMsgVO랑 맞춰야 함)
    const message = {
        "dmSubNo": dmSubNo,
        "msgSndrNo": memNoDm,
        "msgContent": msgContent,
		"artNo":artNoDm,
		"msgDtStr":sendtime,
		"memFirstName":memFirstNameDm
    };

	// sendMessage(message); //메세지 전송 함수 호출
	const li = document.createElement('div');
	const liOfTime = document.createElement('div');
	li.style = "text-align:left; align-self: flex-end; margin-left:10%; border:1px solid #F86D72;border-radius: 20px 20px 0px 20px; max-width:70%; padding: 8px 12px; background-color: floralwhite;";
	li.innerHTML = msgContent;
	
	liOfTime.style ="color:gray; text-align: right; font-size:12px;";
	liOfTime.innerHTML= sendtime;
	document.querySelector('#dmMsgContent'+dmSubNo).appendChild(li);
	document.querySelector('#dmMsgContent'+dmSubNo).appendChild(liOfTime);
	let dmMsgContentContainer = document.querySelector("#dmMsgContent"+dmSubNo);
	dmMsgContentContainer.scrollTop = dmMsgContentContainer.scrollHeight;

    // 메시지 전송
	stompClientDm.send("/app/dm/msgByFan", {}, JSON.stringify(message));

    // 입력창 비우기
    document.getElementById("msgContent").value = "";

}

function msgSideTab(msgTab){
	event.preventDefault();
	// alert("메세지 탭 나와랍");

	// //탭 초기화
	// for(let i=0; i<dmTabs.length; i++){
	// 	dmTabs[i].style.zIndex =11 ;    
	// }

	// dmTabs[msgTab.dataset.dmNum].style.zIndex =20;

	// 모든 탭 감추기
	dmTabs.forEach((tab) => {
		tab.style.display = "none";
	});

	// 메시지 탭 보여주기
	const selectedTab = dmTabs[1];
	selectedTab.style.display = "block";
	myChatRoomList();
}

function subscribeSideTab(subTab){
	event.preventDefault();
	// alert("전체 아티스트 나와랍");

	//탭 초기화
	// for(let i=0; i<dmTabs.length; i++){
	// 	dmTabs[i].style.zIndex =11 ;    
	// }

	// dmTabs[subTab.dataset.dmNum].style.zIndex =20;

	// 탭 초기화: 모든 탭을 숨기기
	dmTabs.forEach((tab) => {
		tab.style.display = "none";
	});

	// 선택한 탭만 보이게
	const selectedTab = dmTabs[subTab.dataset.dmNum];
	selectedTab.style.display = "block";
}

function myArtist(){
	document.querySelector('#myArtistText').style.color="black";
	document.querySelector('#recArtistText').style.color="gray";
	// alert("내가 구독한 커뮤니티 아티스트");
	axios.post("/oho/dm/myArtist").then(resp=>{
		const myArtistListDm = resp.data;
		console.log("내가 구독한 커뮤니티 아티스트 : ", myArtistListDm);

		commonArtListDm(myArtistListDm);

		})
		.catch(error => {
			console.error("Error:", error);
		});

}

function recArtist(){
	document.querySelector('#myArtistText').style.color="gray";
	document.querySelector('#recArtistText').style.color="black"; 
	// alert("구독제외 전체 아티스트 리스트트");

	axios.post("/oho/dm/artistList").then(resp=>{
		const artistAllListDm = resp.data;
		console.log("전체 아티스트 목록 : ", artistAllListDm);
		commonArtListDm(artistAllListDm)
		
		})
		.catch(error => {
			console.error("Error:", error);
		});
}

function commonArtListDm(artistAllList){
	const artistListDiv = document.getElementById("artistListDm");
		artistListDiv.innerHTML = ""; 
		let artistLink =`
			<div class="filter-buttons mb-3">
			
			</div>`;
			artistListDiv.insertAdjacentHTML('beforeend', artistLink);
			// alert(artistAllList[0].artGroupNm);
				if (artistAllList.length > 0) {
				let prevGroup = null;
				let groupHtml = "";

				artistAllList.forEach((artist, i) => {
					const artistName = artist.artGroupNm;
					const artistNo = artist.artGroupNo;
					const artistVOList = artist.artistVOList;

					// 새로운 그룹이면 이전 그룹 HTML 마무리하고 추가
					if (artistName !== prevGroup) {
						// 이전 그룹이 존재하면 닫아줌
						if (groupHtml !== "") {
							groupHtml += `</ul></div>`;
							artistListDiv.insertAdjacentHTML('beforeend', groupHtml);
						}

						// 새로운 그룹 시작
						groupHtml = `
							<div class="artist-group_dm">
								<p class="group-name_dm">\${artistName}</p>
								<ul class="artist-list_dm">
						`;
						prevGroup = artistName;
					}

					artistVOList.forEach(artistInfo => {
						groupHtml += `
							<li class="artist_item_dm" style="text-align:center; margin-left: 10px;" 
								data-bs-target="#buyDmModal" data-dm-art-act-nm="\${artistInfo.artActNm}"
								data-dm-art-no="\${artistInfo.artNo}" data-dm-art-img="\${artistInfo.fileSaveLocate}">
								<div role="button" tabindex="0">
									<div>
										<div>
											<img src="/upload\${artistInfo.fileSaveLocate}" width="100" height="100" style="border-radius: 50%; object-fit: cover;">
										</div>
									</div>
									<strong>\${artistInfo.artActNm}</strong>
								</div>
							</li>
						`;
					});

					// 마지막 아티스트일 경우 그룹 닫기
					if (i === artistAllList.length - 1) {
						groupHtml += `</ul></div>`;
						artistListDiv.insertAdjacentHTML('beforeend', groupHtml);
					}
				});
			} else {
				artistListDiv.innerHTML = "<p style='margin-top: 90px;'>가입한 커뮤니티가 없습니다 <br> 커뮤니티 가입 후 아티스트를 만나보실 수 있습니다 <br> <h5>추천아티스트를 확인하고 DM을 시작하세요💌</h5></p>";
			}
}

/* 구독 모달에 값넣어주기기 */
document.addEventListener("DOMContentLoaded", () => {
	document.addEventListener("click", function(e) {
		if (e.target.closest(".artist_item_dm")) {
			const dmArtistItem = e.target.closest(".artist_item_dm");
			// console.log(dmArtistItem.dataset)
			
			const dmArtActNm = dmArtistItem.dataset.dmArtActNm;
			const dmArtImg = dmArtistItem.dataset.dmArtImg;
			const dmArtNo = dmArtistItem.dataset.dmArtNo;

			//구매이력확인
			const checkSubs = {
				'artNo':dmArtNo,
				'memNo':memNoDm
			}
			console.log(checkSubs.memNo);

			axios.post("/oho/dm/checkPurchaseDm?memNo="+memNoDm+"&artNo="+dmArtNo).then(resp=>{
				console.log(resp.data);

				//채팅방이동
				if(resp.data){
					msgSideTab(1);
				}
				else{	//모달 띄우기
					// 모달 내부 요소에 넣기
					document.getElementById("dmArtActNmModal").innerText = "🌟 "+dmArtActNm+" DM 월 구독권 🌟";
					document.getElementById("dmGdsNmModal").value = dmArtActNm;
					document.getElementById("dmArtImgModal").src = "/upload"+dmArtImg;
					document.getElementById("dmGdsFileModal").value = dmArtImg;
					console.log("dmArtImg",dmArtImg);
					document.getElementById("dmArtNoModal").value = dmArtNo; // hidden input이라면
	
					// 모달 수동으로 띄우기
					const modal = new bootstrap.Modal(document.getElementById('buyDmModal'));
					modal.show();

				}
			})
			
		}
	});
});



/* 
let dmTimer = null;
function fShow(){

	clearTimeout(dmTimer); // 기존 타이머 제거

	if(!dmList.style.width){
		dmList.style.width="0px";
		dmList.style.height="0px";
	}
	dmList.style.width=parseInt(dmList.style.width)+20 + "px";
	dmList.style.height=parseInt(dmList.style.height)+20 + "px";

	if(parseInt(dmList.style.width) >= 700){
		console.log("로그인했음: ",'${not empty userVO.memberVO.memNo}')
		if(${not empty userVO.memberVO.memNo}){
			myArtist();
		}else{
			recArtist();
		}
		showTimer = null;
		return;
	}
	dmTimer = setTimeout(fShow, 3);
	
	document.querySelector('#dmIcon').style.zIndex=3;
	
}

function fHide(){

	clearTimeout(dmTimer); // 기존 타이머 제거

	dmList.style.width=parseInt(dmList.style.width)-15 + "px";
	dmList.style.height=parseInt(dmList.style.height)-15 + "px";

	if(parseInt(dmList.style.width) <=0) return;
	setTimeout(fHide,3);

	hideTimer = setTimeout(fHide, 3);

	document.querySelector('#dmIcon').style.zIndex=10;

	dmTimer = setTimeout(fHide, 3);
} */

</script> 
<script src="/js/dm/dmSearch.js" ></script>
</body>  
</html>