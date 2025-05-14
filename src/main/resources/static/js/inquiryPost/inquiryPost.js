
const blockSize = 10;

	// 렌더링 될 때 실행
	fn_search(1);

	// 초기화 버튼 눌렀을 때
	const btnReset = document.getElementById("btnReset");
	btnReset.addEventListener("click", () => {
		fn_reset();
	})
	
	// 검색버튼 눌렀을 때
	const btnSearch = document.getElementById("btnSearch");
	btnSearch.addEventListener("click", ()=> {
		fn_search(1);
	});
	
	function fn_search(page) {
		const inqType = document.getElementById("inqType");
		const mode = document.getElementById("mode");
		const keyword = document.getElementById("keyword");
		
		const params = {
			mode : mode.value,
			keyword : keyword.value,
			inqTypeNo : inqType.value,
	 		page : page,
	 		blockSize : blockSize,
	 		start : (page - 1) * blockSize + 1,
	 		end : page * 10
	 	}
		
		axios.get("/oho/inquiryPost/getListAjax", { params }).then(resp => {
			const { content, currentPage, totalPages, startPage, endPage } = resp.data;
			renderTable(content);
			renderPagination({currentPage, totalPages, startPage, endPage});
		})
	}
	
	function renderTable(data) { 
		const tbody = document.getElementById("listBody");
		tbody.innerHTML = "";
		
		let html = ``;
			
		if(data.length == 0) {
			html += `
				<tr>
					<th colspan="6" class="empty-row">등록된 글이 없습니다.</th>
				</tr>
			`
		} else {

			data.forEach(board => {
				const inqWriter = board.inquiryPostVO.inqWriter;
				console.log("board : ", board.inquiryPostVO.pswdYn);
				html += `
					  <tr style="height: 60px;" class="align-middle">
				      <th scope="row" class="col-1">${board.rnum}</th>
				      <th class="col-2" style="text-align: left;">${board.inquiryPostVO.inqTypeNm}</th>
				      <td class="col-5" onclick="fn_clickPost(${board.bbsPostNo}, '${board.inquiryPostVO.pswdYn}')" style="cursor:pointer; color:black; text-align: left;">
					  	${board.bbsTitle}
					  </td>
				      <td  class="col-2" style="text-align: left;">${inqWriter}</td>
				      <td  class="col-1">${board.bbsRegYmd}</td>
					`;
				
				if(board.inquiryPostVO.inqPswd != null ) {
					html += `<td class="col-1"><i class="bi bi-lock-fill"></i></td>`;
				}else {
					html += `<td class="col-1"><i class="bi bi-unlock-fill"></i></td>`;
				}
				
				html += `</tr>`;
				
			})
		}
			tbody.innerHTML = html;
	}

function renderPagination(paging) {
	console.log("renderPagination실행 data: ", paging);
	
	const container = document.getElementById("pagination-container");
	container.innerHTML = "";
	
	if (!paging || paging.totalPages === 0) {
		return;
	}
	
	const totalPages = paging.totalPages;
	let startPage = Math.floor((paging.currentPage - 1) / blockSize) * blockSize + 1;
	let endPage = startPage + blockSize - 1;
	console.log("totalPages : ", totalPages);
	console.log("startPage : ", startPage);
	console.log("endPage : ", endPage);

	if (endPage > totalPages) {
		endPage = totalPages;
	}

	let html = '<ul class="pagination">';

	const disabledFirst = startPage <= 1 ? 'disabled' : '';
	const disabledLast = endPage >= totalPages ? 'disabled' : '';

	html += `<li class="page-item ${disabledFirst}">
	          <a class="page-link" href="javascript:void(0)" onclick="fn_search(1); return false;"><<</a></li>`;
	html += `<li class="page-item ${disabledFirst}">
	          <a class="page-link" href="javascript:void(0)" onclick="fn_search(${paging.currentPage - 1}); return false;"><</a></li>`;

	for (let i = startPage; i <= endPage; i++) {
		const active = i === paging.currentPage ? 'active' : '';
		html += `<li class="page-item ${active}">
	              <a class="page-link" href="javascript:void(0)" onclick="fn_search(${i}); return false;">${i}</a></li>`;
	}

	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="javascript:void(0)" onclick="fn_search(${endPage + 1}); return false;">></a></li>`;
	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="javascript:void(0)" onclick="fn_search(${totalPages}); return false;">>></a></li>`;

	html += '</ul>';

	container.innerHTML = html;
		
}

/* 검색필터 초기화 버튼 */
function fn_reset() {
	
	document.getElementById("srhFrm").reset();
	fn_search(1);

}

//게시글을 눌렀을 때
function fn_clickPost(postNo, pswdYn) {
	if(pswdYn == "N") { // 공개글일 경우
	   inquiryPostDetail(postNo);
	}else {  // 비밀글일 경우
		// 비밀번호 입력 모달창 열기
		const pswdModal =	document.getElementById("pswdModal");
		pswdModal.style.display = "flex";
		
		// 입력버튼 클릭했을 경우
		const nextBtn = document.getElementById("nextBtn");
		nextBtn.addEventListener("click", () => {
			const inputPswd = document.getElementById("inputPswd").value;
			
			axios.post("/oho/inquiryPost/pswdCheck", {boardNo:postNo, pswd:inputPswd}).then(resp => {
				if(resp.data=="success") {
				   inquiryPostDetail(postNo);
				}else {
					failAlert();
				}
			})
		})
	}
}

function inquiryPostDetail(postNo) {
   const form = document.createElement("form");
   form.method = "get";
   form.action = "/oho/inquiryPost/detail";
   
   const input = document.createElement("input");
   input.type = "hidden";
   input.name = "boardNo";
   input.value = postNo;
   form.appendChild(input);
   
   document.body.appendChild(form);
   form.submit();
}

// 비밀번호 토글
function togglePassword(iconSpan) {
	const input = iconSpan.parentElement.querySelector('input');
	const eyeIcon = iconSpan.querySelector('i');

	if (input.type === "password") {
		input.type = "text";
		eyeIcon.classList.remove("fa-eye-slash");
		eyeIcon.classList.add("fa-eye");
	} else {
		input.type = "password";
		eyeIcon.classList.remove("fa-eye");
		eyeIcon.classList.add("fa-eye-slash");
	}
}

// 취소 버튼 을 눌렀을 때
const cancelBtn = document.getElementById("cancelBtn");
cancelBtn.addEventListener("click", () => {
 		 pswdModal.style.display = "none";
		 document.getElementById("inputPswd").value="";
    });
	
