<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oHoT EMP</title>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
#calendar {
	width: calc(100vw - 300px);
	max-width: 100%;
}

.fc-scroller, .fc-scrollgrid-sync-table {
	overflow: hidden !important;
}

/* FullCalendar v5~v6 기준 */
.fc .fc-button.btn-all {
  background-color:#2196f3;
  color: white;
  border: 2px #2196f3;
}

/* 호버 스타일도 적용하려면 */
.fc .fc-button.btn-personal:hover {
  background-color: #d32f2f;
}




/* 모달 css */
/* 전체 모달 배경 */
.modal {
  display: none;
  position: fixed;
  z-index: 1050;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
  padding-top: 50px;
}

/* 모달 다이얼로그 박스 */
.modal-dialog {
  background-color: #fff;
  margin: auto;
  padding: 0;
  border-radius: 16px;
  width: 500px;
  box-shadow: 0 0 20px rgba(0,0,0,0.2);
}

/* 헤더 */
.modal-header {
  padding: 16px;
  background-color: #17a2b8;
  color: white;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 본문 */
.modal-body {
  padding: 20px;
}

/* 폼 요소 */
.modal-body .form-label {
  font-weight: bold;
  font-size: 18px;
  display: block;
  margin-bottom: 6px;
}

.modal-body .form-control,
.modal-body input[type="color"],
.modal-body textarea {
  width: 100%;
  padding: 8px;
  font-size: 16px;
  margin-bottom: 16px;
  border: 1px solid #ccc;
  border-radius: 6px;
  box-sizing: border-box;
}

.form-check-inline {
  margin-right: 15px;
}

.form-check-input {
  margin-right: 5px;
}

/* 푸터 */
.modal-footer {
  padding: 16px;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  border-top: 1px solid #ddd;
}

/* 버튼 스타일 */
.modal-footer button {
  padding: 8px 16px;
  font-size: 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

#saveBtn {
  background-color: #17a2b8;
  color: white;
}

#deleteBtn {
  background-color: #dc3545;
  color: white;
}

#testBtn {
  background-color: #6c757d;
  color: white;
}

.modal-footer .btn-secondary {
  background-color: #6c757d;
  color: white;
}
</style>
</head>
<body class="g-sidenav-show  bg-gray-100">

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO" />
	</sec:authorize>

	<!-- 사이드바 -->
	<%@ include file="./sidebar.jsp"%>

	<!-- 컨텐츠 -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- 헤더 -->
		<%@ include file="./header.jsp"%>
		<div class="container-fluid py-2">
			<div id='calendar'></div>
<%-- 			${userVO.employeeVO.position} --%>
			<input type="hidden" id="role" value="${userVO.employeeVO.position}"/>
		</div>




