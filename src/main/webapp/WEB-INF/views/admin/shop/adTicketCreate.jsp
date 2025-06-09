<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

</head>
<body class="sidebar-mini layout-fixed" style="height: auto;">
<div class="wrapper">	
	<c:set var="title" value="공연/티켓관리 &ensp;>&ensp; 공연정보등록"></c:set>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO"/>
	</sec:authorize>

	<!-- 메인페이지 컨텐츠-->
<div class="content-wrapper">
	<form name="saveForm" id="saveForm" enctype="multipart/form-data">
	<div class="form-group " style="padding: 30px;">
		<div class="row">
			<div class="col-sm-2" style="text-align: center">
				<div>
					<a></a><br>
				</div>
				<div id="poster" style="width: 100%; height: 300px; border: 1px solid lightblue; border-radius: 10px;" >
					<p style="color: gray;"><br><br>포스터 이미지를<br> 등록하세요</p>
				</div>
				<br>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#posterModal" id="addPoster" > 포스터이미지 등록 </button>
				<br>
				<button type="button" class="btn btn-secondary mt-1" data-toggle="modal" onClick="testBtn()" > 시연용 </button>
			</div>
			<div class="col-sm-5 ">
				<div class=row>
					<span style="color: red;">* 표시는 반드시 입력하세요</span>
					<div class="col-sm-4">
						<select name="gdsType" id="gdsType" required onchange="toggleGdsType()" class=" btn btn-secondary form-select col-sm-12">
							<option disabled selected value="" >상품타입 *</option>
							<option value="G" class="dropdown-item" >그룹상품</option>					
							<option value="I" class="dropdown-item" >아티스트상품</option>					
						</select>
					</div>
					<div class="col-sm-4">
						<select  class=" btn btn-secondary form-select col-sm-12" id="selectGoods" ><option >상품타입을 선택하세요 *</option></select>
						<select name="artGroupNo" id="artGroupNo" required style="display: none;" class=" btn btn-secondary form-select col-sm-12" > 
							<option disabled selected value="">그룹 선택 *</option>
							<c:forEach items="${artistGroupVOList }" var="artist">
								<option value="${artist.artGroupNo }"  >${artist.artGroupNm }</option>					
							</c:forEach>
						</select>
						<select name="artNo" id="artNo" required style="display: none;" class=" btn btn-secondary form-select col-sm-12" >
							<option disabled selected value="" >아티스트 선택 *</option>
							<c:forEach items="${artistVOList }" var="artist">
								<option value="${artist.artNo }" >${artist.artActNm }</option>					
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-4">
						<select name="ticketVO.tkCtgr" id="tkCtgr" required class=" btn btn-secondary form-select col-sm-12">
							<option disabled selected value="">공연분류 *</option>
							<option value="콘서트" >콘서트</option>
							<option value="팬미팅" >팬미팅</option>
							<option value="기타" >기타</option>
						</select>
					</div>
					
					
					<div class="col-sm-12 ">
						<br/>
						<b>공연명<span style="color: red">*</span></b> <input type="text" id="gdsNm" name="gdsNm" class="form-control" required /><br/>
					</div>
					<div class=" col-sm-12">
					 	<b>공연가격<span style="color: red">*</span></b>
						<div class="row">
						<div class="col-sm-4">VIP석<span style="color: red">*</span> <input type="number" id="tkVprice" name="unitPrice" class="form-control " required placeholder="120000"/></div>
						<div class="col-sm-4">R석 <input type="number" id="tkRprice" name="ticketVO.tkRprice" class="form-control" placeholder="필요시 입력" value="0"/></div>
						<div class="col-sm-4">S석<input type="number" id="tkSprice" name="ticketVO.tkSprice" class="form-control" placeholder="필요시 입력" value="0"/></div>
						</div> <br/>
					</div>
					<div class="col-sm-12" id="tkRuntime">
						<b>공연시간(분)<span style="color: red">*</span></b> <input type="number" id="tkRuntime" name="ticketVO.tkRuntime" class="form-control" required placeholder="120"/><br/>
					</div>
					
					<div class="col-sm-12" id="ckExplan">
						<b>상품설명이미지등록</b>
						<input type="file" id="uploadFile" name="uploadFile"  class="form-control" onchange="readFileExpln(this)" multiple/>
						<div class="mt-3" id="newImg" style="width:100%; height: 600px; overflow-y: auto; overflow-x:hidden; border: 0.5px solid lightblue; border-radius: 10px; color: gray; text-align: center;">
							<br><br>상품설명 이미지를 등록하세요
						</div><br/>
						<!-- <b>상품설명</b> <textarea cols="50" rows="5" id="expln" name="expln" class="form-control" ></textarea> -->
					</div>
					<input type="hidden" name="commCodeGrpNo" id="commCodeGrpNo" value="GD02"/>

				</div>
			</div>
			
			<div class="col-sm-5">
				<div id="calendar" >
					<!-- 캘린더 영역 -->
					 <a style="color: red;">* 오늘 날짜 이후만 등록가능합니다 *</a>
				</div>
				<div class="col-sm-12" >
					<br/>
					<b>공연장소</b>
					<%@ include file="./location.jsp"%>
				</div>

			</div>
		</div>
		<div class="d-flex justify-content-between  mt-5">
			<a class="btn btn-secondary" href="/admin/shop/adTicketList">목록보기</a>
			<button type="submit" class="btn btn-primary" id="saveBtn" >저장</button>
		</div>
	</div>
	</form>
