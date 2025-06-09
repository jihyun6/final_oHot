<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang='ko'>
  <head>
  <%@include file="../header.jsp" %>
    <meta charset='utf-8' />
    <title>${artistScheduleVOList[0].artGroupNm} 스케쥴</title>
    
    <!-- FullCalendar CDN -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
    
    <!-- jQuery & Axios -->
    <script src="/js/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/main.min.css" rel="stylesheet" />

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
      body {
        padding: 20px;
        background-color: #f8f9fa;
      }
      #external-events .fc-event {
        cursor: grab;
        margin-bottom: 10px;
        padding: 8px 12px;
        background-color: #0d6efd;
        color: white;
        border-radius: 5px;
      }
      #calendar {
        min-height: 600px;
      }
    </style>


  </head>
  <body>
  <form id="artistInfo" name="artistInfo">
  	<input type="hidden" id="artistScheduleVOList" name="artistScheduleVOList" value="${artistScheduleVOList }">
  </form>
   ${artistScheduleVOList}
    <div class="container">
      <h1 class="mb-4 text-center fw-bold">📅${artistScheduleVOList[0].artGroupNm} 아티스트 일정 관리</h1>
      <div class="row">
        <!-- 외부 이벤트 목록 -->
        <div class="col-md-3 mb-4">
          <div class="card shadow-sm">
            <div class="card-header bg-primary text-white fw-bold">
              ${artistScheduleVOList[0].artGroupNm}
            </div>
             <div class="card-body" id="external-events">
            <c:forEach var="artistScheduleVO" items="${artistScheduleVOList}">
             	 <div class="fc-event" data-title="${artistScheduleVO.artActNm }">${artistScheduleVO.artActNm }</div>
            </c:forEach>
             </div>
         </div>
	   </div>
        <!-- FullCalendar -->
        <div class="col-md-9">
          <div class="card shadow-sm">
            <div class="card-header bg-success text-white fw-bold">
              일정 캘린더
            </div>
            <div class="card-body">
              <div id="calendar"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
<!-- Bootstrap 5 모달 -->
<div class="modal fade" id="eventDetailModal" tabindex="-1" aria-labelledby="eventDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="eventDetailModalLabel">일정 상세보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <form id="eventForm" name="frm" action="/oho/community/addSchedule" method="post">
        	<input type="hidden" name="artGroupNo" value="${artistScheduleVOList[0].artGroupNo}">
        	<input type="hidden" name="artGroupNm" value="${artistScheduleVOList[0].artGroupNm}">
          <div class="mb-3">
            <label for="eventTitle" class="form-label">Artist</label>
            <input type="text" name="artActNm" class="form-control" id="eventTitle" readonly>
          </div>
          <div class="mb-3">
            <label for="eventStart" class="form-label">시작일</label>
            <input type="date" name="startDate" class="form-control" id="eventStart">
          </div>
          <div class="mb-3">
            <label for="eventEnd" class="form-label">종료일</label>
            <input type="date" name="endDate" class="form-control" id="eventEnd">
          </div>
          <div class="mb-3">
            <label for="eventDesc" class="form-label">내용</label>
            <textarea class="form-control" name="description" id="eventDesc" rows="3" placeholder="세부 내용을 입력하세요"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="saveEventBtn">저장</button>
        <button type="button" class="btn btn-danger" id="deleteEventBtn">삭제</button>
      </div>
    </div>
  </div>
</div>
<script>
  let selectedEvent = null; // 클릭한 이벤트 저장용
  const serverEventList = [
	    <c:forEach var="item" items="${artistScheduleVOList}" varStatus="status">
	      {
	        title: "${item.artActNm}",
	        start: "${item.startDate}",   // yyyy-MM-dd 형태
	        end: "${item.endDate}",
	        description: "${item.description}"
	      }<c:if test="${!status.last}">,</c:if>
	    </c:forEach>
	  ];
$(function(){
	getSchedule();
})
  function getSchedule(){
    console.log("스케쥴 : ",serverEventList);
  }
	function renderFixedMembers() {
	  const members = ["Karina", "Winter", "Ningning", "Zezel"];
	  const container = document.getElementById("external-events");
	  container.innerHTML = ''; // 💡 먼저 비우기

	  members.forEach(name => {
		  const div = document.createElement("div");
		  div.className = "fc-event";
		  div.innerText = name;
		  div.dataset.title = name; // 이걸 넣어줘야 drop 이벤트에서 사용 가능
		  container.appendChild(div);
		});
	}

	document.addEventListener('DOMContentLoaded', function () {
		  // 🔥 초기화 시점에서 외부 이벤트 강제 초기화
		  renderFixedMembers(); // << 이게 중요함!

		  new FullCalendar.Draggable(document.getElementById('external-events'), {
		    itemSelector: '.fc-event',
		    eventData: function (eventEl) {
		      return { title: eventEl.innerText }; // dataset.title → innerText로 변경
		    }
		  });

    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      editable: true,
      droppable: true,
      timeZone:'local',
      selectable:true,
      selectMirror:true,
	  unselectAuto:true,
	  events: serverEventList,
      eventClick: function (info) {
        const event = info.event;
        selectedEvent = event;

        document.getElementById("eventTitle").value = event.title;
        document.getElementById("eventStart").value = event.start?.toISOString().slice(0, 10) || '';
        document.getElementById("eventEnd").value = event.end?.toISOString().slice(0, 10) || '';
        document.getElementById("eventDesc").value = event.extendedProps.description || '';

        const modal = new bootstrap.Modal(document.getElementById('eventDetailModal'));
        modal.show();
      },

      drop: function (info) {
    	  alert("일정이 '" + info.draggedEl.dataset.title + "'로 추가되었습니다.");

    	  // 오늘 날짜로 시작일 지정
    	  const today = new Date().toISOString().slice(0, 10);
    	  document.getElementById("eventStart").value = today;
    	  document.getElementById("eventEnd").value = today;
    	}
    });

    calendar.render();

    // 저장 버튼 클릭 시
document.getElementById("saveEventBtn").addEventListener("click", function () {
  if (selectedEvent) {
    let start = document.getElementById("eventStart").value;
    let end = document.getElementById("eventEnd").value;

    // start, end 모두 1일씩 추가
    const startDateObj = new Date(start);
    const endDateObj = new Date(end);
    startDateObj.setDate(startDateObj.getDate()+1);
    endDateObj.setDate(endDateObj.getDate()+1);

    const newStart = startDateObj.toISOString().slice(0, 10);
    const newEnd = endDateObj.toISOString().slice(0, 10);

    selectedEvent.setStart(newStart);
    selectedEvent.setEnd(newEnd);
    selectedEvent.setProp("title", document.getElementById("eventTitle").value);
    selectedEvent.setExtendedProp("description", document.getElementById("eventDesc").value);

    bootstrap.Modal.getInstance(document.getElementById('eventDetailModal')).hide();
    document.forms["frm"].submit();
  }
});

    // 삭제 버튼 클릭 시
    document.getElementById("deleteEventBtn").addEventListener("click", function () {
      if (selectedEvent && confirm("정말 이 일정을 삭제하시겠습니까?")) {
        selectedEvent.remove();
        bootstrap.Modal.getInstance(document.getElementById('eventDetailModal')).hide();
      }
    });
  });
</script>
  </body>
</html>
