<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
		selectable : true,
		selectMirror : true,
		selectConstraint:{
			start: new Date(),
			end: '9999-12-31'
		},
		now: '${goodsVO.ticketVO.tkStartYmd }',
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
			calendar.addEvent({
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
			console.log("무슨타입"+JSON.stringify(calendar.getEvents().map(event => event.extendedProps)));
			
		$('#eventModal').hide();
		
	}
	window.closeModal = function () {
		$('#eventModal').hide();
	}
	
	$(document).ready(function () {
	    $('#saveBtn').click(function (event) {
	    	event.preventDefault();
	    	//console.log("✅ 현재 캘린더에 추가된 이벤트 목록:"+ eventList);
	    	
    		const eventList =calendar.getEvents().map(event => event.extendedProps);
    		
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

            
	    	const formData=new FormData(document.querySelector('#saveForm'));
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
	    	
	    });
	});

});


</script>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">	
	<c:set var="title" value="공연/티켓관리 &ensp;>&ensp; 공연정보수정"></c:set>
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<!-- 컨텐츠-->
<div class="content-wrapper">
<%-- 		${goodsVO } --%>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO"/>
	</sec:authorize>

	<form action="/admin/shop/adTicketUpdatePost" method="post" enctype="multipart/form-data" id="allFrm">
	<input type="hidden"  name="gdsNo" value="${goodsVO.gdsNo }">
	<input type="hidden"  name="ticketVO.tkNo" value="${goodsVO.ticketVO.tkNo }">
	<div class="form-group " style="padding: 30px;">
		<div class="row">
			<div class="col-sm-2" style="text-align: center">
				<div id="poster" >
					<img alt="경로확인" src="/upload/${goodsVO.ticketVO.tkFileSaveLocate}" style="width: 100%; height: 400px;" id="posterImg" >
					<input type="hidden" value="${goodsVO.ticketVO.posterFile}" name="ticketVO.posterFile" id="posterInput">
				</div>
				<br>
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#posterModal" id="addPoster" >포스터이미지 수정</button>
			</div>
			<div class="col-sm-6">
				<div class=row>
					
					<div class="col-sm-4">
						<c:choose>
						<c:when test="${empty goodsVO.artGroupNo || goodsVO.artGroupNo==0}">
							<b>공연자</b>
							<button type="button" class="btn btn-outline-primary col-sm-12">${goodsVO.artActNm }</button>
						</c:when>
						<c:when test="${empty goodsVO.artNo|| goodsVO.artNo==0}">
							<b>공연자</b>
							<button type="button" class="btn btn-outline-primary col-sm-12" >${goodsVO.artGroupNm }</button>
						</c:when>
					</c:choose>
				</div>
				<div class="col-sm-4">
						<b>공연기간</b>
						<button type="button" class="btn btn-outline-secondary col-sm-12">${goodsVO.ticketVO.tkStartYmd } ~ ${goodsVO.ticketVO.tkFinishYmd }</button>
					</div>
					<div class="col-sm-4">
						<b>공연분류</b>
						<select name="ticketVO.tkCtgr" id="tkCtgr" required class=" btn btn-success dropdown-toggle col-sm-12"  required>
							<option value="${goodsVO.ticketVO.tkCtgr }"hidden selected>${goodsVO.ticketVO.tkCtgr }</option>
							<option value="콘서트" >콘서트</option>
							<option value="팬미팅" >팬미팅</option>
							<option value="기타" >기타</option>
						</select>
					</div>
					
					<div class="col-sm-12 ">
						<b>공연명</b> <input type="text" id="gdsNm" name="gdsNm" class="form-control" value="${goodsVO.gdsNm }" required /><br/>
					</div>
					<br/>
					<div class=" col-sm-12">
					 	<b>공연가격</b>
						<div class="row">
							<div class="col-sm-4 d-flex align-items-center">
								VIP석 &ensp;<input type="number" id="tkVprice" name="ticketVO.tkVprice" class="form-control col-sm-8" value="${goodsVO.ticketVO.tkVprice }" required/>원 &ensp;|
							</div>
							<div class="col-sm-4 d-flex align-items-center">
								R석 &ensp;<input type="number" id="tkRprice" name="ticketVO.tkRprice" class="form-control col-sm-8" value="${goodsVO.ticketVO.tkRprice }"required />원 &ensp;|
							</div>
							<div class="col-sm-4 d-flex align-items-center">
								S석 &ensp;<input type="number" id="tkSprice" name="ticketVO.tkSprice" class="form-control col-sm-8" value="${goodsVO.ticketVO.tkSprice }"required />원 
							</div>
						</div> <br/>
					</div>
					<div class="col-sm-12" id="tkRuntime">
						<b>공연시간(분)<span style="color: red">*</span></b> <input type="number" id="tkRuntime" name="ticketVO.tkRuntime" class="form-control" value="${goodsVO.ticketVO.tkRuntime}" required /><br/>
					</div>
					<div class="col-sm-12" id="ckExplan">
						<b>상품설명</b> <textarea cols="50" rows="5" id="expln" name="expln"  class="form-control" placeholder="이미지 혹은 설명 글 하나만 등록해주세요" >${goodsVO.expln }</textarea><br/>
						
						<b>상품설명이미지</b>
						<b class="text-danger fw-bold">&emsp; * 수정시 사진 전체를 새로 업로드 하는 것으로 기존 이미지는 삭제됩니다 * &emsp;</b>
