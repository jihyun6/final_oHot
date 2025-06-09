
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독관리</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script -->
<!-- 	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<script src="/adminlte/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" type="text/css"
	href="https://ssl.pstatic.net/static.datalab/202405030736/css/datalab.css">

	
<style>
/* 필요시 추가 스타일 */
#myChart {
    position: relative;
    margin: auto;
    height: 40vh; /* 높이 조절 */
    width: 100%; /* 너비 조절 */
}

/* 개선된 레이아웃 스타일 */
html, body {
  height: 100%;
  margin: 0;
  font-family: Arial, sans-serif;
}

.content-wrapper {
  display: flex;
  flex-direction: row;
  height: calc(100vh - 60px); /* 헤더 제외한 전체 화면 */
  overflow: auto;
  padding: 20px;
}

.left {
  width: 250px; /* 사이드바 크기 */
  position: fixed;
  top: 60px; /* 헤더 위치 */
  bottom: 0;
  z-index: 999;
  padding: 20px;
  background-color: #f4f4f4;
  overflow-y: auto;
}

.right {

  padding: 20px;
  overflow-y: auto;
  width: 600px;
}

/* 차트 영역 */
.chart {
  width: 100%;
  max-width: 100%;
  margin: 20px auto;
}

.chart2, .chart3 {
  width: 100%;
  max-width: 300px;
  margin: 20px auto;
  margin-left: 70%;
}



/* 검색 폼 */
.card-body {
  padding: 20px;
}

input[type="text"], select {
  width: 100%;
}

/* 차트 관련 스타일 */
.graph_period {
  display: flex;
  gap: 10px;
}

.period {
  padding: 10px 20px;
  background-color: #f1f1f1;
  border: 1px solid #ccc;
  border-radius: 5px;
  cursor: pointer;
}
.btn-outline-primary:active, .btn-outline-success:active {
  color: white !important; /* 누를 때 글자 하얗게 */
  background-color: #0d6efd !important; /* primary 파랑 */
  border-color: #0d6efd !important;
}
    .sidebarTemp { height: 120%; }
</style>
</head>
<body>

	<!-- 관리자 헤더네비바  -->
	<c:set var="title" value="통계 관리"></c:set>
	<%@ include file="../adminHeader.jsp"%>

	<!-- 관리자 사이드바 -->
  <div class="sidebarTemp">
	<%@ include file="../adminSidebar.jsp"%>
  </div>
	<div class="content-wrapper">

		<div class="col-md-12" style="padding: 10px 20px 0px 20px">
						<div class="card card-secondary" style="margin-bottom: 8px;">
							<div class="card-header" id="divTitle">
							</div>

							<!-- /.card-header -->
							<!-- form start -->
							<form onsubmit="return false;" id="srhFrm">
								<!-- /.card-body -->
								<div class="card-body" style="padding: 10px 10px 0px;">
									<div class="row mb-4" style="margin-bottom: 0px !important">
										

									</div>
									<!-- 검색 1행 끝 -->

									<!-- 검색 2행 시작 -->
									<div class="row mb-4"
										style="margin-bottom: 0px !important; margin-top: 0px !important">
										 
										<!-- 기간시작일 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label class="small">공연기간 검색시작일</label>
											<div class="input-group date " id="start-date" data-target-input="nearest">
												<input type="date" id="startDate" name="startDate" class="form-control datetimepicker-input"
													data-target="#start-date">
												<div class="input-group-append" data-target="#start-date"
													data-toggle="datetimepicker">
													<div class="input-group-text"><i class="fa fa-calendar"></i></div>
												</div>
											</div>
										</div>

										<!-- 종료일 선택 -->
										<div class="col-md-2 form-group gap-5 mb-1">
											<label class="small">공연기간 검색종료일</label>
											<div class="input-group date" id="end-date" data-target-input="nearest">
												<input type="date" id="endDate" name="endDate" class="form-control datetimepicker-input" data-target="#end-date">
												<div class="input-group-append" data-target="#end-date"
													data-toggle="datetimepicker">
													<div class="input-group-text"><i class="fa fa-calendar"></i></div>
												</div>
											</div>
										</div>


										<div class="col-md-1 form-group gap-5 mb-0">
											<label for="search-title" class="small">&ensp;</label>
											<p>
												<button type="reset" class="btn btn-outline-dark col-md-12 " id="resetBtn">초기화</button>
											</p>
										</div>
										<div class="col-md-1 form-group gap-5 mb-0">
											<label for="search-title" class="small">&ensp;</label>
											<p>
											<a type="button" id="btnSearch" name="btnSearch" class="btn btn-outline-primary col-md-12 ">검색</a>
											</p>
										</div>
									</div>

									<!-- 검색옵션 2행 끝  -->

								</div>
							</form>
						</div>
						<div class="right2">
		  <div class="card">
		    <div class="card-body">
				  <div class="card-header d-flex justify-content-center">
				    <a href="/admin/stats/subscription?gubun=GD01" class="btn btn-outline-primary px-5 fs-5" id="aGoods" style="color: #0d6efd;">굿즈상품 매출</a>
				        				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="/admin/stats/subscription?gubun=GD02" class="btn btn-outline-success px-5 fs-5" id="aTicket" style="color: #198754;">티켓예매 매출</a>
				  </div>

		        <!-- 막대/선형 차트 -->
		        <div class="col-md-12">
		          <div class="chart">
		            <canvas id="myChart"></canvas>
		          </div>
		        </div>
		        
