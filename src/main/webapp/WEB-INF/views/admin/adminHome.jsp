<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<link href="/images/oHoT_logo.png" rel="icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<script src="/adminlte/dist/js/adminlte.min.js"></script>
</head>

<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
	
		<c:set var="title" value="홈"></c:set>
		<!-- 관리자 헤더네비바  -->
		<%@ include file="adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper">

			<section class="content pt-2">
				<div class="row ">
					<div class="col-lg-3 col-6">
						<!-- small box -->
						<div class="small-box bg-info">
							<div class="p-2 d-flex gap-5 justify-content-between align-items-center">
								<p class="ps-3 mb-0">최근 1개월 신규가입 회원 수</p>
								<h3 class="pe-3 mb-0">${memberTotal[0].totalCnt2}
									<span style="font-size: 20px">건</span>
								</h3>
							</div>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-6">
						<!-- small box -->
						<div class="small-box bg-success">
							<div class="p-2 d-flex gap-5 justify-content-between align-items-center">
								<p class="ps-3 mb-0">최근 1개월 멤버십 신규 가입 수</p>
								<h3 class="pe-3 mb-0">${followersTotal[0].totalCnt3}
									<span style="font-size: 20px">건</span>
								</h3>
							</div>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-6">
						<!-- small box -->
						<div class="small-box bg-warning">
							<div class="p-2 d-flex gap-5 justify-content-between align-items-center">
								<p class="ps-3 mb-0">최근 1개월 DM 신규 구독 수</p>
								<h3 class="pe-3 mb-0">${subscriptionTotal[0].totalCnt}
									<span style="font-size: 20px">건</span>
								</h3>
							</div>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-6">
						<!-- small box -->
						<div class="small-box bg-danger">
							<div class="p-2 d-flex gap-5 justify-content-between align-items-center">
								<p class="ps-3 mb-0">최근 1개월 커뮤니티 신규 가입 수</p>
								<h3 class="pe-3 mb-0">${goodTotal[0].totalCnt4}
									<span style="font-size: 20px">건</span>
								</h3>
							</div>
						</div>
					</div>
					<!-- ./col -->
				</div>

				<div class="row">
					<!-- 첫 번째 카드 -->
					<div class="col-2">
					<div class="card">
						<div class="card-header mt-1">
							<h3 class="card-title">이번달 인기 아티스트 TOP 5</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body p-0 mt-1">
							<div id="topArtists"></div>
						</div>
					</div>
					</div>

					
					<!-- 두번 째 카드 -->
					<div class="col-10">
						<div class="card">
							<div class="card-header">
								<h4 class="mb-0 text-center">최근 1개월 티켓 유형별 매출 통계</h4>
							</div>

							<div class="card-body">
								<div class="row">
									<!-- 막대/선형 차트 -->
									<div class="col-md-7">
										<div class="chart">
											<canvas id="myChart4" height="100px"></canvas>
										</div>
									</div>
									<div class="col-1"></div>
									<!-- 원형 차트 -->
									<div class="col-md-4">
										<canvas id="myChart3" height="250px"></canvas>
									</div>
								</div>
							</div>

							<div class="card-footer m-0 p-0" style="height: 60px;" >
								<div class="row text-center">
									<div class="col-3">
										<div class="description-block border-right">
											<h5 class="description-header">${reservationTotalSales[0].reservationTotalSales}</h5>
											<span class="description-text">총합 (원)</span>
										</div>
									</div>

									<div class="col-3">
										<div class="description-block border-right">
											<h5 class="description-header">${concertSales[0].concertTotalSales}</h5>
											<span class="description-text">콘서트 (원)</span>
										</div>
									</div>

									<div class="col-3">
										<div class="description-block border-right">
											<h5 class="description-header">${fanSales[0].fanmeetingTotalSales}</h5>
											<span class="description-text">팬미팅 (원)</span>
										</div>
									</div>

									<div class="col-3">
										<div class="description-block">
											<h5 class="description-header">${restSales[0].etcTicketSales}</h5>
											<span class="description-text">기타 (원)</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<div class="card" style="background-color: white; color: black; border: none;">
									<div class="card-header">
										<h4 class="mb-0 text-center">최근 1개월 일반 굿즈 매출</h4>
									</div>
									<div class="card-body p-1">
										<div class="row">
											<div class="col-1"></div>
											<div class="col-5 d-flex align-items-center">
												<div class="ms-5 color-palette-set" style="width:200px;">
													<div class="bg-primary text-center">
														<span>판매 수량 (건)</span>
													</div>
													<div class="bg-primary disabled text-center">
														<span>${salesVolume[0].totalQty}</span>
													</div>
												</div>
											</div>
											<div class="ms-2 col-5 d-flex align-items-center">
												<div class="color-palette-set" style="width:200px;">
													<div class="bg-primary text-center">
														<span>총 매출 (원)</span>
													</div>
													<div class="bg-primary disabled text-center">
														<span>${totalSales[0].totalAmount}</span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<canvas id="myChart" height="262px"></canvas>
								</div>
							</div>

							<div class="col-6">
								<div class="card">
									<div class="card-header">
										<h4 class="mb-0 text-center">최근 1개월 신고 접수 건</h4>
									</div>
									<div class="card-body p-0">
										<div class="row">
											<div class="col-12">
												<canvas id="myChart2" height="142px"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


				</div>
			</section>

		</div>

		<!-- 관리자 풋터 -->
		<%@ include file="adminFooter.jsp"%>

	</div>



	<script>
	