</div>
	
<!-- The Modal -->
	<div class="modal" id="posterModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
		<!-- Modal Header -->
		<div class="modal-header">
			<h4 class="modal-title">포스터등록</h4>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		
		<!-- Modal body -->
		<div class="modal-body">
			<input type="file" id="uploadFilePoster" name="uploadFilePoster"  class="form-control profile-img"  onchange="readFile(this)"/>
			<img alt="사진을 선택해주세요" id="posterImgPrev" style="width: 100%; height: 500px;">
		</div>
		
		<!-- Modal footer -->
		<div class="modal-footer">
			<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="posterImg()">저장</button>
		</div>
		
		</div>
	</div>
	</div>
	
<!-- The Modal -->
<div class="modal" id="eventModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
		<!-- Modal Header -->
		<div class="modal-header">
			<h4 class="modal-title">공연일정등록</h4>
			<button type="button" class="close" data-dismiss="modal" onclick="closeModal()">&times;</button>
		</div>
		
		<!-- Modal body -->
		<div class="modal-body">
			공연날짜 <input type="date" id="startDate" required>
			공연시간 <select id="startTime" ></select> : <select id="min">
															<option value="00">00</option>
															<option value="10">10</option>
															<option value="20">20</option>
															<option value="30">30</option>
															<option value="40">40</option>
															<option value="50">50</option>
													   </select>
		</div>
		
		<!-- Modal footer -->
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal()">취소</button>
			<button type="button" class="btn btn-danger" onclick="deleteEvent()">삭제</button>
			<button type="button" class="btn btn-primary" onclick="addEvent()">저장</button>
		</div>
		
		</div>
	</div>
</div>

<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
	
</div>

