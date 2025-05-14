<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
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

</style>
</head>
<body class="g-sidenav-show  bg-gray-100">

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.usersVO" var="userVO"/>    
</sec:authorize>
  
  <!-- 사이드바 -->
  <%@ include file="./sidebar.jsp"%>
  
  <!-- 컨텐츠 -->
  <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
      <!-- 헤더 -->
      <%@ include file="./header.jsp"%>
        <div class="container-fluid py-2">
        	<div id='calendar'></div>
        	<input type="hidden" id="role" value="${userVO.userAuthList[0].authNm}">
        </div>
        



       <form id="myForm" action="/emp/addPersnalSchedule" method="post">
		<div class="modal fade" id="scheduleModal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modalTitle"></h5>
		      </div>
		      <div class="modal-body">
		          <div class="mb-3">
		            <label for="startDate" class="form-label">제목</label>
		            <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요.">
		          </div>
		          <div class="mb-3">
		            <label for="startDate" class="form-label">시작일자</label>
		            <input type="date" name="startDate" class="form-control">
		          </div>
		          <div class="mb-3">
		            <label for="endDate" class="form-label">종료일자</label>
		            <input type="date" name="endDate" class="form-control">
		          </div>
		          <div class="mb-3">
		            <label for="description" class="form-label">내용</label>
		            <textarea class="form-control" name="description" rows="3" placeholder="세부 내용을 입력하세요"></textarea>
		          </div>
		          <div class="mb-3">
		            <label>배경색상 : <input type="color" name="backgroundColor" value="#FFD700" /></label><br/>
		          </div>
		          <div class="mb-3">
		  			<label>글자색상 : <input type="color" name="textColor" value="#000000" /></label><br/>
		          </div>
		      </div>
		      <div class="modal-footer">
		        <button class="btn btn-info" id="saveBtn">저장</button>
		        <button type="button" class="btn btn-danger" id="deleteBtn" style="display:none;">삭제</button>
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