<!-- 						<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#explnModal" id="explnImg"  >상품설명이미지 수정</button> -->
							<input type="file" id="uploadFile" name="uploadFile" class="form-control"  onchange="readFileExpln(this)" multiple/>
							<input type="hidden" id="fileGroupNo" name="fileGroupNo" value="${goodsVO.fileGroupNo }"  class="form-control" />
						<div class="mt-3" id="newImg" style="width:100%; height: 600px; overflow-y: auto; overflow-x:hidden;">
							<c:forEach var="fileDetail" items="${goodsVO.fileGroupVO.fileDetailVOList}">
								<img alt="경로확인" src="/upload/${fileDetail.fileSaveLocate }" style="width: 100%;" id="explnImg">
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-4">
				<div id="calendar" >
					<!-- 캘린더 영역 -->
				</div>
				<div class="col-sm-12 mt-1" >
					<b>공연장소</b>
					<%@ include file="./location.jsp"%>
				</div>
			</div>
			
		</div>
		<div class="d-flex justify-content-between mt-3">
			<a type="button" class="btn btn-info" href="/admin/shop/adTicketList">목록</a>
			<button type="submit" class="btn btn-primary" id="dontsubmit">저장</button>
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
			<h5 class="modal-title">포스터등록</h5>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		
		<!-- Modal body -->
		<div class="modal-body">
			<input type="file" id="uploadFilePoster" name="uploadFilePoster"  class="form-control profile-img"  onchange="readFile(this)"/>
			<img  id="posterImgPrev" style="width: 100%; height: 580px;">
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
<!-- 
	<div class="modal" id="explnModal">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
		
		Modal Header
		<div class="modal-header">
			<h5 class="modal-title">상품설명 이미지</h5>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		
		Modal body
		<div class="modal-body">
			<input type="file" id="uploadFile" name="uploadFile"  class="form-control"  onchange="readFileExpln(this)" multiple/>
			<div id="explnImgPrev" style="display: flex; flex-wrap: wrap; gap: 10px;"></div>
		</div>
		
		Modal footer
		<div class="modal-footer">
			<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="explnImg()">저장</button>
		</div>
		
		</div>
	</div>
	</div>
 -->	
<!-- The Modal -->
<div class="modal" id="eventModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
		<!-- Modal Header -->
		<div class="modal-header">
			<h5 class="modal-title">공연일정등록</h5>
			<button type="button" class="close" data-dismiss="modal" onclick="closeModal()">&times;</button>
		</div>
		
		<!-- Modal body -->
		<div class="modal-body">
			공연날짜 <input type="date" id="startDate" required><br/><br/>
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
			<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeModal()">취소</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addEvent()">저장</button>
		</div>
		
		</div>
	</div>
</div>

<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
	
</div>

<script type="text/javascript">
const select = document.getElementById("startTime");
[...Array(24)].forEach(
		(_, i) => select.innerHTML += `<option value="\${i+1}">\${i+1}</option>`
 );

$(document).ready(function () {
    $("#posterModal").on("hide.bs.modal", function () {
        $("#posterImgPrev").attr("src", ""); // 이미지 초기화
        $("#uploadFilePoster").val(""); 

    });
});
$(document).ready(function () {
    $("#explnModal").on("hide.bs.modal", function () {
    	$("#explnImgPrev").empty(); // 이미지 초기화
        $("#uploadFile").val(""); 
    });
});


function explnImg(){
	console.log("저장하고 이미지 뿌려줘야함")

	// 상품 설명 이미지 영역 초기화
    $("#ckExplan img").remove();

    // 모달 내 미리보기 이미지를 가져와서 복사 후 상품 설명 영역에 추가
    $("#explnImgPrev img").each(function () {
        let imgClone = $(this).clone(); // 이미지 복사
        imgClone.css({ 
            width: "100%", 
            height: "auto", 
            objectFit: "contain"  // 이미지를 컨테이너에 맞춤 
        });
        $("#newImg").append(imgClone); // 상품 설명 영역에 추가
    });
	
};


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
            
            if(document.querySelector('#posterFile') ){
            	document.querySelector('#posterFile').remove();
            	
            } 
			if(document.querySelector('#posterImg')){
            	document.querySelector('#posterImg').remove();
            	
            }
			if(document.querySelector('#posterInput')){
            	document.querySelector('#posterInput').remove();
            }
	            var img = document.createElement('img');
	            img.setAttribute("style","width: 200px; height: 300px;");
	            img.setAttribute("id","posterFile");
	            img.setAttribute("src","/upload/"+response.fileSaveLocate);
	            document.querySelector('#poster').appendChild(img);
	            
				
	            var input = document.createElement('input')
				input.setAttribute("name","ticketVO.posterFile")
            	input.setAttribute("value",response.fileGroupNo);
	            input.setAttribute("type","hidden");
	            document.querySelector('#poster').appendChild(input);
            
            
        },
        error: function (xhr, status, error) {
            alert("파일 업로드 실패: " + error);
        }
	})
}


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
		            
		        	 document.querySelector("#newImg").appendChild(img);
		             
   	        	 };
   	         })(file);
   	         
   	         reader.readAsDataURL(file);
    	});
    }
};

document.getElementById('allFrm').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      console.log('Enter 키 제출 방지됨');
    }
  });

</script>
</body>
</html>