<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<style>

  /* 알림 스타일 */
  #alarmBox {
  position: absolute;
  top: 85%; /* 아이콘 바로 아래 */
  right: 10px; /* 오른쪽 정렬 */
  background-color: white;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  width: 450px;
  height: 600px;
  display: none; /* 기본은 숨김 */
  z-index: 1000;
  border-radius: 20px;
}

.alarmSrhList {
	display: flex;
	overflow-x: auto;
	scrollbar-width: none; /* Firefox */
	-ms-overflow-style: none;  /* IE 10+ */
	font-size: 14px;
}
.alarmSrhList::-webkit-scrollbar {
	display: none; /* Chrome, Safari, Opera */
}
.alarmSrhList li {
  flex: 0 0 auto;
  margin-right: 10px;
  white-space: nowrap;
  border: 0px solid #ccc;
  border-radius: 5px;
  background-color: aliceblue;
  cursor: pointer;
  transition: background-color 0.3s;
  padding: 2px 6px; /* 상하 좌우 여백을 줌 */
}
.alarmSrhList li:hover {
  background-color: lightblue;
}
.alarm-container {
  display: flex;
  align-items: center;
  gap: 4px;
  position: relative;
  margin:5px;
}
.scroll-alarm-btn {
  background: none;
  border: none;
  font-size: 12px;
  cursor: pointer;
}
.scroll-alarm-btn.hidden {
  visibility: hidden;
}
.alarm_item{
	padding: 5px; 
	border: 0px solid #ccc;
	box-shadow: 0 2px 6px rgba(0,0,0,0.1);
	cursor: pointer;
	margin: 8px;
	border-radius: 10px;
}

</style>
</head>
<body>
	
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO" />
	</sec:authorize>
<div class="alarm-container" >
	<button type="button" id="scrollLeft" class="scroll-alarm-btn hidden" style="background-color: aliceblue; width: 30px; height: 30px; border-radius: 50%; border: 0;">
		<i class="bi bi-chevron-left"></i>
	</button>

	<ul class="alarmSrhList" id="alarmList">
		<li onclick="alarmDetail(0)" id="alarm0">전체</li>
	</ul>
	<button type="button" class="scroll-alarm-btn" id="scrollRight" style="background-color: aliceblue; width: 30px; height: 30px; border-radius: 50%; border: 0;">
		<i class="bi bi-chevron-right"></i>
	</button>
</div>

<!-- 알림 목록 영역 시작 -->
<div class="notification_area" style="height: 500px;">
	<div class="notification_list_wrap" id="alarmDetailBox" style="overflow-y: auto; height: 100%;">
		<!-- 알림내용 자리 -->
			
	</div>