<!-- 		        <div class="chart2"> -->
<!-- 		           원형 차트 -->
<%-- 		            <canvas id="myChart2"></canvas> --%>
<!-- 		         </div> -->

		      
		      
<!-- 		       <div class="chart3"> -->
<%-- 			        <canvas id="myChart3"></canvas> --%>
<!-- 			     </div> -->
		    </div>
		
		<!-- 
		--1) 굿즈 매출
		--멤버십(굿즈 테이블에서 구분 : M), 일반굿즈(굿즈 테이블에서 구분 : G/I), 앨범(굿즈 테이블에서 구분 : A), DM(상품넘버 GDS_NO : 98)
		
		--2) 티켓예매 매출(*)
		--총매출, 콘서트, 팬미팅, 기타 매출
		 -->
		    <div class="card-footer" id="divFooter">
		      <div class="row text-center">
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header"><span id="spnTot"></span>원</h5>
		            <span class="description-text">총매출</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header"><span id="spnConcert"></span>원</h5>
		            <span class="description-text">콘서트 매출</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header"><span id="spnReservation"></span>원</h5>
		            <span class="description-text">팬미팅 매출</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block">
		            <h5 class="description-header"><span id="spnEtc"></span>원</h5>
		            <span class="description-text">기타 매출</span>
		          </div>
		        </div>
		      </div>
		      
		    </div>
		  </div>
		</div>
	</div>
</div>



	<!-- 관리자 풋터 -->

		<%@ include file="../adminFooter.jsp"%>
</body>


<script type="text/javascript">
//Chart.js 코드
const ctx = document.getElementById('myChart').getContext('2d');
let monthlySalesChart; // 차트 객체를 저장할 변수

//전역변수(굿즈 / 티켓 구분)
let gubun = "";

