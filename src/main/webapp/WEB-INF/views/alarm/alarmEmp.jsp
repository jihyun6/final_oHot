<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

#alarmBox {
  position: absolute;
  top: 85%; /* 아이콘 바로 아래 */
  right: 10px; /* 오른쪽 정렬 */
  background-color: white;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  width: 350px;
  height: 480px;
  display: none; /* 기본은 숨김 */
  z-index: 1000;
  border-radius: 20px;
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
    <!-- 알림 목록 영역 시작 -->
    <div class="notification_area" style="height: 430px;">
        <div class="notification_list_wrap" id="alarmDetailBox" style="overflow-y: auto; height: 100%;">
            <!-- 알림내용 자리 -->
            <!-- ${userVO} -->
        </div>
    </div>
    <!-- 알림 목록 영역 끝 -->

<script>
    
let isAlarmOpen = false; // 알림창 초기값
const userNoAlarm='${userVO.userNo}';
const badgeYn = document.querySelector('.badgeNoti');

//읽지 않은 알림 있는지 확인
axios.post('/oho/alarm/empCheckEnum?empNo='+userNoAlarm).then(resp=>{
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
        axios.post('/oho/alarm/empReadEnum?empNo='+userNoAlarm).then(resp=>{
        	//Y 처리 성공하면 빨간 불 없애기 
        	if(resp.data !=0){
        		badgeYn.style.display='none';
        	}
        })
        alarmDetail();
    }
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

function alarmDetail() {
console.log(userNoAlarm);
    axios.post("/oho/alarm/empDetailList?memNo="+userNoAlarm).then(resp=>{
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
            console.log(alarm);
            const li = document.createElement('li');
            li.innerHTML = `<div style="display: flex; align-items: center; gap: 5px;">
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

            if(alarm.notiOrgTb=='ATRZ_LINE'){
                li.onclick = () => { 
                    window.location.href = "/emp/atrzDocDetail?atrzDocNo="+alarm.empOrgNo; //기안문서 상세로 넘기기
                };
            };
            alarmDetailBoxDiv.appendChild(li);
        });
        
    });

};
</script>
</body>
</html>