</div>
<!-- 알림 목록 영역 끝 -->
	
	  
<script type="text/javascript">
	let isAlarmOpen = false; // 알림창 초기값
	const alarmMemNo = '${userVO.memberVO.memNo}'; 

	const badgeYn = document.querySelector('.badgeNoti');

	//읽지 않은 알림 있는지 확인
	axios.post('/oho/alarm/checkEnum?memNo='+alarmMemNo).then(resp=>{
		if(resp.data !=0){
			badgeYn.style.display='block';
		}
	})
	
	//알림창 열고 닫기
	function toggleAlarm() {
		if (isAlarmOpen) {
			document.getElementById("alarmBox").style.display = "none";
			isAlarmOpen = false;
			
			
		} else {
			document.getElementById("alarmBox").style.display = "block";
			isAlarmOpen = true;
			//open 되었을때 read_enum 업데이트
			axios.post('/oho/alarm/readEnum?memNo='+alarmMemNo).then(resp=>{
				//Y 처리 성공하면 빨간 불 없애기 
				if(resp.data !=0){
					badgeYn.style.display='none';
				}
		
			})
			alarmGroupList();
		}
	}

	//가입한 커뮤니티 리스트 불러오기
	function alarmGroupList(){

		// alert(alarmMemNo);
		axios.post("/oho/alarm/registeredGroupList?memNo="+alarmMemNo).then(resp=>{
			const alarmGroupList = resp.data;
			const alarmListUl=document.querySelector('#alarmList'); 
			
			alarmGroupList.forEach(group => {
				const li = document.createElement('li');
				li.textContent = group.artGroupNm; // 그룹 이름을 표시
				li.id="alarm"+group.artGroupNo;
				li.onclick = () => alarmDetail(group.artGroupNo);
				alarmListUl.appendChild(li);
			});

			console.log(alarmGroupList);
		})
		alarmDetail(0);
	}

	function alarmDetail(groupNo) {
		// alert("알림  그룹 번호: " + groupNo);
		document.querySelectorAll('.alarmSrhList li').forEach(li => {
			li.style.backgroundColor = "aliceblue";
		});
		const currLi=document.querySelector('#alarm'+groupNo);
		currLi.style.backgroundColor="lightblue";

		axios.post("/oho/alarm/alarmDetailList?memNo="+alarmMemNo+"&artGroupNo="+groupNo).then(resp=>{
			const alarmDetailList = resp.data;
			console.log(JSON.stringify(alarmDetailList));
			const alarmDetailBoxDiv=document.querySelector('#alarmDetailBox'); 
			alarmDetailBoxDiv.innerHTML = ""; // 기존 알림 목록 초기화
			if(alarmDetailList.length==0){
				const li = document.createElement('li');
				li.textContent = "아직 도착한 알림이 없습니다"; // 알림 내용을 표시
				li.className = "alarm_item";
				li.style ="text-align: center; cursor: auto; margin-top: 100px; border: none; box-shadow:none;" 
				alarmDetailBoxDiv.appendChild(li);
			}
			alarmDetailList.forEach(alarm => {
				const li = document.createElement('li');
				li.innerHTML = `<div style="display: flex; align-items: center; gap: 5px;">
									<img src="/upload\${alarm.fileSaveLocate}" alt="main" style="width:60px; height:60px; border-radius:10px; object-fit: cover; flex-shrink: 0;"/>
									<div style="display: flex; flex-direction: column; justify-content: space-between; flex: 1;">
										<div style="font-size: 14px; line-height: 1.4; word-break: break-word;">
											\${alarm.notiCn}
										</div>
										<div style="font-size: 12px; color: gray; text-align: right; margin-top:8px;">
											\${alarm.notiDt}
										</div>
									</div>
								</div>`; // 알림 내용을 표시
				li.className = "alarm_item"; // CSS 클래스 추가
				if(alarm.notiOrgTb=='COMMUNITY_POST'){
					li.onclick = () => { 
						if(alarm.boardDelyn =='N'){
							window.location.href = "/oho/community/artistBoardList?artGroupNo="+alarm.notiSndrNo+"&notiOrgNo="+alarm.notiOrgNo; //커뮤니티포스트일경우
						}else{
							Swal.fire({
								title: "삭제된 게시글입니다",
								text: "",
								icon: "error",
								showConfirmButton: false,
								timer: 1000  // 2초 후 자동 닫힘
							});
						}
					};
				}
				if(alarm.notiOrgTb=='COMMUNITY_REPLY'){
					li.onclick = () => { 

						if(alarm.replyDelyn=='N'){
							//아래처럼 세션에 담으면 url 노출 없이 보낼 수 있다
							sessionStorage.setItem("replyNo", alarm.boardNo); // 팬 쪽에 남긴 댓글일경우 
							window.location.href = "/oho/community/fanBoardList?artGroupNo="+alarm.notiSndrNo;
						}else{
							Swal.fire({
								title: "삭제된 댓글입니다",
								text: "",
								icon: "error",
								showConfirmButton: false,
								timer: 1000  // 2초 후 자동 닫힘
							});
						}
					};
				}
				alarmDetailBoxDiv.appendChild(li);
			});
			
			//날짜 구분선 나와야함
			// <div class="notification_date">어제</div>;

			
		})

	}

	
//외부 클릭 시 드롭다운 닫기
document.addEventListener("click", function () {
	if(isAlarmOpen==true){

		const searchArea = document.querySelector(".alarm-warapper");
		if (!searchArea.contains(event.target)) {
			// alert("알림창을 닫습니다.");
			toggleAlarm();
		}
	}
   
 });

	const ul = document.getElementById('alarmList');
	const leftBtn = document.getElementById('scrollLeft');
	const rightBtn = document.getElementById('scrollRight');
	const scrollAmount = 100;

	leftBtn.addEventListener('click', () => {
		ul.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
	});
	rightBtn.addEventListener('click', () => {
		ul.scrollBy({ left: scrollAmount, behavior: 'smooth' });
	});

	ul.addEventListener('scroll', checkScroll);

	function checkScroll() {
		leftBtn.classList.toggle('hidden', ul.scrollLeft <= 0);
		rightBtn.classList.toggle('hidden', ul.scrollLeft + ul.clientWidth >= ul.scrollWidth - 1);
	}

	// 초기 로딩 시 상태 체크
	window.addEventListener('load', () => {
		checkScroll();
		rightBtn.classList.remove('hidden');  // 오른쪽 버튼을 강제로 보이게
	});
</script>
</body>
</html>