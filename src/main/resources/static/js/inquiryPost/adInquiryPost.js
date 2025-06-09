
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
		console.log("dkkddkkd")
		fn_search(1);
	});
	
	function fn_search(page) {
		
		const inqType = document.getElementById("inqType");
		const isMember = document.getElementById("isMember");
		const ansYn = document.getElementById("ansYn");
		const bbsDelYn = document.getElementById("bbsDelYn");
		const isSecret = document.getElementById("isSecret");
		const inqWriter = document.getElementById("inqWriter");
		const startDate = document.getElementById("startDate");
		const endDate = document.getElementById("endDate");
		const mode = document.getElementById("mode");
		const keyword = document.getElementById("keyword");
		console.log("inqType가 뭘까요 : ", inqType.value);
	    console.log("isMember가 뭘까요 : ", isMember.value);
		console.log("ansYn가 뭘까요 : ", ansYn.value);
		console.log("bbsDelYn가 뭘까요 : ", bbsDelYn.value);
		console.log("isSecret가 뭘까요 : ", isSecret.value);
		console.log("inqWriter가 뭘까요 : ", inqWriter.value);
		console.log("startDate가 뭘까요 : ", startDate.value);
		console.log("endDate가 뭘까요 : ", endDate.value);
		console.log("mode가 뭘까요 : ", mode.value);
		console.log("keyword가 뭘까요 : ", keyword.value);
		
		const params = {
			isMember : isMember.value,
			ansYn : ansYn.value,
			bbsDelYn : bbsDelYn.value,
			isSecret : isSecret.value,
			inqTypeNo : inqType.value,
			inqWriter : inqWriter.value,
			startDate : startDate.value,
			endDate : endDate.value,
			mode : mode.value,
			keyword : keyword.value, 
	 		page : page,
	 		blockSize : blockSize,
	 		start : (page - 1) * blockSize + 1,
	 		end : page * 10
	 	}
		
		console.log("params 체크 : ", params);
		
		axios.get("/admin/inquiryPost/getListAjax", { params }).then(resp => {
			console.log("아작스 결과 : ", resp.data);
			
			const { content, currentPage, totalPages, startPage, endPage } = resp.data;
			renderTable(content);
			renderPagination({currentPage, totalPages, startPage, endPage});
		})
	}
	
	function renderTable(data) { 
		
		console.log("renderTable 실행 : ", data);
		const tbody = document.getElementById("listBody");
		tbody.innerHTML = "";
		
		let html = ``;
			
		if(data.length == 0) {
			html += `
				<tr>
					<th colspan="9" class="empty-row">등록된 글이 없습니다.</th>
				</tr>
			`
		} else {

			data.forEach(board => {
				console.log("board : ", board);
				
				const inqWriter = board.inquiryPostVO.inqWriter;
				
				html += `
					  <tr onclick="fn_clickPost(${board.bbsPostNo})" style="cursor: pointer;">
				      <td scope="row" class="col-1">${board.rnum}</td>
				      <td class="col-1" style="text-align: left;">${board.inquiryPostVO.inqTypeNm}</td>
				      <td class="col-4" style="text-align: left;">${board.bbsTitle}</td>
				      <td class="col-1">${board.bbsRegYmd}</td>
				      <td class="col-1" style="text-align: left;">${inqWriter}</td>
					`;
				
				// 회원여부 체크
				if(board.inquiryPostVO.memNo != 0 ) {
					html += `<td class="col-1">Y</td>`;
				}else {
					html += `<td class="col-1">N</td>`;
				}
				
				// 답글여부 체크
				if(board.inquiryPostVO.ansYn == '답변 완료' ) {
					html += `<td class="col-1">Y</td>`;
				}else {
					html += `<td class="col-1">N</td>`;
				}
				
				// 삭제여부 체크
				if(board.bbsDelYn == 'Y' ) {
					html += `<td class="col-1">Y</td>`;
				}else {
					html += `<td class="col-1">N</td>`;
				}
				
				if(board.inquiryPostVO.inqPswd == null) {
					html += `<td class="col-1">공개글</td>`;
				}else{
					html += `<td class="col-1">비밀글</td>`;
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

//상세버튼을 눌렀을 때
function fn_clickPost(postNo) {
	console.log("게시글 번호 : ", postNo);
	location.href='/admin/inquiryPost/detail?boardNo='+postNo;
}

// 취소 버튼 을 눌렀을 때
const cancelBtn = document.getElementById("cancelBtn");
cancelBtn.addEventListener("click", function(e) {
 		 pswdModal.style.display = "none";
 		 newPw.value = "";
    });
	
// 상세버튼을 눌렀을 때