document.addEventListener('DOMContentLoaded', function() {
	
	const customButtons = {
	  myCustomButton1: {
	    text: '개인일정등록',
	    click: function () {
	      document.getElementById("modalTitle").innerText = "개인 일정 등록";
	      document.getElementById("myForm").action = "/emp/addPersnalSchedule";
	      scheduleOpen();
	    }
	  }
	};

	if (userRole === "ROLE_ADMIN") {
	  customButtons.myCustomButton2 = {
	    text: '부서일정등록',
	    click: function () {
	      document.getElementById("modalTitle").innerText = "부서 일정 등록";
	      document.getElementById("myForm").action = "/emp/addCommonSchedule";
	      scheduleOpen();
	    }
	  };
	}
	
	// 버튼 배열 설정
	let leftButtons = "prev,next today myCustomButton1";
	if (userRole === "ROLE_ADMIN") {
	  leftButtons += " myCustomButton2";
	}
	
	axios.get("/emp/fullcalendar").then(resp => {
		console.log("resp:data", resp.data );
		
		const personalSchedules = resp.data.persnalScheduleVOList;
	    const departmentSchedules = resp.data.departmentScheduleVOList;
	    
	    const totaldSchedules = personalSchedules.concat(departmentSchedules);
	    
	    totaldSchedules.forEach(schedule=>{
			serverEventList.push(schedule);
		})
		
		console.log("serverEventList : ", serverEventList);
	
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	  initialView: 'dayGridMonth',
    	  contentHeight: 700,
    	  selectable: true,
    	  events: serverEventList,
    	  eventAllow: function(dropInfo, draggedEvent) {
   		    // 관리자가 아니고 부서일정이면 false
   		    console.log("department : ",draggedEvent.extendedProps.type );
   		    if (userRole !== "ROLE_ADMIN" && draggedEvent.extendedProps.type === "department") {
   		      return false;
   		    }
   		    return true;
   		  },
    	  editable: true,
    	  customButtons: customButtons,
   		  headerToolbar: {
   				left: leftButtons,
   			    center: 'title',
   			    right: 'dayGridMonth,timeGridWeek,timeGridDay'
 		 },
 		 themeSystem: 'bootstrap5',
		 eventClick: function (info) {
 	       const event = info.event;
 	       const eventType = info.event.extendedProps.type;
 	       if(eventType === "department") {
	 	       if (userRole !== "ROLE_ADMIN") {
	 	          document.getElementById("saveBtn").style.display = "none";
	 	          document.getElementById("deleteBtn").style.display = "none";
	 	        } else {
	 	        	
 	        	  const input = document.createElement("input");
 			   	  input.type="hidden";
 			   	  input.id="departmentScheduleNo";
 			   	  input.name="departmentScheduleNo";
 			   	  input.value = event.extendedProps.departmentScheduleNo;
 			   	  
 			   	  const form = document.getElementById("myForm");
 			   	  form.appendChild(input);
 			   	  
 			   	  document.getElementById("myForm").action = "/emp/editDepartmentSchedule";
	 	          document.getElementById("saveBtn").style.display = "block";
	 	          document.getElementById("deleteBtn").style.display = "block";
	 	        }
	 	       
 	      	document.getElementById("modalTitle").innerText = "부서 일정 상세";
	 	    document.querySelector("input[name=title]").value = event.title;
 	        document.querySelector("input[name=startDate]").value = event.start?.toLocaleDateString('sv-SE') || '';
 	        document.querySelector("input[name=endDate]").value = event.end?.toISOString().slice(0, 10) || '';
 	        document.querySelector("textarea[name=description]").value = event.extendedProps.description;
 	        document.querySelector("input[name=backgroundColor]").value = event.backgroundColor;
 	        document.querySelector("input[name=textColor]").value = event.textColor;
	 	      
	 	    scheduleOpen();
 	       }
 	       else {
 	    	   
 	        const input = document.createElement("input");
		   	input.type="hidden";
		   	input.id="persnalScheduleNo";
		   	input.name="persnalScheduleNo";
		   	input.value = event.extendedProps.persnalScheduleNo;
		   	
		   	// 폼태그 안에 persnalScheduleNo 번호 넣기
		   	const form = document.getElementById("myForm");
		   	form.appendChild(input);
		   	
		   	console.log("체킁 : ",event.start);
		   	console.log("체킁 : ",event.start?.toISOString().slice(0, 10));
 	        
 	        document.getElementById("modalTitle").innerText = "개인 일정 상세";
 	        document.getElementById("myForm").action = "/emp/editPersnalSchedule";
 	        document.getElementById("deleteBtn").style.display = "block";
 	        document.querySelector("input[name=title]").value = event.title;
 	        document.querySelector("input[name=startDate]").value = event.start?.toLocaleDateString('sv-SE') || '';
 	        document.querySelector("input[name=endDate]").value = event.end?.toISOString().slice(0, 10) || '';
 	        document.querySelector("textarea[name=description]").value = event.extendedProps.description;
 	        document.querySelector("input[name=backgroundColor]").value = event.backgroundColor;
 	        document.querySelector("input[name=textColor]").value = event.textColor;
 	        
 	       scheduleOpen();
 	       }
 	      }
    	});
    calendar.render();
	})
  });
  
function scheduleOpen() {
	 const modal = new bootstrap.Modal(document.getElementById("scheduleModal"));
     modal.show();
}

const modalElement = document.getElementById("scheduleModal");
modalElement.addEventListener("hidden.bs.modal", function () {
  document.getElementById("deleteBtn").style.display = "none";
  if(document.getElementById("persnalScheduleNo")){
	  document.getElementById("persnalScheduleNo").remove();
  }
  if(document.getElementById("departmentScheduleNo")){
	  document.getElementById("departmentScheduleNo").remove();
  }
  document.querySelector("input[name=title]").value = "";
  document.querySelector("input[name=startDate]").value = "";
  document.querySelector("input[name=endDate]").value = "";
  document.querySelector("textarea[name=description]").value = "";
  document.querySelector("input[name=backgroundColor]").value = "#FFD700";
  document.querySelector("input[name=textColor]").value = "#000000";
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
			
			const persnalScheduleNo = document.getElementById("persnalScheduleNo").value;
			
			axios.get("/emp/deletePersnalSchedule?persnalScheduleNo="+persnalScheduleNo).then(resp => {
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
</script>
</body>
</html>