const obj_chart1 = document.getElementById('myChart');
const obj_chart2 = document.getElementById('myChart2');
const obj_chart3 = document.getElementById('myChart3');
const obj_chart4 = document.getElementById('myChart4');	
$(document).ready(function() {
	//아이돌 인기top6사진 업로드
	$.ajax({
	    url: "/admin/stats/idolPost",
	    type: "post",
	    dataType: "json",
	    success: function(resp) {
	      console.log("resp : ", resp);
	      
	      let str = "";
	      
	      $.each(resp, function(idx, artist){
	    	  str += `
	    		<div class="row align-items-center ms-3">
	    		  <div class="col-auto text-center">
	    		    <div class="card" style="width: 200px; border: none; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
	    		      <img src="/upload\${artist.fileSaveLocate}" class="card-img-top" style="width: 100%; height: 100px; object-fit: cover;">
	    		      <div class="card-body p-1">
	    		        <div style="display: flex; justify-content: space-between; align-items: center;">
	    		          <span style="font-size: 1rem; font-weight: bold; color: #333;">
	    		            TOP \${idx + 1}
	    		          </span>
	    		          <span style="font-size: 1rem; font-weight: bold; color: #333; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
	    		            \${artist.artistName}
	    		          </span>
	    		        </div>
	    		      </div>
	    		    </div>
	    		  </div>
	    		</div>
		      `;
	      });
	      
	      $("#topArtists").html(str);
	    }
	  });
	
	$.ajax({
	    url: "/admin/stats/listAjax",
	    type: "post",
	    dataType: "json",
	    success: function(resp) {
	      getStats1(resp);
	    }
	  });

	  $.ajax({
	    url: "/admin/stats/listBarAjax",
	    type: "post",
	    dataType: "json",
	    success: function(resp) {
	      getStats2(resp);
	    }
	  });
	
	  $.ajax({
		    url: "/admin/stats/listdoughnutAjax2",
		    type: "post",
		    dataType: "json",
		    success: function(resp) {
		      getStats4(resp);
		    }
		});
		
		//이번달 티켓 굿즈 디엠 멤버십 현황(myChart3 => const obj_chart3 = document.getElementById('myChart3'))
	  $.ajax({
		    url: "/admin/stats/listdoughnutAjax",
		    type: "post",
		    dataType: "json",
		    success: function(resp) {
		    	console.log("이번달 티켓 굿즈 디엠 멤버십 현황->resp : ", resp);
		    	
		    	//resp : listdoughnutAjax
		    	getStats3(resp);
		    }
		});
	
});




