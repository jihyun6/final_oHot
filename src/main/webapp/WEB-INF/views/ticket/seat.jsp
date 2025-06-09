<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO"/>
	</sec:authorize>

    <div class="container-sm" style="max-width: 100%; overflow-x: hidden;">
        <div style="display: flex; flex-direction: column; height: 100%; border: 2px solid #ccc;">
			<!-- 헤더 영역 -->
			<div style="display: flex; flex-direction: row; align-items: center; border: 2px solid #ccc;">
				<!-- 좌측: 좌석선택 -->
				<div style="width: 150px; text-align: center; padding: 20px;"><h5><b>좌석선택</b></h5></div>
				
				<!-- 구분선 -->
				<div style="width: 1px; height: 80px; background-color: #ccc;"></div>
				
				<!-- 오른쪽 내용 -->
				<div style="display: flex; flex-direction: column; padding: 20px; gap: 10px; flex-grow: 1;">
					<h5 style="margin: 0;"><b>${ticketVO.tkDetailVOList[0].gdsNm} |</b> <a style="font-size: 0.7em;">${seatVOList[0].tkLctn}</a> </h5>
					<select class="form-select form-select-sm" onchange="changeRound(this.value)" style="max-width: 250px;">
						<option disabled>다른 회차 선택하기</option>
						<c:forEach var="tkDetailVO" items="${ticketVO.tkDetailVOList}">
							<c:choose>
								<c:when test="${tkDetailVO.tkDetailNo == tkDetailNo}">
									<option value="${tkDetailVO.tkDetailNo}" selected>
										${tkDetailVO.tkYmd} / ${tkDetailVO.tkRound}
									</option>
								</c:when>
								<c:otherwise>
									<option value="${tkDetailVO.tkDetailNo}">
										${tkDetailVO.tkYmd} / ${tkDetailVO.tkRound}
									</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
			</div>

            <!-- 본문 영역 -->
            <div style="display: flex; padding: 10px;">
                <div style="display: flex; flex-direction: column; flex: 2; ">
                    
                    <!-- 층 반복: 1층, 2층 -->
                    <c:forEach var="floorEntry" items="${floorSectionMap}">
					<c:set var="floor" value="${floorEntry.key}" />
					<c:set var="sections" value="${floorEntry.value}" />
					<c:forEach var="i" begin="0" end="${fn:length(sections) - 1}" step="3">
						<div style="display: flex; justify-content: center; margin-bottom: 5px;">
							<div class="justify-content: flex-start;">
									<b>${floor}F</b>
							</div>
							<c:forEach var="j" begin="0" end="2">
								<c:set var="idx" value="${i + j}" />
								<c:if test="${idx lt fn:length(sections)}">
									<c:set var="sectionName" value="${sections[idx]}" />

									<!-- 정렬 방향 설정 -->
									<c:choose>
										<c:when test="${sectionName == 'A' || sectionName == 'D'}">
											<c:set var="alignStyle" value="flex-end" />
										</c:when>
										<c:when test="${sectionName == 'B'}">
											<c:set var="alignStyle" value="center" />
										</c:when>
										<c:otherwise>
											<c:set var="alignStyle" value="flex-start" />
										</c:otherwise>
									</c:choose>
									<div>
									
									<div style="font-weight: bold;  margin-bottom: 5px; text-align: center;">
										${sectionName}
									</div>
									
									<div style="display: flex; flex-direction: column; align-items: ${alignStyle}; padding: 5px; margin: 1px; min-width: 100px;">
										<c:set var="currentRow" value="" />
										<c:forEach var="seat" items="${seatVOList}">
											<c:if test="${seat.seatFloor == floor && seat.seatSection == sectionName}">
												
												<c:if test="${currentRow != seat.seatRow}">
													<c:if test="${currentRow != ''}">
														</div> <!-- 이전 row 닫기 -->
													</c:if>
													<div style="display: flex; margin-bottom: 4px;">
														<!-- 왼쪽에 row 번호 -->
														<c:choose>
															<c:when test="${sectionName == 'B' || sectionName == 'C' || sectionName == 'E'}">
																<div style="width: 10px; font-size: 0.53rem; text-align: right; margin-right: 4px;"><b>${seat.seatRow}</b></div>
															</c:when>
															<c:otherwise>
																<div style="width: 10px; margin-bottom: 10px;"> </div> <!-- 공백으로 정렬 유지 -->
															</c:otherwise>
														</c:choose>
													<c:set var="currentRow" value="${seat.seatRow}" />
												</c:if>
												<c:choose>
													<c:when test="${seat.rsvtnEnum==1 || seat.rsvtnEnum ==2}">
														<!-- 예약된 좌석 회색처리 -->
														<c:set var="color" value="lightgray" />
														<c:set var="cursor" value="default" />
														<c:set var="pointerEvents" value="none" />
													</c:when>
													<c:otherwise>
														<!-- 등급별 색상처리 -->
														<c:choose>
															<c:when test="${seat.seatGrade == 0||seat.seatGrade == '0'}">
																<c:set var="color" value="mediumpurple" />
																<c:set var="cursor" value="pointer" />
																<c:set var="pointerEvents" value="auto" />
															</c:when>
															<c:when test="${seat.seatGrade == 1 || seat.seatGrade == '1'}">
																<!-- R석 처리 -->
																<c:choose>
																	<c:when test="${ticketVO.tkSprice == 0}">
																		<!-- S석이 공짜면 R석도 VIP처럼 -->
																		<c:set var="color" value="mediumpurple" />
																		<c:set var="cursor" value="pointer" />
																		<c:set var="pointerEvents" value="auto" />
																	</c:when>
																	<c:otherwise>
																		<c:set var="color" value="green" />
																		<c:set var="cursor" value="pointer" />
																		<c:set var="pointerEvents" value="auto" />
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:when test="${seat.seatGrade == 2||seat.seatGrade == '2'}">
																<!-- S석 처리 -->
																<c:choose>
																	<c:when test="${ticketVO.tkRprice == 0 && ticketVO.tkSprice == 0}">
																		<!-- R석과 S석이 0원이면 VIP처럼 -->
																		<c:set var="color" value="mediumpurple" />
																		<c:set var="cursor" value="pointer" />
																		<c:set var="pointerEvents" value="auto" />
																	</c:when>
																	<c:when test="${ticketVO.tkRprice != 0 && ticketVO.tkSprice == 0}">
																		<!-- S 공짜면 R석 색상 -->
																		<c:set var="color" value="green" />
																		<c:set var="cursor" value="pointer" />
																		<c:set var="pointerEvents" value="auto" />
																	</c:when>
																	<c:otherwise>
																		<c:set var="color" value="skyblue" />
																		<c:set var="cursor" value="pointer" />
																		<c:set var="pointerEvents" value="auto" />
																	</c:otherwise>
																</c:choose>
															</c:when>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 좌석 출력 -->
												<div style="width: 12px; height: 12px; line-height: 10px; font-size: 0.7rem; margin: 0.5px; text-align: center; color: ${color}; cursor: ${cursor}; pointer-events:${pointerEvents};"
													onclick="selectSeat('${seat.seatNo}','${seat.seatGrade}','${seat.seatFloor}','${seat.seatSection}','${seat.seatRow}','${seat.seatDetailNo}')" 
													id="${seat.seatNo}">■</div>
												
											</c:if>
										</c:forEach>
										<!-- 오른쪽 row 번호: D구역일 때만
										<c:if test="${sectionName == 'D'}">
											<div style="width: 10px; font-size: 0.7rem; text-align: left; margin-left: 4px;">${seat.seatRow}</div>
										</c:if> -->
										
									</div>
									
									<c:if test="${currentRow != ''}">
											</div > <!-- 마지막 row 닫기 -->
									</c:if>
									</div> <!-- 구역 박스 닫기 -->
								</c:if>
								<div id="jh${i}${j}" style="display:inline-block;width:0;padding:0;margin:0;"></div>
							</c:forEach>
						</div>
					</c:forEach>
				</c:forEach>
                </div>

                <!-- 오른쪽 영역 -->
                <div style="flex: 1; display: flex; flex-direction: column; gap: 10px; padding-left: 30px;">
                    <div style="text-align: left; padding: 10px; height: 200px;  border: 5px solid lightpink;">
						<b>가격정보</b>
						<hr/>
						<fmt:formatNumber var="formattedVprice" value="${ticketVO.tkVprice}" type="number" />
						<fmt:formatNumber var="formattedRprice" value="${ticketVO.tkRprice}" type="number" />
						<fmt:formatNumber var="formattedSprice" value="${ticketVO.tkSprice}" type="number" />
						<c:choose>
							<c:when test="${ticketVO.tkRprice == 0 && ticketVO.tkSprice == 0}">
								<a><span style=" color: mediumpurple; ">■</span> 전석: ${formattedVprice} 원</a><br>
							</c:when>
							<c:when test="${ticketVO.tkRprice != 0 && ticketVO.tkSprice == 0}">
								<a><span style=" color: mediumpurple; ">■</span> VIP석: ${formattedVprice} 원</a><br>
								<br>
								<a><span style=" color: green; ">■</span> R석: ${formattedRprice} 원</a><br>
							</c:when>
							<c:otherwise>
								<a><span style=" color: mediumpurple; ">■</span> VIP석: ${formattedVprice} 원</a><br>
								<br>
								<a><span style=" color: green; ">■</span> R석: ${formattedRprice} 원</a><br>
								<br>
								<a><span style=" color: skyblue; ">■</span> S석: ${formattedSprice} 원</a>
							</c:otherwise>
						</c:choose>
						
					</div>
                    <div style="text-align:left ; padding: 10px; border: 5px solid lightpink; height: 250px;" id="checkDiv">
						<b>좌석확인 <i class="bi bi-arrow-clockwise" onclick="seatAllReset()"></i></b>
						<hr/>
						<a id="ckeckSeat" name="checkSeat"></a>
					</div> 
					
					<div class="d-grid gap-2">
						<button type="button" class="btn btn-danger" onclick="payBtn()" >결제하기</button>
					</div>
                </div>
            </div>
        </div>
    </div>

