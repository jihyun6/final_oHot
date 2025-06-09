const blockSize = 10; // 한 번에 표시할 페이지 수

$(function() {
	fn_search(1);

	$('#btnSearch').on('click', function() {
		fn_search(1);
	});

	$('#resetBtn').on('click', function() {
		$('#srhFrm')[0].reset();
		fn_search(1);
	});
});

// 검색 및 페이징 처리 함수
function fn_search(page) {
	console.log("fn_search 실행, page: " + page);

	const startDate = $('#startDate').val();
	const endDate = $('#endDate').val();
	
	const datas = {
		reportPostNo: $('#reportPostNo').val(),
		reportGubun: $('#reportGubun').val(),
		reportTitle: $('#reportTitle').val(),
		piMemEmail: $('#piMemEmail').val(),
		piMemName: $('#piMemName').val().trim(),
		startDate: startDate ? startDate.replace(/(\d{4})-(\d{2})-(\d{2})/, '$1-$2-$3') : null,
		endDate: endDate ? endDate.replace(/(\d{4})-(\d{2})-(\d{2})/, '$1-$2-$3') : null,


		reportResult: $('#reportResult').val(),
		page,
		blockSize,
		startRow: (page - 1) * blockSize + 1,
		endRow: page * blockSize
	};

	console.log('datas:', datas); 
	
	
	// 로딩 표시
	$('#listBody').html('<tr><td colspan="9" class="text-center">로딩 중...</td></tr>');

	axios.post('/admin/reportmanage/reportListPost', datas)
		.then(resp => {
			const { content, currentPage, totalPages, startPage, endPage } = resp.data;
			renderTable(content);
			renderPagination({ currentPage, totalPages, startPage, endPage });
		})
		.catch(() => {
			$('#listBody').html('<tr><td colspan="9" class="text-center text-danger">검색 중 오류 발생</td></tr>');
		});
}

// 테이블 렌더링 함수
function renderTable(data) {
	let html = '';
	console.log('선택한 날짜:', $('#reportRegDt').val());
	if (data && data.length > 0) {
		data.forEach(item => {
			html += `
				<tr>
					<td>${item.reportPostNo}</td>
					<td>${item.reportGubun}</td>
					<td>${item.reportTitle}</td>
					<td>${item.piMemEmail || '-'}</td>
					<td>${item.piMemName}</td>
					<td>${item.reportRegDt}</td>
					

					<td id="tdReportResult_${item.reportPostNo}">${translateResult(item.reportResult)}</td>
					<td>
						<button type="button" class="btn btn-secondary" 
							data-toggle="modal" data-target="#updateModal"
							onclick="updateReportmanage(${item.reportPostNo})">신고상세</button>
					</td>
				</tr>
			`;
		});
	} else {
		html = '<tr><td colspan="9" class="text-center">검색 결과가 없습니다.</td></tr>';
	}
	$('#listBody').html(html);
}

// 신고 결과 번역 함수
function translateResult(code) {
	switch(code) {
		case '001': return '신고 해지';
		case '004': return '활동 정지(3일)';
		case 'N': return '미처리';
		default: return '미처리';
	}
}

// 페이징 렌더링 함수
function renderPagination({ currentPage, totalPages }) {
	console.log("renderPagination 실행", { currentPage, totalPages });
	const container = $('#pagination-container');
	container.empty();

	if (!totalPages || totalPages === 0) return;

	let startPage = Math.floor((currentPage - 1) / blockSize) * blockSize + 1;
	let endPage = Math.min(startPage + blockSize - 1, totalPages);

	let html = '<ul class="pagination justify-content-center">';

	// '처음' 버튼
	html += `<li class="page-item ${currentPage === 1 ? 'disabled' : ''}">
		<a class="page-link" href="#" onclick="fn_search(1)">&laquo;&laquo;</a></li>`;

	// '이전' 버튼
	html += `<li class="page-item ${currentPage === 1 ? 'disabled' : ''}">
		<a class="page-link" href="#" onclick="fn_search(${Math.max(currentPage - 1, 1)})">&laquo;</a></li>`;

	for (let i = startPage; i <= endPage; i++) {
		html += `<li class="page-item ${i === currentPage ? 'active' : ''}">
			<a class="page-link" href="#" onclick="fn_search(${i})">${i}</a></li>`;
	}

	// '다음' 버튼
	html += `<li class="page-item ${currentPage === totalPages ? 'disabled' : ''}">
		<a class="page-link" href="#" onclick="fn_search(${Math.min(currentPage + 1, totalPages)})">&raquo;</a></li>`;

	// '끝' 버튼
	html += `<li class="page-item ${currentPage === totalPages ? 'disabled' : ''}">
		<a class="page-link" href="#" onclick="fn_search(${totalPages})">&raquo;&raquo;</a></li>`;

	html += '</ul>';
	container.append(html);
}