// 서버로부터 데이터를 비동기적으로 가져오는 함수
function fetchMonthlySalesData(gubun) {
	let formData = new FormData();
	
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();
	
	console.log("startDate : ", startDate);
	console.log("endDate : ", endDate);
	
	//StatsVO(..startDate=2025-04-01,..., startRow=1, endRow=10)
	formData.append("startDate",startDate);
	formData.append("endDate",endDate);
	formData.append("startRow","1");
	formData.append("endRow","10");
	formData.append("gubun",gubun);
	
	$.ajax({
		url:"/admin/stats/dateSubscriptionAjax",
		contentType: false,
        processData: false,
		data:formData,
		type:"post",
		dataType:"json",
		success:function(data){
			console.log("data : ", data);
			
			let stat1 = data.stat1;
			
			//I. Chart.js
			// Chart.js가 요구하는 형식으로 데이터 가공
	        const labels = stat1.map(item => item.saleDate); // x축 레이블 (월)
	        const quantities = stat1.map(item => item.totalRevenue); // y축 데이터 (판매량)

	        renderChart(labels, quantities); // 차트 렌더링 함수 호출
	        
	        //II. 총매출, 콘서트, 팬미팅, 기타 매출 
	        let stat2 = data.stat2;
	        
	        if(stat2!=null){
		        /*
		        콘서트 : 12995000
		        팬미팅 : 3972000
		        기타 : 1331000
		        */
		        
		        let sumInt = 0;
		        
		        $.each(stat2,function(idx,m){
		        	console.log(m.TK_CTGR + " : " + m.GRAMT);
		        	
		        	sumInt += Number(m.GRAMT);
		        	
		        	if(m.TK_CTGR=="콘서트"){
		        		$("#spnConcert").html(m.GRAMT);
		        	}else if(m.TK_CTGR=="팬미팅"){
		        		$("#spnReservation").html(m.GRAMT);
		        	}else{//기타
		        		$("#spnEtc").html(m.GRAMT);
		        	}
		        });
		        
		        $("#spnTot").html(sumInt);
	        }else{
	        	
	        }//end if
		}
	});
}

// 차트를 그리는 함수
function renderChart(labels, data) {
    // 만약 기존 차트가 있다면 파괴 (데이터 업데이트 시 유용)
    if (monthlySalesChart) {
        monthlySalesChart.destroy();
    }

    monthlySalesChart = new Chart(ctx, {
        type: 'bar', // 차트 종류: bar, line, pie 등
        data: {
            labels: labels, // x축 레이블
            datasets: [{
                label: '판매통계', // 데이터셋 레이블
                data: data,       // 실제 데이터
                backgroundColor: 'rgba(54, 162, 235, 0.5)', // 막대 색상
                borderColor: 'rgba(54, 162, 235, 1)',       // 막대 테두리 색상
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: { // y축 설정
                    beginAtZero: true // 0부터 시작
                }
            },
            responsive: true, // 반응형 활성화
            maintainAspectRatio: false // chart-container 스타일에 맞춰 크기 조절
        }
    });
}


$(function(){
	$("#aGoods").removeClass("activeMenu");
	$("#aTicket").removeClass("activeMenu");
	
	gubun = "${param.gubun}";
	
	if(gubun==null || gubun==""){
		gubun = "GD01";
	}
	
	console.log("gubun : ", gubun);
	
	// 페이지 제목 설정
	if(gubun=="GD01"){
		$("#divTitle").html("굿즈 통계");
		// 굿즈 매출만 보이기
		$("#spnGoodsFooter").show();
		$("#spnTicketFooter").hide();
	}else{
		$("#divTitle").html("티켓 통계");
		// 티켓 매출만 보이기
		$("#spnTicketFooter").show();
		$("#spnGoodsFooter").hide();
	}
	
	// 페이지 로드 시 데이터 가져와서 차트 그리기
	fetchMonthlySalesData(gubun);
	
	//검색
	$("#btnSearch").on("click",function(){
		if(gubun==null || gubun==""){
			gubun = "GD01";
		}
		
		console.log("gubun : ", gubun);
		
		// 검색 버튼 클릭 시 데이터 가져와서 차트 그리기
		fetchMonthlySalesData(gubun);
		
		// 검색 후, 데이터에 따라 매출 정보 보이기/숨기기
		if(gubun == "GD01"){
			$("#spnGoodsFooter").show();
			$("#spnTicketFooter").hide();
		} else {
			$("#spnTicketFooter").show();
			$("#spnGoodsFooter").hide();
		}
	});
});
</script>


</html>