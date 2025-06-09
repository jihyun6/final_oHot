<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>oHoT Admin</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body class="sidebar-mini" style="height: auto;">
	<div class="wrapper">

		<c:set var="title" value="문의글 관리 &nbsp; > &nbsp; 문의글 상세"></c:set>
		<!-- 관리자 헤더네비바  -->
		<%@ include file="../adminHeader.jsp"%>

		<!-- 관리자 사이드바 -->
		<%@ include file="../adminSidebar.jsp"%>

		<!-- 컨텐츠-->
		<div class="content-wrapper" style="padding: 20px">
			<!-- 게시글 원글 시작 -->
<!-- 					<p>문의게시글 상세 정보</p> -->
<%-- 						${boardPostVO} --%>
			<input type="hidden" id="boardNo" value="${boardPostVO.replyPostVO.bbsPostNo}">
			<input type="hidden" id="parentNo" value="${boardPostVO.bbsPostNo}">
			
			<div class="card card-secondary">
				<div class="card-body">
					<div class="row">
						<div class="col-md-2">
							<label>문의 유형</label>
							<p>${boardPostVO.inquiryPostVO.inqTypeNm}</p>
						</div>
						<div class="col-md-2">
							<label>작성일시</label>
							<p>${boardPostVO.bbsRegDt}</p>
						</div>
						<div class="col-md-2">
							<label>회원여부</label>
							<c:choose>
								<c:when test="${boardPostVO.inquiryPostVO.memNo == 0}">
									<p>N</p>
								</c:when>
								<c:otherwise>
									<p>Y</p>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-md-2">
							<label>작성자</label>
							<p>${boardPostVO.inquiryPostVO.inqWriter}</p>
						</div>
						<div class="col-md-2">
							<label>비밀글 상태</label>
							<c:choose>
								<c:when test="${boardPostVO.inquiryPostVO.inqPswd == null}">
									<p>공개글</p>
								</c:when>
								<c:otherwise>
									<br>
									<span style="margin-right: 40px;">비밀글</span>
									<button class="col-auto btn btn-xs btn-warning" onclick="pswdReset()">초기화</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="form-group">
						<label for="post-title">제목</label> <input type="text"
							class="form-control" readonly value="${boardPostVO.bbsTitle}">
					</div>
					<!-- 게시글 내용 -->
					<div class="form-group">
						<label for="post-content">내용</label>
						<textarea class="form-control" rows="2" readonly>${boardPostVO.bbsCn}</textarea>
					</div>
					<div class="form-group">
						<c:choose>
							<c:when test="${boardPostVO.fileGroupVO == null}">
								<label for="post-content">첨부파일</label>
								<p>등록된 첨부파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<label for="post-content">첨부파일 (${fn:length(boardPostVO.fileGroupVO.fileDetailVOList)})</label>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-xs btn-warning" onclick="downloadImage()">다운로드</button>
								<div>
									<c:forEach var="file" items="${boardPostVO.fileGroupVO.fileDetailVOList}">
										<label class="imageSelect">
											<input type="checkbox" class="imageCheck" data-img-name="${file.fileSaveName}" data-src="/upload${file.fileSaveLocate}">
											<img src="/upload${file.fileSaveLocate}" width="100px;" height="100px;">
										</label>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<!-- 게시글 원글 끝 -->

			<!-- 답글 시작 -->
			<div class="card card-secondary">
				<!-- 답글이 있을 경우 -->
			<c:choose>
				<c:when test="${boardPostVO.inquiryPostVO.ansYn == '답변 완료'}">
				<c:set var="replyVO" value="${boardPostVO.replyPostVO}"/>
					<div class="card-header">
						<h3 class="card-title">
							답글 &nbsp; <span style="color: black;">(${boardPostVO.inquiryPostVO.ansYn} : ${replyVO.bbsRegDt} )</span>
						</h3>
					</div>
					<form action="/admin/inquiryPost/edit" method="post" enctype="multipart/form-data">
						<input type="hidden" id="parentPostNo" name="parentPostNo" value="${boardPostVO.bbsPostNo}"/>
						<input type="hidden" id="bbsPostNo" name="bbsPostNo" value="${boardPostVO.replyPostVO.bbsPostNo}" />
						<div class="card-body">
							<div class="form-group">
								<label for="post-title">제목</label>
								<input type="text" id="replyTitle" name="bbsTitle" class="form-control" readonly value="${replyVO.bbsTitle}">
							</div>
							<div class="form-group">
								<label for="post-content">내용</label>
								<textarea id="replyCn" name="bbsCn" class="form-control" readonly rows="2">${replyVO.bbsCn}</textarea>
							</div>
							<c:choose>
							<c:when test="${replyVO.fileGroupVO == null}">
								<label for="post-content">첨부파일</label>
								<p>등록된 첨부파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<div>
									<label for="post-content">첨부파일 (${fn:length(replyVO.fileGroupVO.fileDetailVOList)})</label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" class="btn btn-xs btn-warning" onclick="downloadReplyImage()">다운로드</button>
									<div>
										<c:forEach var="file" items="${replyVO.fileGroupVO.fileDetailVOList}">
											<label class="replyImageSelect">
												<input type="checkbox" class="replyImageCheck" data-img-name="${file.fileSaveName}" data-src="/upload${file.fileSaveLocate}">
												<img src="/upload${file.fileSaveLocate}" width="100px;" height="100px;">
											</label>
										</c:forEach>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<div id="fileUploadWrapper" class="form-group" style="display: none;">
							<br>
						    <label>새 첨부파일 업로드</label>
						    <input type="file" name="newUploadFile" class="form-control" multiple>
						</div>
							
						</div>
						<button type="button" onClick="goToList()" class="btn btn-info float-right  m-2">목록</button>
						<button type="button" id="removeReply" class="btn btn-danger float-right  m-2">삭제</button>
						<button type="button" id="editReply" class="btn btn-secondary float-right m-2">수정</button>
						<button type="button" id="cancelReply" class="btn btn-danger float-right m-2" style="display:none;">취소</button>
						<button id="saveReply" class="btn btn-primary float-right m-2" style="display:none;">저장</button>
					</form>
				</c:when>
				<c:otherwise>
				<!-- 답글이 없을 경우 -->
					<div class="card-header">
						<h3 class="card-title">
							답글 <span style="color: black;">(${boardPostVO.inquiryPostVO.ansYn})</span>
						</h3>
					</div>
					<form action="/admin/inquiryPost/createReplyPost" method="post" enctype="multipart/form-data">
						<input type="hidden" name="bbsPostNo" value="${boardPostVO.bbsPostNo}"/>
						<input type="hidden" name="inqPswd" value="${boardPostVO.inquiryPostVO.inqPswd}" />
						<div class="card-body">
							<!-- 게시글 제목 -->
							<div class="form-group">
								<label for="post-title">제목</label>
								<input type="text" name="bbsTitle" class="form-control" value="RE: ${boardPostVO.bbsTitle}">
							</div>
							<!-- 게시글 내용 -->
							<div class="form-group">
								<label for="post-content">내용</label>
								<textarea class="form-control" rows="2" name="bbsCn"></textarea>
							</div>
							<div class="form-group">
								<label>첨부파일</label>
								<input type="file" name="uploadFile" multiple>
							</div>
						</div>
						<div class="d-flex flex-row-reverse">
							<button type="button" onClick="goToList()" class="btn btn-info m-2">목록</button>
							<button class="btn btn-primary m-2">저장</button>
							<button type="button" onClick="testBtn()" class="btn btn-secondary m-2">시연용</button>
						</div>
					</form>
				</c:otherwise>
			</c:choose>
				
			</div>
			<!-- 답글 끝-->
		</div>
		
		
		<script>
			function goToList() {
				location.href="/admin/inquiryPost"
			}
			
			const editReply = document.getElementById("editReply");
			if(editReply) {
				document.getElementById("editReply").addEventListener("click", ()=> {
					
					const removeReply = document.getElementById("removeReply");
					const cancelReply = document.getElementById("cancelReply");
					const saveReply = document.getElementById("saveReply");
					const replyTitle = document.getElementById("replyTitle");
					const replyCn = document.getElementById("replyCn");
					const fileUploadWrapper = document.getElementById("fileUploadWrapper");
					
					editReply.style.display="none";
					removeReply.style.display="none";
					cancelReply.style.display="block";
					saveReply.style.display="block";
					replyTitle.removeAttribute("readonly");
					replyCn.removeAttribute("readonly");
					fileUploadWrapper.style.display="block";
					
				});
			}
			
		  	const cancelReply = document.getElementById("cancelReply");
		  	if(cancelReply) {
				document.getElementById("cancelReply").addEventListener("click", ()=> {
					Swal.fire({
						  title: "취소 시 변경사항이 저장되지 않습니다.",
						  text: "그래도 계속 진행하시겠습니까?",
						  icon: "warning",
						  showCancelButton: true,
						  confirmButtonColor: "#3085d6",
						  cancelButtonColor: "#d33",
						  confirmButtonText: "네"
						}).then((result) => {
						  if (result.isConfirmed) {
							  const editReply = document.getElementById("editReply");
							  const removeReply = document.getElementById("removeReply");
							  const saveReply = document.getElementById("saveReply");
							  const replyTitle = document.getElementById("replyTitle");
							  const replyCn = document.getElementById("replyCn");
							  editReply.style.display="block";
							  removeReply.style.display="block";
							  cancelReply.style.display="none";
							  saveReply.style.display="none";
							  replyTitle.readOnly = true;
							  replyCn.readOnly = true;
						  }
						});
					})
		  	}
		  	
		  	const removeReply = document.getElementById("removeReply");
		  	if(removeReply) {
				document.getElementById("removeReply").addEventListener("click", ()=> {
			    	const parentPostNo = document.getElementById("parentPostNo").value;
					const bbsPostNo = document.getElementById("bbsPostNo").value;
					Swal.fire({
						  title: "정말 삭제하시겠습니까?",
						  icon: "warning",
						  showCancelButton: true,
						  confirmButtonColor: "#3085d6",
						  cancelButtonColor: "#d33",
						  confirmButtonText: "네, 삭제합니다."
						}).then((result) => {
						  if (result.isConfirmed) {
							location.href="/admin/inquiryPost/delete?parentPostNo="+parentPostNo+"&bbsPostNo="+bbsPostNo;
						  }
						});
				});
		  	}
			
			function downloadImage() {
				const selected = document.querySelectorAll('.imageCheck:checked');
				
				if (selected.length === 0) {
			        alert("다운로드할 이미지를 선택해주세요!");
			        return;
		      	}
				
				selected.forEach((checkbox, index) => {
			        const imgSrc = checkbox.getAttribute('data-src');
			        const link = document.createElement('a');
			        const imgName = checkbox.getAttribute('data-img-name');
			        link.href = imgSrc;
			        link.download = imgName;
			        document.body.appendChild(link);
			        link.click();
			        document.body.removeChild(link);
		      });
				
			}
			
			function downloadReplyImage() {
				const selected = document.querySelectorAll('.replyImageCheck:checked');
				
				if (selected.length === 0) {
			        alert("다운로드할 이미지를 선택해주세요!");
			        return;
		      	}
				
				selected.forEach((checkbox, index) => {
			        const imgSrc = checkbox.getAttribute('data-src');
			        const link = document.createElement('a');
			        const imgName = checkbox.getAttribute('data-img-name');
			        link.href = imgSrc;
			        link.download = imgName;
			        document.body.appendChild(link);
			        link.click();
			        document.body.removeChild(link);
		      });
			}
			
			function pswdReset() {
				
				Swal.fire({
					  title: "비밀번호를 초기화하시겠습니까?",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#3085d6",
					  cancelButtonColor: "#d33",
					  confirmButtonText: "네"
					}).then((result) => {
					  if (result.isConfirmed) {
						  const parentPostNo = document.getElementById("parentNo");
							const bbsPostNo = document.getElementById("boardNo");
							console.log("parentPostNo : ", parentPostNo.value);
							console.log("bbsPostNo : ", bbsPostNo.value);
							
							const params = {
									parentPostNo : parentPostNo.value,
									bbsPostNo : bbsPostNo.value
							 	}
							
							axios.get("/admin/inquiryPost/pswdReset", { params }).then(resp => {
								location.replace(location.href);
							})
					  }
					});
			}
		
			
// 시연용 버튼 시작
function testBtn() {
	const bbsCn = document.querySelector("textarea[name='bbsCn']");
	let html = ``;
	html += `아티스트 등록이 지연되어 서비스 이용에 불편을 드린 점 진심으로 사과드립니다. \n`;
	html += `최대한 빠른 시일 내에 새로운 아티스트를 등록하겠습니다. \n`;
	html += `이용해 주셔서 감사합니다.`;
	
	bbsCn.value = html;
}
// 시연용 버튼 끝
		</script>
		<!-- 관리자 풋터 -->
		<%@ include file="../adminFooter.jsp"%>
	</div>
</body>
</html>