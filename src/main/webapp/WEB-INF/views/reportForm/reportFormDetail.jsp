<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/jquery.min.js"></script>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
	   <sec:authentication property="principal.usersVO" var="userVO"/>
	</sec:authorize>

	<!-- 신고하기 버튼 -->
	<button id="reportbtn" class="btn btn-primary aRe  port" data-bs-toggle="modal"
		data-bs-target="#reportModal" data-report-board-no="123"
		data-memNo="456">신고하기</button>

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
					<input style="font-weight: bold; font-size: 18px; border: none; background: transparent;" type="hidden" name="memNo" id="userNoModal" value="유저NO : ${userVO.userNo}" />
    	
					
					 <!-- 신고 사유 -->
                <div class="form-group row">
                    <label class="col-sm-4 col-form-label"><h5>신고사유</h5></label>
                    <div class="col-sm-9">
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle1" name="reportTitle" value="영리적인/흥보성" /> <label for="reportTitle1">영리적인/흥보성</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle2" name="reportTitle" value="음란물" /> <label for="reportTitle2">음란물</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle3" name="reportTitle" value="불법정보" /> <label for="reportTitle3">불법정보</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle4" name="reportTitle" value="음란성/선정성" /> <label for="reportTitle4">음란성/선정성</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle5" name="reportTitle" value="욕설/인신공격" /> <label for="reportTitle5">욕설/인신공격</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle6" name="reportTitle" value="아이디/DB거래" /> <label for="reportTitle6">아이디/DB거래</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle7" name="reportTitle" value="같은 내용 반복(도배)" /> <label for="reportTitle7">같은 내용 반복(도배)</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="reportTitle8" name="reportTitle" value="운영규칙 위반" /> <label for="reportTitle8">운영규칙 위반</label>
                        </div>
                        <div>
                            <input type="radio" id="reportTitle9" name="reportTitle" value="기타" /> <label for="reportTitle9">기타</label>
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
							<input type="file" class="form-control" id="uploadFile" name="uploadFile" multiple />
						</div>
					</div>
				</div>
				<!-- /// 모달 바디 끝 /// -->

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="btnModalSubmit" data-mem-no="${userVO.userNo}">전송</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ///// 신고하기 모달 끝 ///// -->

	<script type="text/javascript">
// 모달 취소시 입력값 초기화
$(document).ready(function() {
    // 신고하기 모달 띄우기
   /*  $(document).on("click", ".aReport", function() {
        let reportBoardNo = $(this).data("reportBoardNo");
        let memNo = $(this).data("memNo");

        console.log("reportBoardNo : ", reportBoardNo);
        console.log("memNo : ", memNo);

        $("#reportBoardNoModal").val(reportBoardNo);
        $("#memNoModal").val(memNo); 
    }); */

    // 신고하기 모달 전송
    $("#btnModalSubmit").on("click", function() {
        console.log("신고 저장 클릭");
       let reportBoardNo = $("#reportbtn").data("reportBoardNo"); // 게시글 여기 
        let memNo = $(this).data("memNo");

        // 입력값 가져오기
         //const reportBoardNo = $("#reportBoardNoModal").val();
        //const memNo = $("#memNoModal").val();
        const reportCn = $("#reportCn").val();
        const reportTitle = $("input[name='reportTitle']:checked").val(); // 선택된 신고 사유
        
        console.log("reportBoardNo: ", reportBoardNo);
        console.log("memNo: ", memNo);
        console.log("reportCn: ", reportCn);
        console.log("reportTitle: ", reportTitle);


        

        
        let formData = new FormData();
        formData.append("reportPostNo", reportBoardNo);
        formData.append("reportBoardNo", reportBoardNo);
        formData.append("memNo", memNo);
        formData.append("reportTitle", reportTitle);
        formData.append("reportCn", reportCn);
        
        //파일업로드
        let files = $("#uploadFile")[0].files;        
        for(let i=0;i<files.length;i++){
        	formData.append("uploadFile",files[i]);
        }
        
        console.log("formData", formData);
        /*
        data{"reportBoardNo": "1","memNo": "2","reportCn": "asfd"}
        */
        //console.log("data : ", data);

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
                $('#reportModal').modal('hide');
                document.forms["frm"].reset();
            },
            error: function(error) {
                console.log("신고 실패:", error);
                alert("신고에 실패하였습니다.");
            }
        });
    });

    // 모달 닫을 때 폼 리셋
    $("#reportModal").on("hidden.bs.modal", function () {
        $("input[name='reportTitle']").prop("checked", false); // 라디오 버튼 초기화
        $("#reportCn").val(''); // 텍스트 영역 초기화
        $("#uploadFile").val(''); // 파일 초기화
    });
});
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