<script type="text/javascript">
let eventIndex = 0; // 전역에서 관리
let selectedEvent=null;
document.querySelectorAll("select[required], input[required]").forEach(el => {
    el.addEventListener("blur", function () {
      if (!el.value) {
        el.style.border = "2px solid red !important";
      } else {
        el.style.border = "";
      }
    });
  });

	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			 initialView : 'dayGridMonth',
			 timeZone:'local',
			headerToolbar : {
				left:'prev',
				center:'title',
				right:'next'
			},
			height : "auto",
			events : [],
			selectable : true,
			selectMirror : true,
			selectConstraint:{
				start: new Date(),
				end: '9999-12-31'
			},
			select: function(info){
				console.log(info.startStr+"~"+info.endStr);
				$('#startDate').val(info.startStr);
				$('#eventModal').show();
			},
			windowResize : true,
			/* dateClick : function(info) {
				console.log("클릭한 날짜"+info.dateStr)
				calendar.addEvent({title:"glgl", start: info.dateStr})
			}  */
		
			eventClick: function (info) {
			selectedEvent = info.event; // 수정할 이벤트 저장
				console.log(JSON.stringify(selectedEvent)+"뭐지");
			const start = selectedEvent.start;
			const hours = selectedEvent.title.split(":")[0]; // "10"
			const minutes = String(start.getMinutes()).padStart(2, '0');

			$('#startDate').val(start.toISOString().slice(0, 10));
			$('#startTime').val(hours);
			$('#min').val(minutes);
			$('#eventModal').show();
			},
			windowResize: true
		
		})
		calendar.render();
	
		window.addEvent = ()=> {
			var start = $('#startDate').val();
			var time = $('#startTime').val();
			var min =$('#min').val();
			var gdsNm = $('#gdsNm').val();
	// 		console.log(min);
	// 		console.log("rhkdus"+typeof start);
	
			if (time) {
				const newEventId = `event-\${eventIndex++}`; // 유니크 ID 생성
				calendar.addEvent({
					id: newEventId, // 고유 ID
					title: time+":"+min+" 공연",
					start: start,
					extendedProps: {
						tkYmd: start.split('-').join(''),
						tkRound : time+min,
						gdsNm: gdsNm
					}
				});
				console.log("잘려라"+start.split('-').join(''));
			}
			const titles = calendar.getEvents().map(event => event.extendedProps);
	// 			console.log(typeof titles[0].tkYmd + "제발 롱타입이어라");
	// 			console.log(typeof titles[0].tkRound + "제발 롱타입이어라");
	// 			console.log(typeof titles[0].gdsNm + "제발 롱타입이어라");
				console.log("무슨타입"+JSON.stringify(calendar.getEvents().map(event => event.extendedProps)));
			$('#eventModal').hide();
			
		}

		window.deleteEvent = () => {
    if (selectedEvent) {
      selectedEvent.remove();
	  selectedEvent = null;
      $('#eventModal').hide();
    }
  };
		window.closeModal = function () {
			$('#eventModal').hide();
		}
		
		$(document).ready(function () {
			$('#saveBtn').click(function (event) {
				event.preventDefault();
				//console.log("✅ 현재 캘린더에 추가된 이벤트 목록:"+ eventList);
				
				// 공연일정없을 때
				const eventList =calendar.getEvents().map(event => event.extendedProps);
				if (eventList.length === 0) {
					alert("⚠ 공연 일정을 한 개 이상 등록해야 저장할 수 있습니다.");
					return;
				}


				// HTML5 기본 유효성 검사 실행
				const formAll = document.querySelector('#saveForm');
				if (!formAll.checkValidity()) {
					formAll.reportValidity(); // 브라우저 기본 경고 메시지 출력
					return;
				}
				else{
									
				
				eventList.sort((a,b) => Number(a.tkYmd) -Number(b.tkYmd) || Number(a.tkRound) - Number(b.tkRound) );
				//eventList = JSON.stringify(eventList);
				console.log( JSON.stringify(eventList[eventList.length-1].tkYmd)+"22222");
				
				var inputStartYmd = document.createElement('input')
				inputStartYmd.setAttribute("name","ticketVO.tkStartYmd")
				inputStartYmd.setAttribute("value",eventList[0].tkYmd);
				inputStartYmd.setAttribute("type","hidden");
				document.querySelector('#poster').appendChild(inputStartYmd);
				
				var inputFinishYmd = document.createElement('input')
				inputFinishYmd.setAttribute("name","ticketVO.tkFinishYmd")
				inputFinishYmd.setAttribute("value",eventList[eventList.length-1].tkYmd);
				inputFinishYmd.setAttribute("type","hidden");
				document.querySelector('#poster').appendChild(inputFinishYmd);
				const formData=new FormData(formAll);
				console.log(inputStartYmd+"glglgl"+inputFinishYmd);
				
				
				axios.post('/admin/shop/ticketCreatePost',formData).then(response=>{
				//response.data : gdsNo
				console.log(response.data+"일단하나는성공");
				let gdsNo = response.data;
			
					axios.post('/admin/shop/ticketEventPost',eventList).then(resp=>{
						console.log("tdNo : ", resp.data);
						window.location.href = "/admin/shop/adTicketDetail?gdsNo="+gdsNo;
					})
				})   
			}
			});
		});
	
	});
	
	function toggleGdsType() {
		var gdsType = document.getElementById("gdsType").value;
		console.log("옴"+gdsType);
		var artGroupNo = document.getElementById("artGroupNo");
		var artNo = document.getElementById("artNo");
		var selectGoods = document.getElementById("selectGoods");
	
		if (gdsType === "G") {
			selectGoods.style.display = "none";  
			artGroupNo.style.display = "block";  

			artNo.style.display = "none";  
			artGroupNo.required = true;
			artNo.required = false;
			
		} else {
			selectGoods.style.display = "none";   
			artNo.style.display = "block";   
			artGroupNo.style.display = "none";   
			artGroupNo.required = false;
    artNo.required = true;
		}
	}
	
	
	function posterImg(){
		let fileInput = document.getElementById("uploadFilePoster");
		
		let formData = new FormData();
		formData.append("uploadFile", fileInput.files[0]); // 'uploadFile'은 서버에서 받을 변수명과 일치해야 함
	
		$.ajax({
			url:"/admin/shop/ticketPosterPost",
			type:"POST",
			data: formData,
			processData: false,  // 파일 업로드 시 필수 설정
			contentType: false,  // 파일 업로드 시 필수 설정
			success: function (response) {
				console.log(response);
	//         	const fileGroupNo = response;
				//alert("포스터등록 성공!");
				console.log(response.fileGroupNo);
				
				//안내문자 삭제
				document.querySelector('#poster p').remove();

				if(document.querySelector('#posterFile')){
					document.querySelector('#posterFile').remove();
				}
					var img = document.createElement('img');
					img.setAttribute("src", "/upload/"+response.fileSaveLocate );
					img.setAttribute("id","posterFile");
					img.setAttribute("style","width: 100%; height: 300px; border: 1px solid lightblue; border-radius: 10px;");
					document.querySelector('#poster').appendChild(img);
					
					var btn = document.getElementById('addPoster');
					btn.innerText="포스터 이미지 수정";
					
					var input = document.createElement('input')
					input.setAttribute("name","ticketVO.posterFile")
					input.setAttribute("value",response.fileGroupNo);
					input.setAttribute("type","hidden");
					document.querySelector('#poster').appendChild(input);
				
				/* var btn = document.getElementById('#addPoster');
				btn.setAttribute("display","none"); */
				
				/* $.ajax({
					 url:"/admin/shop/ticketPosterImgPost",
					type:"POST",
					data: {"fileGroupNo":response},
					success: function (resp) {
						console.log(resp);
						alert("이미지가져오기 성공!");
					},
					error: function (xhr, status, error) {
						alert("이미지가져오기 실패: " + error);
					} 
				}) */
				
			},
			error: function (xhr, status, error) {
				alert("파일 업로드 실패: " + error);
			}
		})
	}


  const select = document.getElementById("startTime");
  [...Array(14)].forEach(
		(_, i) => select.innerHTML += `<option value="\${i+10}">\${i+10}</option>`
   );

  function readFile(input){
      var reader;
          console.log("input : ",input);
      for(var file of input.files){
          reader= new FileReader();
          reader.onload = function(e){
          	console.log(e);
          	var imgPrev=document.querySelector("#posterImgPrev")
              imgPrev.setAttribute("src",e.target.result);
          };
          console.log("dddd",reader);
          reader.readAsDataURL(input.files[0]);
      }
  };

  function readFileExpln(input){
	// 사용자가 파일을 선택할 때 기존 미리보기 초기화
    $("#newImg").empty();
    console.log("input : ",input);
    
    if (input.files) {
    	console.log(input.files)
    	Array.from(input.files).forEach(file=>{
    		var reader= new FileReader();
   	         reader.onload = (function(selectedFile) {
	        	 return function(e){
		        	 console.log(e);
		        	 let img = document.createElement("img");
		             img.setAttribute("src", e.target.result);
		             img.style.objectFit = "cover";
		             img.style.border = "1px solid #ddd";
		             img.style.borderRadius = "5px";
		             img.style.width="100%"
		             document.querySelector("#newImg").setAttribute("style","width:100%; height: 600px; overflow-y: auto; overflow-x:hidden;")
		        	 document.querySelector("#newImg").appendChild(img);
   	        	 };
   	         })(file);
   	         
   	         reader.readAsDataURL(file);
    	});
    }
};

