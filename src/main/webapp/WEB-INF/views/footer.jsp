<%@ page language="java" contentType="text/html; charset=UTF-8"%>


<c:choose>
	<c:when test="${userVO.userAuthList[0].authNm  == 'ROLE_MEM'}">
		<%@ include file="./dm/dmForFan.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="./dm/dmForArtist.jsp" %>
	</c:otherwise>
</c:choose>

 <!-- footer 영역 정의 -->
<footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
	<div class="col-md-4 d-flex align-items-center">
    	<a href="/" class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
        	<svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
      	</a>
      	<span class="mb-3 mb-md-0 text-body-secondary">© 2025 Company, Inc</span>
		<a href="/oho/inquiryPost" style="margin-left:10px; color:#F86D72; !important;">
			문의하기
		</a>
    </div>

    <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
    	<li class="ms-3"><a class="text-body-secondary" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#twitter"></use></svg></a></li>
      	<li class="ms-3"><a class="text-body-secondary" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#instagram"></use></svg></a></li>
      	<li class="ms-3"><a class="text-body-secondary" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#facebook"></use></svg></a></li>
    </ul>
    
    
    
    
    <!-- ///// 신고하기 모달 시작 ///// -->
	<div class="modal fade" id="reportModal" tabindex="-1"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-h eader">
					<h5 id="reportModalLabel" style="text-align: center;">신고하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- /// 모달 바디 시작 /// -->
				<div class="modal-body">
					<!-- 유저정보 -->
					<input
						style="font-weight: bold; font-size: 18px; border: none; background: transparent;"
						type="hidden" name="memNo" id="userNoModal"
						value="유저NO : ${userVO.userNo}" /> 
<!-- 						<input -->
<!-- 						style="font-weight: bold; font-size: 18px; border: none; background: transparent; width: 100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;" -->
<!-- 						type="text" name="memEmail" id="memEmailModal" -->
<%-- 						value="유저EMAIL : ${userVO.userMail}" /> --%>

					<!-- 신고 사유 -->
					<div class="form-group row">
						<label class="col-sm-4 col-form-label"><h5>신고사유</h5></label>
						<div class="col-sm-9">
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle1" name="reportTitle"
									value="영리적인/흥보성" /> <label for="reportTitle1">영리적인/흥보성</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle2" name="reportTitle"
									value="음란물" /> <label for="reportTitle2">음란물</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle3" name="reportTitle"
									value="불법정보" /> <label for="reportTitle3">불법정보</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle4" name="reportTitle"
									value="음란성/선정성" /> <label for="reportTitle4">음란성/선정성</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle5" name="reportTitle"
									value="욕설/인신공격" /> <label for="reportTitle5">욕설/인신공격</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle6" name="reportTitle"
									value="아이디/DB거래" /> <label for="reportTitle6">아이디/DB거래</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle7" name="reportTitle"
									value="같은 내용 반복(도배)" /> <label for="reportTitle7">같은
									내용 반복(도배)</label>
							</div>
							<div style="margin-bottom: 10px;">
								<input type="radio" id="reportTitle8" name="reportTitle"
									value="운영규칙 위반" /> <label for="reportTitle8">운영규칙 위반</label>
							</div>
							<div>
								<input type="radio" id="reportTitle9" name="reportTitle"
									value="기타" /> <label for="reportTitle9">기타</label>
							</div>
						</div>
					</div>
					<br>

					<div class="form-group row">
						<h4>상세내용</h4>
						<div class="col-sm-8">
							<textarea id="reportCn" name="reportCn" cols="60" rows="10"
								class="form-control" style="text-align: left;"></textarea>
							<code>* ex) 부적절한 게시글</code>
						</div>
					</div>

					<div class="form-group row">
						<h4>신고사진</h4>
						<div class="col-sm-8">
							<input type="file" class="form-control" id="uploadFile"
								name="uploadFile" multiple />
						</div>
					</div>
				</div>
				<!-- /// 모달 바디 끝 /// -->

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" id="btnModalClose"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnModalSubmit"
						data-mem-no="${userVO.userNo}">전송</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
//전역변수
let reportGubun = ""; // 신고 구분 (게시글, 댓글, 기대평)
let reportBoardNo = ""; //게시글 또는 댓글 또는 기대평 테이블의 기본키 데이터
let memNo2 = ""; //신고자 회원번호(로그인 한 회원의 memNo(=userNo))

let reportPostNo = "";

$(function(){
	

	//신고하기 모달 띄우기
	$(document).on("click", ".aReport", function() {
		console.log("dafsdfasdf::",$(this).data())
		 reportGubun = $(this).data("reportGubun");
	     reportBoardNo = $(this).data("reportBoardNo");
	     memNo2 = $(this).data("memNo");
	
		//*******의미 : 43번 게시글을 8번 유저가 신고하기
		//reportGubun :  게시글
		 console.log("reportGubun : ", reportGubun);
		//reportBoardNo :  43
	     console.log("reportBoardNo : ", reportBoardNo);
		//memNo :  8
	     console.log("memNo : ", memNo2);
	
	 });
	
	//신고하기 모달 전송
	$("#btnModalSubmit").on("click", function() {
	    console.log("신고 저장 클릭");
	    
	    // 입력값 가져오기
	    const reportCn = $("#reportCn").val();
	    const reportTitle = $("input[name='reportTitle']:checked").val(); // 선택된 신고 사유
	    
// 	    console.log("reportGubun: ", reportGubun);
// 	    console.log("reportBoardNo: ", reportBoardNo);
// 	    console.log("memNo: ", memNo2);
// 	    console.log("reportTitle: ", reportTitle);
// 	    console.log("reportCn: ", reportCn);
	
	    let formData = new FormData();
	    formData.append("reportPostNo", "0");
	    formData.append("reportGubun", reportGubun);
	    formData.append("reportBoardNo", reportBoardNo);
	    formData.append("memNo", memNo2);
	    formData.append("reportTitle", reportTitle);
	    formData.append("reportCn", reportCn);
	    
	    //파일업로드
	    let files = $("#uploadFile")[0].files;        
	    for(let i=0;i<files.length;i++){
	    	formData.append("uploadFile",files[i]);
	    }
	    
	    for (let [key, value] of formData.entries()) {
	    	console.log(key, ":", value);
	    }
	    /*
	    reportPostNo : 0
	    reportGubun:  게시글
	    reportBoardNo:  43
	    memNo:  8
	    reportTitle : 운영규칙 위반
	    reportCn : 상세내용22
	    uploadFile : [object File]
	    */
	    
	    // 비동기 insert
	    $.ajax({
	        type:"POST",
	        url:"/oho/reportForm/registerPost",
	        processData:false,
	        contentType:false,
	        data:formData,
	        success:function(response) {
	            console.log("신고 성공:", response);
	            alert("신고가 완료되었습니다.");
	            // 모달 닫기 및 폼 초기화
//	             $('#reportModal').modal('hide');
	            $("#btnModalClose").click();
	            document.forms["frm"].reset();
	        },
	        error: function(error) {
	            console.log("신고 실패:", error);
	            alert("이미 신고되었습니다.");
				$("#btnModalClose").click();
	        }
	    });
	});
	
	// 모달 닫을 때 폼 리셋
	$("#reportModal").on("hidden.bs.modal", function () {
	    $("input[name='reportTitle']").prop("checked", false); // 라디오 버튼 초기화
	    $("#reportCn").val(''); // 텍스트 영역 초기화
	    $("#uploadFile").val(''); // 파일 초기화
	});
});//end of 달러(function())
</script>
	<!-- ///// 신고하기 모달 끝 ///// -->
</footer>