<script>
<!-- 콘솔 위치 표시 (임시) -->
const jhBox = document.querySelector("#jh30");
if (jhBox) {
	jhBox.style = "width:270px; text-align:center; padding:5%;";
	jhBox.innerHTML = `<div style=" height:90%; text-align:center; background-color:lightgray;">CONSOLE</div>`;
}

let reservSeats=[]; // 선택된 좌석 정보
let boughtCnt='${boughtCnt}'; // 이미 구매한 좌석 수
let maxBuy=4; // 최대 선택 가능 좌석 수
const ckeckSeat= document.querySelector("#ckeckSeat");


function selectSeat(seatNo, seatGrade, seatFloor, seatSection, seatRow, seatDetailNo ){
	// alert("선택한 좌석: "+seatNo);
	console.log(seatNo+" : "+ seatGrade+" : "+ seatFloor+" : "+ seatSection+" : "+ seatRow+" : "+ seatDetailNo)
	
	const existingSeat = reservSeats.findIndex(seat => seat.seatNo === seatNo);
	const selectedSeat =document.getElementById(seatNo);


	
	if (existingSeat !== -1) {
		
		// 이미 선택된 좌석이면 취소
		const removedSeat = reservSeats.splice(existingSeat, 1)[0]; // 제거하면서 정보 꺼냄
		console.log("취소"+JSON.stringify(removedSeat)+"dd");
		let recolor = "skyblue";
		if (seatGrade == 0) recolor = "mediumpurple";
		else if (seatGrade == 1) recolor = "green";

		selectedSeat.style.cssText = `width: 12px; height: 12px; line-height: 10px; font-size: 0.7rem; margin: 0.5px; text-align: center; color: \${recolor}; cursor: pointer;`;

		// 체크된 좌석 영역도 갱신
		ckeckSeat.innerText = reservSeats.map(s =>
			s.seatFloor + 'F ' + s.seatSection + '구역 ' + s.seatRow + '열 ' + s.seatDetailNo
		).join('\n'+'\n');

		return;
	}

	// 이미 4개 선택했으면 함수 종료
	if (reservSeats.length+parseInt(boughtCnt)>=maxBuy) {
		Swal.fire("선택가능 매수를 초과했습니다","", "warning");
		return;
	}
	console.log("선택매수: ",reservSeats.length+parseInt(boughtCnt));


	selectedSeat.style.boxShadow = "inset 0 0 0 8px black";
	selectedSeat.style.fontSize = "0.65rem";
	
	reservSeats.push({
		seatNo, seatGrade, seatFloor, seatSection, seatRow, seatDetailNo
	})
	console.log("${userVO.userNo}"+"reserv 어떻게담기니"+JSON.stringify(reservSeats))
	
	ckeckSeat.innerText = reservSeats.map(s =>
		s.seatFloor + 'F ' + s.seatSection + '구역 ' + s.seatRow + '열 ' + s.seatDetailNo
	).join('\n'+'\n');
}