document.getElementById('saveForm').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      console.log('Enter 키 제출 방지됨');
    }
  });
  
  
  
  // 시연용버튼 시작
  function testBtn() {
	  // 상품타입 '그룹상품' 선택
	  document.getElementById("gdsType").value="G";
	  document.getElementById("gdsType").dispatchEvent(new Event("change")); // 강제로 select 박스에 change 이벤트를 발생함 -> 안그럼 내부값만 변경됨
	  
	  // 그룹 '에스파' 선택
	  document.getElementById("artGroupNo").value= 1;
	  document.getElementById("artGroupNo").dispatchEvent(new Event("change"));
	  
	  // 공연분류 '콘서트' 선택
	  document.getElementById("tkCtgr").value= "콘서트";
	  document.getElementById("tkCtgr").dispatchEvent(new Event("change"));
	  
	  // 공연명 선택
	  document.getElementById("gdsNm").value= "[AESPA] SYNK : HYPER LINE";
	  
	  // 공연가격 선택
	  document.getElementById("tkVprice").value= 150000;
	  document.getElementById("tkRprice").value= 100000;
	  document.getElementById("tkSprice").value= 70000;
	  
	  // 공연 시간 선택
	  document.querySelector("input[name='ticketVO.tkRuntime']").value= 200;
	  
	  // 공연 장소 선택
	  document.getElementById("keyword").value= "고척돔";
	  searchPlaces();
	  
  }
  // 시연용버튼 끝
</script>

</body>
</html>