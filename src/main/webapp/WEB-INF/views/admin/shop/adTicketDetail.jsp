<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
 		initialView : 'dayGridMonth',
 		timeZone:'local',
 		now:'${goodsVO.ticketVO.tkStartYmd}',
		headerToolbar : {
			left:'prev',
			center:'title',
			right:'next'
		},
		height : "auto",
		events : [
			<c:forEach items="${goodsVO.ticketVO.tkDetailVOList}" var="tkDetailVO">
			{
				title: '${fn:substring(tkDetailVO.tkRound, 0, 2)}:${fn:substring(tkDetailVO.tkRound, 2, 4)} 공연',
				start: '${tkDetailVO.tkYmd}'
			},
			</c:forEach>
			{}
		],

		select: function(info){
			console.log(info.startStr+"~"+info.endStr);
			$('#startDate').val(info.startStr);
			$('#eventModal').show();
		},
		windowResize : true,

	
	})
	calendar.render();


});
</script>
<style type="text/css">

	.fc-col-header-cell-cushion {
		color: black;
	}
	
	.fc-day-sun .fc-col-header-cell-cushion {
		color: red;
	}
	
	.fc-day-sat .fc-col-header-cell-cushion {
		color: blue;
	}
	.fc-day-today {
    background-color: #f8f9fa !important; 
	}

</style>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">	
	<c:set var="title" value="공연/티켓관리 &ensp;>&ensp; 상세정보조회"></c:set>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<fmt:formatNumber var="formattedVprice" value="${goodsVO.ticketVO.tkVprice}" type="number" />
	<fmt:formatNumber var="formattedRprice" value="${goodsVO.ticketVO.tkRprice}" type="number" />
	<fmt:formatNumber var="formattedSprice" value="${goodsVO.ticketVO.tkSprice}" type="number" />
	<!-- 컨텐츠-->
