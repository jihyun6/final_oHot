<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
</head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">	
	<!-- 관리자 헤더네비바  -->
	<%@ include file="../adminHeader.jsp"%>
	
	<!-- 관리자 사이드바 -->
	<%@ include file="../adminSidebar.jsp"%>

	<!-- 컨텐츠-->
	<div class="content-wrapper">
		<div class="row">
		<div class="col-lg-3 col-6">
			<div class="small-box bg-info">
				<div class="inner">
					<h3>${SubscriptionTotal[0].totalCnt}</h3> 
					<p>누적구독수</p>
				</div>
				<div class="icon">
					<i class="ion ion-bag"></i>
				</div>
				
			</div>
		</div>
		<!-- ./col -->
		<div class="col-lg-3 col-6">
			<!-- small box -->
			<div class="small-box bg-success">
				<div class="inner">
					<h3>${SubscriptionTotal2[0].totalCnt2}</h3>
					<p>가입자수</p>
				</div>
				<div class="icon">
					<i class="ion ion-stats-bars"></i>
				</div>
			</div>
		</div>
		<!-- ./col -->
		<div class="col-lg-3 col-6">
			<!-- small box -->
			<div class="small-box bg-warning">
				<div class="inner">
					<h3>${SubscriptionTotal3[0].totalCnt3}</h3>

					<p>팔로워수</p>
				</div>
				<div class="icon">
					<i class="ion ion-person-add"></i>
				</div>
			</div>
		</div>
		<!-- ./col -->
		<div class="col-lg-3 col-6">
			<!-- small box -->
			<div class="small-box bg-danger">
				<div class="inner">
					<h3>${SubscriptionTotal4[0].totalCnt4}</h3>

					<p>누적 좋아요수</p>
				</div>
				<div class="icon">
					<i class="ion ion-pie-graph"></i>
				</div>
			</div>
		</div>
		<!-- ./col -->
	</div>









	<!-- sidebar 영역 -->
	<div class="container">
		<div class="sidebarTemp" style="width: 230px; height: 100%;">
			<button class="button">⚡</button>
			<div class="content"></div>
			<div class="nav-2">
				<div class="menubar">
					<a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 설문관리</h3>
					</a><br> <a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 굿즈인사이트</h3>
					</a><br> <a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 구독관리</h3>
					</a>
				</div>
			</div>
		</div>
	</div>


	<div class="wrapper">
		<div class="left">

			<div class="row">
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-black color-palette">
							<span>판매수</span>
						</div>
						<div class="bg-black disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-gray-dark color-palette">
							<span>매출</span>
						</div>
						<div class="bg-gray-dark disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-gray color-palette">
							<span>높은 매출 굿즈 상품</span>
						</div>
						<div class="bg-gray disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center bg-light">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-light color-palette">
							<span>높은 매출 굿즈 매출</span>
						</div>
						<div class="bg-light disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
			</div>
			<canvas id="myChart"></canvas>

		</div>
		<div class="right">
			<h1>오늘 순위</h1>
			<div class="keyword_rank" style="width: 350px;">
				<div class="rank_inner v2">
					<strong class="rank_title"> <span class="title_cell">굿즈상품순위</span>
					</strong>
					<div class="rank_scroll" style="left: 0px; width: 5000px;">
						<ul class="rank_list">
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EC%9C%84%EB%93%9C%EC%9E%90%EC%BC%93"
								class="list_area"> <em class="num">1</em> <span
									class="title">트위드자켓</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">2</em> <span
									class="title">원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4"
								class="list_area"> <em class="num">3</em> <span
									class="title">블라우스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8B%B0%EC%85%94%EC%B8%A0"
								class="list_area"> <em class="num">4</em> <span
									class="title">티셔츠</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EB%A0%8C%EC%B9%98%EC%BD%94%ED%8A%B8"
								class="list_area"> <em class="num">5</em> <span
									class="title">트렌치코트</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%82%98%EC%9D%B4%ED%82%A4%EB%B0%94%EB%9E%8C%EB%A7%89%EC%9D%B4"
								class="list_area"> <em class="num">6</em> <span
									class="title">나이키바람막이</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8A%A4%ED%88%AC%EC%8B%9C%EB%B0%98%ED%8C%94"
								class="list_area"> <em class="num">7</em> <span
									class="title">스투시반팔</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">8</em> <span
									class="title">써스데이아일랜드원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C"
								class="list_area"> <em class="num">9</em> <span
									class="title">써스데이아일랜드</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%95%84%EB%94%94%EB%8B%A4%EC%8A%A4%EC%A0%B8%EC%A7%80"
								class="list_area"> <em class="num">10</em> <span
									class="title">아디다스져지</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="keyword_rank2" style="width: 350px;">
				<div class="rank_inner v2">
					<strong class="rank_title"> <span class="title_cell">아티스트순위</span>
					</strong>
					<div class="rank_scroll" style="left: 0px; width: 5000px;">
						<ul class="rank_list">
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EC%9C%84%EB%93%9C%EC%9E%90%EC%BC%93"
								class="list_area"> <em class="num">1</em> <span
									class="title">트위드자켓</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">2</em> <span
									class="title">원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4"
								class="list_area"> <em class="num">3</em> <span
									class="title">블라우스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8B%B0%EC%85%94%EC%B8%A0"
								class="list_area"> <em class="num">4</em> <span
									class="title">티셔츠</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EB%A0%8C%EC%B9%98%EC%BD%94%ED%8A%B8"
								class="list_area"> <em class="num">5</em> <span
									class="title">트렌치코트</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%82%98%EC%9D%B4%ED%82%A4%EB%B0%94%EB%9E%8C%EB%A7%89%EC%9D%B4"
								class="list_area"> <em class="num">6</em> <span
									class="title">나이키바람막이</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8A%A4%ED%88%AC%EC%8B%9C%EB%B0%98%ED%8C%94"
								class="list_area"> <em class="num">7</em> <span
									class="title">스투시반팔</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">8</em> <span
									class="title">써스데이아일랜드원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C"
								class="list_area"> <em class="num">9</em> <span
									class="title">써스데이아일랜드</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%95%84%EB%94%94%EB%8B%A4%EC%8A%A4%EC%A0%B8%EC%A7%80"
								class="list_area"> <em class="num">10</em> <span
									class="title">아디다스져지</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="wrapper">
			<div class="left">
				<h1>댓글 통계</h1>
				<canvas id="myChart2"></canvas>

			</div>
			<div class="right">
				<h1>예매 통계</h1>
				<canvas id="myChart3"></canvas>
			</div>

		</div>

	</div>
	<!-- sidebar 영역 -->
	<div class="container">
		<div class="sidebarTemp" style="width: 230px; height: 100%;">
			<button class="button">⚡</button>
			<div class="content"></div>
			<div class="nav-2">
				<div class="menubar">
					<a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 설문관리</h3>
					</a><br> <a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 굿즈인사이트</h3>
					</a><br> <a class="word">&ensp;&ensp;
						<h3>&ensp;&ensp; 구독관리</h3>
					</a>
				</div>
			</div>
		</div>
	</div>


	<div class="wrapper">
		<div class="left">

			<div class="row">
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-black color-palette">
							<span>판매수</span>
						</div>
						<div class="bg-black disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-gray-dark color-palette">
							<span>매출</span>
						</div>
						<div class="bg-gray-dark disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-gray color-palette">
							<span>높은 매출 굿즈 상품</span>
						</div>
						<div class="bg-gray disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 col-md-2">
					<h4 class="text-center bg-light">이번달</h4>

					<div class="color-palette-set">
						<div class="bg-light color-palette">
							<span>높은 매출 굿즈 매출</span>
						</div>
						<div class="bg-light disabled color-palette">
							<span>Disabled</span>
						</div>
					</div>
				</div>
			</div>
			<canvas id="myChart"></canvas>

		</div>
		<div class="right">
			<h1>오늘 순위</h1>
			<div class="keyword_rank" style="width: 350px;">
				<div class="rank_inner v2">
					<strong class="rank_title"> <span class="title_cell">굿즈상품순위</span>
					</strong>
					<div class="rank_scroll" style="left: 0px; width: 5000px;">
						<ul class="rank_list">
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EC%9C%84%EB%93%9C%EC%9E%90%EC%BC%93"
								class="list_area"> <em class="num">1</em> <span
									class="title">트위드자켓</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">2</em> <span
									class="title">원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4"
								class="list_area"> <em class="num">3</em> <span
									class="title">블라우스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8B%B0%EC%85%94%EC%B8%A0"
								class="list_area"> <em class="num">4</em> <span
									class="title">티셔츠</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EB%A0%8C%EC%B9%98%EC%BD%94%ED%8A%B8"
								class="list_area"> <em class="num">5</em> <span
									class="title">트렌치코트</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%82%98%EC%9D%B4%ED%82%A4%EB%B0%94%EB%9E%8C%EB%A7%89%EC%9D%B4"
								class="list_area"> <em class="num">6</em> <span
									class="title">나이키바람막이</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8A%A4%ED%88%AC%EC%8B%9C%EB%B0%98%ED%8C%94"
								class="list_area"> <em class="num">7</em> <span
									class="title">스투시반팔</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">8</em> <span
									class="title">써스데이아일랜드원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C"
								class="list_area"> <em class="num">9</em> <span
									class="title">써스데이아일랜드</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%95%84%EB%94%94%EB%8B%A4%EC%8A%A4%EC%A0%B8%EC%A7%80"
								class="list_area"> <em class="num">10</em> <span
									class="title">아디다스져지</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="keyword_rank2" style="width: 350px;">
				<div class="rank_inner v2">
					<strong class="rank_title"> <span class="title_cell">아티스트순위</span>
					</strong>
					<div class="rank_scroll" style="left: 0px; width: 5000px;">
						<ul class="rank_list">
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EC%9C%84%EB%93%9C%EC%9E%90%EC%BC%93"
								class="list_area"> <em class="num">1</em> <span
									class="title">트위드자켓</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">2</em> <span
									class="title">원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4"
								class="list_area"> <em class="num">3</em> <span
									class="title">블라우스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8B%B0%EC%85%94%EC%B8%A0"
								class="list_area"> <em class="num">4</em> <span
									class="title">티셔츠</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%ED%8A%B8%EB%A0%8C%EC%B9%98%EC%BD%94%ED%8A%B8"
								class="list_area"> <em class="num">5</em> <span
									class="title">트렌치코트</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EB%82%98%EC%9D%B4%ED%82%A4%EB%B0%94%EB%9E%8C%EB%A7%89%EC%9D%B4"
								class="list_area"> <em class="num">6</em> <span
									class="title">나이키바람막이</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8A%A4%ED%88%AC%EC%8B%9C%EB%B0%98%ED%8C%94"
								class="list_area"> <em class="num">7</em> <span
									class="title">스투시반팔</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C%EC%9B%90%ED%94%BC%EC%8A%A4"
								class="list_area"> <em class="num">8</em> <span
									class="title">써스데이아일랜드원피스</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%8D%A8%EC%8A%A4%EB%8D%B0%EC%9D%B4%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C"
								class="list_area"> <em class="num">9</em> <span
									class="title">써스데이아일랜드</span>
							</a></li>
							<li class="list"><a
								href="/shoppingInsight/sKeyword.naver?keyword=%EC%95%84%EB%94%94%EB%8B%A4%EC%8A%A4%EC%A0%B8%EC%A7%80"
								class="list_area"> <em class="num">10</em> <span
									class="title">아디다스져지</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="wrapper">
			<div class="left">
				<h1>댓글 통계</h1>
				<canvas id="myChart2"></canvas>

			</div>
			<div class="right">
				<h1>예매 통계</h1>
				<canvas id="myChart3"></canvas>
			</div>

		</div>

	</div>
	</div>
	<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
	
