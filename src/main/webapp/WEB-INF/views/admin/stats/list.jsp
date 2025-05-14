<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
  <script src="/adminlte/dist/js/adminlte.min.js"></script>

  <style>
    .container { background: none; }
    .button {
      font-size: 50px;
      position: relative;
      right: 80px;
      top: 0px;
      width: 40px;
      height: 40px;
      z-index: 99;
      
      transition: 0.8s ease;
      background: none;
      border: none;
    }

    .header { width: 90%; height: 10%; display: inline-block; }
    .wrapper { width: 100vw; height: 10%; display: inline-block; }
    .left  {
	  vertical-align: top;
	  display: inline-block;
	  width: 25%;
	  height: 250px;
	  margin-left: 5%;
	  margin-top: 0%; /* ← 예: 4% → 1%로 줄이면 myChart가 위로 올라감 */
	}
	.right {
	  vertical-align: top;
	  display: inline-block;
	  width: 38%;
	  height: 250px;
	  margin-left: 5%;
	  margin-top: 0%; /* ← 예: 4% → 1%로 줄이면 myChart가 위로 올라감 */
	}
	.left2{
	  vertical-align: top;
	  display: inline-block;
	  width: 25%;
	  height: 250px;
	  margin-left: 18%;
	  margin-top: -18%; /* ← 예: 4% → 1%로 줄이면 myChart가 위로 올라감 */
	
	}
    .right2 {
      vertical-align: top;
      display: inline-block;
      width:850px;
      height:350px;
      margin-left: 5%;
      margin-top: -28%;
    }
    .right3 {
      vertical-align: top;
      display: inline-block;
      width:350px;
      height:350px;
      margin-left: 67%;
      margin-top: -20%;
    }

    .sidebarTemp { height: 100%; }
    .content {
      padding: 100px 20px 0 40px;
      position: relative;
      width: 100%;
    }

    .menubar .submenu { display: none; }
    .menubar { position: relative; }

    .nav-2 {
      width: 100%;
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
    }

    .word {
      font-size: 25px;
      font-family: 'Cafe24Ssurround';
      color: black;
      cursor: pointer;
    }

    .keyword_rank, .keyword_rank2 {
      display: inline-block;
      font-size: 25px;
    }

    html, body {
      width: 100%;
      overflow-x: hidden;
      margin: 0;
      padding: 0;
    }

    .rank_list {
      list-style: none;
      padding: 0;
    }

    .rank_list li {
      background-color: #fff;
      margin-bottom: 10px;
      padding: 12px 18px;
      border-radius: 10px;
      box-shadow: 0 1px 4px rgba(0,0,0,0.05);
      transition: all 0.2s;
    }

    .rank_list li:hover {
      background-color: #f0f0f0;
    }

    .rank_title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 10px;
      display: block;
    }

    /* 새로운 콘텐츠 영역 스타일 */
    .new-widgets-container {
      display: flex;
      gap: 20px; /* 박스 사이 간격 */
    }

    .new-widget {
      background-color: #fff;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      flex: 1; /* 동일한 너비로 분할 */
    }

    .new-widget-title {
      font-size: 1.5rem;
      font-weight: bold;
      margin-bottom: 10px;
      color: #333;
    }

    .new-widget-content {
      color: #666;
      line-height: 1.6;
    }
  </style>
</head>

<body>

  <%@ include file="../adminHeader.jsp"%>

  <div class="sidebarTemp">
    <%@ include file="../adminSidebar.jsp"%>
  </div>

  <div class="content-wrapper">
    <div class="row">
  <div class="col-8 col-sm-4 col-md-3">
    <div class="info-box" style="background-color: #1e90ff; color: #ffffff;">
      <span class="info-box-icon bg-warning elevation-1">
        <i class="ion ion-person-add"></i>
      </span>
      <div class="info-box-content">
        <span class="info-box-text">이번달 신규회원</span>
        <span class="info-box-number">
          ${memberTotal[0].totalCnt2}
        </span>
      </div>
    </div>
  </div>

  <div class="col-8 col-sm-4 col-md-3">
    <div class="info-box" style="background-color: #1e90ff; color: #ffffff;">
      <span class="info-box-icon bg-info elevation-1">
        <i class="ion ion-bag"></i>
      </span>
      <div class="info-box-content">
        <span class="info-box-text">이번달 멤버쉽 신규 가입</span>
        <span class="info-box-number">
          ${FollowersTotal[0].totalCnt3}
        </span>
      </div>
    </div>
  </div>



  <div class="col-8 col-sm-4 col-md-3">
    <div class="info-box" style="background-color: #1e90ff; color: #ffffff;">
      <span class="info-box-icon bg-success elevation-1">
        <i class="ion ion-stats-bars"></i>
      </span>
      <div class="info-box-content">
        <span class="info-box-text">이번달 신규 누적구독수</span>
        <span class="info-box-number">
          ${SubscriptionTotal[0].totalCnt}
        </span>
      </div>
    </div>
  </div>

  <div class="col-8 col-sm-4 col-md-3">
    <div class="info-box" style="background-color: #1e90ff; color: #ffffff;">
      <span class="info-box-icon bg-danger elevation-1">
        <i class="ion ion-pie-graph"></i>
      </span>
      <div class="info-box-content">
        <span class="info-box-text">이번달 커뮤니티 신규 가입</span>
        <span class="info-box-number">
          ${goodTotal[0].totalCnt4}
        </span>
      </div>
    </div>
  </div>