<form id="myForm" action="/emp/addSchedule" method="post">
  <div class="modal fade" id="scheduleModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content shadow-lg rounded-4" style="border:none;">
        <div class="modal-header bg-info text-white">
          <h5 class="modal-title" id="modalTitle" style="color:white;">일정 등록</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <!-- 일정 종류 -->
          <div class="mb-3" id="scheduleType">
            <label class="form-label d-block fw-bold" style="font-size: 18px;">일정 유형</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="type" id="persnal" value="persnal" checked>
              <label class="form-check-label" for="persnal">개인일정</label>
            </div>
            <c:if test="${userVO.employeeVO.position == '이사' }" >
	            <div class="form-check form-check-inline">
	              <input class="form-check-input" type="radio" name="type" id="department" value="department">
	              <label class="form-check-label" for="department">부서일정</label>
	            </div>
            </c:if>
          </div>

          <!-- 제목 -->
          <div class="mb-3">
            <label for="title" class="form-label d-block fw-bold" style="font-size: 18px;">제목</label>
            <input type="text" name="title" class="form-control" id="title" placeholder="제목을 입력하세요." required>
          </div>

          <!-- 시작일자 -->
          <div class="mb-3">
            <label for="startDate" class="form-label d-block fw-bold" style="font-size: 18px;">시작일자</label>
            <input type="date" name="startDate" class="form-control" id="startDate">
          </div>

          <!-- 종료일자 -->
          <div class="mb-3">
            <label for="endDate" class="form-label d-block fw-bold" style="font-size: 18px;">종료일자</label>
            <input type="date" name="endDate" class="form-control" id="endDate">
          </div>

          <!-- 내용 -->
          <div class="mb-3">
            <label for="description" class="form-label d-block fw-bold" style="font-size: 18px;">내용</label>
            <textarea class="form-control" name="description" id="description" rows="3" placeholder="세부 내용을 입력하세요"></textarea>
          </div>

          <!-- 색상 선택 -->
          <div class="mb-3 d-flex gap-3">
            <div>
              <label for="backgroundColor" class="form-label d-block fw-bold" style="font-size: 18px;">배경색상</label>
              <input type="color" name="backgroundColor" id="backgroundColor" value="#d4d4d4">
            </div>
            <div>
              <label for="textColor" class="form-label d-block fw-bold" style="font-size: 18px;">글자색상</label>
              <input type="color" name="textColor" id="textColor" value="#fff">
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" id="testBtn" style="display: none;">시연용</button>
          <button type="submit" class="btn btn-info" id="saveBtn">저장</button>
          <button type="button" class="btn btn-danger" id="deleteBtn" style="display: none;">삭제</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</form>


		<!-- 풋터 -->
		<%@ include file="./footer.jsp"%>
	</main>


	<script>
let serverEventList = [];
const userRole = document.getElementById("role").value;
console.log("userRole ; ", userRole);

document.addEventListener('DOMContentLoaded', function() {
	
	axios.get("/emp/fullcalendar").then(resp => {
		console.log("resp:data", resp.data);
		
		const schedules = resp.data;
		schedules.forEach(schedule=>{
			serverEventList.push(schedule);
		})
		
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	  initialView: 'dayGridMonth',
    	  contentHeight: 700,
    	  selectable: true,
    	  dateClick: function(i) {
    	      console.log("클릭한 날짜: ", i.dateStr);
    	      
    	      document.getElementById("testBtn").style.display = "block";
    	      document.querySelector("input[name=startDate]").value = i.dateStr;
   	          document.querySelector("input[name=endDate]").value = i.dateStr;
			  scheduleOpen();
    	    },
    	  events: serverEventList,
    	  editable: true,
    	  customButtons: {
    		  myCustomButton1: {
    		    text: '개인',
    		    click: function () {
   		    		calendar.getEventSources().forEach(source => source.remove());
   		    		
   		    		const persnalSchedules = [];
   		    		schedules.forEach(schedule => {
   		    			if(schedule.type == "persnal" ) {
   		    				persnalSchedules.push(schedule);
   		    			}
   		    		})
   		    	    calendar.addEventSource(persnalSchedules);
    		    }
    		  },
    		  myCustomButton2: {
    		    text: '부서',
    		    click: function () {
   		    		calendar.getEventSources().forEach(source => source.remove());
					
   		    		const departmentSchedules = [];
   		    		schedules.forEach(schedule => {
   		    			if(schedule.type == "department" ) {
   		    				departmentSchedules.push(schedule);
   		    			}
   		    		})
   		    	    calendar.addEventSource(departmentSchedules);
    		    }
    		  },
    		  myCustomButton3: {
    		    text: '전체',
    		    click: function () {
   		    		calendar.getEventSources().forEach(source => source.remove());
   		    	    calendar.addEventSource(schedules);
    		    }
    		  }
    	  },
   		  headerToolbar: {
   				left: 'prev,next today myCustomButton3 myCustomButton2 myCustomButton1',
   			    center: 'title',
   			    right: 'dayGridMonth,timeGridWeek,timeGridDay'
 		 },
 		 themeSystem: 'bootstrap5',
		 eventClick: function (info) {
 	      	const event = info.event;
 	      	const eventType = info.event.extendedProps.type;
 	       
 	      	document.getElementById("myForm").action = "/emp/eidtEmployeeSchedule";
 	       
 	      	const input = document.createElement("input");
	   	 	input.type="hidden";
	   	  	input.id="employeeScheduleNo";
	   	  	input.name="employeeScheduleNo";
	   	  	input.value = event.extendedProps.employeeScheduleNo;
	   	  
	   	 	const form = document.getElementById("myForm");
	   	 	form.appendChild(input);
 	       
          	document.getElementById("scheduleType").style.display = "none";
          
	 	    document.querySelector("input[name=title]").value = event.title;
 	        document.querySelector("input[name=startDate]").value = event.start?.toLocaleDateString('sv-SE') || '';
 	        document.querySelector("input[name=endDate]").value = event.end?.toISOString().slice(0, 10) || '';
 	        document.querySelector("textarea[name=description]").value = event.extendedProps.description;
 	        document.querySelector("input[name=backgroundColor]").value = event.backgroundColor;
 	        document.querySelector("input[name=textColor]").value = event.textColor;
 	       
 	       if(eventType === "department") {
	 	       if (userRole !== "이사") {
	 	          document.getElementById("testBtn").style.display = "none";
	 	          document.getElementById("saveBtn").style.display = "none";
	 	          document.getElementById("deleteBtn").style.display = "none";
	 	        } else {
	 	          document.getElementById("saveBtn").style.display = "block";
	 	          document.getElementById("deleteBtn").style.display = "block";
	 	        }
	 	      	document.getElementById("modalTitle").innerText = "부서 일정 상세";
 	       }else {
	 	        document.getElementById("modalTitle").innerText = "개인 일정 상세";
	 	        document.getElementById("deleteBtn").style.display = "block";
 	       }
	 	       	scheduleOpen();
 	      }
    	});
    calendar.render();
    
    document.querySelector('.fc-myCustomButton3-button')?.classList.add('btn-all');
	})
  });
  