</div>
</body>
<script>
const button = document.querySelector(".button");
const sidebarTemp = document.querySelector(".sidebarTemp");
let isSidebarOpen = false;
let timeoutId;

sidebarTemp.style.width = "0";

button.addEventListener("click", () => {

	if (!isSidebarOpen) {
		sidebarTemp.style.width = "300px";
		isSidebarOpen = true;
	} else {
		sidebarTemp.style.width = "0";
		button.style.right = "80px";
		closeSubmenus();
		isSidebarOpen = false;
	}
});

function closeSubmenus() {
	const submenus = document.querySelectorAll(".submenu");
	submenus.forEach((submenu) => {
		submenu.style.display = "none";
	});

	if (!document.querySelector('.submenu[style*="block"]')) {
		button.style.right = "80px";
	}
}


const obj_chart1 = document.getElementById('myChart');
const obj_chart2 = document.getElementById('myChart2');
const obj_chart3 = document.getElementById('myChart3');

$(document).ready(function() {

	$.ajax({
		url: "/admin/stats/listAjax",
		type: "post",
		dataType: "json",
		success: function(resp) {
			console.log("====================================================1");
			console.log("resp : ", resp);
			getStats1(resp);
		}
	});
	
	$.ajax({
		url: "/admin/stats/listBarAjax",
		type: "post",
		dataType: "json",
		success: function(resp) {
			console.log("====================================================2");
			console.log("resp : ", resp);
			getStats2(resp);
			
		}
	});
	
	$.ajax({
		url: "/admin/stats/listdoughnutAjax",
		type: "post",
		dataType: "json",
		success: function(resp) {
			console.log("====================================================3");
			console.log("resp : ", resp);
			getStats3(resp);
			
		}
	});
});