</div>

    <div class="wrapper">
    
      <div class="left">
      <div class="card" style="background-color: white; color: black; border: none;">
        <div class="card-header">
		    <h4 class="mb-0 text-center">이번달 굿즈샵</h4>
		  </div>
		  <div class="card-body">
		    <div class="row">
		      <div class="col-md-6 d-flex align-items-center">
		        <div class="color-palette-set w-100">
		          <div class="bg-primary color-palette text-center"><span>판매수</span></div>
		          <div class="bg-primary disabled color-palette text-center">
		            <span>${salesVolume[0].totalQty}</span>
		          </div>
		        </div>
		      </div>
		      <div class="col-md-6 d-flex align-items-center">
		        <div class="color-palette-set w-100">
		          <div class="bg-primary color-palette text-center"><span>총매출</span></div>
		          <div class="bg-primary disabled color-palette text-center">
		            <span>${totalSales[0].totalAmount}</span>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
        <canvas id="myChart"></canvas>
      </div>
	</div>
      <!-- 사진 -->

     <div class="right">
        <div class="card">
		  <div class="card-header">
		    <h3 class="card-title">이번달 DM구독 인기아이돌 Top 5</h3>
		
		    <div class="card-tools">
		      <span class="badge badge-danger">Top 5</span>
		      
		    </div>
		  </div>
		  <!-- /.card-header -->
		  <div class="card-body p-0">
		    <ul class="users-list clearfix" id="topArtists">
		    <!-- 동기로 했다가 비동기로 바꿈 -->
		      <%-- <c:forEach var="artist" items="${topArtists}"> 
		        <li>
		          <img src="${artist.fileSaveLocate}${artist.fileSaveName}" alt="${artist.artistName}" style="width:80px; height:80px; object-fit:cover;" />
		          <a class="users-list-name" href="javascript:void(0);">${artist.artistName}</a>
		          <span class="users-list-date">TOP</span>
		        </li>
		      </c:forEach> --%>
		    </ul>
		  </div>
		  <!-- /.card-body -->
		 
		  <!-- /.card-footer -->
		</div>
      </div>
          
          
          <div class="card-footer text-center">
          </div>
        </div>
      </div>
      <!-- 사진 끝 -->

      <div class="wrapper">
        <div class="left2">
		  <div class="card">
		    <div class="card-header">
		      <h4 class="mb-0 text-center">이번달 신고현황</h4>
		    </div>
		    <div class="card-body">
		      <div class="row">
		        <div class="col-12">
		          <canvas id="myChart2"></canvas>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
        
        <!-- 그래프 영역 -->
         <div class="right2">
		  <div class="card">
		    <div class="card-header">
		      <h4 class="mb-0 text-center">이번달 티켓 매출</h4>
		    </div>
		
		    <div class="card-body">
		      <div class="row">
		        <!-- 막대/선형 차트 -->
		        <div class="col-md-8">
		          <div class="chart">
		            <canvas id="myChart4" height="180"></canvas>
		          </div>
		        </div>
		
		        <!-- 원형 차트 -->
		        <div class="col-md-4">
		          <h5 class="text-center">티켓종류 원형그래프</h5>
		          <canvas id="myChart3"></canvas>
		        </div>
		      </div>
		    </div>
		
		    <div class="card-footer">
		      <div class="row text-center">
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header">${reservationTotalSales[0].reservationTotalSales}원</h5>
		            <span class="description-text">전체 매출</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header">${concertSales[0].concertTotalSales}원</h5>
		            <span class="description-text">콘서트 예매 매출</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block border-right">
		            <h5 class="description-header">${fanSales[0].fanmeetingTotalSales}원</h5>
		            <span class="description-text">팬미팅 예매</span>
		          </div>
		        </div>
		
		        <div class="col-sm-3 col-6">
		          <div class="description-block"> 
		            <h5 class="description-header">${restSales[0].etcTicketSales}원</h5>
		            <span class="description-text">기타</span>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
    </div>


  <%@ include file="../adminFooter.jsp"%>
</body>

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
	    	  str += `<li style="width:20%;">
	      		<img src="/upload\${artist.fileSaveLocate}" alt="\${artist.artistName}" style="width:40px; height:40px; object-fit:cover;" />
		        <p class="users-list-name">\${artist.artistName}</p>
		      </li>`;
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

	//커뮤니티 통계 티켓 굿즈 디엠 멤버쉽
//   $.ajax({
//     url: "/admin/stats/listdoughnutAjax",
//     type: "post",
//     dataType: "json",
//     success: function(resp) {
//       getStats3(resp);
//     }
//   });
	//예매통계
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
        label: '# of Votes',
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
        label: '누적신고수 : ${reportTotal[0].reportTotalCnt}건',
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } } }
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
        label: '예매 총매출',
        data: data,
        borderWidth: 3
      }]
    },
    options: { scales: { y: { beginAtZero: true } } }
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
                label: '예매별 매출비율',
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
            responsive: true,
            plugins: {
                legend: {
                    position: 'right'
                },
                title: {
                    display: true,
                    text: '예매별 매출비율'
                }
            }
        }
    });
}
</script>

</html>