function seatAllReset(){
	reservSeats.forEach(seat => {
		const seatElement = document.getElementById(seat.seatNo);
		let recolor = "skyblue";
		if (seat.seatGrade == 0) recolor = "mediumpurple";
		else if (seat.seatGrade == 1) recolor = "green";

		seatElement.style.cssText = `width: 12px; height: 12px; line-height: 10px; font-size: 0.7rem; margin: 0.5px; text-align: center; color: \${recolor}; cursor: pointer;`;
	});

	reservSeats=[];
	ckeckSeat.innerText = "";

	return;
}

function changeRound(tkDetailNo) {
		console.log(tkDetailNo);
		window.location.href = "seat?tkNo=${ticketVO.tkNo}&artGroupNo=${artGroupNo}&tkDetailNo=" + tkDetailNo;
}

function payBtn(){
	console.log(`${artGroupNo}`+"payBtn파라미터들" +JSON.stringify(reservSeats));
	
	if(reservSeats.length<1) {
		alert("좌석을 선택해주세요"+reservSeats);
		return;
	};
	
	const need ={
		'artGroupNo':"${artGroupNo}",
		'gdsNo': "${ticketVO.gdsNo}",
		'tkDetailNo': "${tkDetailNo}",
		'memNo':"${userVO.userNo}",
		'seatVOList': reservSeats
	};
	console.log("필수: "+JSON.stringify(need))
	
	let payList =''; 
	console.log('\${ticketVO.tkVprice}'+"dfsdfsds "+"\${reservSeats[0].seatNo}"+111111+"reservSeats[0].seatNo");
	
	//전체 가격 gramt
	let gramt=0;

	for (let i = 0; i < reservSeats.length; i++) {

		let unitPrice = 0;
		let grade ="";
		

		if (reservSeats[i].seatGrade == 0) {
			if(${ticketVO.tkRprice == 0 && ticketVO.tkSprice == 0}){
				unitPrice = '${ticketVO.tkVprice}';
				grade="전석";
				gramt+=parseInt('${ticketVO.tkVprice}');
			}else{
				unitPrice = '${ticketVO.tkVprice}';
				grade="VIP";
				gramt+=parseInt('${ticketVO.tkVprice}');
			}
		}
		else if (reservSeats[i].seatGrade == 1) {
			
			if(${ticketVO.tkRprice==0}){
				unitPrice = '${ticketVO.tkVprice}';
				grade="전석";
				gramt+=parseInt('${ticketVO.tkVprice}');
				
			}else{
				unitPrice = '${ticketVO.tkRprice}';
				grade="R";
				gramt+=parseInt('${ticketVO.tkRprice}');
			}
		}
		else if (reservSeats[i].seatGrade == 2) {
			if(${ticketVO.tkRprice == 0 && ticketVO.tkSprice == 0}){
				unitPrice = '${ticketVO.tkVprice}';
				grade="전석";
				gramt+=parseInt('${ticketVO.tkVprice}');

			}else if('${ticketVO.tkRprice}!=0'){
				unitPrice = '${ticketVO.tkRprice}';
				grade="R";
				gramt+=parseInt('${ticketVO.tkRprice}');

			}else{
				unitPrice = '${ticketVO.tkSprice}';
				grade="S";
				gramt+=parseInt('${ticketVO.tkSprice}');
			}
		}
		// alert("gramt는 도대체: "+gramt);
		payList += `
			<input type="hidden" name="goodsVOList[\${i}].gdsNo" value="${ticketVO.gdsNo}" />
			<input type="hidden" name="goodsVOList[\${i}].artGroupNo" value="${artGroupNo}" />
			<input type="hidden" name="goodsVOList[\${i}].gdsNm" value="${ticketVO.tkDetailVOList[0].gdsNm}" />
			<input type="hidden" name="goodsVOList[\${i}].fileSavePath" value="${ticketVO.tkFileSaveLocate}" />
			<input type="hidden" name="goodsVOList[\${i}].qty"  value="1" />
			<input type="hidden" name="goodsVOList[\${i}].unitPrice" value="\${unitPrice}" />
			<input type="hidden" name="goodsVOList[\${i}].amount" value="\${unitPrice}" />
			<input type="hidden" name="goodsVOList[\${i}].commCodeGrpNo" value="\${grade}" />
			<input type="hidden" name="goodsVOList[\${i}].option2" 
					value="\${reservSeats[i].seatNo} \${reservSeats[i].seatFloor}F \${reservSeats[i].seatSection}구역 \${reservSeats[i].seatRow}열 \${reservSeats[i].seatDetailNo}" />
		`;
	}
	payList += `<input type="hidden" name="goodsVOList[0].gramt" value= "\${gramt}"/>`;
	axios.post('/shop/ticket/tkRsvtnPost',need).then(resp=>{
		console.log(resp.data+": 성공했지요");
		console.log(payList+"제발발");
		// alert("plz");

		const payForm = document.createElement('form');
		payForm.method = 'POST';
		payForm.action = '/shop/ordersPost'
		payForm.innerHTML = payList;
		document.body.appendChild(payForm);
		payForm.submit();



	}).catch(error=>{
		alert(error.response?.data);
		location.reload(); // 새로고침
	})
};

