<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<!DOCTYPE html>
		<html>

		<head>
			<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
			<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>

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

				.fc-daygrid-day-number {
					color: rgb(199, 198, 198);
					opacity: 80%;
				}


				.fc-daygrid-day-top {
					width: 50px;
					/* 너비 줄이기 */
					height: 20px;
					/* 높이 줄이기 */
					font-size: 18px !important;
					/* 폰트 크기 조정 */
				}

				.fc-daygrid-day-top a {
					text-decoration: none !important;
				}

				.fc-day-today {
					background-color: white !important;
				}
			</style>
			<meta charset="UTF-8">
			<title>공연상세</title>
		</head>

		<body>
			<%@ include file="../shopHeader.jsp" %>

				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.usersVO" var="userVO" />
				</sec:authorize>

				<fmt:formatNumber var="formattedVprice" value="${goodsVO.ticketVO.tkVprice}" type="number" />
				<fmt:formatNumber var="formattedRprice" value="${goodsVO.ticketVO.tkRprice}" type="number" />
				<fmt:formatNumber var="formattedSprice" value="${goodsVO.ticketVO.tkSprice}" type="number" />
				<!-- /// 제목 시작 /// -->
				<div class="jumbotron">
					<!-- container : 내용이 들어갈 때 -->
					<div class="container">
						<h5 class="display-5">${goodsVO.gdsNm}</h5>
						<!-- ${goodsVO } -->
					</div>
				</div>
				<!-- /// 제목 끝 /// -->

				<!-- /// 내용 시작 /// -->
				<input type="hidden" name="gdsNo" value="${goodsVO.gdsNo}" />
				<div class="container-sm ">
					<div class="row">
					<div class="col-md-8">
						<div class="row ">
							<div class=" col-md-4">
								<img src="/upload${goodsVO.ticketVO.tkFileSaveLocate}" alt="안돼!!" title="${goodsVO.gdsNm}"
									style="width:95%; height: 95%;" />
							</div>
							<div class="col-md-8">
								<!-- <h5>공연정보</h5> -->
								<table class="table text-nowrap">
									<tr>
										<th>공연명</th>
										<td>${goodsVO.gdsNm}</td>
									</tr>
									<tr>
										<th>출연</th>
										<c:if test="${goodsVO.artGroupNo ==0}">
											<td>${goodsVO.artActNm}</td>
										</c:if>
										<c:if test="${goodsVO.artNo==0}">
											<td>${goodsVO.artGroupNm}</td>
										</c:if>	
									</tr>
									<tr>
										<th>가격</th>
										<td>
											<p>
												<c:choose>
													<c:when test="${goodsVO.ticketVO.tkRprice ==0 && goodsVO.ticketVO.tkSprice ==0}">
														전석 ${formattedVprice} 원
													</c:when>
													<c:otherwise>
														VIP석 ${formattedVprice} 원
														<c:if test="${goodsVO.ticketVO.tkRprice !=0}">
															<br>&ensp; R석 ${formattedRprice} 원
														</c:if>
														<c:if test="${goodsVO.ticketVO.tkSprice !=0}">
															<br>&ensp; S석 ${formattedSprice} 원
														</c:if>
													</c:otherwise>
												</c:choose>
											</p>
										</td>
									</tr>
									<tr>
										<th>관람시간</th>
										<td>${goodsVO.ticketVO.tkRuntime} 분</td>
									</tr>
									<tr>
										<th>공연기간</th>
										<td>${goodsVO.ticketVO.tkStartYmd} ~ ${goodsVO.ticketVO.tkFinishYmd}</td>
									</tr>
									<tr>
										<th>공연장소</th>
										<td>${goodsVO.ticketVO.tkLctn}</td>
									</tr>
									<tr>
										<th></th>
										<td style="color: red;"> * 회차당 1인 4매 예매가능 * </td>
									</tr>
								</table>
							</div>
				
							<div class="col-12">
								<div class="card rounded-shadow shadow-lg">
				
									<!--카드 헤더 (탭 버튼 포함) -->
									<div class="card-header p-0">
										<ul class="nav nav-tabs d-flex w-100" id="myTab" role="tablist">
											<li class="nav-item flex-fill text-center" role="presentation">
												<button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">
													상세정보
												</button>
											</li>
											<li class="nav-item flex-fill text-center" role="presentation">
												<button class="nav-link w-100" id="lctn-tab" data-bs-toggle="tab" data-bs-target="#lctn" type="button" role="tab" aria-controls="lctn" aria-selected="false">
													공연장정보
												</button>
											</li>
											<li class="nav-item flex-fill text-center" role="presentation">
												<button class="nav-link w-100" id="board-tab" data-bs-toggle="tab" data-bs-target="#board" type="button" role="tab" aria-controls="board" aria-selected="false">
													기대평
												</button>
											</li>
										</ul>
									</div>
									<!--카드 헤더 끝끝 -->
				
									<!-- 카드 바디 (탭 콘텐츠 포함) -->
									<div class="card-body">
										<div class="tab-content" id="myTabContent">
				
											<!-- 상세정보 탭 -->
											<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="expln-tab">
												<c:forEach var="fileDetail" items="${goodsVO.fileGroupVO.fileDetailVOList}">
													<img alt="경로확인" src="/upload/${fileDetail.fileSaveLocate }" style="width: 100%;" id="explnImg">
												</c:forEach>
											</div>
				
											<!-- 공연장정보 탭 -->
											<div class="tab-pane fade" id="lctn" role="tabpanel" aria-labelledby="lctn-tab">
												<div class="col-sm-12" id="map" style="width: 100%; height: 500px;">
													<%@ include file="./locationRead.jsp" %>
												</div>
											</div>
				
											<!-- 기대평 탭 -->
											<div class="tab-pane fade" id="board" role="tabpanel" aria-labelledby="board-tab">
												<%@ include file="./tkBoard.jsp" %>
											</div>
										</div>
									</div> <!-- 카드 바디 끝 -->
								</div> <!-- 카드 끝 -->
				
							</div>
				
						</div>
					</div>
					<div class="col-md-4" style="height: 100vh; position: sticky; top:150px;  overflow-y: auto; z-index: 10;">
						<div id="calendar">
							<!-- 캘린더 영역 -->
						</div>
						<div id="ground" style="text-align: center; height: 50px; border: 0.5px solid lightblue; border-radius: 5px;">
						</div>
						<sec:authorize access="!isAuthenticated()">
							<button type="button" class="btn btn-primary  btn-block" onclick="Swal.fire('','로그인이 필요한 서비스입니다', 'warning')">예매하기</button>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<a type="button" onclick="reserv()" target="_blank" class="btn btn-primary  btn-block">예매하기</a>
						</sec:authorize>
					</div>
				</div>
				</div>
				
				</div>
				<!-- /// 내용 끝 /// -->
				<%@ include file="../shopfooter.jsp" %>

