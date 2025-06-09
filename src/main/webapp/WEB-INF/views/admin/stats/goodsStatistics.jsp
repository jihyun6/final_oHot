<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독관리</title>
<style>
.left {
  width: 100%;
  float: left;
  max-height: 90vh; /* 화면 세로 90%까지만 */
  overflow-y: auto; /* 넘치면 스크롤 */
}

.right {
  width: 19%;
  float: right;
  margin-top: 0;
  height: 600px;
}
.product-name {
  white-space: nowrap; /* 한 줄로 */
  overflow: hidden; /* 넘치면 감춤 */
  text-overflow: ellipsis; /* ... 표시 */
  max-width: 200px; /* 원하는 너비로 조정 */
}

</style>
<!-- JS & CSS -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="/adminlte/dist/css/adminlte.min.css" />
<script src="/adminlte/dist/js/adminlte.min.js"></script>

</head>

<body class="sidebar-mini">

	<c:set var="title" value="통계 관리"></c:set>
	<%@ include file="../adminHeader.jsp"%>
	<div class="sidebarTemp">
		<%@ include file="../adminSidebar.jsp"%>
	</div>
	<div class="content-wrapper" style="padding: 20px;">
		<div class="card card-secondary">
			<div class="card-header"></div>

			<!-- 검색 폼 -->
			<form id="frm" name="frm" action="/admin/stats/GoodsStatistics" method="get">
				<div class="card-body">
					<div class="row" id="example1_filter"  >
						<div class="col-md-2">
						<!-- <div id="example1_filter" > -->
							<label class="small">상품번호</label>
							<input type="text" class="form-control" id="gdsNo" name="gdsNo" placeholder="상품번호">
			
							<label class="small">조회기간 시작</label>
							<input type="text" class="form-control" id="startDate" name="startDate" placeholder="YYYY-MM-DD">
						</div>
						<div class="col-md-2">
							<label class="small">상품유형</label>
							<select id="gdsDelYn" name="gdsDelYn" class="form-control">
								<option value="all">전체보기</option>
								<option value="G">G:그룹상품</option>
								<option value="I">I:개별상품</option>
								<option value="M">  M: MEMBERSHIP</option>
								<option value="A">A: ALBUM</option>
								<option value="D">D: DM</option>
							</select>
  							
							<label class="small">조회기간 종료</label>
							<input type="text" class="form-control" id="endDate" name="endDate" placeholder="YYYY-MM-DD">
						</div>
						<div class="col-md-2">
							<label class="small">상품명</label>
							<input type="search" name="keyword" class="form-control" placeholder="검색어를 입력해주세요" value="${param.keyword}" />
						</div>
						<div class="col-md-2">
							<label class="small">상품단가</label>
							<input type="text" class="form-control" id="unitPrice" name="unitPrice" placeholder="상품단가">
						</div>
						<div class="col-md-2">
							<label class="small">구매건수</label>
							<input type="text" class="form-control" id="productPurchases" name="productPurchases" placeholder="구매건수">
						</div>
						<div class="col-md-1">
							<label class="small">상품수</label>
							<input type="text" class="form-control" id="goodsNum" name="goodsNum" placeholder="상품수">
							
							<br>
						
							<button type="reset" class="btn btn-outline-dark mt-2 w-100">초기화</button>
						</div>
						<div class="col-md-1 d-flex align-items-end">
							<button type="submit" class="btn btn-outline-primary w-100">검색</button>
						</div>
					</div>
				
				</div>
			</form>
		</div>
		<!-- 리스트 영역 (겹침 방지를 위한 margin-top 추가됨) -->
		<div class="left">
			<div class="d-flex justify-content-end mb-2 w-100">
				<a href="/admin/shop/adGoodsCreate" class="btn btn-primary "> <i
					class="fas fa-plus"></i> exel
				</a>
			</div>
			<div class="card-body table-responsive p-0">
				<table class="table table-hover text-nowrap">
					<thead>
						<tr>
							<th>목록번호</th>
							<th>상품번호</th>
							<th>상품유형</th>
							<th>상품명</th>
							<th>상품단가</th>
							<th>구매건수</th>
							<th>등록일자</th>
							<th>아티스트 번호</th>
							<th>그룹명</th>
							<th>상품수</th>
							<th>판매율</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="statsVO" items="${goodsStatistics}"
							varStatus="stat">
							<tr>
								<td>${statsVO.rnum}</td>
								<td>${statsVO.gdsNo}</td>
								<td>${statsVO.gdsType}</td>
								<td class="product-name">${statsVO.gdsNm}</td>
								<td>${statsVO.unitPrice}</td>
								<td>${statsVO.productPurchases}</td>
								<td>${statsVO.regDt}</td>
								<td>${statsVO.artGroupNo}</td>
								<td>${statsVO.artGroupNm}</td>
								<td>${statsVO.goodsNum}</td>
								<td>${statsVO.competition}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="row">
				<div class="col-sm-12 col-md-5">
					<div class="dataTables_info" id="example2_info" role="status"
						aria-live="polite">
						Showing
					</div>
				</div>
				<div class="col-sm-12 col-md-7">
					<div class="dataTables_paginate paging_simple_numbers"
						id="example2_paginate">
						<ul class="pagination">
							<!-- 
								ArticlePage(total=79, currentPage=1, totalPages=8, blockSize=5, startPage=1, endPage=5
								, keyword=, url=, content=[Item2VO(itemId=79, itemName=텀블러, price=36000, description=보라색, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226074, uploadFile=null, fileGroupVO=null), Item2VO(itemId=78, itemName=개똥아똥쌌니아니오, price=12000, description=똥싸지마, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226073, uploadFile=null, fileGroupVO=null), Item2VO(itemId=77, itemName=노란 스펀지, price=12345, description=네네모네모 스폰지밥~~~~, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226072, uploadFile=null, fileGroupVO=null), Item2VO(itemId=76, itemName=쇼파, price=800000, description=왕멋진쇼파, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226071, uploadFile=null, fileGroupVO=null), Item2VO(itemId=75, itemName=개똥이 홍보, price=11000, description=좋아요5, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226070, uploadFile=null, fileGroupVO=null), Item2VO(itemId=74, itemName=5개마지막이닷, price=4300, description=수여일, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226069, uploadFile=null, fileGroupVO=null), Item2VO(itemId=73, itemName=한개 더, price=10000, description=좋아요, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226068, uploadFile=null, fileGroupVO=null), Item2VO(itemId=72, itemName=애플, price=1000000, description=사과22, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226067, uploadFile=null, fileGroupVO=null), Item2VO(itemId=71, itemName=핸드크림, price=12000, description=구웃, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226066, uploadFile=null, fileGroupVO=null), Item2VO(itemId=70, itemName=해산물볶음밥, price=90000, description=비쌈, pictureUrl=null, pictureUrl2=null, fileGroupNo=20250226065, uploadFile=null, fileGroupVO=null)]
								, pagingArea=)
								블록시작번호가 6(블록크기 + 1)보다 작을 때 비활성 처리-->
			                <li class="paginate_button page-item 
								<c:if test="${articlePage.startPage le 1}">disabled</c:if>">
								<a class="page-link"
								   href="/admin/stats/goodsStatistics?currentPage=1&keyword=${param.keyword}"><<</a>
							</li>
							<li
								class="paginate_button page-item previous 
									<c:if test="${articlePage.startPage lt (articlePage.blockSize + 1)}"></c:if>
								">
								<a
								href="/admin/stats/goodsStatistics?currentPage=${articlePage.startPage-articlePage.blockSize}&keyword=${param.keyword}"
								class="page-link"><</a>
							</li>
							<!-- 
								ArticlePage(total=79, currentPage=1, totalPages=8
								, blockSize=5, startPage=1, endPage=5
								, keyword=, url=, content=..
								, pagingArea=)
								
								, 골뱅이RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage
								, 골뱅이RequestParam(value="keyword",required=false,defaultValue="") String keyword
								 -->
							<c:forEach var="pNo" begin="${articlePage.startPage}"
								end="${articlePage.endPage}" step="1">
								<!-- active :  
									/item/list2?currentPage=2&keyword=
									pNo가 2일때
									
									param : currentPage=2&keyword=
									param.currentPage : 2
									-->
								<li
									class="paginate_button page-item 
										<c:if test="${param.currentPage eq pNo}">active</c:if>
									">
									<a
									href="/admin/stats/goodsStatistics?currentPage=${pNo}&keyword=${param.keyword}"
									class="page-link">${pNo}</a>
								</li>
							</c:forEach>
							<!-- 
								블록종료번호가 전체페이지수를 초과하면 안됨
								
								ArticlePage(total=79, currentPage=1, totalPages=8
								, blockSize=5, startPage=1, endPage=5
								, keyword=, url=, content=..
								, pagingArea=)
								 -->
							<!-- EL태그 정리 
									== : eq(equal)
									!= : ne(not equal)
									<  : lt(less than)
									>  : gt(greater than)
									<= : le(less equal)
									>= : ge(greater equal)
								 -->
							<li
								class="paginate_button page-item next
									<c:if test="${articlePage.endPage ge articlePage.totalPages}"></c:if>
								">
								<a
								href="/admin/stats/goodsStatistics?currentPage=${articlePage.startPage+articlePage.blockSize}&keyword=${param.keyword}"
								class="page-link">></a>
								
							</li>
							<li class="paginate_button page-item 
								<c:if test="${articlePage.endPage ge articlePage.totalPages}">disabled</c:if>">
								<a class="page-link"
								   href="/admin/stats/goodsStatistics?currentPage=${articlePage.totalPages}&keyword=${param.keyword}">&gt;&gt;</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 인기 차트 -->
		
	</div>

	<%@ include file="../adminFooter.jsp"%>
	<!--   <script src="/js/stats/goodStatiList.js"></script> -->

	<script>
	
    
  </script>

</body>
</html>
