/**
 *  //모달 취소시 입력값 초기화
 	$(document).ready(function(){
 		//신고하기 모달 띄우기
 		$(document).on("click",".aReport",function(){
 			let reportBoardNo = $(this).data("reportBoardNo");
 			let memNo = $(this).data("memNo");
 			
 			console.log("reportBoardNo : ", reportBoardNo);
 			console.log("memNo : ", memNo);
 			
 			$("#reportBoardNoModal").val(reportBoardNo);
 			$("#memNoModal").val(memNo);
 		});
 		
 		//신고하기 모달 저장
 		$("#btnModalSubmit").on("click",function(){
 			console.log("왔다");
 			
 			//입력값 가져오기
 			
 			//비동기 insert
 		});
 		
 		$("#postModal").on("hidden.bs.modal", function () {
 		    document.forms["frm"].reset();
 		    document.getElementById("submitBtn").disabled = true;
 		});
 	});
	
	
	<!-- ///// 신고하기 모달 시작 ///// -->
	<div class="modal fade custom-modal" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="false">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	            <!-- 모달 헤더 -->

	            <div class="modal-header">
	                <h5 class="modal-title" id="reportModalLabel">신고하기2</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>

	            <!-- /// 모달 바디 시작 /// -->
				<!-- Modal body -->
				<div class="modal-body">
					<input type="text" name="reportBoardNo" id="reportBoardNoModal" value="" />
					<input type="text" id="memNoModal" name="memNo" /> 
		
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">신고사유</label>
						<div class="col-sm-8">
							<input type="radio" id="reportTitle1" name="reportTitle" class="blind" /><label for="reportTitle1" checked>게시글신고</label>
							<input type="radio" id="reportTitle2" name="reportTitle" class="blind" /><label for="reportTitle2">댓글신고</label>
							<input type="radio" id="reportTitle3" name="reportTitle" class="blind" /><label for="reportTitle3">디엠신고</label>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-4 col-form-label">신고내용</label>
						<div class="col-sm-8">
							<textarea id="reportCn" name="reportCn" cols="30" rows="5"
								class="form-control"></textarea>
							<code>* ex) 부적절한 게시글</code>
						</div>
					</div>
					
				</div>
	        	<!-- /// 모달 바디 끝 /// -->  
	        	
	        	<!-- Modal footer -->
				<div class="modal-footer">
	<!-- 				<button type="button" class="btn btn-danger" id="btnModalClose">취소</button> -->
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="취소">취소</button>
					<button type="button" class="btn btn-primary"
						data-dismiss="modal" id="btnModalSubmit">저장</button>
				</div>
	        </div>
	    </div>
	</div>
	<!-- ///// 신고하기 모달 끝 ///// -->
 */