/* 
//웹소켓연결
let socket =null;
window.onload= function(){

	//websocket연결
	socket = new WebSocket("ws://localhost:28080/ws/seat");
	
	//연결성공
	socket.onopen = function(){
		console.log("웹소켓 연결성공");
	}

	//메시지 수신 처리 
	socket.onmessage = function (event) {
		const data = JSON.parse(event.data);
		console.log("받은 메시지: ", data);

		if (data.type === "seat-selected") {
			const seatNo = data.seatNo;
			const seatDiv = document.getElementById(seatNo);
			if (seatDiv) {
				seatDiv.style.backgroundColor = "#ccc";
				seatDiv.style.pointerEvents = "none";
				seatDiv.title = "이미 선택된 좌석입니다.";
			}
		}

		//서버에서 에러 메시지 보냈을 때
		if (data.type === "error" && data.reason === "seat-already-selected") {
			alert("이미 선택된 좌석입니다!");
			location.reload(); // 확인 누르면 새로고침
		}
	};

	// 연결 종료
	socket.onclose = function () {
		console.log("WebSocket 연결 종료");
	};

	// 에러 발생
	socket.onerror = function (err) {
		console.error("WebSocket 오류:", err);
	};

	//좌석메세지 날리기
	const payBtn = document.getElementById("payBtn");
	
	payBtn.addEventListener("click", function(){
		if(reservSeats.length===0){
			alert("좌석을 선택해주세요!");
			return;
		}
	
		//웹소켓으로 메세지 날리기
		const msg={
			type:"seat-selected",
			seats:reservSeats,
			userId:"로그인 아이디 넣기"
		};
	
		socket.send(JSON.stringify(msg));
	})
} */

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>	
</body>

</html>
