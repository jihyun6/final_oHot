<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>title</title>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.usersVO" var="userVO"/>
	</sec:authorize>
	<!-- ${userVO} -->
	<!-- /// 작성 시작 /// -->
	<div class="jumbotron" style="padding: 1rem 1rem;">
		<!-- container : 내용이 들어갈 때 -->
		<form id="replyForm">
			<div class="container row" style="margin:0px;">
				<input type="hidden" name="memNo" value="${userVO.memberVO.memNo}">
				<input type="hidden" name="tkNo" value="${goodsVO.ticketVO.tkNo}">
				<input type="hidden" name="urlCategory" value="${userVO.userAuthList[0].authNm}">
				<h6>${userVO.memberVO.memLastName}${userVO.memberVO.memFirstName}</h6>
				<textarea class="col-md-10 mr-3" rows="2" name="replyContent" id="contentInsert" placeholder="최대 500byte까지 입력 가능합니다."></textarea>
				<button type="button" class="col-md-1 btn btn-success mr-0" onclick="replyInsert()">등록</button>
				<div id="byteCounter" style="font-size: 13px; color: #777; display: flex;">0 / 500 byte</div>
			</div>
		</form>
	</div>
	<!-- /// 작성 끝 /// -->

	<!-- /// 리스트 시작 /// -->
	<div class="container-sm">

		<div class="list_cmt" id="replyAllList" >
			<div class="search_loading d_cmtpgn_loading" style="display: none;"> 
				<img src="https://cdnimg.melon.co.kr/resource/image/cmt/web/common/img_loading.gif" width="40" height="40" alt="">
				<p>잠시 기다려 주세요.</p>
			</div>
			<!-- 댓글 -->
				<c:forEach var="reply" items="${communityReplyVOList}" varStatus="stat">
					<div style="border: 1px solid #e0e0e0; border-radius: 12px; padding: 10px; margin-bottom: 20px; background-color: #fff; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05); 
								font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;">
						<div style="font-size: 13px; color: #777; display: flex; justify-content: space-between; margin-bottom: 8px;">
							<span>${reply.memNm}</span>
							
								<div class="dropdown">
									<!-- 점 3개 버튼 -->
									<button class="btn-sm btn-light border" type="button" id="dropdownMenuButton"
										data-bs-toggle="dropdown" aria-expanded="false">
										⋮ <!-- 점 3개 아이콘 (수직) -->
									</button>
						
									<!-- 드롭다운 메뉴 -->
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
										<c:if test="${userVO.userNo != reply.memNo}">
											<li>
												<a class="dropdown-item d-flex align-items-center aReport" href="#" data-bs-toggle="modal"
													data-bs-target="#reportModal" data-report-gubun="기대평" data-report-board-no="${reply.replyNo}" data-mem-no="${userVO.userNo}">
													<span class="me-2">🔔신고하기</span> 
												</a>
											</li>
										</c:if>	
										<c:if test="${userVO.userNo == reply.memNo}">
											<li>
												<a class="dropdown-item d-flex align-items-center " onclick="deleteReply(${reply.replyNo})" style="cursor: pointer;">
													<span class="me-2">🗑️삭제하기</span>
												</a>
											</li>
											<li>
												<a class="dropdown-item d-flex align-items-center " onclick="editReply(${reply.replyNo})" style="cursor: pointer;">
													<span class="me-2">✏️수정하기</span>
												</a>
											</li>
										</c:if>
									</ul>
								</div>
						
						</div>
						
						<div style="font-size: 14px; color: #444; line-height: 1.6;" id="replyContent${reply.replyNo}">
							<div id="alreadyContent${reply.replyNo}">${reply.replyContent}</div>
						</div> 
						<div class="justify-content-end" style="font-size: 13px; color: #777; display: flex; margin-bottom: 8px;">
						<span>${reply.repCreateDate}</span>
						</div>
					</div>
				</c:forEach>
			<!-- 댓글이 없을 때 -->
			<c:if test="${empty communityReplyVOList}">
				<div style="border: 1px solid #e0e0e0; border-radius: 12px; padding: 10px; margin-bottom: 20px; background-color: #fff; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05); 
								font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;"  id="tkNoReply" >
						
						<div style="font-size: 12px; color: #444; line-height: 1.6; text-align: center;" >
							<p><h5>등록된 기대평이 없습니다</h5><br/>가장 먼저 기대평을 남겨보세요!</p>
						</div> 

				</div>
			
			</c:if>

		</div>
	</div>
	<!-- /// 내용 끝 /// -->

