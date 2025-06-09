
const rowSize = 10; // 한 번에 표시할 페이지 수
const blockSize= 10; //페이지네이션 수

$(document).ready(function() {
	fn_search(1);

	$('#btnSearch').on('click', function() {
		fn_search(1);
	});

	$('#btnReset').on('click', function() {
		fn_reset();
		fn_search(1);
	});
	
	$('#emergency-tab').on('click', function() {
		changeTab(this);
	});
	$('#wait-tab').on('click', function() {
		changeTab(this);
	});
	$('#ready-tab').on('click', function() {
		changeTab(this);
	});
	$('#reference-tab').on('click', function() {
		changeTab(this);
	});
	
});

/* 검색필터 초기화 버튼 */
function fn_reset() {

	$('#selectOption').val('all').trigger('change');
	$('#startDate').val('');
	$('#endDate').val('');
	$('#keywordInput').val('');
	$('#periodSelect').val('1WEEK').trigger('change');

}

let currentTabType = 'ALL'

function changeTab(button){
	document.querySelectorAll('.nav-link').forEach(btn => btn.classList.remove('active'));
	button.classList.add('active');
	currentTabType = button.dataset.type;
	
	fn_search(1);
}


function fn_search(page) {

	// 검색 옵션 파라미터 수집
	const datas = {
		period : $('#periodSelect').val(),
		type: currentTabType,
		mode: $('#selectOption').val(),
		startDate: $('#startDate').val(),
		endDate: $('#endDate').val(),
		keyword: $('#keywordInput').val(),
		
		page: page,
		rowSize: rowSize,
		blockSize: blockSize,
		startRow: (page - 1) * rowSize + 1,
		endRow: page * rowSize

	};

	const instance = axios.create();

	instance.interceptors.request.use(function() { $('#listBody').html('<tr><td colspan="9" class="text-center"><i class="fas fa-spinner fa-spin"></i> 검색 중...</td></tr>'); });

	axios.post('/emp/atrzListAjax', datas).then(resp => {
		
		console.log("응답 데이터: ", resp.data);
		
		const { content, currentPage, totalPages, startPage, endPage } = resp.data;
		renderTable(content);
		renderPagination({ content, currentPage, totalPages, startPage, endPage });

	}).catch(error => {
		console.error("요청 중 오류 발생", error);
		console.error("응답 상세:", error.response);
		$('#listBody').html('<tr><td colspan="9" class="text-center text-danger">검색 중 오류 발생</td></tr>');
	})


}



function renderTable(data) {

	console.log("renderTable 실행 : ", data);

	const tbody = $('#listBody');
	tbody.empty();

	if (!data || data.length === 0) {
		tbody.append(`<tr><td colspan="9" class="text-center">검색 결과가 없습니다</td></tr>`);
		$('#pagination-container').empty();
		return;
	}

	data.forEach(dept => {
	      dept.employeeVOList?.forEach(emp => {
	        emp.atrzDocVOList?.forEach(doc => {
	          const tr = document.createElement("tr");
	          tr.innerHTML = `
	            <td>${doc.drftYmd}</td>
	            <td>${doc.ddlnYmd ? doc.ddlnYmd : '-'}</td>
	            <td>${doc.emrgYn === 'Y' ? '<span class="badge bg-danger-subtle text-danger border border-danger">긴급</span>' : '-'}</td>
	            <td id="tdtitle" class="text-start"><a href="#" class="ref-doc-link" data-atrz-doc-no="${doc.atrzDocNo}">${doc.drftTtl}</a></td>
	            <td>${doc.docFrmNm}</td>
	            <td>${doc.fileGroupNo ? '<i class="bi bi-paperclip"></i>' :  '-'}</td>
	            <td>${emp.empNm} ${emp.position} / ${dept.deptNm}</td>
	          `;
			  
	  		  $('#listBody').append(tr);
	        
			});
	  
		});
	
	});

}

function renderPagination(paging) {
	console.log("renderPagination실행 data: " + paging)
	const container = $('#pagination-container');
	container.empty();

	if (!paging || paging.totalPages === 0) {
		return;
	}
	const totalPages = paging.totalPages;
	let startPage = Math.floor((paging.currentPage - 1) / blockSize) * blockSize + 1;
	let endPage = startPage + blockSize - 1;

	if (endPage > totalPages) {
		endPage = totalPages;
	}

	let html = '<ul class="pagination">';

	const disabledFirst = startPage <= 1 ? 'disabled' : '';
	const disabledLast = endPage >= totalPages ? 'disabled' : '';

	html += `<li class="page-item ${disabledFirst}">
	          <a class="page-link" href="#" onclick="fn_search(1); return false;"><<</a></li>`;
	html += `<li class="page-item ${disabledFirst}">
	          <a class="page-link" href="#" onclick="fn_search(${startPage - 1}); return false;"><</a></li>`;

	for (let i = startPage; i <= endPage; i++) {
		const active = i === paging.currentPage ? 'active' : '';
		html += `<li class="page-item ${active}">
	              <a class="page-link" href="#" onclick="fn_search(${i}); return false;">${i}</a></li>`;
	}

	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="#" onclick="fn_search(${endPage + 1}); return false;">></a></li>`;
	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="#" onclick="fn_search(${totalPages}); return false;">>></a></li>`;

	html += '</ul>';

	container.append(html);

}

/*$('#startDate, #endDate').datetimepicker({
	format: 'YYYY-MM-DD'
});*/