function getStats1(statsList) {

	//console.log("getStats->statsList : ", statsList);

	let labels = [];
	let data = [];


	$.each(statsList, function(idx, stats) {
		labels.push(stats.dmStrYmd);
		data.push(stats.cnt);
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
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
}

function getStats2(listBarAjax) {

	//console.log("getStats->statsList : ", statsList);

	let labels = [];
	let data = [];


	$.each(listBarAjax, function(idx, stats2) {
		labels.push(stats2.replyCreateDt);
		data.push(stats2.cnt2);
	});

	new Chart(obj_chart2, {
		type: 'bar',
		data: {
			labels: labels,
			datasets: [{
				label: '# of Votes',
				data: data,
				borderWidth: 3
			}]
		},
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
}

function getStats3(listdoughnutAjax) {

	//console.log("getStats->statsList : ", statsList);

	let labels = [];
	let data = [];

	
	$.each(listdoughnutAjax, function(idx, stats3) {
		labels.push(stats3.tkStartYmd);
		data.push(stats3.cnt3);
	});

	new Chart(obj_chart3, {
		type: 'doughnut',
		data: {
			labels: labels,
			datasets: [{
				label: '# of Votes',
				data: data,
				borderWidth: 3
			}]
		},
		
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
	
}






  
</script>
</html>