function getStats1(statsList) {
  let labels = [], data = [];
  $.each(statsList, function(idx, stats) {
    labels.push(stats.saleDate);
    data.push(stats.totalSale);
  });

  new Chart(obj_chart1, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } },
    	plugins: {
    	      legend: {
    	        display: false // ← 범례 숨기기
    	      }
    	    }
    }
  });
}

function getStats2(listBarAjax) {
  let labels = [], data = [];
  $.each(listBarAjax, function(idx, stats2) {
    labels.push(stats2.reportRegDt);
    data.push(stats2.cnt2);
  });

  new Chart(obj_chart2, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        label: '이번달 총매출',
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } } }
  });
}

function getStats2(listBarAjax) {
  let labels = [], data = [];
  $.each(listBarAjax, function(idx, stats2) {
    labels.push(stats2.reportRegDt);
    data.push(stats2.cnt2);
  });

  new Chart(obj_chart2, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } },
    plugins: {
	      legend: {
	        display: false // ← 범례 숨기기
	      }
	    }
    }
  });
}

//예매통계
function getStats4(listdoughnutAjax2) {
  let labels = [], data = [];
  $.each(listdoughnutAjax2, function(idx, stats4) {
    labels.push(stats4.saleDate);
    data.push(stats4.totalRevenue);
  });

  new Chart(obj_chart4, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } },
    	plugins: {
  	      legend: {
  	        display: false // ← 범례 숨기기
  	      }
  	    }	
    }
    
  });
}


let chartInstance3 = null; // 차트 인스턴스를 저장할 변수

// 이번달 티켓 굿즈 디엠 멤버십 현황
function getStats3(listdoughnutAjax) {
    if (!listdoughnutAjax || listdoughnutAjax.length === 0) {
        console.warn("데이터가 비어있습니다.");
        return;
    }

    let labels = [ '콘서트', '팬미팅', '기타'];
    let data = [];

    // 단일 객체에서 각 값 추출
    const stats3 = listdoughnutAjax;  // 첫 번째 객체만 사용
    console.log("getStats3->stats3 : ", stats3); // stats3 객체 로그

    // 각 항목에 대한 값이 없으면 0을 사용
    const totalCnts1 = stats3.totalCnts1 || 0;  // 신규 회원
    const totalCnts2 = stats3.totalCnts2 || 0;  // DM 구독 시작
    const totalCnts3 = stats3.totalCnts3 || 0;  // 멤버십 시작

    
    console.log("totalCnts1 : ", totalCnts1);
    console.log("totalCnts2: ", totalCnts2);
    console.log("totalCnts3 : ", totalCnts3);


    // 차트에 반영할 데이터 배열
    data.push(totalCnts1);
    data.push(totalCnts2);
    data.push(totalCnts3);
 

    console.log("받은 데이터:", listdoughnutAjax); // 데이터 로그
    console.log("labels:", labels); // 라벨 확인
    console.log("data:", data); // 데이터 확인

    // 이전 차트 인스턴스가 있으면 파괴
    if (chartInstance3) {
        chartInstance3.destroy();
    }

    // 새로운 차트 인스턴스 생성
    chartInstance3 = new Chart(obj_chart3, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                label: '매출',
                backgroundColor: [
                    'rgba(255, 99, 132, 0.6)', // 신규 회원   
                    'rgba(54, 162, 235, 0.6)', // DM 구독 시작
                    'rgba(255, 206, 86, 0.6)', // 멤버십 시작  
                    'rgba(75, 192, 192, 0.6)'  // 커뮤니티 가입 
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: false,
            plugins: {
                legend: {
                    position: 'right'
                },
                title: {
                    display: true,
                    text: '카테고리별 매출 비율'
                }
            }
        }
    });
}
</script>
</body>
</html>