<div class="content-wrapper">
		<div class="row" style="padding: 30px">
			<div class="col-sm-2" style="text-align: center">
				<div>
					</br>
				</div>
				<div id="poster" >
					<b>공연 포스터</b>
					<img alt="경로확인" src="/upload/${goodsVO.ticketVO.tkFileSaveLocate}" style="width: 100%; height: 350px;" id="posterImg">
				</div>
			</div>
			<div class="col-sm-6 ">
				<div class=row>
					<div class="col-sm-4">
						<c:choose>
						<c:when test="${empty goodsVO.artGroupNo || goodsVO.artGroupNo==0}">
							<button class="btn btn-outline-primary col-sm-12">${goodsVO.artActNm }</button>
						</c:when>
						<c:when test="${empty goodsVO.artNo|| goodsVO.artNo==0}">
							<button class="btn btn-outline-primary col-sm-12">${goodsVO.artGroupNm }</button>
						</c:when>
						</c:choose>
					</div>
					
					<div class="col-sm-4 btn btn-outline-primary ">${goodsVO.ticketVO.tkCtgr }</div>
					<div class="col-sm-4">
						<button class="btn btn-outline-success col-sm-12">${goodsVO.ticketVO.tkStartYmd } ~ ${goodsVO.ticketVO.tkFinishYmd }</button>
						<%-- <select name="ticketVO.tkCtgr" id="tkRound" required class=" btn btn-outline-success dropdown-toggle col-sm-12"  required>
							<option  disabled selected>공연날짜</option>
							<c:forEach var="tkDetailVO" items="${goodsVO.ticketVO.tkDetailVOList }">
								<option >공연날짜: ${tkDetailVO.tkYmd } | ${tkDetailVO.tkRound }</option>
							</c:forEach>
						</select> --%>
					</div>
					
					<div class="col-sm-12 ">
						<br/>
						<b>공연명</b> <input type="text" id="gdsNm" name="gdsNm" class="form-control" value="${goodsVO.gdsNm }" readonly /><br/>
					</div>
					<div class=" col-sm-12">
						<b>공연가격</b>
						<div class="row">
							<div class="col-sm-4 d-flex align-items-center">
								<c:choose>
									<c:when test="${goodsVO.ticketVO.tkRprice ==0 && goodsVO.ticketVO.tkSprice ==0}">
										전석 &ensp;<input type="text" id="tkVprice" name="ticketVO.tkVprice" class="form-control col-sm-8" value="${formattedVprice }" readonly/>원 
									</c:when>
									<c:otherwise>
										VIP석 &ensp;<input type="text" id="tkVprice" name="ticketVO.tkVprice" class="form-control col-sm-8" value="${formattedVprice }" readonly/>원 
									</c:otherwise>
								</c:choose>
							</div>
							<div class="col-sm-4 d-flex align-items-center">
								<c:if test="${goodsVO.ticketVO.tkRprice !=0}">
									|&ensp; R석 &ensp;<input type="text" id="tkRprice" name="ticketVO.tkRprice" class="form-control col-sm-8" value="${formattedRprice }"readonly />원 
								</c:if>
							</div>
							<div class="col-sm-4 d-flex align-items-center">
								<c:if test="${goodsVO.ticketVO.tkSprice !=0}">
									|&ensp; S석 &ensp;<input type="text" id="tkSprice" name="ticketVO.tkSprice" class="form-control col-sm-8" value="${formattedSprice }"readonly />원 
								</c:if>
							</div>
						</div> <br/>
					</div>
					<br/>
					<div class="col-sm-12">
						<b>공연시간(분)</b><input type="number" id="tkRuntime" name="tkRuntime" class="form-control col-sm-12" value="${goodsVO.ticketVO.tkRuntime }" readonly />
					</div>
					
					<div class="col-sm-12" id="ckExplan">
						<c:if test="${not empty goodsVO.expln }">
						<b>상품설명</b> <textarea cols="50" rows="5" id="expln" readonly class="form-control" >${goodsVO.expln }</textarea>
						</c:if>
						<c:if test="${not empty goodsVO.fileGroupNo }">
						<b>상품설명이미지</b> 
						<div class="mt-3" id="newImg" style="width:100%; height: 750px; overflow-y: auto; overflow-x:hidden;">
							<c:forEach var="fileDetail" items="${goodsVO.fileGroupVO.fileDetailVOList}">
								<img alt="경로확인" src="/upload/${fileDetail.fileSaveLocate }" style="width: 100%;" id="explnImg">
							</c:forEach>
						</div>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="col-sm-4">
				
				<div id="calendar" >
					<!-- 캘린더 영역 -->
				</div>
				<div class="col-sm-12" >
					<br/>
					<b>공연장소</b>
					<div class="col-sm-12" id="map" style="width: 100%; height: 350px;">
						<%@ include file="../../ticket/locationRead.jsp"%>
					</div>
				</div>
			</div>
		
			<div class="d-flex justify-content-end mt-3">
				<div>
					<a type="button" class="btn btn-info" href="/admin/shop/adTicketList">목록</a>
					<a type="button" class="btn btn-secondary" onclick="editTk()">수정</a>
					<button type="button" class="btn btn-danger" onclick="deleteTk()">삭제</button>
				</div>
			</div>
			</div>
		</div>
		<!-- 관리자 풋터 -->
			<%@ include file="../adminFooter.jsp"%>
	</div>
</div>
	
</div>
<script>


const gdsNoCur="${goodsVO.gdsNo }";
function editTk(){
	Swal.fire({
	title: "수정하시겠습니까?",
	icon: "warning",
	showCancelButton: true,
	confirmButtonColor: "#3085d6",
	cancelButtonColor: "#d33",
	cancelButtonText: "취소",
	confirmButtonText: "수정"
	}).then((result) => {
	if (result.isConfirmed) {
		window.location.href="/admin/shop/adTicketUpdate?gdsNo="+gdsNoCur;
	}
	});
}
function deleteTk(){
		Swal.fire({
	title: "숨김 처리하시겠습니까?",
	icon: "error",
	showCancelButton: true,
	cancelButtonColor: "#3085d6",
	confirmButtonColor: "#d33",
	cancelButtonText: "취소",
	confirmButtonText: "숨김"
	}).then((result) => {
	if (result.isConfirmed) {
		axios.post("/admin/shop/ticketDelete", {gdsNo:gdsNoCur})
        .then(res => {
          Swal.fire({
			icon: "success",
  			title: "정상적으로 처리되었습니다",
			showConfirmButton: false,
  			timer: 1000
		  }).then(() => {
            // 페이지 새로고침 or 이동
            location.href = "/admin/shop/adTicketList";
          });
        })
        .catch(err => {
          Swal.fire("삭제 실패", "오류가 발생했습니다.", "error");
          console.error(err);
        });
    }
  });
}

</script>
</body>
</html>