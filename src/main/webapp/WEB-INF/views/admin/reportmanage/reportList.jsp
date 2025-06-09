<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>

<style type="text/css">
.search-label {
	width: 100px;
	align-items: center;
}

.search-input {
	width: 320px !important;
	margin-right: 10px;
}
</style>

</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">
		<!-- 관리자 헤더네비바  -->
		<c:set var="title" value="신고 관리"></c:set>
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper" style="padding: 20px;">
			<!-- card 영역 -->
			<div class="card card-secondary">
				<div class="card-header "></div>

				<!-- /.card-header -->
				<!-- form start -->
				<form onsubmit="return false;" id="srhFrm">
					<!-- /.card-body -->
					<div class="card-body" style="padding: 10px 10px 0px;">
						<div class="row mb-4" style="margin-bottom: 0px !important">
							<!-- 상품번호 1행 1열 -->
							<div class="col-md-2 form-group gap-5 mb-1">
								<!-- 신고처리여부 -->
								<label for="reportResult" class="small">신고처리여부</label> <select
									id="reportResult" name="reportResult"
									class="form-control select2bs4" style="width: 100%;">
									<option selected value="">전체</option>
									<option value="004">활동정지(3일)</option>
									<option value="N">미처리</option>
									<option value="001">신고해지</option>
								</select>
								<!-- 등록일시 2행 1열 -->
								<label for="reportPostNo" class="small">등록일시</label>
								<div class="input-group date " id="start-date"
									data-target-input="nearest">
									<input type="date" id="startDate" name="startDate" class="form-control datetimepicker-input"
										data-target="#start-date">
									<div class="input-group-append" data-target="#start-date"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="fa fa-calendar"></i>
										</div>
									</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
								</div>
							</div>

							<!-- 신고타입 1행 2열 -->
							<div class="col-md-2 form-group gap-5 mb-1">
								<label for="reportGubun" class="small">신고타입</label> <select
									id="reportGubun" name="reportGubun"
									class="form-control select2bs4" style="width: 100%;">
									<option selected value="">전체</option>
									<option value="게시글">게시글</option>
									<option value="댓글">댓글</option>
									<option value="디엠">디엠</option>
								</select>
								<!-- 등록일시종료일 2행 2열 -->
								<label for="reportPostNo" class="small">등록일시</label>
								<div class="input-group date " id="end-date"
									data-target-input="nearest">
									<input type="date" id="endDate" name="endDate" class="form-control datetimepicker-input" data-target="#end-date">
									<div class="input-group-append" data-target="#end-date"
										data-toggle="datetimepicker">
										<div class="input-group-text">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>



							<!-- 더미데이터 1행 4열 -->
							<div class="col-md-4 form-group mb-1">
								<label class="small invisible">더미데이터</label> <select
									class="form-select invisible" style="width: 100%;">
								</select> <label for="piMemName" class="small">신고회원검색</label> <input
									type="text" id="piMemName" name="piMemName"
									class="form-control" placeholder="신고회원">
							</div>

							<!-- 더미데이터 1행 5열 -->
							<div class="col-md-2 form-group mb-1"></div>


							<!-- 더미데이터 선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label class="small invisible">더미데이터</label> <select
									class="form-select invisible" style="width: 100%;">
								</select> <label for="search-title" class="small">&ensp;</label>
								<p class="">
									<button type="reset" class="btn btn-outline-dark col-md-12"
										id="resetBtn">초기화</button>
								</p>
							</div>

							<!-- 더미데이터선택 -->
							<div class="col-md-1 form-group gap-5 mb-1">
								<label class="small invisible">더미데이터</label> <select
									class="form-select invisible" style="width: 100%;">
								</select> <label for="search-title" class="small">&ensp;</label>
								<p>
									<button type="button" id="btnSearch" class="btn btn-outline-primary col-md-12">검색</button>
								</p>
							</div>
						</div>
						<!-- 검색 1행 끝 -->
					</div>
				</form>
			</div>

			<!-- List 영역 시작 -->
			<div class="row text-center" style="padding: 0px 40px 0px 40px">
				<!-- 등록 --> 
				
				<!-- card-body 영역 시작 -->
				<div class="card-body table-responsive p-0"
					style="text-align: center;">
					<table class="table table-hover text-nowrap"
						style="table-layout: auto;">
						<thead>
							<tr>
								<th>신고NO</th>
								<th>신고타입</th>
								<th>신고사유</th>
								<th>피신고회원 이메일</th>
								<th>피신고회원 이름</th>
								<th>등록일시</th>

								<th>신고처리여부</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody id="listBody">

						</tbody>
					</table>
				</div>

				<!-- 페이징이 들어갈 영역 -->
				<div id="pagination-container"
					class="d-flex justify-content-center mt-3"></div>
				<!-- 페이징이 들어갈 영역 끝 -->
			</div>
		</div>
		<!-- 컨텐츠 끝 -->
			<!-- 관리자 풋터 -->
	<%@ include file="../adminFooter.jsp"%>
	</div>
	<!-- wrapper 끝 -->