<script>
	let selectedDate = "";
	let selTkDetailNo = "";

	let ticketList = [
		<c:forEach var="ticket" items="${goodsVO.ticketVO.tkDetailVOList}" varStatus="loop">
			{"tkNo": ${ticket.tkNo},
			"tkYmd": "${ticket.tkYmd}",
			"tkRound": ${ticket.tkRound},
			"tkDetailNo" :${ticket.tkDetailNo}
			}
		<c:if test="${!loop.last}">,</c:if>
		</c:forEach>
	];

	let endDay = new Date("${goodsVO.ticketVO.tkFinishYmd}");
	endDay.setDate(endDay.getDate() + 1);
	let chEndDate = endDay.toISOString().split("T")[0];
	// 	console.log(chEndDate);
	let stDay = new Date("${goodsVO.ticketVO.tkStartYmd}");
	stDay.setDate(stDay.getDate());
	let chStDate = stDay.toISOString().split("T")[0];


	document.addEventListener('DOMContentLoaded', function () {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			//locale:'ko',
			now: chStDate,

			headerToolbar: false,
			height: "380px",

			// showNonCurrentDates: false,
			//expandRows:true,
			//             validRange:{
			//           	  start:chStDate,
			//           	  end:chEndDate
			//             },
			events: [{
				start: chStDate,
				end: chEndDate,
				display: 'background',
				color: 'green'

			}],

			/* 			eventClassNames: function(arg){
							//console.log("체킁: ",chEndDate);
							return "merong";
						}, */

			selectable: true,
			selectMirror: true,
			selectConstraint: {
				start: chStDate,
				end: chEndDate
			},
			windowResize: true,
			dateClick: function (info) {
				selectedDate = info.dateStr;
				//console.log("클릭한 날짜: " + selectedDate);
				groundbtn();

			},
			eventDidMount: function (info) {
				//console.log(ticketList[5].tkYmd+"ddfsd")

				ticketList.forEach(ticket => {
					let eventDate = ticket.tkYmd; // 공연 날짜
					//console.log(eventDate +"어디야!")

					// 해당 날짜의 숫자 색상을 변경
					$("td[data-date='" + eventDate + "'] .fc-daygrid-day-number").css({
						"color": "red",
						"font-weight": "bold"
					});
				});
			}
		});
		calendar.render();


		function groundbtn() {
			const ground = document.getElementById("ground");
			ground.innerHTML = "";

			// 선택한 날짜(`tkYmd`)에 해당하는 `tkRound`만 필터링
			let filteredTickets = ticketList.filter(ticket => ticket.tkYmd === selectedDate);
			// 		console.log(filteredTickets)

			if (filteredTickets.length === 0) {
				Swal.fire("선택한 날짜에 공연이 없습니다", "다른날짜를 선택해주세요", "warning");
				return;
			}

			// tkRound를 키로 하고, tkDetailNo를 값으로 저장하는 Map 생성
			let roundMap = new Map();
			filteredTickets.forEach(ticket => {
				roundMap.set(ticket.tkRound, ticket.tkDetailNo);
			});

			// 회차별 버튼 추가
			roundMap.forEach((tkDetailNo, round) => {
				// round가 예: 1900, 100이면 → 19:00, 01:00 형태로 변환
				let roundStr = round.toString().padStart(4, "0");  // 4자리 문자열로 맞추기 (예: "0100")
				let hour = roundStr.substring(0, 2);
				let minute = roundStr.substring(2, 4);

				const btn = document.createElement("button");
				btn.className = "btn btn-outline-success mr-4 mt-2 ml-3";
				btn.style = "margin-top:5px;";
				btn.textContent =`\${hour}:\${minute}`;
				btn.value = tkDetailNo;  // tkDetailNo 저장
				btn.id = 'btn' + round;

				//                 console.log(tkDetailNo +"dd")

				// 클릭 이벤트 추가
				btn.onclick = function () {
					selTkDetailNo = btn.value; // 선택한 tkDetailNo 저장

					// 모든 버튼을 원래 상태로 초기화
					document.querySelectorAll("#ground button").forEach(b => {
						b.className = "btn btn-outline-success mr-4";
					});

					btn.className = "btn btn-success  mr-4";
					console.log("선택한 회차:", selTkDetailNo + "회차" + round);

				};

				ground.appendChild(btn);
			});
		}
	});

	function reserv() {
		// 		console.log("선택된 날짜: "+selectedDate)
		// 		console.log("되나? : "+"${goodsVO.ticketVO.tkNo}")


		if (selectedDate >= "${goodsVO.ticketVO.tkStartYmd}" && selectedDate < chEndDate) {
			if (selTkDetailNo != "" && selTkDetailNo != null) {

				console.log(" 제대로선택? : " + selectedDate + "   " + selTkDetailNo);

				let timerInterval;
				Swal.fire({
					//   title: "이용자가 많아 대기가 있습니다",
					html: '새로고침 하지마시고 잠시만 기다려주세요 <br/> 대기시간: <b id="timer-value">2000</b> 초',
					timer: 1000,
					timerProgressBar: true,
					didOpen: () => {
						Swal.showLoading();
						setTimeout(() => { // 약간의 딜레이 후 실행
							const timer = Swal.getPopup().querySelector("b");
							if (timer) {
								timerInterval = setInterval(() => {
									timer.textContent = Swal.getTimerLeft();
								}, 100);
							}
						}, 50); // DOM이 렌더링될 시간을 주기 위해 약간의 딜레이 추가
					},
					willClose: () => {
						clearInterval(timerInterval);
					}
				}).then((result) => {
					/* Read more about handling dismissals below */
					if (result.dismiss === Swal.DismissReason.timer) {
						console.log("타이머작동중");
						window.open("seat?tkNo=${goodsVO.ticketVO.tkNo}&artGroupNo=${goodsVO.artGroupNo}&tkDetailNo=" + selTkDetailNo, "_blank", "width=1100,height=850,top=100,left=50");
					}
				});


			} else Swal.fire("회차를 선택해주세요","", "warning");
		} else {
			if (selectedDate == "" || selectedDate == null) {
				Swal.fire("날짜를 선택해주세요","", "warning");
			} else Swal.fire("선택한 날짜에 공연이 없습니다", "다른날짜를 선택해주세요", "warning");
		}
	}

</script>
</body>

</html>