function scheduleOpen() {
	 const modal = new bootstrap.Modal(document.getElementById("scheduleModal"));
     modal.show();
}

const modalElement = document.getElementById("scheduleModal");
modalElement.addEventListener("hidden.bs.modal", function () {
  document.getElementById("deleteBtn").style.display = "none";
  document.getElementById("saveBtn").style.display = "block";
  if(document.getElementById("employeeScheduleNo")){
	  document.getElementById("employeeScheduleNo").remove();
  }
  document.getElementById("myForm").action = "/emp/addSchedule";
  document.getElementById("modalTitle").innerText = "일정 등록";
  document.getElementById("scheduleType").style.display = "block";
  document.querySelector("input[name=title]").value = "";
  document.querySelector("input[name=startDate]").value = "";
  document.querySelector("input[name=endDate]").value = "";
  document.querySelector("textarea[name=description]").value = "";
  document.querySelector("input[name=backgroundColor]").value = "#d4d4d4";
  document.querySelector("input[name=textColor]").value = "#000000";
  document.getElementById("testBtn").style.display = "none";
});

document.getElementById("deleteBtn").addEventListener("click", ()=> {
	Swal.fire({
		  title: "정말 삭제 하시겠습니까?",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "네",
		  cancelButtonText: "아니오"
		}).then((result) => {
		  if (result.isConfirmed) {
			
			const employeeScheduleNo = document.getElementById("employeeScheduleNo").value;
			
			axios.get("/emp/deleteEmployeeSchedule?employeeScheduleNo="+employeeScheduleNo).then(resp => {
				if(resp.data == "success") {
					Swal.fire({
					      title: "삭제 되었습니다.",
					      icon: "success"
				    }).then(()=>{
				    	
						location.href = "/emp/home";
						
				    });
				}
			})
		  }
		});
})

document.getElementById("testBtn").addEventListener("click", ()=> {
	document.querySelector("input[name=title]").value = "대덕 404호 수료";
	document.querySelector("textarea[name=description]").value = "404호 7개월 동안 수고 많으셨습니다.";
	document.querySelector("input[name=backgroundColor]").value = "#FFBF00";
	document.querySelector("input[name=textColor]").value = "#000000";
})
</script>
</body>
</html>