<!-- 신고관리 상세보기 폼 -->
<form id="editForm" name="editForm">
  <div class="modal" id="updateModal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">

        <input type="hidden" id="reportPostNo" name="reportPostNo" />

        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">신고상세</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" id="memNo" name="memNo" />
          <input type="hidden" id="fileGroupNo" name="fileGroupNo" />

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고자 이메일</label>
            <div class="col-sm-8">
              <input type="text" id="piMemEmail2" name="piMemEmail2" class="form-control" readonly />
              <code>* ex) 신고한 유저 이메일</code>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고자 이름</label>
            <div class="col-sm-8">
              <input type="text" id="piMemEmail" name="piMemEmail" class="form-control" readonly />
              <code>* ex) 신고한 유저 이름</code>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">피신고유저</label>
            <div class="col-sm-8">
              <input type="text" id="memBirth" name="memBirth" class="form-control" readonly />
              <code>* ex) 피신고 유저 이메일</code>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">피신고 회원 이름</label>
            <div class="col-sm-8">
              <input type="text" id="memFirstName" name="memFirstName" class="form-control" readonly />
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고사유</label>
            <div class="col-sm-8">
              <input type="text" id="joinYmd" name="joinYmd" class="form-control" readonly />
              <code>* ex) 부적절한 댓글입니다</code>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고상세사유</label>
            <div class="col-sm-8">
              <input type="text" id="secsnYmd" name="secsnYmd" class="form-control" readonly />
              <code>* ex) ...때문입니다</code>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고조치</label>
            <div class="col-sm-8">
              <select class="form-select" name="reportResult" id="reportResultModal" >
                <option value="001">신고해지</option>
                <option value="004">활동정지(3일)</option>
                <option value="N">미처리</option>
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label">신고이미지</label>
            <div class="col-sm-8" id="imgContainer"></div>
          </div>
        </div>

        <!-- Modal Footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" id="modalSave" data-dismiss="modal">저장</button>
        </div>
      </div>
    </div>
  </div>
</form>









	<script>
    $(function () {
    	/*
    	신고상세 모달에서 신고조치 선택(활동정지 3일) 후 저장버튼 클릭    	
    	*/
    	$("#modalSave").on("click",function(){
    		let reportPostNo = $("#reportPostNo").val();
    		let reportResult = $("#reportResultModal").val();
    		let reportResultText = $("#reportResultModal option:selected").html();
    		//피신고유저(o@naver.com)
    		let piMemEmail = $("#memBirth").val();
    		
    		console.log("reportResult : ", reportResult);
    		console.log("reportResultText : ", reportResultText);
    		
    		//기본키를 조건으로 update함
    		let data = {
    			"reportPostNo":reportPostNo,
    			"reportResult":reportResult,
    			"piMemEmail":piMemEmail
    		};
    		
    		console.log("data : ", data);
    		
    		//REPORT_BOARD_POST테이블의 REPORT_RESULT 컬럼의 값을 UPDATE함
    		$.ajax({
    			url:"/admin/reportmanage/reportBoardPostUpdate",
    			data:data,
    			type:"post",
    			dataType:"json",
    			success:function(result){
    				console.log("result : ", result);
    				
    				$("#tdReportResult_"+reportPostNo).html(reportResultText);
    			}
    		});
    	});
    	
        // Date picker
    	$("#modalSave").on("click", function(){
    	    editPost();  // editPost 함수만 호출
    	});
    });
    
    

   //어떤 신고 글(reportPostNo)의 상세인가?
function updateReportmanage(reportPostNo) {
    console.log("이건나오나? : ", reportPostNo);

    fetch("/admin/reportmanage/reportmanageDetail?reportPostNo=" + reportPostNo)
        .then(resp => {
            return resp.json(); 
        })
        .then(data => {
            console.log("data : ", data);


            $("#reportPostNo").val(reportPostNo);
        	$("#piMemEmail2").val(data.memEmail);
        	$("#piMemEmail").val(data.memName);
        	$("#memBirth").val(data.piMemEmail);
        	$("#memFirstName").val(data.piMemName);
        	$("#joinYmd").val(data.reportTitle);
        	$("#secsnYmd").val(data.reportCn);
        	$("#reportResultModal").val(data.reportResult);
    
        	// 이미지 업데이트도 가능
            if (data.fileGroupNo) {
            	$("#imgContainer").html(`<img src="/upload/${data.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" style="max-width: 200px; height: auto;" />`);  // 경로 확인 필요
            } else {
                $("#imgContainer").html("이미지가 없습니다.");
            }


            $("#updateModal").modal("show");
        })
        .catch(error => {
            console.error("Error:", error);
            alert("오류가 발생했습니다.");
        });
}
   
    function editPost(){
    	
    	//1) REPORT_POST_NO
    	//2) reportResult
    	let reportPostNo = document.getElementById("reportPostNo").value;
    	let reportResultObj = document.getElementById("reportResultModal");//select박스
    	//선택된 옵션의 value값을 가져옴
    	console.log("reportResultObj.selectedIndex : ", reportResultObj.selectedIndex);
    	let reportResult = reportResultObj.options[reportResultObj.selectedIndex].value;
    	
    	console.log("reportPostNo : ", reportPostNo);
    	console.log("reportResult : ", reportResult);
    	
    	let formData = new FormData();
    	formData.append("reportPostNo", reportPostNo);
    	formData.append("reportResult", reportResult);
    	
    	
    	for(let [key,value] of formData.entries()) {
            console.log(key + ', ' + value);
        }
    	
    	//관리자가 신고 요청에 대한 처리
    	fetch("/admin/reportmanage/reportmanageDetailPost", {
    			method : "post",
    			body : formData
    	}).then(resp=>{
    		console.log("resp :", resp);
    		return resp.text(); // 응답을 텍스트로 파싱
    	}).then(data=>{
    		console.log("서버 응답 : ", data);
//     		alert("됐나");
    		location.href = location.href;
    	}).catch(error=>{
            console.error("Error:", error);
            alert("오류가 발생했습니다.");
        });
    }//end editPost
</script>
<script src="/js/report/reportList.js"></script>

</body>
</html>