<script>
	function replyInsert() {
		event.preventDefault(); // 기본 동작 방지
		console.log(${userVO.memberVO.memNo ==null});
		if(${userVO.memberVO.memNo ==null}){
			Swal.fire("","로그인이 필요한 서비스입니다", "warning");
			return;
		}
		var formData = new FormData(document.getElementById("replyForm"));
		axios.post('/shop/ticket/replyInsert',formData).then(resp => {
			console.log("댓글 등록 성공실s패? "+JSON.stringify(resp.data));
			const replyData = resp.data;

			//한국시간으로 안찍힘 이슈
			const now = new Date();
			const kst = new Date(now.getTime() + 9 * 60 * 60 * 1000);

			const year = kst.getUTCFullYear();
			const month = String(kst.getUTCMonth() + 1).padStart(2, '0');
			const day = String(kst.getUTCDate()).padStart(2, '0');
			const hour = String(kst.getUTCHours()).padStart(2, '0');
			const minute = String(kst.getUTCMinutes()).padStart(2, '0');
			const second = String(kst.getUTCSeconds()).padStart(2, '0');

			const dateString = `\${year}-\${month}-\${day} \${hour}:\${minute}:\${second}`;
			console.log(dateString + " ← 한국시간");

			const noreplyInfo =document.querySelector('#tkNoReply');
			if(noreplyInfo){

				noreplyInfo.remove(); // 기존 문구 삭제
			}

			const newReplyHtml = `
				<div style="border: 1px solid #e0e0e0; border-radius: 12px; padding: 10px; margin-bottom: 20px; background-color: #fff; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05); 
								font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;">
						<div style="font-size: 13px; color: #777; display: flex; justify-content: space-between; margin-bottom: 8px;">
							<span>${userVO.memberVO.memLastName}${userVO.memberVO.memFirstName}</span>
								<div class="dropdown">
									<!-- 점 3개 버튼 -->
									<button class="btn-sm btn-light border" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
										⋮ <!-- 점 3개 아이콘 (수직) -->
									</button>
						
									<!-- 드롭다운 메뉴 -->
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
										<li>
											<a class="dropdown-item d-flex align-items-center " onclick="deleteReply(\${replyData.replyNo})" style="cursor: pointer;">
												<span class="me-2">🗑️삭제하기</span>
											</a>
										</li>
										<li>
											<a class="dropdown-item d-flex align-items-center " onclick="editReply(\${replyData.replyNo})" style="cursor: pointer;">
												<span class="me-2">✏️수정하기</span>
											</a>
										</li>
									</ul>
								</div>
						</div>
						
						<div style="font-size: 14px; color: #444; line-height: 1.6;" id="alreadyContent\${replyData.replyNo}">
							\${replyData.replyContent}
						</div> 
						<div class="justify-content-end" style="font-size: 13px; color: #777; display: flex; margin-bottom: 8px;">
						<span>\${dateString}</span>
						</div>
					</div>
			`;
			const newDiv = document.createElement('div');
			newDiv.innerHTML =newReplyHtml;
			const newReply = newDiv.firstElementChild;

			const replyAll =document.querySelector("#replyAllList").prepend( newReply); 

			document.querySelector('#contentInsert').value="";

		}).catch(error => console.error('Error:', error));
	}

	function deleteReply(replyNo) {
		event.preventDefault(); // 기본 동작 방지
		 Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'error',
			showCancelButton: true,
			confirmButtonColor: '#d33',
			cancelButtonColor: 'gray',
			confirmButtonText: '삭제',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				// alert(replyNo)
				axios.post('/shop/ticket/replyDelete?replyNo='+replyNo)
				.then(resp => {
					console.log("댓글 삭제 성공실패? "+JSON.stringify(resp.data));

					if (resp.data == 1) {
						Swal.fire({
							icon: "success",
							title: "삭제되었습니다",
							showConfirmButton: false,
							timer: 1000
						});
						document.querySelector('#replyContent'+replyNo).parentElement.remove(); // 댓글 삭제

					} else {
						Swal.fire("삭제 실패","잠시후 다시 이용해주세요", "error");
					}
				}).catch(error => console.error('Error:', error));
			}
		}).catch(error => console.error('Error:', error)); 



	}

	function editReply(replyNo) {
		event.preventDefault(); // 기본 동작 방지
		const alreadyDiv = document.querySelector('#alreadyContent'+replyNo);
		alreadyDiv.style.display = "none"; //기존댓글 숨김
		
		const alreadyContent= alreadyDiv.innerHTML;

		const editDiv= document.createElement('div');
		const editHtml = `
			<div class="container row">
				<textarea classs="col-md-6 mr-3" rows="3" name="replyContent" id="editContent">\${alreadyContent}</textarea>
				<button type="button" class="col-md-1 btn btn-success" id="updateBtn">등록</button>
			</div> `
		editDiv.innerHTML = editHtml;
		document.querySelector('#replyContent'+replyNo).appendChild(editDiv); // 댓글 수정창 추가

		//버튼 누르면 update 쿼리 날라가게 성공하면 alreadyDiv 내용 바꾸기
		const updateBtn = document.querySelector('#updateBtn');
		updateBtn.addEventListener('click', function() {
			
			const editContent = document.querySelector('#editContent').value;
			
			axios.post('/shop/ticket/replyUpdate',{
				'replyNo':replyNo,
				'replyContent':editContent
				}).then(resp => {

				if (resp.data == 1) {
					
					Swal.fire("수정되었습니다","", "success");
					alreadyDiv.innerHTML = editContent; // 댓글 수정내용으로 바꿔주기
					alreadyDiv.style.display = "block"; // 댓글 내용 보이게
					editDiv.remove(); // 댓글 수정창 삭제

				} else {
					Swal.fire("수정 실패","잠시후 다시 이용해주세요", "error");
				}
			}).catch(error => console.error('Error:', error));
		});
	}

	document.addEventListener('DOMContentLoaded', () => {
	const textarea = document.getElementById('contentInsert');
	const counter = document.getElementById('byteCounter');

	if (textarea && counter) {
		textarea.addEventListener('input', function () {
			const maxByte = 500;
			let text = textarea.value;
			let byteCount = 0;
			let result = '';
			
			// alert(text+"여기는 오나");
			for (let i = 0; i < text.length; i++) {
				const char = text.charAt(i);
				const charByte = char.charCodeAt(0) > 128 ? 3 : 1;
				if (byteCount + charByte > maxByte) break;

				byteCount += charByte;
				result += char;
			}

			if (textarea.value !== result) {
				textarea.value = result;
			}
			counter.innerText = `\${byteCount} / \${maxByte} byte`;
		});
	}
});


</script>
</body>

</html>